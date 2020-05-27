-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-05-2020 a las 16:14:43
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `compugamer`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `clie_nomb` varchar(45) DEFAULT NULL COMMENT 'Nombre del cliente',
  `clie_apell` varchar(45) DEFAULT NULL COMMENT 'Apellido del cliente',
  `clie_tel` varchar(45) DEFAULT NULL COMMENT 'Número telefonico del cliente',
  `clie_dir` varchar(45) DEFAULT NULL COMMENT 'Dirección de residencia del cliente',
  `clie_privilegiado` tinyint(1) DEFAULT 0,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `profile_img` varchar(160) DEFAULT 'https://i.ibb.co/Fs99HVV/photo-1511367461989-f85a21fda167-pffqga.jpg',
  `public_id` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `clie_nomb`, `clie_apell`, `clie_tel`, `clie_dir`, `clie_privilegiado`, `fecha_registro`, `username`, `password`, `email`, `profile_img`, `public_id`) VALUES
(1, 'Rafael Andres', 'Bacca Zuluaga', '3043302800', 'Calle 29 AV. 7 #86-13 Libertad', 1, '2020-03-30 16:18:38', 'admin', '$2a$10$wmvac/ia1HMEW624xRqGgOk92aQXrwSYjThp3OEgbacCGOPITDQXG', 'rabzcompugamer@gmail.com', 'https://i.ibb.co/Fs99HVV/photo-1511367461989-f85a21fda167-pffqga.jpg', NULL),
(2, 'Cristian Ricardo', 'Tautiva Lizcano', '3118618284', 'Calle 30 AV.1 #0-93 Cordialidad-Patios', 0, '2020-03-31 01:57:58', 'Dcris', '$2a$10$ftT9WNXB4HTRDaEkXOjp.OI0vgpZj9BwfnAd9AV.08D87l0vCzHiG', 'cristianricardotl@ufps.edu.co', 'http://res.cloudinary.com/dcris/image/upload/v1586528263/td2xywpvbmelaa2lv1wo.jpg', 'td2xywpvbmelaa2lv1wo'),
(3, 'Miguel Angel', 'Portilla ', '312364748', 'Calle 29 AV. 1 Cordialidad', 0, '2020-04-12 16:36:47', 'Paco', '$2a$10$fG9nrhNH9kDTwFyjVFaP1.GC5cI2nh.xillU38jacnRA/GT1e63Zi', 'pacosabe@gmail.com', 'http://res.cloudinary.com/dcris/image/upload/v1587132472/rep7ek63uzhfrymjtapo.jpg', 'rep7ek63uzhfrymjtapo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `computador`
--

CREATE TABLE `computador` (
  `id` int(11) NOT NULL,
  `comp_tipo` int(11) DEFAULT NULL COMMENT 'Define que tipo de computador es: 1= Escritorio, 2= Portatil y 3= Todo en uno; Extraido de la tabla "tipo_computador"',
  `comp_marca` varchar(45) DEFAULT NULL COMMENT 'Marca del computador, ejemplo: Asus, Lenovo, HP, Acer, Compumax, Etc...',
  `comp_ref` varchar(45) DEFAULT NULL COMMENT 'Referencia del computador',
  `comp_proc` varchar(20) DEFAULT NULL,
  `comp_ram` varchar(20) DEFAULT NULL,
  `comp_alm` varchar(18) DEFAULT NULL,
  `comp_vid` varchar(45) DEFAULT NULL COMMENT 'Tipo de tarjeta grafica que tiene el computador',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `image_url` varchar(150) DEFAULT NULL,
  `public_id` varchar(150) DEFAULT NULL,
  `existencias` int(11) NOT NULL DEFAULT 1,
  `precio` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `computador`
--

INSERT INTO `computador` (`id`, `comp_tipo`, `comp_marca`, `comp_ref`, `comp_proc`, `comp_ram`, `comp_alm`, `comp_vid`, `created_at`, `image_url`, `public_id`, `existencias`, `precio`) VALUES
(1, 2, 'Acer', 'A315-53-59QQ', 'Intel Core i5', '4GB DDR4', '1000GB HDD', 'Integrados Intel(Sin tarjeta de video dedicad', '2020-04-02 18:45:12', 'http://res.cloudinary.com/dcris/image/upload/v1585853112/kpwancdp1wtdjwa3gp1w.png', 'kpwancdp1wtdjwa3gp1w', 13, 1599000),
(2, 3, 'HP', '22-C009LA', 'AMD A9', '4GB DDR4', '1000GB HDD', 'Integrados Intel(Sin tarjeta de video dedicad', '2020-04-03 00:36:49', 'http://res.cloudinary.com/dcris/image/upload/v1585874209/xjrwwulegkha7dpliwtc.png', 'xjrwwulegkha7dpliwtc', 3, 1498500),
(3, 1, 'Compumax', 'Ebano Plus IP-33', 'Intel Pentium Gold S', '4GB DDR4', '1000GB HDD', 'Integrados Intel(Sin tarjeta de video dedicad', '2020-04-07 13:40:48', 'http://res.cloudinary.com/dcris/image/upload/v1586527950/tqte6eiotnmzhadlongz.png', 'tqte6eiotnmzhadlongz', 5, 1389000),
(6, 2, 'Compumax', 'Onix Series IC4', 'Intel Celeron', '4GB DDR4', '500GB HDD', 'Integrados Intel(Sin tarjeta de video dedicad', '2020-04-10 20:23:38', 'http://res.cloudinary.com/dcris/image/upload/v1586550307/bexc3ybpsp0q8pxashf4.png', 'bexc3ybpsp0q8pxashf4', 1, 1299000),
(7, 3, 'Compumax', 'AIO Unno Max Series Evolution IC0', 'Intel Celeron', '4GB DDR4', '500GB HDD', 'Integrados Intel(Sin tarjeta de video dedicad', '2020-04-10 20:27:04', 'http://res.cloudinary.com/dcris/image/upload/v1586550424/prsmp4mgwyp1l5sakyeq.png', 'prsmp4mgwyp1l5sakyeq', 6, 1790346),
(8, 1, 'Lenovo', 'V530s SFF', 'Intel Core i7', '8GB DDR4', '1000GB HDD', 'Integrados Intel(Sin tarjeta de video dedicad', '2020-04-10 20:35:54', 'http://res.cloudinary.com/dcris/image/upload/v1586550954/lds7q5kp9rj5uhirt5nb.png', 'lds7q5kp9rj5uhirt5nb', 1, 1999400);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_computador`
--

CREATE TABLE `tipo_computador` (
  `tipo_id` int(11) NOT NULL COMMENT 'Código para identificar que tipo de computador es: 1= Escritorio, 2= Portatil y 3= Todo en uno',
  `tipo_desc` varchar(45) DEFAULT NULL COMMENT 'Describe que tipo de computador es dependiendo del código '
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_computador`
--

INSERT INTO `tipo_computador` (`tipo_id`, `tipo_desc`) VALUES
(1, 'Escritorio'),
(2, 'Portatil'),
(3, 'Todo en uno');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedor`
--

CREATE TABLE `vendedor` (
  `id` int(11) NOT NULL,
  `vend_nombre` varchar(45) DEFAULT NULL COMMENT 'Nombre/s del vendedor',
  `vend_apell` varchar(45) DEFAULT NULL COMMENT 'Apellido/s del vendedor',
  `vend_tel` varchar(45) DEFAULT NULL COMMENT 'Número telefonico del vendedor',
  `vend_cedula` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `vendedor`
--

INSERT INTO `vendedor` (`id`, `vend_nombre`, `vend_apell`, `vend_tel`, `vend_cedula`) VALUES
(1, 'Jhon David', 'Tautiva Hernandez', '5806190', '1093787070'),
(2, 'Pedro santiago', 'alvarado cruz', '5716863', '1093764324'),
(3, 'Ana luz', 'Cuevaz canvas', '3118618295', '13456732');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_factura` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_venta` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `computador`
--
ALTER TABLE `computador`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tipo_pc` (`comp_tipo`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indices de la tabla `tipo_computador`
--
ALTER TABLE `tipo_computador`
  ADD PRIMARY KEY (`tipo_id`);

--
-- Indices de la tabla `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `computador`
--
ALTER TABLE `computador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `vendedor`
--
ALTER TABLE `vendedor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `computador`
--
ALTER TABLE `computador`
  ADD CONSTRAINT `FK_tipo` FOREIGN KEY (`comp_tipo`) REFERENCES `tipo_computador` (`tipo_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tipo_pc` FOREIGN KEY (`comp_tipo`) REFERENCES `tipo_computador` (`tipo_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
