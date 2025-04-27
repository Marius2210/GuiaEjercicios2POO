package ejercicio4;

/**
 * Autor: Danilo Antonio Martínez Miranda MM240370
 * Fecha: 26/4/2025
 * Clase Cliente: representa a un cliente de la importadora.
 */


public class Cliente {
    private String nombreCompleto;
    private String sexo;

    // Constructor que inicializa los atributos
    public Cliente(String nombreCompleto, String sexo) {
        this.nombreCompleto = nombreCompleto;
        this.sexo = sexo;
    }

    // Retorna el nombre completo
    public String getNombreCompleto() {
        return nombreCompleto;
    }

    // Retorna el sexo
    public String getSexo() {
        return sexo;
    }
}
