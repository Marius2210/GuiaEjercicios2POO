<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ejercicio3.Contact" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Lista de Contactos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Ejercicio3/styles.css">
</head>
<body>
<div class="container">
    <h2>Lista de Contactos</h2>
    <%
        List<Contact> contactList = (List<Contact>) request.getAttribute("contactList");
        for (Contact c : contactList) {
    %>
    <div class="contact">
        <p><strong><%= c.getName() %></strong></p>
        <p>Tel: <%= c.getPhone() %></p>
        <p>Email: <%= c.getEmail() %></p>
    </div>
    <hr/>
    <% } %>

    <a href="Ejercicio3/index.jsp">Volver</a>
</div>
</body>
</html>