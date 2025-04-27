<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ejercicio3.Contact" %>
<html>
<head>
    <title>Resultado</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Ejercicio3/styles.css">
</head>
<body>
<div class="container">
    <% if (request.getAttribute("foundContact") != null) {
        Contact found = (Contact) request.getAttribute("foundContact"); %>
    <h2>Contacto Encontrado</h2>
    <p>Nombre: <%= found.getName() %></p>
    <p>Teléfono: <%= found.getPhone() %></p>
    <p>Correo: <%= found.getEmail() %></p>
    <% } %>

    <% if (request.getAttribute("error") != null) { %>
    <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>

    <% if (request.getAttribute("message") != null) { %>
    <p class="success"><%= request.getAttribute("message") %></p>
    <% } %>

    <a href="Ejercicio3/index.jsp">Volver</a>
</div>
</body>
</html>