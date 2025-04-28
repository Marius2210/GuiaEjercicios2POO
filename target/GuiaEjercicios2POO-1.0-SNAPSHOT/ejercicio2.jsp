<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!--
Autor: Danilo Antonio Martinez Miranda MM240370
Fecha de creación:26/4/2025
Descripción: Formulario para capturar datos del empleado y calcular vacaciones.
-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ejercicio 2 - Vacaciones</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
<h2 class="mb-4">Cálculo de Vacaciones</h2>
<form action="resultadoejercicio2.jsp" method="post">
    <!-- Campo para ingresar el nombre del empleado -->
    <div class="mb-3">
        <label class="form-label">Nombre:</label>
        <input type="text" name="nombre" class="form-control" required>
    </div>
    <!-- Campo para ingresar los apellidos -->
    <div class="mb-3">
        <label class="form-label">Apellidos:</label>
        <input type="text" name="apellidos" class="form-control" required>
    </div>
    <!-- Campo para ingresar el salario -->
    <div class="mb-3">
        <label class="form-label">Salario:</label>
        <input type="number" step="0.01" name="salario" class="form-control" required>
    </div>
    <!-- Campo para ingresar la fecha de ingreso -->
    <div class="mb-3">
        <label class="form-label">Fecha de ingreso (YYYY-MM-DD):</label>
        <input type="date" name="fechaIngreso" class="form-control" required>
    </div>
    <!-- Botón para enviar el formulario -->
    <button type="submit" class="btn btn-primary">Calcular Vacaciones</button>
</form>
</body>
</html>

