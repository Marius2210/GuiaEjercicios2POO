// Autor: Rodrigo Alejandro Pérez
// Fecha: 24/04/2025

package com.ejercicio3;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "contacts", value = "/contacts")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            switch (action) {
                case "add":
                    addContact(request, response);
                    break;
                case "search":
                    searchContact(request, response);
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error al procesar la solicitud: " + e.getMessage());
            request.getRequestDispatcher("/Ejercicio3/result.jsp").forward(request, response);
        }
    }

    //Agregar un contacto
    private void addContact(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        //Validaciones
        if (name.isEmpty() || phone.isEmpty() || email.isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("/Ejercicio3/index.jsp").forward(request, response);
            return;
        }

        if (!name.matches("^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$")) {
            request.setAttribute("error", "El nombre solo puede contener letras y espacios.");
            request.getRequestDispatcher("/Ejercicio3/index.jsp").forward(request, response);
            return;
        }

        if (!phone.matches("^\\d{7,15}$")) {
            request.setAttribute("error", "El teléfono debe contener solo números (entre 7 y 15 dígitos).");
            request.getRequestDispatcher("/Ejercicio3/index.jsp").forward(request, response);
            return;
        }

        if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            request.setAttribute("error", "El correo electrónico no tiene un formato válido.");
            request.getRequestDispatcher("/Ejercicio3/index.jsp").forward(request, response);
            return;
        }

        //Query para agregar los datos
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO contacts (name, phone, email) VALUES (?, ?, ?)")) {

            stmt.setString(1, name);
            stmt.setString(2, phone);
            stmt.setString(3, email);
            stmt.executeUpdate();
            request.setAttribute("message", "Contacto agregado exitosamente.");
        } catch (SQLException e) {
            request.setAttribute("error", "Error al guardar el contacto: " + e.getMessage());
        }

        request.getRequestDispatcher("/Ejercicio3/result.jsp").forward(request, response);  // Hacemos forward a result.jsp para mostrar mensaje de éxito
    }

    //Busqueda de contactos
    private void searchContact(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchName = request.getParameter("searchName");
        Contact found = null;

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM contacts WHERE name = ?")) {

            stmt.setString(1, searchName);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                found = new Contact(
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("email")
                );
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Error al buscar el contacto: " + e.getMessage());
        }

        if (found != null) {
            request.setAttribute("foundContact", found);
        } else {
            request.setAttribute("error", "Contacto no encontrado.");
        }


        request.getRequestDispatcher("/Ejercicio3/result.jsp").forward(request, response);
    }

    //Mostrar todos los contactos
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Contact> contactList = new ArrayList<>();

        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM contacts")) {

            while (rs.next()) {
                Contact c = new Contact(
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("email")
                );
                contactList.add(c);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Error al obtener los contactos: " + e.getMessage());
        }

        request.setAttribute("contactList", contactList);
        request.getRequestDispatcher("/Ejercicio3/list.jsp").forward(request, response);
    }
}