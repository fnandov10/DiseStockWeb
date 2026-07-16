package com.disestock.disestockweb.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionBD {

    private static final String URL = "jdbc:mysql://localhost:3306/disestock";
    private static final String USER = "root";
    private static final String PASSWORD = "Dise1234";

    public static Connection conectar() {

        Connection conexion = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            conexion = DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("Conexión exitosa a la base de datos.");

        } catch (Exception e) {

            System.out.println("Error de conexión: " + e.getMessage());
            e.printStackTrace();
        }

        return conexion;
    }
}