package ejercicio4;

/**
 * Autor: Danilo Antonio Martínez Miranda MM240370
 * Fecha: 26/4/2025
 * Clase Validaciones: realiza las validaciones de entrada de datos.
 */
public class Validaciones {

    // Verifica si el texto es válido (no nulo ni vacío)
    public static boolean esTextoValido(String texto) {
        return texto != null && !texto.trim().isEmpty();
    }

    // Verifica si el año está en el rango válido (2000-2025)
    public static boolean esAnioValido(int anio) {
        return anio >= 2000 && anio <= 2025;
    }

    // Verifica si el precio es válido (mayor que 0)
    public static boolean esPrecioValido(double precio) {
        return precio > 0;
    }
}
