package ejercicio2;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.Period;

/**
 * Calculadora de días de vacaciones.
 * Autor: Danilo Antonio Martínez Miranda MM240370
 * Fecha de creación: 25/04/2025
 */
public class VacacionesCalculator {

    // Método que calcula los días de vacaciones según fecha de ingreso
    public static int calcularDiasVacaciones(String fechaIngreso) throws Exception {
        // Formato que esperamos de la fecha
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // Convertimos la fecha de texto a un objeto de tipo LocalDate
        LocalDate ingreso = LocalDate.parse(fechaIngreso, formatter);

        // Obtenemos la fecha actual
        LocalDate hoy = LocalDate.now();

        // Calculamos los años completos trabajados
        int años = Period.between(ingreso, hoy).getYears();

        // Devolvemos los días según los años trabajados
        if (años >= 1 && años < 3) {
            return 10;
        } else if (años >= 3 && años <= 5) {
            return 15;
        } else if (años > 5) {
            return 21;
        } else {
            return 0;
        }
    }
}
