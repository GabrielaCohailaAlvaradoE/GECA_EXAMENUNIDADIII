<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login · EXAIII_GECA</title>
    <style>
        body { display: flex; justify-content: center; align-items: center; height: 100vh; background: #0f172a; font-family: Arial, sans-serif; }
        .login-box { background: #fff; padding: 2rem; border-radius: 10px; width: 420px; box-shadow: 0 10px 25px rgba(0,0,0,0.25); }
        h1 { margin-top: 0; color: #0f172a; }
        label { display: block; margin-top: 1rem; font-weight: bold; }
        input { width: 100%; padding: 0.7rem; margin-top: 0.3rem; border-radius: 6px; border: 1px solid #cbd5e1; }
        button { margin-top: 1.2rem; width: 100%; background: #2563eb; color: #fff; border: none; padding: 0.8rem; border-radius: 6px; cursor: pointer; font-size: 1rem; }
        .alert { margin-top: 0.5rem; padding: 0.7rem; border-radius: 6px; }
        .alert-error { background: #fee2e2; color: #991b1b; }
    </style>
</head>
<body>
    <div class="login-box">
        <h1>Acceso seguro</h1>
        <p>Ingresa tus credenciales para continuar con la gestión y firma de planillas.</p>

        <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <label for="username">Usuario</label>
            <input type="text" id="username" name="username" value="${loginForm.username}" required />

            <label for="password">Contraseña</label>
            <input type="password" id="password" name="password" required />

            <button type="submit">Ingresar</button>
        </form>
    </div>
</body>
</html>