-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-04-2025 a las 07:31:14
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `car_clean`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `automotor`
--

CREATE TABLE `automotor` (
  `id` int(11) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `year` int(11) NOT NULL,
  `tipo_automotor` enum('Motocicleta','Sedan','Camioneta','Microbús','Autobús') NOT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `automotor`
--

INSERT INTO `automotor` (`id`, `marca`, `modelo`, `year`, `tipo_automotor`, `id_cliente`) VALUES
(1, 'Lexus', 'RX350', 2024, 'Sedan', 1),
(2, 'Lexus', 'RX350', 2024, 'Sedan', 2),
(3, 'Toyota', 'Highlander', 2025, 'Camioneta', 3),
(4, 'honda', '2', 2023, 'Sedan', 4),
(5, 'Toyota', 'Highlander', 2023, 'Camioneta', 5),
(6, 'Lexus', 'RX350', 2023, 'Sedan', 6),
(7, 'f', 'f', 1900, 'Sedan', 7),
(8, 'Lexus', 'Highlander', 2024, 'Sedan', 8),
(9, 'Lexus', 'Highlander', 2025, 'Sedan', 9),
(10, 'Toyota', 'RX350', 2022, 'Sedan', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `vip` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `nombres`, `apellidos`, `vip`) VALUES
(1, 'Mario', 'Meléndez', 1),
(2, 'Mario', 'Meléndez', 1),
(3, 'Mario', 'Meléndez', 1),
(4, 'Danilo', 'Martinez', 0),
(5, 'Andres', 'Mendez', 0),
(6, 'omar', 'perez', 1),
(7, 'f', 'f', 1),
(8, 'daniel', 'gozales', 1),
(9, 'daniel', 'mendez', 1),
(10, 'rodrigo', 'perez', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `precio_automotor`
--

CREATE TABLE `precio_automotor` (
  `id` int(11) NOT NULL,
  `tipo_automotor` enum('Motocicleta','Sedan','Camioneta','Microbús','Autobús') DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `precio_automotor`
--

INSERT INTO `precio_automotor` (`id`, `tipo_automotor`, `precio`) VALUES
(1, 'Motocicleta', 2.75),
(2, 'Sedan', 3.50),
(3, 'Camioneta', 4.00),
(4, 'Microbús', 5.00),
(5, 'Autobús', 7.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `service`
--

CREATE TABLE `service` (
  `id` int(11) NOT NULL,
  `id_automotor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `service`
--

INSERT INTO `service` (`id`, `id_automotor`) VALUES
(1, 5),
(2, 6),
(3, 7),
(4, 8),
(5, 9),
(6, 10);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `automotor`
--
ALTER TABLE `automotor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `tipo_automotor` (`tipo_automotor`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `precio_automotor`
--
ALTER TABLE `precio_automotor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tipo_automotor` (`tipo_automotor`);

--
-- Indices de la tabla `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_automotor` (`id_automotor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `automotor`
--
ALTER TABLE `automotor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `precio_automotor`
--
ALTER TABLE `precio_automotor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `service`
--
ALTER TABLE `service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `automotor`
--
ALTER TABLE `automotor`
  ADD CONSTRAINT `automotor_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`),
  ADD CONSTRAINT `automotor_ibfk_2` FOREIGN KEY (`tipo_automotor`) REFERENCES `precio_automotor` (`tipo_automotor`);

--
-- Filtros para la tabla `service`
--
ALTER TABLE `service`
  ADD CONSTRAINT `service_ibfk_1` FOREIGN KEY (`id_automotor`) REFERENCES `automotor` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
