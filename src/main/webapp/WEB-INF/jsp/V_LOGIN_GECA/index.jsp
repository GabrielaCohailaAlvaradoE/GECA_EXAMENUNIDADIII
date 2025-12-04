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
        main { padding: 1.5rem; max-width: 1200px; margin: 0 auto; }
        .card { background: #fff; border-radius: 8px; padding: 1rem; margin-bottom: 1rem; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        table { width: 100%; border-collapse: collapse; margin-top: 0.5rem; }
        th, td { border: 1px solid #e2e8f0; padding: 0.5rem; text-align: left; }
        th { background: #0ea5e9; color: #fff; }
        .actions { display: flex; gap: 0.5rem; flex-wrap: wrap; }
        .btn { padding: 0.45rem 0.85rem; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .btn-primary { background: #2563eb; color: #fff; }
        .btn-secondary { background: #e2e8f0; color: #111827; }
        .btn-danger { background: #ef4444; color: #fff; }
        .alert { padding: 0.75rem 1rem; border-radius: 6px; margin-bottom: 1rem; }
        .alert-success { background: #dcfce7; color: #166534; }
        .alert-error { background: #fee2e2; color: #991b1b; }
        .pill { display: inline-block; padding: 0.2rem 0.6rem; border-radius: 999px; background: #0ea5e9; color: #fff; font-size: 0.85rem; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 0.75rem; }
        .timeline-step { border-left: 4px solid #0ea5e9; padding-left: 0.75rem; margin-bottom: 0.5rem; }
        .muted { color: #6b7280; }
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
                        <span class="muted">Las fases van desde el cálculo en RRHH hasta la firma del empleado y cierre del jefe.</span>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card">
                    <div style="display:flex; justify-content: space-between; align-items: center; gap: 1rem; flex-wrap: wrap;">
                        <div>
                            <h2>Sesión activa</h2>
                            <p><strong>Usuario:</strong> ${usuario.nombreCompleto} · <strong>Rol:</strong> ${usuario.rol.nombreRol}</p>
                            <p class="muted">Las firmas digitales almacenan usuario, fase y IP para garantizar trazabilidad.</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/logout" method="post">
                            <button class="btn btn-danger" type="submit">Cerrar sesión</button>
                        </form>
                    </div>
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
                        <p class="muted">Horas generadas automáticamente (lunes a viernes, 8h) con bonificación de 9% y deducciones de ESSALUD, AFP u ONP.</p>
                    </div>
                </c:if>

                <c:if test="${not empty planillaActual}">
                    <div class="card">
                        <h3>Flujo de aprobación y pago</h3>
                        <div class="grid">
                            <div class="timeline-step"><strong>FASE 2 · RRHH:</strong> Revisa cálculo y firma desde IP permitida; si no coincide, registra observación.</div>
                            <div class="timeline-step"><strong>FASE 3 · Gerencia:</strong> Gerente Financiero revisa y aprueba/rechaza; Gerente General valida autorización final con IP registrada.</div>
                            <div class="timeline-step"><strong>FASE 4 · Tesorería y Contabilidad:</strong> Tesorería ejecuta transferencias, notifica y adjunta comprobantes PDF; Contabilidad firma registro contable.</div>
                            <div class="timeline-step"><strong>FASE 5 · Notificación:</strong> Se informa a todos los involucrados y se avisa a los empleados que el pago fue procesado.</div>
                            <div class="timeline-step"><strong>FASE 6 · Empleado:</strong> Cada empleado puede visualizar su boleta y firmarla digitalmente desde cualquier dispositivo.</div>
                            <div class="timeline-step"><strong>FASE 7 · Jefe:</strong> Reporte de firmantes y pendientes, con trazabilidad de usuarios, fase y IP almacenados.</div>
                        </div>
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
                        <p class="muted">La autenticidad se respalda almacenando hash/token de firma, usuario, fase e IP de equipo.</p>
                    </div>

                    <div class="card">
                        <h3>Resumen de avance por fases</h3>
                        <div class="grid">
                            <c:forTokens var="faseNombre" items="FASE1_CALCULO,FASE2_RRHH,FASE3_GER_FIN,FASE3_GER_GRAL,FASE4_TESORERIA,FASE4_CONTABILIDAD,FASE6_EMPLEADO,FASE7_REPORTE" delims=",">
                                <c:set var="estadoFase" value="PENDIENTE"/>
                                <c:set var="observacionFase" value=""/>
                                <c:forEach var="fi" items="${firmas}">
                                    <c:if test="${fi.fase eq faseNombre}">
                                        <c:set var="estadoFase" value="${fi.estado}"/>
                                        <c:set var="observacionFase" value="${fi.observacion}"/>
                                    </c:if>
                                </c:forEach>
                                <div class="card" style="margin:0;">
                                    <strong>${faseNombre}</strong>
                                    <p class="muted">Estado: ${estadoFase}</p>
                                    <c:if test="${not empty observacionFase}"><p class="muted">Obs: ${observacionFase}</p></c:if>
                                </div>
                            </c:forTokens>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty planillaActual}">
                    <div class="card">
                        <h3>Registrar firma digital</h3>
                        <p>Tu rol define la fase a firmar. La IP de tu equipo quedará almacenada.</p>
                        <form class="actions" action="${pageContext.request.contextPath}/firmar" method="post">
                            <input type="hidden" name="planillaId" value="${planillaActual.idPlanilla}" />
                            <input type="text" name="observacion" placeholder="Observación (opcional)" style="flex:1; padding:0.4rem; min-width: 240px;" />
                            <button class="btn btn-primary" type="submit">Firmar fase</button>
                        </form>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
    </main>
</body>
</html>