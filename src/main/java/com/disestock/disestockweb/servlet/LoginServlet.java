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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        UsuarioDAO dao = new UsuarioDAO();

        Usuario usuarioEncontrado = dao.iniciarSesion(usuario, contrasena);

        if (usuarioEncontrado != null) {

            HttpSession sesion = request.getSession();

            sesion.setAttribute("usuario", usuarioEncontrado);

            response.sendRedirect("dashboard.jsp");

        } else {

            response.getWriter().println("Usuario o contraseña incorrectos.");

        }

    }
}