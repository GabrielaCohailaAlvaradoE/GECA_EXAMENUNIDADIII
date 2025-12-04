<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login · EXAIII_GECA</title>
    <style>
        body { display: flex; justify-content: center; align-items: center; height: 100vh; background: linear-gradient(135deg,#0f172a,#111827); font-family: Arial, sans-serif; }
        .login-box { background: #fff; padding: 2rem; border-radius: 12px; width: 440px; box-shadow: 0 12px 28px rgba(0,0,0,0.28); }
        h1 { margin-top: 0; color: #0f172a; }
        p { color: #4b5563; }
        label { display: block; margin-top: 1rem; font-weight: bold; color: #111827; }
        input { width: 100%; padding: 0.7rem; margin-top: 0.3rem; border-radius: 6px; border: 1px solid #cbd5e1; }
        button { margin-top: 1.2rem; width: 100%; background: #2563eb; color: #fff; border: none; padding: 0.8rem; border-radius: 6px; cursor: pointer; font-size: 1rem; }
        .alert { margin-top: 0.8rem; padding: 0.9rem; border-radius: 6px; }
        .alert-error { background: #fee2e2; color: #991b1b; }
        small { color: #6b7280; }
    </style>
</head>
<body>
    <div class="login-box">
        <h1>Acceso seguro</h1>
        <p>Ingresa con tu usuario corporativo para continuar con el flujo de firmas digitales de planillas.</p>

        <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <label for="username">Usuario</label>
            <input type="text" id="username" name="username" value="${loginForm.username}" required />

            <label for="password">Contraseña</label>
            <input type="password" id="password" name="password" required />

            <button type="submit">Ingresar</button>
            <small>El sistema valida horario autorizado e IP registrada para RRHH antes de permitir la firma.</small>
        </form>
    </div>
</body>
</html>