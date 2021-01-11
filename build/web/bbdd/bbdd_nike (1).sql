-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-01-2021 a las 12:30:04
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bbdd_nike`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `idcategorias` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`idcategorias`, `nombre`) VALUES
(1, 'niño'),
(2, 'niña'),
(3, 'hombre'),
(4, 'mujer'),
(5, 'novedades');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `linea_pedido`
--

CREATE TABLE `linea_pedido` (
  `id_lineadepedido` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `pedidos_idpedidos` int(11) NOT NULL,
  `productos_idproductos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `linea_pedido`
--

INSERT INTO `linea_pedido` (`id_lineadepedido`, `cantidad`, `pedidos_idpedidos`, `productos_idproductos`) VALUES
(38, 2, 33, 11),
(39, 1, 33, 6),
(40, 5, 34, 1),
(41, 2, 34, 8),
(43, 1, 36, 21),
(44, 2, 36, 22),
(45, 1, 36, 23),
(46, 3, 38, 11),
(47, 1, 38, 13),
(48, 1, 38, 12),
(49, 1, 39, 21),
(50, 1, 39, 1),
(51, 1, 39, 6),
(52, 1, 39, 11),
(53, 1, 39, 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `idpedidos` int(11) NOT NULL,
  `precio_total` double DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `usuarios_idusuarios` int(11) NOT NULL,
  `comprado` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`idpedidos`, `precio_total`, `fecha`, `usuarios_idusuarios`, `comprado`) VALUES
(33, 259.98, '2021-01-11 09:49:48', 6, 1),
(34, 1129.93, '2021-01-11 09:50:00', 6, 1),
(35, NULL, '2021-01-11 09:54:10', 6, 0),
(36, 739.96, '2021-01-02 10:41:51', 1, 1),
(37, NULL, '2021-01-11 10:41:57', 1, 0),
(38, 274.95, '2021-01-03 10:42:03', 2, 1),
(39, 579.96, '2021-01-11 10:42:10', 2, 1),
(40, NULL, '2021-01-11 11:35:01', 2, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idproductos` int(11) NOT NULL,
  `nombre_producto` varchar(100) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  `categorias_idcategorias` int(11) NOT NULL,
  `foto` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idproductos`, `nombre_producto`, `precio`, `categorias_idcategorias`, `foto`) VALUES
