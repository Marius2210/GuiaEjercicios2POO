// Autor: Rodrigo Alejandro Pérez
// Fecha: 24/04/2025

package com.ejercicio3;

public class Contact {
    private String name;
    private String phone;
    private String email;

    public Contact(String name, String phone, String email) {
        this.name = name;
        this.phone = phone;
        this.email = email;
    }

    // Getters
    public String getName() { return name; }
    public String getPhone() { return phone; }
    public String getEmail() { return email; }
}