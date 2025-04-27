/*
Autor del Código: Mario Ernesto Meléndez Portillo
Carnet:MP240819
Fecha:24/4/2025
*/
package ejercicio5;
import java.sql.*;

public class Service {
    private int id;
    private int idAutomotor;
    private double precioFinal;

    // Constructores
    public Service() {}

    public Service(int idAutomotor) {
        this.idAutomotor = idAutomotor;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdAutomotor() { return idAutomotor; }
    public void setIdAutomotor(int idAutomotor) { this.idAutomotor = idAutomotor; }

    public double getPrecioFinal() { return precioFinal; }
    public void setPrecioFinal(double precioFinal) { this.precioFinal = precioFinal; }

    // Método para insertar el servicio
    public boolean insertar(Connection conexion) throws SQLException {
        String sql = "INSERT INTO service (id_automotor) VALUES (?)";
        try (PreparedStatement ps = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, this.idAutomotor);

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

    // Método para calcular el total a pagar (requerimiento 3)
    public double calcularTotalPago(Connection conexion, boolean esVip) throws SQLException {
        String sql = "SELECT pa.precio FROM automotor a " +
                "JOIN precio_automotor pa ON a.tipo_automotor = pa.tipo_automotor " +
                "WHERE a.id = ?";

        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setInt(1, this.idAutomotor);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    double precioBase = rs.getDouble("precio");
                    this.precioFinal = esVip ? precioBase * 0.85 : precioBase;
                    return this.precioFinal;
                }
            }
        }
        throw new SQLException("No se pudo obtener el precio del automotor");
    }
}