(1, 'Nike Pegasus Trail 2 GORE-TEX', 169.99, 3, 'nike_pegasus.png'),
(2, 'Nike Air Force 1', 99.99, 3, 'nike_air_force.png'),
(3, 'Nike Air Max 97', 179.99, 3, 'nike_air_max_97.png'),
(4, 'Nike Air Max ZM950', 179.99, 3, 'nike_air_max_zm950.png'),
(5, 'Nike Court Vintage Premium', 74.99, 3, 'nike_court_vintage.png'),
(6, 'Nike  Air Max 270 XX', 180, 4, 'air_max_270.png'),
(7, 'Nike Air Force 1 07', 109.99, 4, 'air_force_107.png'),
(8, 'Nike Air Max 90', 139.99, 4, 'air_max_90.png'),
(9, 'Nike Blazer Mid 77', 100, 4, 'blazer_77.png'),
(10, 'Nike Air Max Up NRG', 149.99, 4, 'air_max_up.png'),
(11, 'Nike MD Valiant', 39.99, 1, 'valiant.png'),
(12, 'Nike Blazer Mid 77', 64.99, 1, 'blazer.png'),
(13, 'Nike Air Max 270', 89.99, 1, 'max_270.png'),
(14, 'Nike Air Max Plus', 99.99, 1, 'max_plus.png'),
(15, 'Nike Air Max 90', 79.99, 1, 'max_90.png'),
(16, 'Nike Court Borough Mid 2', 49.99, 2, 'court_boro.png'),
(17, 'Nike Revolution 5', 37.99, 2, 'revolution.png'),
(18, 'Nike Star Runner 2', 34.99, 2, 'star_runner.png'),
(19, 'Force 1 BT', 90, 2, 'force_bt.png'),
(20, 'Nike WearAllDay', 39.99, 2, 'wear_all_day.png'),
(21, 'Nike Air Max 95', 139.99, 5, 'nov_NikeAirMax2095.png'),
(22, 'Nike Air Max 90 SE', 224.99, 5, 'nov_NikeAirMax90.png'),
(23, 'Nike Air VaporMax 2020 FK', 149.99, 5, 'nov_NikeAirVaporMax2020.png'),
(24, 'Nike React Art3mis', 109.99, 5, 'nov_NikeReactArt3mis.png'),
(25, 'Nike Air Max 270 React SE', 159.99, 5, 'nov_NikeAirMax270React.png'),
(26, 'Nike ISPA OverReact Flyknit', 179.99, 5, 'nov_NikeISPAOverReactFlyknit.png'),
(27, 'Nike Air Jordan 11 Retro Low IE', 179.99, 5, 'nov_NikeAirJordan11Retro.png'),
(28, 'Nike Adapt Auto Max', 400, 5, 'nov_NikeAdaptAutoMax.png'),
(29, 'Nike Air Max Triax USA', 139.99, 5, 'nov_NikeAirMaxTriaxUSA.png'),
(30, 'Nike Air Max 2090', 139.99, 5, 'nov_NikeAirMax2090.png'),
(31, 'Air Force 1 React', 169.99, 3, 'air-force-1-react.png'),
(32, 'Nike Air Force 1 High', 99.99, 3, 'air-force-1-high-07.png'),
(33, 'Nike Air Zoom Pegasus', 119.99, 3, 'air-zoom-pegasus.png'),
(34, 'Nike Superrep Cycle', 119.99, 3, 'superrep-cycle.png'),
(35, 'Nike Skate', 84.99, 3, 'Nike-de-skateboard.png'),
(36, 'Nike Lebron 8', 169.99, 1, 'lebron-8-zapatillas-nino-a-phppjX.png'),
(37, 'Nike Air Zephyr', 99.99, 1, 'air-max-zephyr-zapatillas-nino-a-3J8ChJ.png'),
(38, 'Nike air Max 90', 119.99, 1, 'air-max-90-zapatillas-nino-a-0FscGC.png'),
(39, 'Nike BlAZER MID 77', 119.99, 1, 'blazer-mid-77-se-zapatillas-nino-a-pequeno-a-gqBq4S.png'),
(40, 'Nike Air Max 90 LTR', 84.99, 1, 'air-max-90-ltr-zapatillas-nino-a-q6tK7Z.png'),
(41, 'Nike Lebron 8', 169.99, 2, 'lebron-8-zapatillas-nino-a-phppjX.png'),
(42, 'Nike Air Zephyr', 99.99, 2, 'air-max-zephyr-zapatillas-nino-a-3J8ChJ.png'),
(43, 'Nike air Max 90', 119.99, 2, 'air-max-90-zapatillas-nino-a-0FscGC.png'),
(44, 'Nike BlAZER MID 77', 119.99, 2, 'blazer-mid-77-se-zapatillas-nino-a-pequeno-a-gqBq4S.png'),
(45, 'Nike Air Max 90 LTR', 84.99, 2, 'air-max-90-ltr-zapatillas-nino-a-q6tK7Z.png'),
(46, 'Nike Air Max 95', 169.99, 4, 'air-max-95-zapatillas-0S2P1P.png'),
(47, 'Nike Air Max 90', 99.99, 4, 'air-max-90-zapatillas-ZvM8v3.png'),
(48, 'Nike Air Zoom Pegasus 37', 119.99, 4, 'air-zoom-pegasus-37-zapatillas-de-running-XPrmP5.png'),
(49, 'Nike Air Pegasus Trail', 119.99, 4, 'pegasus-trail-2-zapatillas-de-trail-running-mKgjNf.png'),
(50, 'Nike Air Zoom SuperRep', 84.99, 4, 'air-zoom-superrep-zapatillas-las-clases-de-hiit-jxHfXm.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idusuarios` int(11) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `rol` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idusuarios`, `username`, `password`, `email`, `rol`) VALUES
(1, 'user1', '1111', 'user1@gmail.com', 'usuario'),
(2, 'user3', '3333', 'user3@gmail.com', 'usuario'),
(3, 'admin', 'admin', 'admin@gmail.com', 'admin'),
(4, 'user4', '4444', 'user4@gmail.com', 'usuario'),
(5, 'user2', '2222', 'user2@gmail.com', 'usuario'),
(6, 'joserm', '123', 'joserm91pro@gmail.com', 'usuario'),
(7, 'daniel', '123', 'dani@gmail.com', 'usuario');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`idcategorias`);

--
-- Indices de la tabla `linea_pedido`
--
ALTER TABLE `linea_pedido`
  ADD PRIMARY KEY (`id_lineadepedido`),
  ADD KEY `fk_linea_pedido_pedidos1_idx` (`pedidos_idpedidos`),
  ADD KEY `fk_linea_pedido_productos1_idx` (`productos_idproductos`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`idpedidos`,`usuarios_idusuarios`),
  ADD KEY `fk_pedidos_usuarios1_idx` (`usuarios_idusuarios`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idproductos`,`categorias_idcategorias`),
  ADD KEY `fk_productos_categorias1_idx` (`categorias_idcategorias`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idusuarios`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `idcategorias` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `linea_pedido`
--
ALTER TABLE `linea_pedido`
  MODIFY `id_lineadepedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `idpedidos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idproductos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idusuarios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `linea_pedido`
--
ALTER TABLE `linea_pedido`
  ADD CONSTRAINT `fk_linea_pedido_pedidos1` FOREIGN KEY (`pedidos_idpedidos`) REFERENCES `pedidos` (`idpedidos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_linea_pedido_productos1` FOREIGN KEY (`productos_idproductos`) REFERENCES `productos` (`idproductos`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `fk_pedidos_usuarios1` FOREIGN KEY (`usuarios_idusuarios`) REFERENCES `usuarios` (`idusuarios`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_productos_categorias1` FOREIGN KEY (`categorias_idcategorias`) REFERENCES `categorias` (`idcategorias`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
