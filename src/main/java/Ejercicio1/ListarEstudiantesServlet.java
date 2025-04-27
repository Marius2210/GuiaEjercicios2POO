package Ejercicio1;
// Creado por: Salvador José Garía Ruiz
//Carnet: GR230183
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "ListarEstudiantesServlet", value = "/ListarEstudiantesServlet")
public class ListarEstudiantesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (Connection con = Conexion.getConnection()) {
            if (con == null) {
                throw new Exception("No se pudo conectar a la base de datos.");
            }

            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html>");
            out.println("<html lang='es'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<title>Estudiantes Registrados</title>");
            out.println("<link rel='stylesheet' href='css/style.css'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='listado'>");
            out.println("<h2>Listado de estudiantes registrados</h2>");

            String sql = "SELECT carnet, nombres, apellidos, email, telefono, direccion, fecha_nacimiento FROM estudiante";
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            if (!rs.isBeforeFirst()) {
                out.println("<p>No hay estudiantes registrados.</p>");
            } else {
                out.println("<table>");
                out.println("<tr><th>Carnet</th><th>Nombres</th><th>Apellidos</th><th>Email</th><th>Teléfono</th><th>Dirección</th><th>Fecha de Nacimiento</th></tr>");
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("carnet") + "</td>");
                    out.println("<td>" + rs.getString("nombres") + "</td>");
                    out.println("<td>" + rs.getString("apellidos") + "</td>");
                    out.println("<td>" + rs.getString("email") + "</td>");
                    out.println("<td>" + rs.getString("telefono") + "</td>");
                    out.println("<td>" + rs.getString("direccion") + "</td>");
                    out.println("<td>" + rs.getDate("fecha_nacimiento") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }

            out.println("<div class='cent'>");
            out.println("<a href='ejercicio1.jsp' class='btn'>Volver al formulario</a>");
            out.println("<a href='index.jsp' class='btn'>Volver al Menú</a>");
            out.println("</div>");
            out.println("</div>");
            out.println("<footer class='formu'>");
            out.println("<p>Este ejercicio fue realizado por: Salvador José Garía ruiz<br>Carnet; GR230183</p>");
            out.println("</footer>");
            out.println("</body></html>");


        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al listar estudiantes: " + e.getMessage());
        }
    }

}