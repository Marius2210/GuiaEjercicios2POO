<!-- Autor: Danilo Antonio Martínez Miranda MM240370 -->
<!-- Fecha de creación: 27/4/2025  -->
<!-- Descripción: Página que muestra los datos registrados de clientes y vehículos, incluyendo estadísticas de ventas. -->


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="ejercicio4.*" %>
<%@ page import="java.util.List" %>
<%
    try {
        request.setCharacterEncoding("UTF-8");

        // Obtención de parámetros del formulario
        String nombreCompleto = request.getParameter("nombreCompleto");
        String sexo = request.getParameter("sexo");
        String marca = request.getParameter("marca");
        int anio = Integer.parseInt(request.getParameter("anio"));
        double precio = Double.parseDouble(request.getParameter("precio"));

        // Validación del nombre (solo letras y espacios)
        if (nombreCompleto == null || !nombreCompleto.matches("^[\\p{L} ]+$")) {
            throw new Exception("El nombre solo puede contener letras y espacios.");
        }

        // Validaciones generales de los datos ingresados
        if (!Validaciones.esTextoValido(nombreCompleto) || !Validaciones.esTextoValido(sexo) ||
                !Validaciones.esTextoValido(marca) || !Validaciones.esAnioValido(anio) ||
                !Validaciones.esPrecioValido(precio)) {
            throw new Exception("Datos ingresados no válidos. Verifique los campos.");
        }

        // Creación de objetos Cliente y Vehiculo
        Cliente cliente = new Cliente(nombreCompleto, sexo);
        Vehiculo vehiculo = new Vehiculo(marca, anio, precio);
        Registro.agregarRegistro(cliente, vehiculo);

    } catch (Exception e) {
        session.setAttribute("error", e.getMessage());
        response.sendRedirect("error.jsp");
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Datos Registrados</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">

    <h1 class="text-center">Listado de Clientes y Vehículos</h1>
    <table class="table table-bordered table-striped mt-4">
        <thead class="thead-dark">
        <tr>
            <th>Nombre Completo</th>
            <th>Sexo</th>
            <th>Marca</th>
            <th>Año</th>
            <th>Precio ($)</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Cliente> clientes = Registro.getClientes();
            List<Vehiculo> vehiculos = Registro.getVehiculos();
            for (int i = 0; i < clientes.size(); i++) {
        %>
        <tr>
            <td><%= clientes.get(i).getNombreCompleto() %></td>
            <td><%= clientes.get(i).getSexo() %></td>
            <td><%= vehiculos.get(i).getMarca() %></td>
            <td><%= vehiculos.get(i).getAnio() %></td>
            <td><%= vehiculos.get(i).getPrecio() %></td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <h2 class="mt-5 text-center">Datos Estadísticos</h2>
    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
        <tr>
            <th>Marca</th>
            <th>Total Vendidos</th>
            <th>Suma Total ($)</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Nissan</td>
            <td><%= Registro.contarPorMarca("Nissan") %></td>
            <td><%= Registro.sumaVentasPorMarca("Nissan") %></td>
        </tr>
        <tr>
            <td>Toyota</td>
            <td><%= Registro.contarPorMarca("Toyota") %></td>
            <td><%= Registro.sumaVentasPorMarca("Toyota") %></td>
        </tr>
        <tr>
            <td>Kia</td>
            <td><%= Registro.contarPorMarca("Kia") %></td>
            <td><%= Registro.sumaVentasPorMarca("Kia") %></td>
        </tr>
        </tbody>
    </table>

    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
        <tr>
            <th>Rango de Años</th>
            <th>Cantidad Vendida</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>2000-2015</td>
            <td><%= Registro.contarPorRangoAnio(2000, 2015) %></td>
        </tr>
        <tr>
            <td>2016-2025</td>
            <td><%= Registro.contarPorRangoAnio(2016, 2025) %></td>
        </tr>
        </tbody>
    </table>

</div>

</body>
</html>