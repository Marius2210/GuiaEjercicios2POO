<%--
Autor del Código: Mario Ernesto Meléndez Portillo
Carnet:MP240819
Fecha:24/4/2025
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection conexion = null;
    ResultSet rs = null;
    PreparedStatement st = null;

    //Usamos try catch para el manejo de errores al conectar la la base de datos
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost/car_clean", "root", "");
        out.println("Conexion exitosa");


    } catch (Exception e) {
        out.println("Error de conexión: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) {}
        try { if (st != null) st.close(); } catch (SQLException e) {}
        try { if (conexion != null) conexion.close(); } catch (SQLException e) {}
    }
%>
