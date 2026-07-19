package com.disestock.disestockweb.dao;

import com.disestock.disestockweb.config.ConexionBD;
import com.disestock.disestockweb.modelo.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    // =====================================================
    // INICIAR SESIÓN
    // =====================================================

    public Usuario iniciarSesion(String usuario, String contrasena) {

        Usuario usuarioEncontrado = null;

        String sql =
                "SELECT * FROM usuarios " +
                        "WHERE usuario = ? AND contrasena = ?";

        try (
                Connection conexion = ConexionBD.conectar();
                PreparedStatement ps = conexion.prepareStatement(sql)
        ) {

            ps.setString(1, usuario);
            ps.setString(2, contrasena);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    usuarioEncontrado = convertirUsuario(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return usuarioEncontrado;
    }


    // =====================================================
    // LISTAR USUARIOS
    // =====================================================

    public List<Usuario> listarUsuarios() {

        List<Usuario> lista = new ArrayList<>();

        String sql =
                "SELECT * FROM usuarios " +
                        "ORDER BY id_usuario ASC";

        try (
                Connection conexion = ConexionBD.conectar();
                PreparedStatement ps = conexion.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Usuario usuario = convertirUsuario(rs);

                lista.add(usuario);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }


    // =====================================================
    // REGISTRAR USUARIO
    // =====================================================

    public boolean registrarUsuario(Usuario usuario) {

        String sql =
                "INSERT INTO usuarios " +
                        "(nombre, apellido, correo, rol, estado, usuario, contrasena) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (
                Connection conexion = ConexionBD.conectar();
                PreparedStatement ps = conexion.prepareStatement(sql)
        ) {

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getCorreo());
            ps.setString(4, usuario.getRol());
            ps.setString(5, usuario.getEstado());
            ps.setString(6, usuario.getUsuario());
            ps.setString(7, usuario.getContrasena());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // BUSCAR USUARIO POR ID
    // =====================================================

    public Usuario buscarPorId(int id) {

        Usuario usuarioEncontrado = null;

        String sql =
                "SELECT * FROM usuarios " +
                        "WHERE id_usuario = ?";

        try (
                Connection conexion = ConexionBD.conectar();
                PreparedStatement ps = conexion.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    usuarioEncontrado = convertirUsuario(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return usuarioEncontrado;
    }


    // =====================================================
    // ACTUALIZAR USUARIO
    // =====================================================

    public boolean actualizarUsuario(Usuario usuario) {

        String sql =
                "UPDATE usuarios SET " +
                        "nombre = ?, " +
                        "apellido = ?, " +
                        "correo = ?, " +
                        "rol = ?, " +
                        "estado = ?, " +
                        "usuario = ?, " +
                        "contrasena = ? " +
                        "WHERE id_usuario = ?";

        try (
                Connection conexion = ConexionBD.conectar();
                PreparedStatement ps = conexion.prepareStatement(sql)
        ) {

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getCorreo());
            ps.setString(4, usuario.getRol());
            ps.setString(5, usuario.getEstado());
            ps.setString(6, usuario.getUsuario());
            ps.setString(7, usuario.getContrasena());

            ps.setInt(8, usuario.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // ELIMINAR USUARIO
    // =====================================================

    public boolean eliminarUsuario(int id) {

        String sql =
                "DELETE FROM usuarios " +
                        "WHERE id_usuario = ?";

        try (
                Connection conexion = ConexionBD.conectar();
                PreparedStatement ps = conexion.prepareStatement(sql)
        ) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // CONVERTIR RESULTSET EN OBJETO USUARIO
    // =====================================================

    private Usuario convertirUsuario(ResultSet rs)
            throws Exception {

        Usuario usuario = new Usuario();

        usuario.setId(
                rs.getInt("id_usuario")
        );

        usuario.setNombre(
                rs.getString("nombre")
        );

        usuario.setApellido(
                rs.getString("apellido")
        );

        usuario.setCorreo(
                rs.getString("correo")
        );

        usuario.setRol(
                rs.getString("rol")
        );

        usuario.setEstado(
                rs.getString("estado")
        );

        usuario.setUsuario(
                rs.getString("usuario")
        );

        usuario.setContrasena(
                rs.getString("contrasena")
        );

        return usuario;
    }
}