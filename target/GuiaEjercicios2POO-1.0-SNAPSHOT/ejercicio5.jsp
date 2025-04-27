<%--
Autor del Código: Mario Ernesto Meléndez Portillo
Carnet:MP240819
Fecha:25/4/2025
--%>
<%@ page import="ejercicio5.*, java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Conexión a la base de datos
    Connection conexion = null;
    List<Map<String, Object>> registros = new ArrayList<>();

    //Usamos try catch para manejar errores al conectar en ingresar datos a la base de datos
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost/car_clean", "root", "");

        // Consulta para obtener todos los registros
        String sql = "SELECT c.id, c.nombres, c.apellidos, c.vip, " +
                "a.marca, a.modelo, a.year, a.tipo_automotor, " +
                "pa.precio " +
                "FROM cliente c " +
                "JOIN automotor a ON c.id = a.id_cliente " +
                "JOIN precio_automotor pa ON a.tipo_automotor = pa.tipo_automotor " +
                "ORDER BY c.id DESC";

        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> registro = new HashMap<>();
                registro.put("id", rs.getInt("id"));
                registro.put("nombres", rs.getString("nombres"));
                registro.put("apellidos", rs.getString("apellidos"));
                registro.put("vip", rs.getBoolean("vip"));
                registro.put("marca", rs.getString("marca"));
                registro.put("modelo", rs.getString("modelo"));
                registro.put("year", rs.getInt("year"));
                registro.put("tipo_automotor", rs.getString("tipo_automotor"));
                registro.put("precio_base", rs.getDouble("precio"));

                // Calcular precio final con descuento si es VIP
                double precioFinal = registro.get("vip").equals(true) ?
                        rs.getDouble("precio") * 0.85 : rs.getDouble("precio");
                registro.put("precio_final", precioFinal);

                registros.add(registro);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Error al cargar registros: " + e.getMessage());
    } finally {
        if (conexion != null) try { conexion.close(); } catch (SQLException e) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Registro de Cliente - Car Clean</title>
    <style>
        /* Estilos para el formulario... */
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .checkbox-group {
            margin: 15px 0;
        }
        .btn {
            background-color: #3498db;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #2980b9;
        }
        .error {
            color: red;
            font-size: 14px;
        }
        /* Estilos para la tabla de registros */
        .registros-container {
            margin-top: 40px;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .vip-tag {
            background-color: #f39c12;
            color: white;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 12px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Registro de Cliente - Car Clean</h1>

    <% if (request.getAttribute("error") != null) { %>
    <div class="error" style="color: red; padding: 10px; background: #ffeeee; margin-bottom: 20px;">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="procesarRegistro.jsp" method="post" onsubmit="return validarFormulario()">
        <!-- Sección de Datos del Cliente -->
        <fieldset>
            <legend>Datos del Cliente</legend>

            <div class="form-group">
                <label for="nombres">Nombres:</label>
                <input type="text" id="nombres" name="nombres" required>
            </div>

            <div class="form-group">
                <label for="apellidos">Apellidos:</label>
                <input type="text" id="apellidos" name="apellidos" required>
            </div>

            <div class="checkbox-group">
                <label>
                    <input type="checkbox" id="vip" name="vip"> Cliente VIP (15% de descuento)
                </label>
            </div>
        </fieldset>

        <!-- Sección de Datos del Automotor -->
        <fieldset>
            <legend>Datos del Automotor</legend>

            <div class="form-group">
                <label for="marca">Marca:</label>
                <input type="text" id="marca" name="marca" required>
            </div>

            <div class="form-group">
                <label for="modelo">Modelo:</label>
                <input type="text" id="modelo" name="modelo" required>
            </div>

            <div class="form-group">
                <label for="year">Año:</label>
                <input type="number" id="year" name="year" min="1900" max="<%= java.time.Year.now().getValue() %>" required>
            </div>

            <div class="form-group">
                <label for="tipoAutomotor">Tipo de Automotor:</label>
                <select id="tipoAutomotor" name="tipoAutomotor" required>
                    <option value="">Seleccione un tipo</option>
                    <option value="Motocicleta">Motocicleta ($2.75)</option>
                    <option value="Sedan">Sedán ($3.50)</option>
                    <option value="Camioneta">Camioneta ($4.00)</option>
                    <option value="Microbús">Microbús ($5.00)</option>
                    <option value="Autobús">Autobús ($7.00)</option>
                </select>
            </div>
        </fieldset>

        <!-- Botón de envío -->
        <div class="form-group">
            <input type="submit" value="Registrar Cliente y Servicio" class="btn">
        </div>
    </form>
</div>

<!-- Tabla de registros existentes -->
<div class="container registros-container">
    <h2>Clientes Registrados</h2>

    <% if (registros.isEmpty()) { %>
    <p>No hay clientes registrados aún.</p>
    <% } else { %>
    <table>
        <thead>
        <tr>
            <th>Cliente</th>
            <th>Vehículo</th>
            <th>Tipo</th>
            <th>Precio Base</th>
            <th>Descuento</th>
            <th>Total a Pagar</th>
        </tr>
        </thead>
        <tbody>
        <% for (Map<String, Object> registro : registros) { %>
        <tr>
            <td>
                <%= registro.get("nombres") %> <%= registro.get("apellidos") %>
                <% if ((boolean)registro.get("vip")) { %>
                <span class="vip-tag">VIP</span>
                <% } %>
            </td>
            <td>
                <%= registro.get("marca") %> <%= registro.get("modelo") %> (<%= registro.get("year") %>)
            </td>
            <td><%= registro.get("tipo_automotor") %></td>
            <td>$<%= String.format("%.2f", registro.get("precio_base")) %></td>
            <td>
                <% if ((boolean)registro.get("vip")) { %>
                15%
                <% } else { %>
                -
                <% } %>
            </td>
            <td>$<%= String.format("%.2f", registro.get("precio_final")) %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
</div>
</body>
</html>
