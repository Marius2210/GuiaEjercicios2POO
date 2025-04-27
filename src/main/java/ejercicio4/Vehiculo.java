package ejercicio4;

/**
 * Autor: Danilo Antonio Martínez Miranda MM240370
 * Fecha: 26/4/2025
 * Clase Vehiculo: representa un vehículo vendido.
 */
public class Vehiculo {
    private String marca;
    private int anio;
    private double precio;


    // Constructor que inicializa los atributos
    public Vehiculo(String marca, int anio, double precio) {
        this.marca = marca;
        this.anio = anio;
        this.precio = precio;
    }

    // Retorna la marca del vehículo
    public String getMarca() {
        return marca;
    }

    // Retorna el año del vehículo
    public int getAnio() {
        return anio;
    }

    // Retorna el precio del vehículo
    public double getPrecio() {
        return precio;
    }
}
