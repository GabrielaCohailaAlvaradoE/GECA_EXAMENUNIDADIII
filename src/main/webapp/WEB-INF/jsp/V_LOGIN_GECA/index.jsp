<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>EXAIII_GECA - Gestión de Planillas</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: #f4f6f9; }
        header { background: #0f172a; color: #fff; padding: 1rem; }
        main { padding: 1.5rem; }
        .card { background: #fff; border-radius: 8px; padding: 1rem; margin-bottom: 1rem; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        table { width: 100%; border-collapse: collapse; margin-top: 0.5rem; }
        th, td { border: 1px solid #e2e8f0; padding: 0.5rem; text-align: left; }
        th { background: #0ea5e9; color: #fff; }
        .actions { display: flex; gap: 0.5rem; }
        .btn { padding: 0.45rem 0.85rem; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .btn-primary { background: #2563eb; color: #fff; }
        .btn-secondary { background: #e2e8f0; color: #111827; }
        .btn-danger { background: #ef4444; color: #fff; }
        .alert { padding: 0.75rem 1rem; border-radius: 6px; margin-bottom: 1rem; }
        .alert-success { background: #dcfce7; color: #166534; }
        .alert-error { background: #fee2e2; color: #991b1b; }
        .pill { display: inline-block; padding: 0.2rem 0.6rem; border-radius: 999px; background: #0ea5e9; color: #fff; font-size: 0.85rem; }
    </style>
</head>
<body>
    <header>
        <h1>EXAIII_GECA · Gestión de Pago de Planilla con firmas digitales</h1>
        <p>Automatiza la aprobación, pago y firma de planillas con trazabilidad completa.</p>
    </header>

    <main>
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
        <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>

        <c:choose>
            <c:when test="${empty usuario}">
                <div class="card">
                    <h2>Bienvenido</h2>
                    <p>Para acceder al flujo de firmas digitales y revisar las planillas generadas debes autenticarte.</p>
                    <div class="actions">
                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/login">Ir al login</a>
                        <a class="btn btn-secondary" href="#">Revisa el objetivo: trazabilidad y autenticidad de cada fase (FASE1 a FASE7).</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card">
                    <div style="display:flex; justify-content: space-between; align-items: center;">
                        <div>
                            <h2>Sesión activa</h2>
                            <p><strong>Usuario:</strong> ${usuario.nombreCompleto} · <strong>Rol:</strong> ${usuario.rol.nombreRol}</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/logout" method="post">
                            <button class="btn btn-danger" type="submit">Cerrar sesión</button>
                        </form>
                    </div>
                    <p>Las firmas digitales almacenan usuario, fase y IP para garantizar trazabilidad.</p>
                </div>

                <div class="card">
                    <h3>Planillas generadas</h3>
                    <form method="get" action="${pageContext.request.contextPath}/">
                        <label for="planillaId">Selecciona periodo:</label>
                        <select id="planillaId" name="planillaId" onchange="this.form.submit()">
                            <c:forEach var="pl" items="${planillas}">
                                <option value="${pl.idPlanilla}" <c:if test="${planillaActual.idPlanilla == pl.idPlanilla}">selected</c:if>>
                                    ${pl.periodoMes}/${pl.periodoAnio} · Estado ${pl.estado}
                                </option>
                            </c:forEach>
                        </select>
                    </form>
                    <c:if test="${not empty planillaActual}">
                        <p><span class="pill">Periodo ${planillaActual.periodoMes}/${planillaActual.periodoAnio}</span> · Generada: ${planillaActual.fechaGeneracion}</p>
                        <p><strong>Totales:</strong> Bruto ${planillaActual.totalBruto} · Descuentos ${planillaActual.totalDescuentos} · Neto ${planillaActual.totalNeto}</p>
                    </c:if>
                </div>

                <c:if test="${not empty detalles}">
                    <div class="card">
                        <h3>Detalle por empleado (FASE1 · cálculo RRHH)</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>Empleado</th>
                                    <th>Horas</th>
                                    <th>Sueldo</th>
                                    <th>Bonif 9%</th>
                                    <th>ESSALUD</th>
                                    <th>AFP/ONP</th>
                                    <th>Neto</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="det" items="${detalles}">
                                    <tr>
                                        <td>${det.empleado.nombres} ${det.empleado.apellidos}</td>
                                        <td>${det.horasTrabajadas}</td>
                                        <td>${det.sueldo}</td>
                                        <td>${det.bonificacion9}</td>
                                        <td>${det.essaludMonto}</td>
                                        <td><c:out value="${det.afpMonto > 0 ? det.afpMonto : det.onpMonto}"/></td>
                                        <td>${det.netoPagar}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>

                <c:if test="${not empty firmas}">
                    <div class="card">
                        <h3>Bitácora de firmas digitales</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>Fase</th>
                                    <th>Usuario</th>
                                    <th>Estado</th>
                                    <th>IP</th>
                                    <th>Fecha</th>
                                    <th>Observación</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="fi" items="${firmas}">
                                    <tr>
                                        <td>${fi.fase}</td>
                                        <td>${fi.usuario.nombreCompleto}</td>
                                        <td>${fi.estado}</td>
                                        <td>${fi.ipEquipo}</td>
                                        <td>${fi.fechaFirma}</td>
                                        <td>${fi.observacion}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <p>Las fases cubren RRHH, Gerencia Financiera y General, Tesorería, Contabilidad, Empleado y Reporte del Jefe (FASE7).</p>
                    </div>
                </c:if>

                <c:if test="${not empty planillaActual}">
                    <div class="card">
                        <h3>Registrar firma digital</h3>
                        <p>Tu rol define la fase a firmar. La IP de tu equipo quedará almacenada.</p>
                        <form class="actions" action="${pageContext.request.contextPath}/firmar" method="post">
                            <input type="hidden" name="planillaId" value="${planillaActual.idPlanilla}" />
                            <input type="text" name="observacion" placeholder="Observación (opcional)" style="flex:1; padding:0.4rem;" />
                            <button class="btn btn-primary" type="submit">Firmar fase</button>
                        </form>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
    </main>
</body>
</html>