<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
if(session.getAttribute("usuario")==null){
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>DiseStock — Panel Principal</title>
  <link rel="stylesheet" href="css/styles.css">
</head>
<body>
  <div class="page-wrapper">
  <header>
    <nav class="navbar" role="navigation" aria-label="Navegación principal">
      <a href="dashboard.jsp" class="nav-logo">
        <img src="img/logo.png" alt="DiseStock Logo">
      </a>
      <ul class="nav-links" id="navLinks">
        <li><a href="dashboard.jsp" id="nav-inicio">Inicio</a></li>
        <li><a href="inventario.jsp" id="nav-inventario">Inventario</a></li>
        <li><a href="solicitudes.jsp" id="nav-solicitudes">Solicitudes</a></li>
        <li><a href="reportes.jsp" id="nav-reportes">Reportes</a></li>
        <li><a href="usuarios" id="nav-usuarios">Usuarios</a></li>
      </ul>
      <div class="nav-right" id="navRight">
        <span class="nav-user"><%= session.getAttribute("usuario") %>
</span>>&#128100; <%= session.getAttribute("usuario") %></span>
        <form action="logout" method="post" style="display:inline;"><button class="btn-salir" type="submit">SALIR</button></form>
      </div>
      <button class="nav-toggle" id="navToggle" aria-label="Menu" aria-expanded="false">
        <span></span><span></span><span></span>
      </button>
    </nav>
  </header>
    <main class="main" id="mainContent">
      <h1 class="page-title">Panel Principal</h1>
      <p class="page-subtitle">Bienvenido al sistema de gestión de inventario <strong>DiseStock</strong>.</p>

      <!-- Estadísticas -->
      <section aria-label="Resumen del sistema">
        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-num" id="statProductos">124</div>
            <div class="stat-label">Productos en inventario</div>
          </div>
          <div class="stat-card">
            <div class="stat-num" id="statSolicitudes">8</div>
            <div class="stat-label">Solicitudes pendientes</div>
          </div>
          <div class="stat-card">
            <div class="stat-num" id="statUsuarios">3</div>
            <div class="stat-label">Usuarios activos</div>
          </div>
          <div class="stat-card">
            <div class="stat-num" id="statMovimientos">12</div>
            <div class="stat-label">Movimientos hoy</div>
          </div>
        </div>
      </section>

      <!-- Módulos -->
      <section aria-label="Acceso a módulos">
        <div class="module-grid">
          <a href="inventario.jsp" class="module-card">
            <div class="module-icon">📦</div>
            <h3>Inventario</h3>
            <p>Consulta y control de materiales disponibles.</p>
          </a>
          <a href="solicitudes.jsp" class="module-card">
            <div class="module-icon">📋</div>
            <h3>Solicitudes</h3>
            <p>Gestión de solicitudes y devoluciones.</p>
          </a>
          <a href="reportes.jsp" class="module-card">
            <div class="module-icon">📊</div>
            <h3>Reportes</h3>
            <p>Visualización de reportes del sistema.</p>
          </a>
          <a href="usuarios.jsp" class="module-card">
            <div class="module-icon">👥</div>
            <h3>Usuarios</h3>
            <p>Administración de cuentas y roles.</p>
          </a>
        </div>
      </section>

      <section aria-label="Actividad reciente">
        <div class="card" style="margin-top:0.5rem;">
          <h2 style="font-size:1rem;color:#333;margin-bottom:1rem;display:flex;align-items:center;gap:0.5rem;">🕐 Actividad reciente</h2>
          <div class="table-wrap">
            <table>
              <thead>
                <tr>
                  <th>Evento</th>
                  <th>Usuario</th>
                  <th>Módulo</th>
                  <th>Fecha/Hora</th>
                </tr>
              </thead>
              <tbody>
                <tr><td>Producto agregado</td><td>Luis Pérez</td><td>Inventario</td><td>05/04/2026 08:32</td></tr>
                <tr><td>Solicitud aprobada</td><td>Ana Gómez</td><td>Solicitudes</td><td>05/04/2026 09:15</td></tr>
                <tr><td>Usuario creado</td><td>Luis Pérez</td><td>Usuarios</td><td>04/04/2026 16:40</td></tr>
                <tr><td>Stock actualizado</td><td>María Torres</td><td>Inventario</td><td>04/04/2026 14:22</td></tr>
              </tbody>
            </table>
          </div>
        </div>
      </section>
    </main>
    <footer><p>DiseStock &copy; 2026 — Sistema de Gestión de Inventario · SENA ADSO</p></footer>
  </div>
  <script src="app.js"></script>
  <script>setActiveNav('nav-inicio');</script>
</body>
</html>