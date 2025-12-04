-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para exaiii_geca_db
CREATE DATABASE IF NOT EXISTS `exaiii_geca_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `exaiii_geca_db`;

-- Volcando estructura para tabla exaiii_geca_db.asientos_contables
CREATE TABLE IF NOT EXISTS `asientos_contables` (
  `id_asiento` int(11) NOT NULL AUTO_INCREMENT,
  `id_planilla` int(11) NOT NULL,
  `cuenta` varchar(10) NOT NULL,
  `denominacion` varchar(100) NOT NULL,
  `debe` decimal(12,2) DEFAULT 0.00,
  `haber` decimal(12,2) DEFAULT 0.00,
  PRIMARY KEY (`id_asiento`),
  KEY `id_planilla` (`id_planilla`),
  CONSTRAINT `asientos_contables_ibfk_1` FOREIGN KEY (`id_planilla`) REFERENCES `planillas` (`id_planilla`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla exaiii_geca_db.asientos_contables: ~17 rows (aproximadamente)
INSERT INTO `asientos_contables` (`id_asiento`, `id_planilla`, `cuenta`, `denominacion`, `debe`, `haber`) VALUES
	(1, 1, '62', 'Gastos de personal y directores', 8892.24, 0.00),
	(2, 1, '6211', 'Sueldos y salarios', 2050.00, 0.00),
	(3, 1, '6214', 'Gratificaciones', 2255.00, 0.00),
	(4, 1, '6215', 'Vacaciones', 2225.00, 0.00),
	(5, 1, '6221', 'Asignación familiar', 205.00, 0.00),
	(6, 1, '6222', 'Bonificación extraordinaria 9%', 202.96, 0.00),
	(7, 1, '6271', 'Régimen de prestaciones de salud', 608.86, 0.00),
	(8, 1, '6291', 'Compensación por tiempo de servicios', 1315.42, 0.00),
	(9, 1, '40', 'Trib. cont. y aportes al sist. pens. y de salud por pagar', 0.00, 1048.59),
	(10, 1, '4031', 'EsSalud', 0.00, 608.86),
	(11, 1, '4032', 'ONP', 0.00, 0.00),
	(12, 1, '41', 'Remuneración y participaciones por pagar', 0.00, 7843.65),
	(13, 1, '4111', 'Sueldos y salarios por pagar', 0.00, 1964.10),
	(14, 1, '4114', 'Gratificaciones por pagar', 0.00, 2167.07),
	(15, 1, '4115', 'Vacaciones por pagar', 0.00, 1964.10),
	(16, 1, '4151', 'Compensación por tiempo de servicios', 0.00, 1315.42),
	(17, 1, '4171', 'AFP', 0.00, 432.96);

-- Volcando estructura para tabla exaiii_geca_db.comprobantes_pago
CREATE TABLE IF NOT EXISTS `comprobantes_pago` (
  `id_comprobante` int(11) NOT NULL AUTO_INCREMENT,
  `id_planilla` int(11) NOT NULL,
  `ruta_pdf` varchar(255) NOT NULL,
  `fecha_carga` datetime NOT NULL,
  `id_usuario_carga` int(11) NOT NULL,
  PRIMARY KEY (`id_comprobante`),
  KEY `id_planilla` (`id_planilla`),
  KEY `id_usuario_carga` (`id_usuario_carga`),
  CONSTRAINT `comprobantes_pago_ibfk_1` FOREIGN KEY (`id_planilla`) REFERENCES `planillas` (`id_planilla`),
  CONSTRAINT `comprobantes_pago_ibfk_2` FOREIGN KEY (`id_usuario_carga`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla exaiii_geca_db.comprobantes_pago: ~0 rows (aproximadamente)

-- Volcando estructura para tabla exaiii_geca_db.empleados
CREATE TABLE IF NOT EXISTS `empleados` (
  `id_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `dni` varchar(15) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  `sueldo_basico` decimal(10,2) NOT NULL,
  `tipo_pension` enum('AFP','ONP') NOT NULL,
  `porc_afp` decimal(5,2) DEFAULT 0.00,
  `porc_onp` decimal(5,2) DEFAULT 0.00,
  `essalud` decimal(5,2) DEFAULT 9.00,
  `asignacion_familiar` decimal(10,2) DEFAULT 0.00,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_empleado`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla exaiii_geca_db.empleados: ~1 rows (aproximadamente)
INSERT INTO `empleados` (`id_empleado`, `dni`, `nombres`, `apellidos`, `fecha_ingreso`, `sueldo_basico`, `tipo_pension`, `porc_afp`, `porc_onp`, `essalud`, `asignacion_familiar`, `estado`) VALUES
	(1, '12345678', 'Juan', 'Pérez López', '2020-01-10', 2050.00, 'AFP', 10.00, 0.00, 9.00, 205.00, 1);

-- Volcando estructura para tabla exaiii_geca_db.firmas_digitales
CREATE TABLE IF NOT EXISTS `firmas_digitales` (
  `id_firma` int(11) NOT NULL AUTO_INCREMENT,
  `id_planilla` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fase` enum('FASE1_CALCULO','FASE2_RRHH','FASE3_GER_FIN','FASE3_GER_GRAL','FASE4_TESORERIA','FASE4_CONTABILIDAD','FASE6_EMPLEADO','FASE7_REPORTE') NOT NULL,
  `fecha_firma` datetime NOT NULL,
  `ip_equipo` varchar(50) NOT NULL,
  `estado` enum('FIRMADO','OBSERVADO','PENDIENTE') NOT NULL DEFAULT 'FIRMADO',
  `observacion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_firma`),
  KEY `id_planilla` (`id_planilla`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `firmas_digitales_ibfk_1` FOREIGN KEY (`id_planilla`) REFERENCES `planillas` (`id_planilla`),
  CONSTRAINT `firmas_digitales_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla exaiii_geca_db.firmas_digitales: ~0 rows (aproximadamente)

-- Volcando estructura para tabla exaiii_geca_db.planillas
CREATE TABLE IF NOT EXISTS `planillas` (
  `id_planilla` int(11) NOT NULL AUTO_INCREMENT,
  `periodo_mes` int(11) NOT NULL,
  `periodo_anio` int(11) NOT NULL,
  `fecha_generacion` datetime NOT NULL,
  `estado` enum('GENERADA','EN_REVISION','APROBADA','PAGADA','COMPLETADA') NOT NULL DEFAULT 'GENERADA',
  `total_bruto` decimal(12,2) DEFAULT 0.00,
  `total_descuentos` decimal(12,2) DEFAULT 0.00,
  `total_neto` decimal(12,2) DEFAULT 0.00,
  PRIMARY KEY (`id_planilla`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla exaiii_geca_db.planillas: ~1 rows (aproximadamente)
INSERT INTO `planillas` (`id_planilla`, `periodo_mes`, `periodo_anio`, `fecha_generacion`, `estado`, `total_bruto`, `total_descuentos`, `total_neto`) VALUES
	(1, 1, 2025, '2025-12-04 10:03:53', 'GENERADA', 8892.24, 1048.59, 7843.65);

-- Volcando estructura para tabla exaiii_geca_db.planilla_detalle
CREATE TABLE IF NOT EXISTS `planilla_detalle` (
  `id_detalle` int(11) NOT NULL AUTO_INCREMENT,
  `id_planilla` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `horas_trabajadas` int(11) NOT NULL,
  `sueldo` decimal(10,2) NOT NULL,
  `gratificacion` decimal(10,2) DEFAULT 0.00,
  `vacaciones` decimal(10,2) DEFAULT 0.00,
  `asignacion_familiar` decimal(10,2) DEFAULT 0.00,
  `bonificacion_9` decimal(10,2) DEFAULT 0.00,
  `regimen_salud` decimal(10,2) DEFAULT 0.00,
  `cts` decimal(10,2) DEFAULT 0.00,
  `essalud_monto` decimal(10,2) DEFAULT 0.00,
  `afp_monto` decimal(10,2) DEFAULT 0.00,
  `onp_monto` decimal(10,2) DEFAULT 0.00,
  `total_bruto` decimal(10,2) DEFAULT 0.00,
  `total_descuentos` decimal(10,2) DEFAULT 0.00,
  `neto_pagar` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`id_detalle`),
  KEY `id_planilla` (`id_planilla`),
  KEY `id_empleado` (`id_empleado`),
  CONSTRAINT `planilla_detalle_ibfk_1` FOREIGN KEY (`id_planilla`) REFERENCES `planillas` (`id_planilla`),
  CONSTRAINT `planilla_detalle_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla exaiii_geca_db.planilla_detalle: ~1 rows (aproximadamente)
INSERT INTO `planilla_detalle` (`id_detalle`, `id_planilla`, `id_empleado`, `horas_trabajadas`, `sueldo`, `gratificacion`, `vacaciones`, `asignacion_familiar`, `bonificacion_9`, `regimen_salud`, `cts`, `essalud_monto`, `afp_monto`, `onp_monto`, `total_bruto`, `total_descuentos`, `neto_pagar`) VALUES
	(1, 1, 1, 176, 2050.00, 2255.00, 2225.00, 205.00, 202.96, 608.86, 1315.42, 608.86, 432.96, 0.00, 8892.24, 1048.59, 7843.65);

-- Volcando estructura para tabla exaiii_geca_db.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla exaiii_geca_db.roles: ~8 rows (aproximadamente)
INSERT INTO `roles` (`id_rol`, `nombre_rol`) VALUES
	(1, 'ADMIN'),
	(2, 'RRHH'),
	(3, 'GERENTE_FINANCIERO'),
	(4, 'GERENTE_GENERAL'),
	(5, 'TESORERIA'),
	(6, 'CONTABILIDAD'),
	(7, 'EMPLEADO'),
	(8, 'JEFE');

-- Volcando estructura para tabla exaiii_geca_db.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `nombre_completo` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `id_rol` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `ip_permitida` varchar(50) DEFAULT NULL,
  `horario_ingreso` time DEFAULT NULL,
  `horario_salida` time DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `username` (`username`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla exaiii_geca_db.usuarios: ~2 rows (aproximadamente)
INSERT INTO `usuarios` (`id_usuario`, `username`, `password`, `nombre_completo`, `email`, `id_rol`, `estado`, `ip_permitida`, `horario_ingreso`, `horario_salida`) VALUES
	(1, 'admin', '{noop}admin123', 'Administrador General', 'admin@geca.com', 1, 1, NULL, '08:00:00', '18:00:00'),
	(2, 'rrhh', '{noop}rrhh123', 'Jefe de RRHH', 'rrhh@geca.com', 2, 1, '192.168.1.10', '08:00:00', '18:00:00');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
