/*
Autor del Código: Mario Ernesto Meléndez Portillo
Carnet:MP240819
Fecha:24/4/2025
*/
package ejercicio5;
import java.sql.*;

public class Automotor {
    private int id;
    private String marca;
    private String modelo;
    private int year;
    private String tipoAutomotor;
    private int idCliente;

    // Constructores
    public Automotor() {}

    public Automotor(String marca, String modelo, int year, String tipoAutomotor, int idCliente) {
        this.marca = marca;
        this.modelo = modelo;
        this.year = year;
        this.tipoAutomotor = tipoAutomotor;
        this.idCliente = idCliente;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getMarca() { return marca; }
    public void setMarca(String marca) { this.marca = marca; }

    public String getModelo() { return modelo; }
    public void setModelo(String modelo) { this.modelo = modelo; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }

    public String getTipoAutomotor() { return tipoAutomotor; }
    public void setTipoAutomotor(String tipoAutomotor) { this.tipoAutomotor = tipoAutomotor; }

    public int getIdCliente() { return idCliente; }
    public void setIdCliente(int idCliente) { this.idCliente = idCliente; }

    // Método para insertar automotor
    public boolean insertar(Connection conexion) throws SQLException {
        String sql = "INSERT INTO automotor (marca, modelo, year, tipo_automotor, id_cliente) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, this.marca);
            ps.setString(2, this.modelo);
            ps.setInt(3, this.year);
            ps.setString(4, this.tipoAutomotor);
            ps.setInt(5, this.idCliente);

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
