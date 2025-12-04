   <label for="planillaId">Periodo:</label>
                <select id="planillaId" name="planillaId" onchange="this.form.submit()">
                    <c:forEach var="pl" items="${planillas}">
                        <option value="${pl.idPlanilla}" <c:if test="${planillaActual.idPlanilla == pl.idPlanilla}">selected</c:if>>${pl.periodoMes}/${pl.periodoAnio} · ${pl.estado}</option>
                    </c:forEach>
                </select>
            </form>
        </div>

        <c:if test="${not empty planillaActual}">
            <div class="card">
                <h3>Resumen para pago</h3>
                <p><span class="pill">${planillaActual.periodoMes}/${planillaActual.periodoAnio}</span> · Neto total ${planillaActual.totalNeto}</p>
                <table>
                    <thead>
                        <tr>
                            <th>Empleado</th>
                            <th>Cuenta</th>
                            <th>Neto pagar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="det" items="${detalles}">
                            <tr>
                                <td>${det.empleado.nombres} ${det.empleado.apellidos}</td>
                                <td>${det.empleado.numeroCuenta}</td>
                                <td>${det.netoPagar}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="grid">
                <div class="card">
                    <h3>Firma Tesorería</h3>
                    <p class="muted">Confirma transferencias y mensaje enviado al empleado. Adjunta referencia del comprobante.</p>
                    <form action="${pageContext.request.contextPath}/firmar" method="post">
                        <input type="hidden" name="planillaId" value="${planillaActual.idPlanilla}" />
                        <textarea name="observacion" rows="4" style="width:100%; padding:0.5rem;" placeholder="Ej: Transferencias ejecutadas, comprobante PDF subido"></textarea>
                        <button class="btn btn-primary" type="submit" style="margin-top:0.7rem; width:100%;">Firmar como Tesorería</button>
                    </form>
                </div>
                <div class="card">
                    <h3>Firma Contabilidad</h3>
                    <p class="muted">Registra el asiento contable completo de la planilla.</p>
                    <form action="${pageContext.request.contextPath}/firmar" method="post">
                        <input type="hidden" name="planillaId" value="${planillaActual.idPlanilla}" />
                        <textarea name="observacion" rows="4" style="width:100%; padding:0.5rem;" placeholder="Ej: Asiento contable registrado, referencia al comprobante"></textarea>
                        <button class="btn btn-primary" type="submit" style="margin-top:0.7rem; width:100%;">Firmar como Contabilidad</button>
                    </form>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty firmas}">
            <div class="card">
                <h3>Historial de firmas</h3>
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