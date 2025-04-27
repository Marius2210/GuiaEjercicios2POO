<%@ page import="com.ejercicio3.Contact" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Agenda de Contactos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Ejercicio3/styles.css" />
</head>
<body>
<div class="container">
    <h2>Agregar Contacto</h2>
    <form action="${pageContext.request.contextPath}/contacts" method="post" class="form">
        <input type="hidden" name="action" value="add"/>
        <label for="name">Nombre:</label>
        <input type="text" name="name" id="name" required value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"/><br/>

        <label for="phone">Teléfono:</label>
        <input type="text" name="phone" id="phone" required value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>"/><br/>

        <label for="email">Correo:</label>
        <input type="text" name="email" id="email" required value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"/><br/>

        <input type="submit" value="Agregar" />
    </form>

    <h2>Buscar Contacto</h2>
    <form action="${pageContext.request.contextPath}/contacts" method="post" class="form">
        <input type="hidden" name="action" value="search"/>
        <label for="searchName">Nombre:</label>
        <input type="text" name="searchName" id="searchName" required value="<%= request.getAttribute("searchName") != null ? request.getAttribute("searchName") : "" %>"/><br/>
        <input type="submit" value="Buscar" />
    </form>

    <h2><a href="${pageContext.request.contextPath}/contacts">Ver todos los contactos</a></h2>

    <!-- Mensaje de error -->
    <% if (request.getAttribute("error") != null) { %>
    <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>

    <!-- Mensaje de éxito -->
    <% if (request.getAttribute("message") != null) { %>
    <p class="success"><%= request.getAttribute("message") %></p>
    <% } %>

    <!-- Mostrar el contacto encontrado o el error en la búsqueda -->
    <% if (request.getAttribute("foundContact") != null) { %>
    <p><strong>Contacto encontrado:</strong></p>
    <p>Nombre: <%= ((Contact)request.getAttribute("foundContact")).getName() %></p>
    <p>Teléfono: <%= ((Contact)request.getAttribute("foundContact")).getPhone() %></p>
    <p>Correo: <%= ((Contact)request.getAttribute("foundContact")).getEmail() %></p>
    <% } else if (request.getAttribute("error") != null && request.getAttribute("error").equals("Contacto no encontrado.")) { %>
    <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>

</div>
</body>
</html>