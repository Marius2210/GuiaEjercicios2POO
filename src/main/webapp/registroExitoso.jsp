<%--
Autor del Código: Mario Ernesto Meléndez Portillo
Carnet:MP240819
Fecha:26/4/2025
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registro Exitoso - Car Clean</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
            background-color: #f5f5f5;
        }
        .success-box {
            background: white;
            max-width: 600px;
            margin: 0 auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #27ae60;
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

<div class="success-box">
    <%--Mostrar el registro exitoso y datos del cliente y total a pagar y enlace para volver atrás--%>
    <h1>¡Registro Exitoso!</h1>
    <p>Cliente: <%= request.getParameter("nombres") %> <%= request.getParameter("apellidos") %></p>
    <p>Total a pagar: $<%= String.format("%.2f", Double.parseDouble(request.getParameter("total"))) %></p>
    <a href="ejercicio5.jsp" class="btn">Regresar</a>
</div>
</body>
</html>
