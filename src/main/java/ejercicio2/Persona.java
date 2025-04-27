package ejercicio2;

/**
 * Clase que representa a una persona.
 * Autor: Danilo Antonio Martinez Miranda MM240370
 * Fecha de creación: 25/4/2025
 */
public class Persona {
    private String nombre;
    private String apellidos;
    private double salario;
    private String fechaIngreso;

    // Constructor que recibe todos los datos de la persona
    public Persona(String nombre, String apellidos, double salario, String fechaIngreso) {
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.salario = salario;
        this.fechaIngreso = fechaIngreso;
    }
    // Método que devuelve el nombre completo (nombre + apellidos)
    public String getNombreCompleto() {
        return nombre + " " + apellidos;
    }
    // Getter del salario
    public double getSalario() {
        return salario;
    }
    // Getter de la fecha de ingreso
    public String getFechaIngreso() {
        return fechaIngreso;
    }
}

