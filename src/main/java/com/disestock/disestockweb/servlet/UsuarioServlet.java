package com.disestock.disestockweb.servlet;

import com.disestock.disestockweb.dao.UsuarioDAO;
import com.disestock.disestockweb.modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/usuarios")
public class UsuarioServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO;

    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }

    // =====================================================
    // GET: LISTAR, EDITAR O ELIMINAR
    // =====================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);

        // Verificar que exista una sesión iniciada
        if (sesion == null ||
                sesion.getAttribute("usuario") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/index.jsp"
            );

            return;
        }

        String accion = request.getParameter("accion");

        if (accion == null || accion.trim().isEmpty()) {

            listarUsuarios(request, response);

            return;
        }

        switch (accion) {

            case "editar":
                mostrarUsuarioEditar(request, response);
                break;

            case "eliminar":
                eliminarUsuario(request, response);
                break;

            default:
                listarUsuarios(request, response);
                break;
        }
    }


    // =====================================================
    // POST: REGISTRAR O ACTUALIZAR
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession sesion = request.getSession(false);

        // Verificar sesión
        if (sesion == null ||
                sesion.getAttribute("usuario") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/index.jsp"
            );

            return;
        }

        String accion = request.getParameter("accion");

        if ("actualizar".equals(accion)) {

            actualizarUsuario(request, response);

        } else {

            registrarUsuario(request, response);
        }
    }


    // =====================================================
    // LISTAR USUARIOS
    // =====================================================

    private void listarUsuarios(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Usuario> listaUsuarios =
                usuarioDAO.listarUsuarios();

        request.setAttribute(
                "listaUsuarios",
                listaUsuarios
        );

        request.getRequestDispatcher("/usuarios.jsp")
                .forward(request, response);
    }


    // =====================================================
    // REGISTRAR USUARIO
    // =====================================================

    private void registrarUsuario(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Recibir datos del formulario
        String nombre =
                request.getParameter("nombre");

        String apellido =
                request.getParameter("apellido");

        String correo =
                request.getParameter("correo");

        String usuario =
                request.getParameter("usuario");

        String contrasena =
                request.getParameter("contrasena");

        String rol =
                request.getParameter("rol");

        String estado =
                request.getParameter("estado");


        // Validar campos obligatorios
        if (campoVacio(nombre)
                || campoVacio(apellido)
                || campoVacio(correo)
                || campoVacio(usuario)
                || campoVacio(contrasena)
                || campoVacio(rol)
                || campoVacio(estado)) {

            request.setAttribute(
                    "error",
                    "Todos los campos son obligatorios."
            );

            listarUsuarios(request, response);

            return;
        }


        // Crear objeto Usuario
        Usuario nuevoUsuario = new Usuario();

        nuevoUsuario.setNombre(nombre.trim());
        nuevoUsuario.setApellido(apellido.trim());
        nuevoUsuario.setCorreo(correo.trim());
        nuevoUsuario.setUsuario(usuario.trim());
        nuevoUsuario.setContrasena(contrasena);
        nuevoUsuario.setRol(rol);
        nuevoUsuario.setEstado(estado);


        // Guardar en MySQL
        boolean registrado =
                usuarioDAO.registrarUsuario(nuevoUsuario);


        if (registrado) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/usuarios?mensaje=registrado"
            );

        } else {

            request.setAttribute(
                    "error",
                    "No fue posible registrar el usuario."
            );

            listarUsuarios(request, response);
        }
    }


    // =====================================================
    // MOSTRAR USUARIO PARA EDITAR
    // =====================================================

    private void mostrarUsuarioEditar(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(
                    request.getParameter("id")
            );

            Usuario usuarioEditar =
                    usuarioDAO.buscarPorId(id);


            if (usuarioEditar != null) {

                request.setAttribute(
                        "usuarioEditar",
                        usuarioEditar
                );

            } else {

                request.setAttribute(
                        "error",
                        "El usuario solicitado no existe."
                );
            }


        } catch (NumberFormatException e) {

            request.setAttribute(
                    "error",
                    "El identificador del usuario no es válido."
            );
        }


        listarUsuarios(request, response);
    }


    // =====================================================
    // ACTUALIZAR USUARIO
    // =====================================================

    private void actualizarUsuario(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(
                    request.getParameter("id")
            );


            String nombre =
                    request.getParameter("nombre");

            String apellido =
                    request.getParameter("apellido");

            String correo =
                    request.getParameter("correo");

            String usuario =
                    request.getParameter("usuario");

            String contrasena =
                    request.getParameter("contrasena");

            String rol =
                    request.getParameter("rol");

            String estado =
                    request.getParameter("estado");


            // Validar campos
            if (campoVacio(nombre)
                    || campoVacio(apellido)
                    || campoVacio(correo)
                    || campoVacio(usuario)
                    || campoVacio(contrasena)
                    || campoVacio(rol)
                    || campoVacio(estado)) {

                request.setAttribute(
                        "error",
                        "Todos los campos son obligatorios."
                );

                listarUsuarios(request, response);

                return;
            }


            // Crear objeto actualizado
            Usuario usuarioActualizado =
                    new Usuario();

            usuarioActualizado.setId(id);

            usuarioActualizado.setNombre(
                    nombre.trim()
            );

            usuarioActualizado.setApellido(
                    apellido.trim()
            );

            usuarioActualizado.setCorreo(
                    correo.trim()
            );

            usuarioActualizado.setUsuario(
                    usuario.trim()
            );

            usuarioActualizado.setContrasena(
                    contrasena
            );

            usuarioActualizado.setRol(
                    rol
            );

            usuarioActualizado.setEstado(
                    estado
            );


            // Actualizar MySQL
            boolean actualizado =
                    usuarioDAO.actualizarUsuario(
                            usuarioActualizado
                    );


            if (actualizado) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/usuarios?mensaje=actualizado"
                );

            } else {

                request.setAttribute(
                        "error",
                        "No fue posible actualizar el usuario."
                );

                listarUsuarios(request, response);
            }


        } catch (NumberFormatException e) {

            request.setAttribute(
                    "error",
                    "El identificador del usuario no es válido."
            );

            listarUsuarios(request, response);
        }
    }


    // =====================================================
    // ELIMINAR USUARIO
    // =====================================================

    private void eliminarUsuario(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        try {

            int id = Integer.parseInt(
                    request.getParameter("id")
            );


            boolean eliminado =
                    usuarioDAO.eliminarUsuario(id);


            if (eliminado) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/usuarios?mensaje=eliminado"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/usuarios?mensaje=error"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/usuarios?mensaje=error"
            );
        }
    }


    // =====================================================
    // VALIDAR CAMPO VACÍO
    // =====================================================

    private boolean campoVacio(String valor) {

        return valor == null ||
                valor.trim().isEmpty();
    }
}