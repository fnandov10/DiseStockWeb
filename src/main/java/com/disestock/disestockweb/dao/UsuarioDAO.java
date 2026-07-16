package com.disestock.disestockweb.dao;

import com.disestock.disestockweb.config.ConexionBD;
import com.disestock.disestockweb.modelo.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO {

    public Usuario iniciarSesion(String usuario, String contrasena) {

        Usuario usuarioEncontrado = null;

        String sql = "SELECT * FROM usuarios WHERE usuario = ? AND contrasena = ?";

        try {

            Connection conexion = ConexionBD.conectar();

            PreparedStatement ps = conexion.prepareStatement(sql);

            ps.setString(1, usuario);
            ps.setString(2, contrasena);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                usuarioEncontrado = new Usuario();

                usuarioEncontrado.setId(rs.getInt("id_usuario"));
                usuarioEncontrado.setNombre(rs.getString("nombre"));
                usuarioEncontrado.setUsuario(rs.getString("usuario"));
                usuarioEncontrado.setContrasena(rs.getString("contrasena"));
                usuarioEncontrado.setRol(rs.getString("rol"));
            }

            rs.close();
            ps.close();
            conexion.close();

        } catch (Exception e) {

            e.printStackTrace();

        }

        return usuarioEncontrado;
    }
}