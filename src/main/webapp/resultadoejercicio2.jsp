<%@ page import="ejercicio2.Persona" %>
<%@ page import="ejercicio2.VacacionesCalculator" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--
Autor: Danilo Antonio Martinez Miranda MM240370
Fecha de creación: 26/4/2025
Descripción: Página JSP que recibe datos del formulario, valida la entrada
y muestra los resultados del cálculo de vacaciones o los errores encontrados.
-->
<%
    // Obtención de parámetros del formulario
    String nombre = request.getParameter("nombre") != null ? request.getParameter("nombre").trim() : "";
    String apellidos = request.getParameter("apellidos") != null ? request.getParameter("apellidos").trim() : "";
    String salarioStr = request.getParameter("salario") != null ? request.getParameter("salario").trim() : "";
    String fechaIngreso = request.getParameter("fechaIngreso") != null ? request.getParameter("fechaIngreso").trim() : "";

    // Variables para mensajes de error
    String errorNombre = "";
    String errorApellidos = "";
    String errorSalario = "";
    String errorFecha = "";
    boolean tieneErrores = false;

    // Validación del nombre
    if (nombre.isEmpty()) {
        errorNombre = "El nombre es obligatorio.";
        tieneErrores = true;
    } else if (!nombre.matches("^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$")) {
        errorNombre = "El nombre solo puede contener letras y espacios.";
        tieneErrores = true;
    }

    // Validación de apellidos
    if (apellidos.isEmpty()) {
        errorApellidos = "Los apellidos son obligatorios.";
        tieneErrores = true;
    } else if (!apellidos.matches("^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$")) {
        errorApellidos = "Los apellidos solo pueden contener letras y espacios.";
        tieneErrores = true;
    }

    // Validación del salario
    double salario = 0.0;
    if (salarioStr.isEmpty()) {
        errorSalario = "El salario es obligatorio.";
        tieneErrores = true;
    } else {
        try {
            salario = Double.parseDouble(salarioStr);
            if (salario < 0) {
                errorSalario = "El salario no puede ser negativo.";
                tieneErrores = true;
            }
        } catch (NumberFormatException e) {
            errorSalario = "El salario debe ser un número válido.";
            tieneErrores = true;
        }
    }

    // Validación de la fecha de ingreso
    if (fechaIngreso.isEmpty()) {
        errorFecha = "La fecha de ingreso es obligatoria.";
        tieneErrores = true;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resultado</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">

<% if (tieneErrores) { %>
<!-- Mostrar mensajes de error si existen -->
<div class="alert alert-danger">
    <ul>
        <% if (!errorNombre.isEmpty()) { %><li><%= errorNombre %></li><% } %>
        <% if (!errorApellidos.isEmpty()) { %><li><%= errorApellidos %></li><% } %>
        <% if (!errorSalario.isEmpty()) { %><li><%= errorSalario %></li><% } %>
        <% if (!errorFecha.isEmpty()) { %><li><%= errorFecha %></li><% } %>
    </ul>
</div>
<!-- Botón para volver al formulario -->
<a href="ejercicio2.jsp" class="btn btn-warning">Volver y corregir</a>

<% } else {
    try {
        // Crear objeto Persona y calcular días de vacaciones
        Persona persona = new Persona(nombre, apellidos, salario, fechaIngreso);
        int diasVacaciones = VacacionesCalculator.calcularDiasVacaciones(fechaIngreso);
%>
<!-- Mostrar resultados si no hay errores -->
<h3 class="mb-4">Resultado del Cálculo</h3>
<ul class="list-group">
    <li class="list-group-item">Nombre Completo: <strong><%= persona.getNombreCompleto() %></strong></li>
    <li class="list-group-item">Salario: <strong>$<%= new DecimalFormat("0.00").format(persona.getSalario()) %></strong></li>
    <li class="list-group-item">Fecha de Ingreso: <strong><%= persona.getFechaIngreso() %></strong></li>
    <li class="list-group-item">Días de Vacaciones: <strong><%= diasVacaciones %></strong></li>
</ul>
<!-- Botón para volver -->
<a href="ejercicio2.jsp" class="btn btn-secondary mt-3">Volver</a>

<%
} catch (Exception ex) {
%>
<!-- Captura y muestra errores durante el procesamiento -->
<div class="alert alert-danger mt-4">
    Error al calcular las vacaciones: <%= ex.getMessage() %>
</div>
<a href="ejercicio2.jsp" class="btn btn-warning">Volver</a>
<%
        }
    }
%>

</body>
</html>