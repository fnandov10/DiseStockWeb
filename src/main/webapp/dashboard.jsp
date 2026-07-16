<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.disestock.disestockweb.modelo.Usuario" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {

        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Dashboard DiseStock</title>

</head>

<body>

<h1>Bienvenido <%= usuario.getNombre() %></h1>

<p>Rol: <%= usuario.getRol() %></p>

<p>Inicio de sesión correcto.</p>

</body>

</html>