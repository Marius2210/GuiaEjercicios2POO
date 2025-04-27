package ejercicio4;

import java.util.ArrayList;
import java.util.List;

/**
 * Autor: Danilo Antonio Martínez Miranda MM240370
 * Fecha: 26/4/2025
 * Clase Registro: gestiona la lista de clientes y vehículos vendidos.
 */


public class Registro {
    private static List<Cliente> clientes = new ArrayList<>();
    private static List<Vehiculo> vehiculos = new ArrayList<>();

    // Agrega un cliente y un vehículo al registro
    public static void agregarRegistro(Cliente cliente, Vehiculo vehiculo) {
        clientes.add(cliente);
        vehiculos.add(vehiculo);
    }

    // Retorna la lista de clientes
    public static List<Cliente> getClientes() {
        return clientes;
    }

    // Retorna la lista de vehículos
    public static List<Vehiculo> getVehiculos() {
        return vehiculos;
    }

    // Cuenta vehículos de una marca específica
    public static int contarPorMarca(String marca) {
        int contador = 0;
        for (Vehiculo v : vehiculos) {
            if (v.getMarca().equalsIgnoreCase(marca)) {
                contador++;
            }
        }
        return contador;
    }

    // Suma el precio de los vehículos de una marca específica
    public static double sumaVentasPorMarca(String marca) {
        double suma = 0;
        for (Vehiculo v : vehiculos) {
            if (v.getMarca().equalsIgnoreCase(marca)) {
                suma += v.getPrecio();
            }
        }
        return suma;
    }

    // Cuenta vehículos en un rango de años
    public static int contarPorRangoAnio(int anioInicio, int anioFin) {
        int contador = 0;
        for (Vehiculo v : vehiculos) {
            if (v.getAnio() >= anioInicio && v.getAnio() <= anioFin) {
                contador++;
            }
        }
        return contador;
    }
}
