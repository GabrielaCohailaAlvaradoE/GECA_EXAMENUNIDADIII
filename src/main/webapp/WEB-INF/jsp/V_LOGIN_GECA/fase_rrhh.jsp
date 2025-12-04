<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Fase RRHH · Revisión y firma inicial</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: #f5f7fb; }
        header { background: #0f172a; color: #fff; padding: 1rem; }
        main { padding: 1.5rem; max-width: 1200px; margin: 0 auto; }
        .card { background: #fff; border-radius: 10px; padding: 1rem; margin-bottom: 1rem; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; margin-top: 0.5rem; }
        th, td { border: 1px solid #e2e8f0; padding: 0.5rem; text-align: left; }
        th { background: #0ea5e9; color: #fff; }
        .btn { padding: 0.55rem 1rem; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; }
        .btn-primary { background: #2563eb; color: #fff; }
        .btn-secondary { background: #e2e8f0; color: #111827; }
        .pill { display: inline-block; padding: 0.2rem 0.6rem; border-radius: 999px; background: #0ea5e9; color: #fff; font-size: 0.85rem; }
        .alert { padding: 0.75rem 1rem; border-radius: 6px; margin-bottom: 1rem; }
        .alert-success { background: #dcfce7; color: #166534; }
        .alert-error { background: #fee2e2; color: #991b1b; }
        .muted { color: #6b7280; }
        .layout { display: grid; grid-template-columns: 2fr 1fr; gap: 1rem; }
    </style>
</head>
<body>
    <header>
        <h1>Fase 2 · RRHH</h1>
        <p>Revisa la planilla calculada, valida IP autorizada y registra la primera firma.</p>
    </header>
    <main>
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
        <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>

        <div class="card">
            <div style="display:flex; justify-content: space-between; align-items: center; gap: 1rem; flex-wrap: wrap;">
                <div>
                    <h3>Usuario conectado</h3>
                    <p><strong>${usuario.nombreCompleto}</strong> · Rol ${usuario.rol.nombreRol}</p>
                    <p class="muted">Solo se permite firmar desde la IP registrada: ${usuario.ipPermitida != null ? usuario.ipPermitida : 'No definida'}.</p>
                </div>
                <div class="actions">
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/">Volver al tablero</a>
                </div>
            </div>
        </div>

        <div class="card">
            <h3>Selecciona planilla</h3>
            <form method="get" action="${pageContext.request.contextPath}/rrhh">
                <label for="planillaId">Periodo:</label>
                <select id="planillaId" name="planillaId" onchange="this.form.submit()">
                    <c:forEach var="pl" items="${planillas}">
                        <option value="${pl.idPlanilla}" <c:if test="${planillaActual.idPlanilla == pl.idPlanilla}">selected</c:if>>${pl.periodoMes}/${pl.periodoAnio} · ${pl.estado}</option>
                    </c:forEach>
                </select>
            </form>
        </div>

        <c:if test="${not empty planillaActual}">
            <div class="layout">
                <div class="card">
                    <h3>Detalle de cálculo automático (FASE 1)</h3>
                    <p><span class="pill">${planillaActual.periodoMes}/${planillaActual.periodoAnio}</span> · Generada el ${planillaActual.fechaGeneracion}</p>
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
                    <p class="muted">Horas generadas automáticamente (lunes a viernes, 8h diarias). Incluye bonificación 9 % y deducciones ESSALUD/AFP/ONP.</p>
                </div>

                <div class="card">
                    <h3>Firmar fase RRHH</h3>
                    <p>Confirma cálculos y registra observación si firmas desde IP distinta.</p>
                    <form action="${pageContext.request.contextPath}/firmar" method="post">
                        <input type="hidden" name="planillaId" value="${planillaActual.idPlanilla}" />
                        <textarea name="observacion" rows="4" style="width:100%; padding:0.5rem;" placeholder="Observación en caso de IP no permitida"></textarea>
                        <button class="btn btn-primary" type="submit" style="margin-top:0.7rem; width:100%;">Registrar firma RRHH</button>
                    </form>
                    <p class="muted">Se almacenará IP, usuario y hash/token de firma para trazabilidad.</p>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty firmas}">
            <div class="card">
                <h3>Firmas registradas</h3>
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
            </div>
        </c:if>
    </main>
</body>
</html>