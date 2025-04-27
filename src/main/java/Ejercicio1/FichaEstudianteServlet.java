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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "FichaEstudianteServlet", value = "/FichaEstudianteServlet")
public class FichaEstudianteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String carnet = request.getParameter("carnet");
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");
        String fechaNacimientoStr = request.getParameter("fechaNacimiento");

        List<String> errores = new ArrayList<>();

        // Validaciones del formulario
        if (carnet == null || !carnet.matches("^[A-Z]{2}\\d{4}$")) {
            errores.add("El carnet debe tener el formato AA0000 (2 letras seguidas de 4 números).");
        }

        if (nombres == null || nombres.trim().isEmpty()) {
            errores.add("Los nombres no pueden estar vacíos.");
        } else if (nombres.length() > 25) {
            errores.add("Los nombres no pueden tener más de 25 caracteres.");
        }

        if (apellidos == null || apellidos.trim().isEmpty()) {
            errores.add("Los apellidos no pueden estar vacíos.");
        } else if (apellidos.length() > 25) {
            errores.add("Los apellidos no pueden tener más de 25 caracteres.");
        }

        if (direccion == null || direccion.trim().isEmpty()) {
            errores.add("La dirección no puede estar vacía.");
        } else if (direccion.length() > 255) {
            errores.add("La dirección no puede tener más de 255 caracteres.");
        }

        if (telefono == null || !telefono.matches("^\\d{4}-\\d{4}$")) {
            errores.add("El teléfono debe tener el formato 0000-0000.");
        }

        if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.\\w{2,}$")) {
            errores.add("El correo electrónico no es válido.");
        }

        Date fechaNacimiento = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            sdf.setLenient(false);
            fechaNacimiento = sdf.parse(fechaNacimientoStr);
        } catch (Exception e) {
            errores.add("La fecha de nacimiento debe tener el formato dd/MM/yyyy.");
        }

        // Si hay error lo envia al formulario
        if (!errores.isEmpty()) {
            request.setAttribute("errores", errores);
            request.getRequestDispatcher("ejercicio1.jsp").forward(request, response);
            return;
        }

        try (Connection con = Conexion.getConnection()) {
            if (con == null) {
                throw new Exception("No se pudo conectar a la base de datos.");
            }

            String sql = "INSERT INTO estudiante (carnet, nombres, apellidos, direccion, telefono, email, fecha_nacimiento) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, carnet);
            stmt.setString(2, nombres);
            stmt.setString(3, apellidos);
            stmt.setString(4, direccion);
            stmt.setString(5, telefono);
            stmt.setString(6, email);
            stmt.setDate(7, new java.sql.Date(fechaNacimiento.getTime()));

            stmt.executeUpdate();

            // ! registrado correctamente xd ¡
            PrintWriter out = response.getWriter();
            out.println("<html><head><title>Registro Exitoso</title>");
            out.println("<link rel='stylesheet' href='css/style.css'>");
            out.println("</head><body>");
            out.println("<div class='formu'>");
            out.println("<h2>Estudiante registrado correctamente</h2>");
            out.println("<a class='btn' href='index.jsp'>Volver al formulario</a><br>");
            out.println("<a class='btn' href='ListarEstudiantesServlet'>Ver estudiantes registrados</a>");
            out.println("</div></body></html>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al registrar el estudiante: " + e.getMessage());
        }
    }
}