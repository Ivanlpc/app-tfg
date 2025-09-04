-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.42 - MySQL Community Server - GPL
-- SO del servidor:              Linux
-- HeidiSQL Versión:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para mikel
CREATE DATABASE IF NOT EXISTS `mikel` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mikel`;

-- Volcando estructura para tabla mikel.categorias
CREATE TABLE IF NOT EXISTS `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.categorias_evento
CREATE TABLE IF NOT EXISTS `categorias_evento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.convocados
CREATE TABLE IF NOT EXISTS `convocados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `partido_id` int NOT NULL,
  `jugador_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_partido_jugador` (`partido_id`,`jugador_id`),
  KEY `idx_jugador_id` (`jugador_id`),
  CONSTRAINT `convocados_ibfk_1` FOREIGN KEY (`partido_id`) REFERENCES `partidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `convocados_ibfk_2` FOREIGN KEY (`jugador_id`) REFERENCES `jugadores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.descargas
CREATE TABLE IF NOT EXISTS `descargas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `tarea_id` int NOT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_completada` datetime DEFAULT NULL,
  `estado` int DEFAULT '0',
  `progreso` float DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_descargas_user` (`user_id`),
  KEY `fk_descargas_tarea` (`tarea_id`),
  CONSTRAINT `fk_descargas_tarea` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_descargas_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.equipos
CREATE TABLE IF NOT EXISTS `equipos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo` enum('masculino','femenino','mixto') NOT NULL DEFAULT 'mixto',
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_equipos_user_id` (`user_id`),
  CONSTRAINT `fk_equipos_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.equipo_liga
CREATE TABLE IF NOT EXISTS `equipo_liga` (
  `id` int NOT NULL AUTO_INCREMENT,
  `equipo_id` int NOT NULL,
  `liga_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_equipo_liga` (`equipo_id`,`liga_id`),
  KEY `equipo_liga_ibfk_liga` (`liga_id`),
  CONSTRAINT `equipo_liga_ibfk_equipo` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `equipo_liga_ibfk_liga` FOREIGN KEY (`liga_id`) REFERENCES `liga` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.eventos
CREATE TABLE IF NOT EXISTS `eventos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `video_id` int NOT NULL,
  `tiempo_seg` int NOT NULL,
  `tipo_evento_id` int DEFAULT NULL,
  `partido_id` int NOT NULL,
  `equipo_id` int DEFAULT NULL,
  `jugador_id` int DEFAULT NULL,
  `descripcion` text,
  `evento_personalizado_id` int DEFAULT NULL,
  `zona_tiro` varchar(20) DEFAULT NULL,
  `resultado_tiro` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_video_id` (`video_id`),
  KEY `idx_tipo_evento_id` (`tipo_evento_id`),
  KEY `idx_partido_id` (`partido_id`),
  KEY `idx_equipo_id` (`equipo_id`),
  KEY `idx_jugador_id` (`jugador_id`),
  KEY `fk_eventos_evento_personalizado` (`evento_personalizado_id`),
  CONSTRAINT `eventos_ibfk_equipo` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `eventos_ibfk_jugador` FOREIGN KEY (`jugador_id`) REFERENCES `jugadores` (`id`) ON DELETE SET NULL,
  CONSTRAINT `eventos_ibfk_partido` FOREIGN KEY (`partido_id`) REFERENCES `partidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `eventos_ibfk_tipo_evento` FOREIGN KEY (`tipo_evento_id`) REFERENCES `tipo_evento` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `eventos_ibfk_video` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_eventos_evento_personalizado` FOREIGN KEY (`evento_personalizado_id`) REFERENCES `evento_personalizado` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ck_un_solo_tipo_evento` CHECK ((((`tipo_evento_id` is not null) and (`evento_personalizado_id` is null)) or ((`tipo_evento_id` is null) and (`evento_personalizado_id` is not null))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.eventos_seleccionados_video
CREATE TABLE IF NOT EXISTS `eventos_seleccionados_video` (
  `id` int NOT NULL AUTO_INCREMENT,
  `video_id` int NOT NULL,
  `user_id` int NOT NULL,
  `tipo_evento_id` int DEFAULT NULL,
  `evento_personalizado_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_video_evento_usuario` (`video_id`,`user_id`,`tipo_evento_id`,`evento_personalizado_id`),
  KEY `fk_esv_user` (`user_id`),
  KEY `fk_esv_tipo_evento` (`tipo_evento_id`),
  KEY `fk_esv_evento_personalizado` (`evento_personalizado_id`),
  CONSTRAINT `fk_esv_evento_personalizado` FOREIGN KEY (`evento_personalizado_id`) REFERENCES `evento_personalizado` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_esv_tipo_evento` FOREIGN KEY (`tipo_evento_id`) REFERENCES `tipo_evento` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_esv_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_esv_video` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `eventos_seleccionados_video_chk_1` CHECK ((((`tipo_evento_id` is not null) and (`evento_personalizado_id` is null)) or ((`tipo_evento_id` is null) and (`evento_personalizado_id` is not null))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.evento_personalizado
CREATE TABLE IF NOT EXISTS `evento_personalizado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `categoria_evento_id` int NOT NULL,
  `es_equipo` tinyint(1) DEFAULT '0',
  `es_global` tinyint(1) DEFAULT '0',
  `es_jugador` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estadistica_tipo` enum('gol','falta','perdida','recuperacion') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_evento_personalizado_usuario` (`user_id`,`nombre`),
  KEY `categoria_evento_id` (`categoria_evento_id`),
  CONSTRAINT `evento_personalizado_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `evento_personalizado_ibfk_2` FOREIGN KEY (`categoria_evento_id`) REFERENCES `categorias_evento` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.jugadores
CREATE TABLE IF NOT EXISTS `jugadores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `dorsal` int DEFAULT NULL,
  `rol` enum('jugador','entrenador') NOT NULL DEFAULT 'jugador',
  `equipo_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `es_capitan` tinyint(1) DEFAULT '0',
  `posicion_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `equipo_id` (`equipo_id`),
  KEY `fk_posicion` (`posicion_id`),
  CONSTRAINT `fk_posicion` FOREIGN KEY (`posicion_id`) REFERENCES `posiciones` (`id`) ON DELETE SET NULL,
  CONSTRAINT `jugadores_ibfk_1` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.jugadores_en_pista
CREATE TABLE IF NOT EXISTS `jugadores_en_pista` (
  `id` int NOT NULL AUTO_INCREMENT,
  `partido_id` int NOT NULL,
  `jugador_id` int NOT NULL,
  `equipo_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_jugador_pista_entrada` (`partido_id`,`jugador_id`),
  KEY `jugador_id` (`jugador_id`),
  KEY `equipo_id` (`equipo_id`),
  CONSTRAINT `jugadores_en_pista_ibfk_1` FOREIGN KEY (`partido_id`) REFERENCES `partidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `jugadores_en_pista_ibfk_2` FOREIGN KEY (`jugador_id`) REFERENCES `jugadores` (`id`) ON DELETE CASCADE,
  CONSTRAINT `jugadores_en_pista_ibfk_3` FOREIGN KEY (`equipo_id`) REFERENCES `equipos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.liga
CREATE TABLE IF NOT EXISTS `liga` (
  `id` int NOT NULL AUTO_INCREMENT,
  `temporada_id` int NOT NULL,
  `categoria_id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_temporada_liga_nombre` (`temporada_id`,`nombre`),
  KEY `liga_ibfk_categoria` (`categoria_id`),
  CONSTRAINT `liga_ibfk_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `liga_ibfk_temporada` FOREIGN KEY (`temporada_id`) REFERENCES `temporada` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.partidos
CREATE TABLE IF NOT EXISTS `partidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `liga_id` int NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `equipo_local_id` int DEFAULT NULL,
  `equipo_visitante_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `goles_local` int DEFAULT NULL,
  `goles_visitante` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_equipo_local_id` (`equipo_local_id`),
  KEY `idx_equipo_visitante_id` (`equipo_visitante_id`),
  KEY `partidos_ibfk_liga` (`liga_id`),
  CONSTRAINT `partidos_ibfk_2` FOREIGN KEY (`equipo_local_id`) REFERENCES `equipos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `partidos_ibfk_3` FOREIGN KEY (`equipo_visitante_id`) REFERENCES `equipos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `partidos_ibfk_liga` FOREIGN KEY (`liga_id`) REFERENCES `liga` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.posiciones
CREATE TABLE IF NOT EXISTS `posiciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `color` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.tareas
CREATE TABLE IF NOT EXISTS `tareas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `video_id` int NOT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_completada` datetime DEFAULT NULL,
  `estado` int DEFAULT NULL,
  `progreso` float DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `video_id` (`video_id`),
  CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tareas_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.temporada
CREATE TABLE IF NOT EXISTS `temporada` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_proyecto_nombre` (`user_id`,`nombre`),
  CONSTRAINT `temporada_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.tipo_evento
CREATE TABLE IF NOT EXISTS `tipo_evento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `es_equipo` tinyint(1) NOT NULL DEFAULT '0',
  `es_global` tinyint(1) NOT NULL DEFAULT '0',
  `es_jugador` tinyint(1) NOT NULL DEFAULT '0',
  `categoria_evento_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_nombre` (`nombre`),
  KEY `fk_categoria_evento` (`categoria_evento_id`),
  CONSTRAINT `fk_categoria_evento` FOREIGN KEY (`categoria_evento_id`) REFERENCES `categorias_evento` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla mikel.videos
CREATE TABLE IF NOT EXISTS `videos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `partido_id` int NOT NULL,
  `filename` varchar(255) NOT NULL,
  `uploaded_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `duracion_segundos` int NOT NULL,
  `fps` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_partido_id` (`partido_id`),
  CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`partido_id`) REFERENCES `partidos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `jugadores_tracking` (
  `tarea_id` int NOT NULL,
  `jugador_id` int NOT NULL,
  `id` int NOT NULL,
  PRIMARY KEY (`tarea_id`,`jugador_id`,`id`),
  KEY `fk_jugador` (`jugador_id`),
  CONSTRAINT `fk_jugador` FOREIGN KEY (`jugador_id`) REFERENCES `jugadores` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tarea` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para vista mikel.vista_convocados
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_convocados` (
	`jugador_id` INT(10) NOT NULL,
	`jugador_nombre` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`jugador_apellido` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`jugador_dorsal` INT(10) NULL,
	`jugador_rol` ENUM('jugador','entrenador') NOT NULL COLLATE 'utf8mb4_general_ci',
	`partido_id` INT(10) NOT NULL,
	`equipo_id` INT(10) NOT NULL,
	`equipo_nombre` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`tipo_equipo` VARCHAR(9) NOT NULL COLLATE 'latin1_swedish_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista mikel.v_estadisticas_jugador_partido
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `v_estadisticas_jugador_partido` (
	`partido_id` INT(10) NOT NULL,
	`fecha_partido` DATETIME NOT NULL,
	`equipo_local` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`equipo_visitante` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`jugador_id` INT(10) NOT NULL,
	`jugador` VARCHAR(216) NOT NULL COLLATE 'utf8mb4_general_ci',
	`equipo_jugador` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`tiros_campo` VARCHAR(49) NULL COLLATE 'latin1_swedish_ci',
	`tiros_7m` VARCHAR(49) NULL COLLATE 'latin1_swedish_ci',
	`perdidas` DECIMAL(23,0) NULL,
	`recuperaciones` DECIMAL(23,0) NULL,
	`faltas_cometidas` DECIMAL(23,0) NULL,
	`faltas_recibidas` DECIMAL(23,0) NULL,
	`asistencias` DECIMAL(23,0) NULL
) ENGINE=MyISAM;

-- Insert categories
INSERT INTO `categorias` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Benjamines', 'Categoría para niños y niñas de hasta 10 años.'),
(2, 'Alevines', 'Categoría para niños y niñas de 11 y 12 años.'),
(3, 'Infantiles', 'Categoría para jugadores de 13 y 14 años.'),
(4, 'Cadetes', 'Categoría para jugadores de 15 y 16 años.'),
(5, 'Juveniles', 'Categoría para jugadores de 17 y 18 años.'),
(6, 'Senior', 'Categoría para mayores de 18 años.');

-- Insert positions
INSERT INTO `posiciones` (`id`, `nombre`, `color`) VALUES
(1, 'portero', '#1E90FF'),
(2, 'lateral', '#FF8C00'),
(3, 'central', '#FFD700'),
(4, 'pivote', '#DC143C'),
(5, 'extremo', '#32CD32');

-- Insert event categories
INSERT INTO `categorias_evento` (`id`, `nombre`) VALUES
(1, 'Tiro'),
(2, 'Falta'),
(3, 'Sanción'),
(4, 'Sustitución'),
(5, 'Global'),
(6, 'Táctica'),
(7, '7 Metros'),
(8, 'Paradas'),
(9, 'Perdidas'),
(10, 'Defensa'),
(11, 'Asistencias');

-- Insert event types
INSERT INTO `tipo_evento` (`id`, `nombre`, `es_equipo`, `es_global`, `es_jugador`, `categoria_evento_id`) VALUES
(4, 'Falta cometida', 0, 0, 1, 2),
(5, 'Exclusión 2 minutos', 0, 0, 1, 3),
(6, 'Entra en pista', 0, 0, 1, 4),
(7, 'Sale de pista', 0, 0, 1, 4),
(8, 'Inicio primer tiempo', 0, 1, 0, 5),
(9, 'Fin primer tiempo', 0, 1, 0, 5),
(10, 'Tiempo muerto', 1, 0, 0, 6),
(11, 'Fin sanción 2 minutos', 0, 0, 1, 3),
(12, 'Falta Recibida', 0, 0, 1, 2),
(13, 'Gol 7 metros', 0, 0, 1, 7),
(14, 'Tiro fallido 7 metros', 0, 0, 1, 7),
(15, 'Tiro parado 7 metros', 0, 0, 1, 7),
(16, 'Comete 7 metros', 0, 0, 1, 2),
(17, 'Inicio segunda parte', 0, 1, 0, 5),
(18, 'Fin segunda parte', 0, 1, 0, 5),
(19, 'Inicio prórroga', 0, 1, 0, 5),
(20, 'Fin prórroga', 0, 1, 0, 5),
(23, 'Final del partido', 0, 1, 0, 5),
(28, 'Parada', 0, 0, 1, 8),
(29, 'Parada 7 metros', 0, 0, 1, 8),
(30, 'Pérdida', 0, 0, 1, 9),
(31, 'Recuperación', 0, 0, 1, 10),
(32, 'Asistencia de gol', 0, 0, 0, 11),
(33, 'Tarjeta Roja', 0, 0, 1, 3),
(34, 'Tarjeta Amarilla', 0, 0, 1, 3),
(35, 'Porteria Vacia (7 J.)', 1, 0, 0, 6),
(36, 'Porteria Vacia (6 J.)', 1, 0, 0, 6),
(37, 'Tiro', 0, 0, 1, 1),
(38, 'Tiro bloqueado', 0, 0, 1, 10),
(39, 'Sustitucion ilegal', 0, 0, 1, 3),
(40, 'Asistencia para Fly', 0, 0, 1, 11);

-- Create demo user (password: demo123)
INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'demo', 'sha256$demo$5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8');


-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_convocados`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_convocados` AS select `j`.`id` AS `jugador_id`,`j`.`nombre` AS `jugador_nombre`,`j`.`apellido` AS `jugador_apellido`,`j`.`dorsal` AS `jugador_dorsal`,`j`.`rol` AS `jugador_rol`,`c`.`partido_id` AS `partido_id`,`j`.`equipo_id` AS `equipo_id`,`e`.`nombre` AS `equipo_nombre`,(case when (`p`.`equipo_local_id` = `j`.`equipo_id`) then 'local' when (`p`.`equipo_visitante_id` = `j`.`equipo_id`) then 'visitante' else 'otro' end) AS `tipo_equipo` from (((`convocados` `c` join `jugadores` `j` on((`c`.`jugador_id` = `j`.`id`))) join `partidos` `p` on((`c`.`partido_id` = `p`.`id`))) join `equipos` `e` on((`j`.`equipo_id` = `e`.`id`)));

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `v_estadisticas_jugador_partido`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_estadisticas_jugador_partido` AS select `p`.`id` AS `partido_id`,`p`.`fecha_hora` AS `fecha_partido`,`e_local`.`nombre` AS `equipo_local`,`e_visitante`.`nombre` AS `equipo_visitante`,`j`.`id` AS `jugador_id`,concat(`j`.`nombre`,' ',`j`.`apellido`,convert(ifnull(concat(' (#',`j`.`dorsal`,')'),'') using utf8mb4)) AS `jugador`,`eq`.`nombre` AS `equipo_jugador`,concat(sum((case when ((`te`.`id` = 37) and (`ev`.`resultado_tiro` = 'gol')) then 1 else 0 end)),'/',sum((case when (`te`.`id` = 37) then 1 else 0 end))) AS `tiros_campo`,concat(sum((case when (`te`.`id` = 13) then 1 else 0 end)),'/',sum((case when (`te`.`id` = 13) then 1 else 0 end))) AS `tiros_7m`,sum((case when (`te`.`id` = 30) then 1 else 0 end)) AS `perdidas`,sum((case when (`te`.`id` = 31) then 1 else 0 end)) AS `recuperaciones`,sum((case when (`te`.`id` = 4) then 1 else 0 end)) AS `faltas_cometidas`,sum((case when (`te`.`id` = 5) then 1 else 0 end)) AS `faltas_recibidas`,sum((case when (`te`.`id` = 32) then 1 else 0 end)) AS `asistencias` from ((((((`eventos` `ev` join `tipo_evento` `te` on((`ev`.`tipo_evento_id` = `te`.`id`))) join `partidos` `p` on((`ev`.`partido_id` = `p`.`id`))) join `equipos` `e_local` on((`p`.`equipo_local_id` = `e_local`.`id`))) join `equipos` `e_visitante` on((`p`.`equipo_visitante_id` = `e_visitante`.`id`))) join `jugadores` `j` on((`ev`.`jugador_id` = `j`.`id`))) join `equipos` `eq` on((`j`.`equipo_id` = `eq`.`id`))) where (`ev`.`jugador_id` is not null) group by `p`.`id`,`j`.`id` order by `p`.`fecha_hora` desc,`eq`.`nombre`,`jugador`,`asistencias`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
