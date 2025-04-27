<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ejercicío1</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
    List<String> errores = (List<String>) request.getAttribute("errores");
    if (errores != null && !errores.isEmpty()) {
%>
<div class="errores">
    <ul>
        <% for(String err : errores) { %>
        <li><%= err %></li>
        <% } %>
    </ul>
</div>
<% } %>
<div class="formu">
    <form action="FichaEstudianteServlet" method="post" >
        <h2>Ficha de Estudiante</h2>
        <input type="text" name="carnet" placeholder="Carnet (AA0000)">
        <input type="text" name="nombres" placeholder="Nombres" >
        <input type="text" name="apellidos" placeholder="Apellidos" >
        <input type="text" name="direccion" placeholder="Dirección" >
        <input type="text" name="telefono" placeholder="0000-0000">
        <input type="text" name="email" placeholder="Correo Electrónico">
        <input type="text" name="fechaNacimiento" placeholder="DD/MM/YYYY">
        <div class="cent">
            <button type="submit">Enviar</button>
            <br>
            <a href="ListarEstudiantesServlet" class="btn">Ver estudiantes registrados</a>
        </div>
    </form>
</div>
<footer class="formu">
    <p>Este ejercicio fue realizado por: Salvador José Garía ruiz<br>Carnet; GR230183</p>
</footer>
</body>
</html>