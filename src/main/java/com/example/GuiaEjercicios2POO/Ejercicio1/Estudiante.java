package com.example.GuiaEjercicios2POO.Ejercicio1;
// Creado por: Salvador José Garía Ruiz
//Carnet: GR230183
public class Estudiante {
    private String carnet, nombres, apellidos, direccion, telefono, email, fechaNacimiento;

    public Estudiante(String carnet, String nombres, String apellidos, String direccion,
                      String telefono, String email, String fechaNacimiento) {
        this.carnet = carnet;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.direccion = direccion;
        this.telefono = telefono;
        this.email = email;
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getCarnet() { return carnet; }
    public String getNombres() { return nombres; }
    public String getApellidos() { return apellidos; }
    public String getDireccion() { return direccion; }
    public String getTelefono() { return telefono; }
    public String getEmail() { return email; }
    public String getFechaNacimiento() { return fechaNacimiento; }
}