
<!-- Autor: Danilo Martínez Miranda MM240370 -->
<!-- Fecha de creación: 27/4/205 -->
<!-- Descripción: Página que muestra un mensaje de error al procesar los datos ingresados por el usuario. -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-danger text-white">

<div class="container mt-5 text-center">
    <h1>Error al Procesar</h1>
    <p><%= session.getAttribute("error") %></p>
    <a href="ejercicio4.jsp" class="btn btn-light">Volver</a>
</div>

</body>
</html>
