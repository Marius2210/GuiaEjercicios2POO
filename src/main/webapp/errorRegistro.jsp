<%--
Autor del Código: Mario Ernesto Meléndez Portillo
Carnet:MP240819
Fecha:26/4/2025
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error en Registro - Car Clean</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
            background-color: #f5f5f5;
        }
        .error-box {
            background: white;
            max-width: 600px;
            margin: 0 auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #e74c3c;
        }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<div class="error-box">
    <h1>¡Error en el Registro!</h1>
    <p>Ocurrió un error al procesar tu solicitud.</p>
    <%--Mostrar detalles del error--%>
    <% if (request.getParameter("error") != null) { %>
    <p class="error-details">Detalles: <%= request.getParameter("error") %></p>
    <% } %>
<%--Volver al formulario--%>
<a href="ejercicio5.jsp" class="btn">Intentar nuevamente</a>
</div>
</body>
</html>