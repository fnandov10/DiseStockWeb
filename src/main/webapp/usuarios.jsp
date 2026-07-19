<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.disestock.disestockweb.modelo.Usuario" %>

<%
    // Verificar sesión
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Si se entra directamente al JSP,
    // pasar primero por el Servlet para cargar MySQL
    if (request.getAttribute("listaUsuarios") == null) {
        response.sendRedirect(request.getContextPath() + "/usuarios");
        return;
    }

    List<Usuario> listaUsuarios =
            (List<Usuario>) request.getAttribute("listaUsuarios");

    Usuario usuarioEditar =
            (Usuario) request.getAttribute("usuarioEditar");

    boolean modoEdicion = usuarioEditar != null;

    String error =
            (String) request.getAttribute("error");

    String mensaje =
            request.getParameter("mensaje");
%>

<!DOCTYPE html>

<html lang="es">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DiseStock — Gestión de Usuarios</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/styles.css">

    <style>

        /* ========================================
           CONTENEDOR PRINCIPAL
           ======================================== */

        .usuarios-container {
            max-width: 1250px;
            margin: 0 auto;
            padding: 105px 24px 50px;
        }

        .usuarios-header {
            margin-bottom: 25px;
        }

        .usuarios-header h1 {
            color: var(--cyan);
            font-size: 1.8rem;
            margin-bottom: 5px;
        }

        .usuarios-header p {
            color: #667085;
        }


        /* ========================================
           GRID
           ======================================== */

        .usuarios-grid {

            display: grid;

            grid-template-columns:
                    minmax(330px, 390px)
                    minmax(0, 1fr);

            gap: 25px;

            align-items: start;
        }


        /* ========================================
           TARJETAS
           ======================================== */

        .usuarios-card {

            background: #ffffff;

            border-radius: 10px;

            padding: 24px;

            box-shadow:
                    0 3px 12px
                    rgba(0, 0, 0, 0.10);
        }

        .usuarios-card h2 {

            margin-bottom: 20px;

            font-size: 1.2rem;
        }


        /* ========================================
           FORMULARIO
           ======================================== */

        .usuarios-form-row {

            display: grid;

            grid-template-columns: 1fr 1fr;

            gap: 12px;
        }

        .usuarios-form-group {

            margin-bottom: 15px;
        }

        .usuarios-form-group label {

            display: block;

            margin-bottom: 6px;

            font-size: 0.84rem;

            font-weight: 600;
        }

        .usuarios-form-group input,
        .usuarios-form-group select {

            width: 100%;

            padding: 10px 12px;

            border:
                    1px solid #d9dee7;

            border-radius: 6px;

            font-size: 0.88rem;

            background: #fafafa;
        }

        .usuarios-form-group input:focus,
        .usuarios-form-group select:focus {

            outline: none;

            border-color: var(--cyan);

            background: white;
        }


        /* ========================================
           BOTONES FORMULARIO
           ======================================== */

        .btn-guardar {

            width: 100%;

            border: none;

            padding: 11px;

            border-radius: 6px;

            cursor: pointer;

            font-weight: 700;

            color: white;

            background: var(--cyan);
        }

        .btn-guardar:hover {

            opacity: 0.9;
        }

        .btn-cancelar {

            display: block;

            margin-top: 10px;

            text-align: center;

            padding: 10px;

            border-radius: 6px;

            background: #eef1f5;

            color: #444;

            text-decoration: none;

            font-weight: 600;
        }


        /* ========================================
           TABLA
           ======================================== */

        .usuarios-table-wrapper {

            width: 100%;

            overflow-x: auto;
        }

        .usuarios-table {

            width: 100%;

            border-collapse: collapse;

            min-width: 760px;
        }

        .usuarios-table th {

            background: var(--cyan);

            color: white;

            text-align: left;

            padding: 11px;

            font-size: 0.78rem;
        }

        .usuarios-table td {

            padding: 11px;

            border-bottom:
                    1px solid #e5e7eb;

            font-size: 0.82rem;

            vertical-align: middle;
        }

        .usuarios-table tr:hover {

            background: #f8fafc;
        }


        /* ========================================
           BADGES
           ======================================== */

        .rol-badge {

            display: inline-block;

            padding: 4px 8px;

            border-radius: 15px;

            background: #eef8fb;

            color: #0786a8;

            font-size: 0.72rem;

            font-weight: 600;
        }

        .estado-activo {

            display: inline-block;

            padding: 4px 8px;

            border-radius: 15px;

            background: #eaf8ef;

            color: #237a3b;

            font-size: 0.72rem;

            font-weight: 600;
        }

        .estado-inactivo {

            display: inline-block;

            padding: 4px 8px;

            border-radius: 15px;

            background: #fdecec;

            color: #b42318;

            font-size: 0.72rem;

            font-weight: 600;
        }


        /* ========================================
           ACCIONES
           ======================================== */

        .acciones {

            white-space: nowrap;
        }

        .btn-editar,
        .btn-eliminar {

            display: inline-block;

            padding: 6px 8px;

            border-radius: 5px;

            text-decoration: none;

            font-size: 0.75rem;

            font-weight: 600;
        }

        .btn-editar {

            background: #eef7ff;

            color: #1677b8;
        }

        .btn-eliminar {

            background: #fff0f0;

            color: #d64545;

            margin-left: 3px;
        }


        /* ========================================
           MENSAJES
           ======================================== */

        .mensaje-exito,
        .mensaje-error {

            padding: 11px 14px;

            margin-bottom: 20px;

            border-radius: 6px;

            font-size: 0.88rem;
        }

        .mensaje-exito {

            background: #eaf8ef;

            color: #237a3b;
        }

        .mensaje-error {

            background: #fdecec;

            color: #b42318;
        }

        .sin-usuarios {

            text-align: center;

            padding: 25px !important;

            color: #667085;
        }


        /* ========================================
           RESPONSIVE
           ======================================== */

        @media (max-width: 950px) {

            .usuarios-grid {

                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 550px) {

            .usuarios-form-row {

                grid-template-columns: 1fr;
            }
        }

    </style>

</head>


<body>

<div class="page-wrapper">


    <!-- =========================================
         NAVBAR
         ========================================= -->

    <header>

        <nav class="navbar"
             role="navigation"
             aria-label="Navegación principal">


            <a href="<%= request.getContextPath() %>/dashboard.jsp"
               class="nav-logo">

                <img
                        src="<%= request.getContextPath() %>/img/logo.png"
                        alt="DiseStock Logo">

            </a>


            <ul class="nav-links">

                <li>

                    <a href="<%= request.getContextPath() %>/dashboard.jsp">

                        Inicio

                    </a>

                </li>


                <li>

                    <a href="#">

                        Inventario

                    </a>

                </li>


                <li>

                    <a href="#">

                        Solicitudes

                    </a>

                </li>


                <li>

                    <a href="#">

                        Reportes

                    </a>

                </li>


                <li>

                    <a href="<%= request.getContextPath() %>/usuarios">

                        Usuarios

                    </a>

                </li>

            </ul>


            <div class="nav-right">

                <span class="nav-user">

                    👤 <%= session.getAttribute("usuario") %>

                </span>


                <form
                        action="<%= request.getContextPath() %>/logout"
                        method="post"
                        style="display:inline;">

                    <button
                            type="submit"
                            class="btn-salir">

                        SALIR

                    </button>

                </form>

            </div>

        </nav>

    </header>


    <!-- =========================================
         CONTENIDO
         ========================================= -->

    <main class="usuarios-container">


        <div class="usuarios-header">

            <h1>

                Gestión de Usuarios

            </h1>

            <p>

                Administración de usuarios y roles
                del sistema DiseStock.

            </p>

        </div>


        <!-- =====================================
             MENSAJES
             ===================================== -->


        <% if ("registrado".equals(mensaje)) { %>


        <div class="mensaje-exito">

            Usuario registrado correctamente.

        </div>


        <% } else if ("actualizado".equals(mensaje)) { %>


        <div class="mensaje-exito">

            Usuario actualizado correctamente.

        </div>


        <% } else if ("eliminado".equals(mensaje)) { %>


        <div class="mensaje-exito">

            Usuario eliminado correctamente.

        </div>


        <% } else if ("error".equals(mensaje)) { %>


        <div class="mensaje-error">

            No fue posible realizar la operación.

        </div>


        <% } %>


        <% if (error != null) { %>


        <div class="mensaje-error">

            <%= error %>

        </div>


        <% } %>


        <!-- =====================================
             GRID PRINCIPAL
             ===================================== -->

        <div class="usuarios-grid">


            <!-- =================================
                 FORMULARIO
                 ================================= -->

            <section class="usuarios-card">


                <h2>

                    <%= modoEdicion
                            ? "Editar usuario"
                            : "Registrar usuario" %>

                </h2>


                <form
                        action="<%= request.getContextPath() %>/usuarios"
                        method="post">


                    <% if (modoEdicion) { %>


                    <input
                            type="hidden"
                            name="accion"
                            value="actualizar">


                    <input
                            type="hidden"
                            name="id"
                            value="<%= usuarioEditar.getId() %>">


                    <% } else { %>


                    <input
                            type="hidden"
                            name="accion"
                            value="registrar">


                    <% } %>


                    <!-- NOMBRE Y APELLIDO -->


                    <div class="usuarios-form-row">


                        <div class="usuarios-form-group">

                            <label for="nombre">

                                Nombre

                            </label>

                            <input
                                    type="text"
                                    id="nombre"
                                    name="nombre"
                                    required
                                    placeholder="Nombre"
                                    value="<%= modoEdicion
                                        ? usuarioEditar.getNombre()
                                        : "" %>">

                        </div>


                        <div class="usuarios-form-group">

                            <label for="apellido">

                                Apellido

                            </label>

                            <input
                                    type="text"
                                    id="apellido"
                                    name="apellido"
                                    required
                                    placeholder="Apellido"
                                    value="<%= modoEdicion
                                        ? usuarioEditar.getApellido()
                                        : "" %>">

                        </div>

                    </div>


                    <!-- CORREO -->


                    <div class="usuarios-form-group">

                        <label for="correo">

                            Correo electrónico

                        </label>

                        <input
                                type="email"
                                id="correo"
                                name="correo"
                                required
                                placeholder="correo@disestock.com"
                                value="<%= modoEdicion
                                    ? usuarioEditar.getCorreo()
                                    : "" %>">

                    </div>


                    <!-- USUARIO -->


                    <div class="usuarios-form-group">

                        <label for="usuario">

                            Usuario

                        </label>

                        <input
                                type="text"
                                id="usuario"
                                name="usuario"
                                required
                                placeholder="Nombre de usuario"
                                value="<%= modoEdicion
                                    ? usuarioEditar.getUsuario()
                                    : "" %>">

                    </div>


                    <!-- CONTRASEÑA -->


                    <div class="usuarios-form-group">

                        <label for="contrasena">

                            Contraseña

                        </label>

                        <input
                                type="password"
                                id="contrasena"
                                name="contrasena"
                                required
                                placeholder="Contraseña"
                                value="<%= modoEdicion
                                    ? usuarioEditar.getContrasena()
                                    : "" %>">

                    </div>


                    <!-- ROL Y ESTADO -->


                    <div class="usuarios-form-row">


                        <div class="usuarios-form-group">

                            <label for="rol">

                                Rol

                            </label>


                            <select
                                    id="rol"
                                    name="rol"
                                    required>


                                <option value="">

                                    Seleccione

                                </option>


                                <option
                                        value="Administrador"

                                        <%= modoEdicion
                                                && "Administrador".equals(
                                                usuarioEditar.getRol())

                                                ? "selected"
                                                : "" %>>

                                    Administrador

                                </option>


                                <option
                                        value="Bodeguero"

                                        <%= modoEdicion
                                                && "Bodeguero".equals(
                                                usuarioEditar.getRol())

                                                ? "selected"
                                                : "" %>>

                                    Bodeguero

                                </option>


                                <option
                                        value="Tecnico"

                                        <%= modoEdicion
                                                && "Tecnico".equals(
                                                usuarioEditar.getRol())

                                                ? "selected"
                                                : "" %>>

                                    Técnico

                                </option>


                            </select>

                        </div>


                        <div class="usuarios-form-group">

                            <label for="estado">

                                Estado

                            </label>


                            <select
                                    id="estado"
                                    name="estado"
                                    required>


                                <option
                                        value="Activo"

                                        <%= !modoEdicion
                                                || "Activo".equals(
                                                usuarioEditar.getEstado())

                                                ? "selected"
                                                : "" %>>

                                    Activo

                                </option>


                                <option
                                        value="Inactivo"

                                        <%= modoEdicion
                                                && "Inactivo".equals(
                                                usuarioEditar.getEstado())

                                                ? "selected"
                                                : "" %>>

                                    Inactivo

                                </option>


                            </select>

                        </div>

                    </div>


                    <!-- BOTÓN -->


                    <button
                            type="submit"
                            class="btn-guardar">

                        <%= modoEdicion

                                ? "ACTUALIZAR USUARIO"

                                : "REGISTRAR USUARIO" %>

                    </button>


                    <% if (modoEdicion) { %>


                    <a
                            href="<%= request.getContextPath() %>/usuarios"
                            class="btn-cancelar">

                        CANCELAR EDICIÓN

                    </a>


                    <% } %>


                </form>

            </section>


            <!-- =================================
                 TABLA DE USUARIOS
                 ================================= -->


            <section class="usuarios-card">


                <h2>

                    Usuarios registrados

                </h2>


                <div class="usuarios-table-wrapper">


                    <table class="usuarios-table">


                        <thead>


                        <tr>

                            <th>ID</th>

                            <th>Nombre</th>

                            <th>Correo</th>

                            <th>Usuario</th>

                            <th>Rol</th>

                            <th>Estado</th>

                            <th>Acciones</th>

                        </tr>


                        </thead>


                        <tbody>


                        <%

                            if (listaUsuarios != null
                                    && !listaUsuarios.isEmpty()) {

                                for (Usuario u : listaUsuarios) {

                        %>


                        <tr>


                            <td>

                                <%= u.getId() %>

                            </td>


                            <td>

                                <%= u.getNombre() %>
                                <%= u.getApellido() %>

                            </td>


                            <td>

                                <%= u.getCorreo() %>

                            </td>


                            <td>

                                <%= u.getUsuario() %>

                            </td>


                            <td>

                                <span class="rol-badge">

                                    <%= u.getRol() %>

                                </span>

                            </td>


                            <td>


                                <% if ("Activo".equalsIgnoreCase(
                                        u.getEstado())) { %>


                                <span class="estado-activo">

                                    Activo

                                </span>


                                <% } else { %>


                                <span class="estado-inactivo">

                                    Inactivo

                                </span>


                                <% } %>


                            </td>


                            <td class="acciones">


                                <a
                                        class="btn-editar"

                                        href="<%= request.getContextPath() %>/usuarios?accion=editar&id=<%= u.getId() %>">

                                    Editar

                                </a>


                                <a
                                        class="btn-eliminar"

                                        href="<%= request.getContextPath() %>/usuarios?accion=eliminar&id=<%= u.getId() %>"

                                        onclick="return confirm(
                                        '¿Está seguro de eliminar este usuario?'
                                        );">

                                    Eliminar

                                </a>


                            </td>


                        </tr>


                        <%

                            }

                        } else {

                        %>


                        <tr>


                            <td
                                    colspan="7"
                                    class="sin-usuarios">

                                No hay usuarios registrados.

                            </td>


                        </tr>


                        <% } %>


                        </tbody>


                    </table>


                </div>


            </section>


        </div>


    </main>


</div>


</body>

</html>