/*
Autor del Código: Mario Ernesto Meléndez Portillo
Carnet:MP240819
Fecha:24/4/2025
*/
package ejercicio5;
import java.sql.*;

public interface CalculadorPago {
    double calcularTotalPago(Connection conexion, boolean esVip) throws SQLException;
}
