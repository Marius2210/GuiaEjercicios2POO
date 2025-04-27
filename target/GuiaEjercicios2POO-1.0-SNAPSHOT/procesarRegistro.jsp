<%--
Autor del Código: Mario Ernesto Meléndez Portillo
Carnet:MP240819
Fecha:26/4/2025
--%>

<%@ page import="ejercicio5.*, java.sql.*, java.time.Year" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Obtener parámetros del formulario
    String nombres = request.getParameter("nombres");
    String apellidos = request.getParameter("apellidos");
    boolean vip = request.getParameter("vip") != null;

    String marca = request.getParameter("marca");
    String modelo = request.getParameter("modelo");
    String tipoAutomotor = request.getParameter("tipoAutomotor");

    // Validar campos obligatorios
    if (nombres == null || nombres.trim().isEmpty() ||
            apellidos == null || apellidos.trim().isEmpty() ||
            marca == null || marca.trim().isEmpty() ||
            modelo == null || modelo.trim().isEmpty() ||
            tipoAutomotor == null || tipoAutomotor.trim().isEmpty()) {

        request.setAttribute("error", "Todos los campos son obligatorios");
        request.getRequestDispatcher("registroCliente.jsp").forward(request, response);
        return;
    }

    // Validar año (entre 1900 y año actual)
    int year;
    try {
        year = Integer.parseInt(request.getParameter("year"));
        int currentYear = Year.now().getValue();
        if (year < 1900 || year > currentYear) {
            throw new NumberFormatException();
        }
    } catch (NumberFormatException e) {
        request.setAttribute("error", "El año debe ser un número entre 1900 y " + Year.now().getValue());
        request.getRequestDispatcher("ejercicio5.jsp").forward(request, response);
        return;
    }

    Connection conexion = null;
    try {
        // Establecer conexión
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost/car_clean", "root", "");

        // Insertar cliente
        Cliente cliente = new Cliente(nombres, apellidos, vip);
        boolean clienteInsertado = cliente.insertar(conexion);

        if (clienteInsertado) {
            // Insertar automotor
            Automotor automotor = new Automotor(marca, modelo, year, tipoAutomotor, cliente.getId());
            boolean autoInsertado = automotor.insertar(conexion);

            if (autoInsertado) {
                // Insertar servicio
                Service servicio = new Service(automotor.getId());
                boolean servicioInsertado = servicio.insertar(conexion);

                if (servicioInsertado) {
                    // Calcular total a pagar
                    double total = servicio.calcularTotalPago(conexion, cliente.isVip());

                    // Redirigir a página de éxito con parámetros
                    response.sendRedirect("registroExitoso.jsp?nombres=" + nombres +
                            "&apellidos=" + apellidos +
                            "&total=" + total);
                    return;
                }
            }
        }

        // Si algo falló, mostrar error
        response.sendRedirect("errorRegistro.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("errorRegistro.jsp?error=" + e.getMessage());
    } finally {
        if (conexion != null) try { conexion.close(); } catch (SQLException e) {}
    }
%>