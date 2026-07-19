package com.disestock.disestockweb.modelo;

public class Usuario {

    private int id;
    private String nombre;
    private String apellido;
    private String correo;
    private String rol;
    private String estado;
    private String usuario;
    private String contrasena;

    // Constructor vacío
    public Usuario() {
    }

    // Constructor completo
    public Usuario(
            int id,
            String nombre,
            String apellido,
            String correo,
            String rol,
            String estado,
            String usuario,
            String contrasena) {

        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.correo = correo;
        this.rol = rol;
        this.estado = estado;
        this.usuario = usuario;
        this.contrasena = contrasena;
    }

    // =========================
    // ID
    // =========================

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // =========================
    // NOMBRE
    // =========================

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    // =========================
    // APELLIDO
    // =========================

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    // =========================
    // CORREO
    // =========================

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    // =========================
    // ROL
    // =========================

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    // =========================
    // ESTADO
    // =========================

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    // =========================
    // USUARIO
    // =========================

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    // =========================
    // CONTRASEÑA
    // =========================

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    // Nombre completo para mostrarlo fácilmente
    public String getNombreCompleto() {
        return nombre + " " + apellido;
    }
}