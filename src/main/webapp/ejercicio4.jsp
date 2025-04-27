<!-- Autor: Danilo Antonio Martínez Miranda MM240370 -->
<!-- Fecha de creación: 27/4/2025 -->
<!-- Descripción: Página para registrar la venta de vehículos, incluyendo datos del cliente y del vehículo. -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="ejercicio4.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Importadora de Vehículos - Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h1 class="text-center mb-4">Registro de Venta de Vehículos</h1>

    <form action="mostrarDatos.jsp" method="post">
        <div class="card p-4">
            <!-- Sección Datos del Cliente -->
            <h4>Datos del Cliente</h4>
            <div class="form-group">
                <label>Nombre Completo:</label>
                <input type="text" name="nombreCompleto" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Sexo:</label>
                <select name="sexo" class="form-control" required>
                    <option value="">Seleccione...</option>
                    <option value="Masculino">Masculino</option>
                    <option value="Femenino">Femenino</option>
                </select>
            </div>

            <!-- Sección Datos del Vehículo -->
            <h4>Datos del Vehículo</h4>
            <div class="form-group">
                <label>Marca:</label>
                <select name="marca" class="form-control" required>
                    <option value="">Seleccione...</option>
                    <option value="Nissan">Nissan</option>
                    <option value="Toyota">Toyota</option>
                    <option value="Kia">Kia</option>
                </select>
            </div>
            <div class="form-group">
                <label>Año:</label>
                <input type="number" name="anio" class="form-control" required min="2000" max="2025">
            </div>
            <div class="form-group">
                <label>Precio ($):</label>
                <input type="number" step="0.01" name="precio" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary btn-block">Registrar Vehículo</button>
        </div>
    </form>

</div>

</body>
</html>
