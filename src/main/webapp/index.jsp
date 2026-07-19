<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DiseStock — Iniciar Sesión</title>

    <link rel="stylesheet" href="css/styles.css">
</head>

<body>

<div class="login-page">

    <nav class="login-nav">
        <img src="img/logo.png" alt="DiseStock Logo">
    </nav>

    <main class="login-body">

        <section class="login-card" aria-label="Formulario de inicio de sesión">

            <h1 class="login-title">
                Iniciar Sesión
            </h1>

            <% if(request.getParameter("error") != null){ %>

            <div class="alert alert-error show">
                Usuario o contraseña incorrectos.
            </div>

            <% } %>

            <form action="login" method="post">

                <div class="form-group">

                    <label for="usuario">
                        Usuario
                    </label>

                    <div class="input-icon-wrap">

                        <span class="icon">👤</span>

                        <input
                                type="text"
                                id="usuario"
                                name="usuario"
                                placeholder="Ingrese su usuario"
                                required>

                    </div>

                </div>

                <div class="form-group">

                    <label for="contrasena">
                        Contraseña
                    </label>

                    <div class="input-icon-wrap">

                        <span class="icon">🔒</span>

                        <input
                                type="password"
                                id="contrasena"
                                name="contrasena"
                                placeholder="Ingrese su contraseña"
                                required>

                    </div>

                </div>

                <button
                        type="submit"
                        class="btn btn-primary btn-login">

                    INGRESAR ➜

                </button>

            </form>

            <p class="forgot-link">

                ¿OLVIDASTE TU CONTRASEÑA?

            </p>

        </section>

    </main>

</div>

</body>

</html>