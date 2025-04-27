/*
Autor del Código: Mario Ernesto Meléndez Portillo
Carnet:MP240819
Fecha:24/4/2025
*/
package ejercicio5;
import java.sql.*;

public class Cliente {
    private int id;
    private String nombres;
    private String apellidos;
    private boolean vip;

    // Constructor vacío
    public Cliente() {}

    // Constructor con parámetros
    public Cliente(String nombres, String apellidos, boolean vip) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.vip = vip;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }

    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }

    public boolean isVip() { return vip; }
    public void setVip(boolean vip) { this.vip = vip; }

    // Método para insertar cliente en la BD
    public boolean insertar(Connection conexion) throws SQLException {
        String sql = "INSERT INTO cliente (nombres, apellidos, vip) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, this.nombres);
            ps.setString(2, this.apellidos);
            ps.setBoolean(3, this.vip);

            // Ejecuta el INSERT y obtiene el número de filas afectadas
            int filasAfectadas = ps.executeUpdate();

            // Si se insertó al menos una fila (lo normal sería 1)
            if (filasAfectadas > 0) {
                // Obtiene las claves generadas (el ID autoincremental)
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    // Si hay una clave generada disponible
                    if (generatedKeys.next()) {
                        this.id = generatedKeys.getInt(1);
                        return true;
                    }
                }
            }
            return false;
        }
    }
}
