SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


CREATE SCHEMA teste_php CHARSET utf8 collate utf8_general_ci;

USE teste_php;

-- -----------------------------------------------------
-- Table `curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `curso` ;

CREATE  TABLE IF NOT EXISTS `curso` (
  `id_curso` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `curso` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id_curso`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `material`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `material` ;

CREATE  TABLE IF NOT EXISTS `material` (
  `id_material` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `material` VARCHAR(30) NOT NULL ,
  `icone` VARCHAR(30) NOT NULL COMMENT 'classe glyphicon' ,
  PRIMARY KEY (`id_material`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tipo` ;

CREATE  TABLE IF NOT EXISTS `tipo` (
  `id_tipo` TINYINT UNSIGNED NOT NULL ,
  `tipo` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`id_tipo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `status` ;

CREATE  TABLE IF NOT EXISTS `status` (
  `id_status` TINYINT UNSIGNED NOT NULL ,
  `status` VARCHAR(40) NOT NULL ,
  `cor` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`id_status`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `card` ;

CREATE  TABLE IF NOT EXISTS `card` (
  `id_card` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `id_tipo` TINYINT UNSIGNED NOT NULL ,
  `id_curso` SMALLINT UNSIGNED NULL ,
  `id_status` TINYINT UNSIGNED NOT NULL ,
  `dt_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `ano` YEAR NOT NULL ,
  `num_aula` SMALLINT NOT NULL ,
  PRIMARY KEY (`id_card`) ,
  CONSTRAINT `fk_card_tipo`
    FOREIGN KEY (`id_tipo` )
    REFERENCES `tipo` (`id_tipo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_curso1`
    FOREIGN KEY (`id_curso` )
    REFERENCES `curso` (`id_curso` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_status1`
    FOREIGN KEY (`id_status` )
    REFERENCES `status` (`id_status` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_card_tipo_idx` ON `card` (`id_tipo` ASC) ;

CREATE INDEX `fk_card_curso1_idx` ON `card` (`id_curso` ASC) ;

CREATE INDEX `fk_card_status1_idx` ON `card` (`id_status` ASC) ;


-- -----------------------------------------------------
-- Table `card_movimentacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `card_movimentacao` ;

CREATE  TABLE IF NOT EXISTS `card_movimentacao` (
  `id_card_movimentacao` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `id_card` MEDIUMINT UNSIGNED NOT NULL ,
  `id_status` TINYINT UNSIGNED NOT NULL ,
  `dt_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id_card_movimentacao`) ,
  CONSTRAINT `fk_card_movimentacao_card1`
    FOREIGN KEY (`id_card` )
    REFERENCES `card` (`id_card` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_movimentacao_status1`
    FOREIGN KEY (`id_status` )
    REFERENCES `status` (`id_status` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_card_movimentacao_card1_idx` ON `card_movimentacao` (`id_card` ASC) ;

CREATE INDEX `fk_card_movimentacao_status1_idx` ON `card_movimentacao` (`id_status` ASC) ;


-- -----------------------------------------------------
-- Table `professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `professor` ;

CREATE  TABLE IF NOT EXISTS `professor` (
  `id_professor` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(70) NOT NULL ,
  PRIMARY KEY (`id_professor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `card_professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `card_professor` ;

CREATE  TABLE IF NOT EXISTS `card_professor` (
  `id_card_professor` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `id_card` MEDIUMINT UNSIGNED NOT NULL ,
  `id_professor` SMALLINT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id_card_professor`) ,
  CONSTRAINT `fk_card_professor_card1`
    FOREIGN KEY (`id_card` )
    REFERENCES `card` (`id_card` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_professor_professor1`
    FOREIGN KEY (`id_professor` )
    REFERENCES `professor` (`id_professor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_card_professor_card1_idx` ON `card_professor` (`id_card` ASC) ;

CREATE INDEX `fk_card_professor_professor1_idx` ON `card_professor` (`id_professor` ASC) ;

CREATE UNIQUE INDEX `un_card_professor` ON `card_professor` (`id_card` ASC, `id_professor` ASC) ;


-- -----------------------------------------------------
-- Table `card_material`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `card_material` ;

CREATE  TABLE IF NOT EXISTS `card_material` (
  `id_card_material` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `id_card` MEDIUMINT UNSIGNED NOT NULL ,
  `id_material` TINYINT UNSIGNED NOT NULL ,
  PRIMARY KEY (`id_card_material`) ,
  CONSTRAINT `fk_card_material_card1`
    FOREIGN KEY (`id_card` )
    REFERENCES `card` (`id_card` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_card_material_material1`
    FOREIGN KEY (`id_material` )
    REFERENCES `material` (`id_material` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_card_material_card1_idx` ON `card_material` (`id_card` ASC) ;

CREATE INDEX `fk_card_material_material1_idx` ON `card_material` (`id_material` ASC) ;

CREATE UNIQUE INDEX `un_card_material` ON `card_material` (`id_card` ASC, `id_material` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `material`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `material` (`id_material`, `material`, `icone`) VALUES (NULL, 'Apostila', 'glyphicon-book');
INSERT INTO `material` (`id_material`, `material`, `icone`) VALUES (NULL, 'Vídeo', 'glyphicon-facetime-video');
INSERT INTO `material` (`id_material`, `material`, `icone`) VALUES (NULL, 'Áudio', 'glyphicon-music');

COMMIT;

-- -----------------------------------------------------
-- Data for table `tipo`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `tipo` (`id_tipo`, `tipo`) VALUES (1, 'Curso');
INSERT INTO `tipo` (`id_tipo`, `tipo`) VALUES (2, 'Aulão');

COMMIT;

-- -----------------------------------------------------
-- Data for table `status`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `status` (`id_status`, `status`, `cor`) VALUES (1, 'Demanda', 'primary');
INSERT INTO `status` (`id_status`, `status`, `cor`) VALUES (2, 'Material Recebido', 'info');
INSERT INTO `status` (`id_status`, `status`, `cor`) VALUES (3, 'Em Conferência', 'danger');
INSERT INTO `status` (`id_status`, `status`, `cor`) VALUES (4, 'Conferido', 'success');

COMMIT;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

INSERT INTO `card` (`id_card`, `id_tipo`, `id_curso`, `id_status`, `dt_registro`, `ano`, `num_aula`) VALUES
	(1, 2, NULL, 1, NOW(), '2019', 5),
	(2, 2, NULL, 1, NOW(), '2019', 4),
	(3, 1, 3, 1, NOW(), '2020', 4),
	(4, 2, NULL, 1, NOW(), '2021', 4),
	(5, 1, 8, 1, NOW(), '2020', 2),
	(6, 1, 8, 1, NOW(), '2019', 1),
	(7, 1, 3, 1, NOW(), '2019', 1),
	(8, 1, 4, 1, NOW(), '2019', 2),
	(9, 1, 10, 1, NOW(), '2019', 1),
	(10, 1, 2, 1, NOW(), '2019', 2),
	(11, 1, 11, 1, NOW(), '2019', 1),
	(12, 1, 4, 1, NOW(), '2020', 1),
	(13, 1, 6, 1, NOW(), '2020', 1),
	(14, 1, 9, 1, NOW(), '2019', 2),
	(15, 1, 7, 1, NOW(), '2020', 6),
	(16, 1, 15, 1, NOW(), '2021', 6),
	(17, 1, 8, 1, NOW(), '2020', 2),
	(18, 1, 2, 1, NOW(), '2020', 5),
	(19, 1, 13, 1, NOW(), '2019', 6),
	(20, 1, 13, 1, NOW(), '2020', 3),
	(21, 2, NULL, 1, NOW(), '2021', 2),
	(22, 1, 14, 1, NOW(), '2019', 2),
	(23, 1, 15, 1, NOW(), '2020', 5),
	(24, 1, 13, 1, NOW(), '2019', 2),
	(25, 2, NULL, 1, NOW(), '2021', 4),
	(26, 1, 13, 1, NOW(), '2019', 2),
	(27, 2, NULL, 1, NOW(), '2021', 4),
	(28, 1, 5, 1, NOW(), '2019', 1),
	(29, 1, 14, 1, NOW(), '2021', 6),
	(30, 1, 9, 1, NOW(), '2020', 4),
	(31, 1, 12, 1, NOW(), '2021', 5),
	(32, 1, 1, 1, NOW(), '2020', 5),
	(33, 1, 6, 1, NOW(), '2019', 3),
	(34, 1, 7, 1, NOW(), '2019', 2),
	(35, 1, 9, 1, NOW(), '2020', 5),
	(36, 1, 8, 1, NOW(), '2019', 2),
	(37, 1, 7, 1, NOW(), '2019', 1),
	(38, 1, 13, 1, NOW(), '2021', 4),
	(39, 1, 12, 1, NOW(), '2020', 1),
	(40, 2, NULL, 1, NOW(), '2019', 1),
	(41, 1, 4, 1, NOW(), '2019', 1),
	(42, 2, NULL, 1, NOW(), '2019', 1),
	(43, 1, 13, 1, NOW(), '2019', 5),
	(44, 1, 14, 1, NOW(), '2019', 5),
	(45, 1, 4, 1, NOW(), '2021', 3),
	(46, 1, 7, 1, NOW(), '2021', 6),
	(47, 1, 8, 1, NOW(), '2021', 5),
	(48, 1, 4, 1, NOW(), '2021', 3),
	(49, 1, 15, 1, NOW(), '2019', 4),
	(50, 1, 6, 1, NOW(), '2020', 1),
	(51, 2, NULL, 1, NOW(), '2020', 4),
	(52, 1, 13, 1, NOW(), '2019', 2),
	(53, 1, 1, 1, NOW(), '2020', 5),
	(54, 1, 12, 1, NOW(), '2020', 4),
	(55, 1, 12, 1, NOW(), '2019', 5),
	(56, 1, 13, 1, NOW(), '2020', 3),
	(57, 1, 11, 1, NOW(), '2021', 4),
	(58, 1, 1, 1, NOW(), '2019', 6),
	(59, 1, 15, 1, NOW(), '2020', 2),
	(60, 1, 4, 1, NOW(), '2019', 4),
	(61, 1, 8, 1, NOW(), '2019', 3),
	(62, 2, NULL, 1, NOW(), '2021', 1),
	(63, 1, 5, 1, NOW(), '2020', 2),
	(64, 2, NULL, 1, NOW(), '2019', 1),
	(65, 2, NULL, 1, NOW(), '2019', 6),
	(66, 1, 8, 1, NOW(), '2020', 1),
	(67, 1, 11, 1, NOW(), '2019', 2),
	(68, 1, 3, 1, NOW(), '2021', 4),
	(69, 1, 6, 1, NOW(), '2021', 3),
	(70, 1, 8, 1, NOW(), '2020', 1),
	(71, 1, 2, 1, NOW(), '2021', 3),
	(72, 1, 15, 1, NOW(), '2019', 3),
	(73, 1, 6, 1, NOW(), '2021', 3),
	(74, 1, 10, 1, NOW(), '2019', 6),
	(75, 1, 11, 1, NOW(), '2021', 5),
	(76, 2, NULL, 1, NOW(), '2021', 2),
	(77, 2, NULL, 1, NOW(), '2019', 3),
	(78, 1, 15, 1, NOW(), '2020', 5),
	(79, 2, NULL, 1, NOW(), '2021', 1),
	(80, 1, 7, 1, NOW(), '2019', 4),
	(81, 2, NULL, 1, NOW(), '2020', 6),
	(82, 2, NULL, 1, NOW(), '2021', 3),
	(83, 1, 15, 1, NOW(), '2020', 1),
	(84, 2, NULL, 1, NOW(), '2021', 3),
	(85, 1, 2, 1, NOW(), '2019', 2),
	(86, 1, 1, 1, NOW(), '2020', 3),
	(87, 1, 8, 1, NOW(), '2021', 4),
	(88, 1, 7, 1, NOW(), '2019', 4),
	(89, 1, 10, 1, NOW(), '2020', 5),
	(90, 1, 9, 1, NOW(), '2020', 2),
	(91, 1, 3, 1, NOW(), '2021', 2),
	(92, 1, 11, 1, NOW(), '2020', 5),
	(93, 1, 1, 1, NOW(), '2021', 3),
	(94, 1, 2, 1, NOW(), '2020', 5),
	(95, 1, 5, 1, NOW(), '2020', 5),
	(96, 1, 9, 1, NOW(), '2020', 3),
	(97, 1, 8, 1, NOW(), '2020', 5),
	(98, 2, NULL, 1, NOW(), '2021', 5),
	(99, 1, 3, 1, NOW(), '2021', 6),
	(100, 1, 14, 1, NOW(), '2021', 3);

INSERT INTO `card_material` (`id_card_material`, `id_card`, `id_material`) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 1, 3),
	(4, 2, 1),
	(5, 2, 2),
	(6, 3, 1),
	(7, 3, 2),
	(8, 3, 3),
	(9, 4, 1),
	(10, 4, 3),
	(11, 5, 2),
	(12, 5, 3),
	(13, 6, 2),
	(14, 6, 3),
	(15, 7, 1),
	(16, 7, 2),
	(17, 7, 3),
	(18, 8, 2),
	(19, 8, 3),
	(20, 9, 1),
	(21, 10, 1),
	(22, 10, 2),
	(23, 11, 1),
	(24, 11, 2),
	(25, 11, 3),
	(26, 12, 1),
	(27, 12, 2),
	(28, 12, 3),
	(29, 13, 2),
	(30, 13, 3),
	(31, 14, 1),
	(32, 14, 2),
	(33, 14, 3),
	(34, 15, 1),
	(35, 16, 2),
	(36, 17, 1),
	(37, 17, 2),
	(38, 17, 3),
	(39, 18, 1),
	(40, 18, 2),
	(41, 18, 3),
	(42, 19, 1),
	(43, 19, 2),
	(44, 19, 3),
	(45, 20, 1),
	(46, 20, 2),
	(47, 20, 3),
	(48, 21, 1),
	(49, 21, 2),
	(50, 21, 3),
	(51, 22, 1),
	(52, 23, 1),
	(53, 23, 2),
	(54, 23, 3),
	(55, 24, 2),
	(56, 24, 3),
	(57, 25, 1),
	(58, 25, 2),
	(59, 25, 3),
	(60, 26, 1),
	(61, 26, 2),
	(62, 26, 3),
	(63, 27, 1),
	(64, 27, 2),
	(65, 27, 3),
	(66, 28, 2),
	(67, 28, 3),
	(68, 29, 1),
	(69, 29, 2),
	(70, 29, 3),
	(71, 30, 2),
	(72, 30, 3),
	(73, 31, 1),
	(74, 31, 2),
	(75, 31, 3),
	(76, 32, 2),
	(77, 32, 3),
	(78, 33, 3),
	(79, 34, 1),
	(80, 34, 2),
	(81, 34, 3),
	(82, 35, 1),
	(83, 35, 2),
	(84, 35, 3),
	(85, 36, 1),
	(86, 36, 3),
	(87, 37, 2),
	(88, 38, 1),
	(89, 38, 2),
	(90, 38, 3),
	(91, 39, 1),
	(92, 39, 2),
	(93, 39, 3),
	(94, 40, 1),
	(95, 40, 2),
	(96, 40, 3),
	(97, 41, 1),
	(98, 41, 2),
	(99, 41, 3),
	(100, 42, 1),
	(101, 43, 1),
	(102, 43, 2),
	(103, 43, 3),
	(104, 44, 1),
	(105, 44, 2),
	(106, 44, 3),
	(107, 45, 1),
	(108, 45, 2),
	(109, 45, 3),
	(110, 46, 1),
	(111, 46, 2),
	(112, 46, 3),
	(113, 47, 1),
	(114, 47, 2),
	(115, 47, 3),
	(116, 48, 1),
	(117, 48, 2),
	(118, 48, 3),
	(119, 49, 1),
	(120, 49, 2),
	(121, 50, 1),
	(122, 50, 2),
	(123, 50, 3),
	(124, 51, 1),
	(125, 51, 2),
	(126, 51, 3),
	(127, 52, 3),
	(128, 53, 1),
	(129, 53, 3),
	(130, 54, 2),
	(131, 54, 3),
	(132, 55, 3),
	(133, 56, 3),
	(134, 57, 1),
	(135, 57, 2),
	(136, 58, 1),
	(137, 58, 3),
	(138, 59, 1),
	(139, 59, 2),
	(140, 59, 3),
	(141, 60, 1),
	(142, 60, 2),
	(143, 61, 3),
	(144, 62, 1),
	(145, 62, 2),
	(146, 62, 3),
	(147, 63, 1),
	(148, 64, 1),
	(149, 64, 2),
	(150, 65, 3),
	(151, 66, 1),
	(152, 66, 2),
	(153, 66, 3),
	(154, 67, 1),
	(155, 67, 2),
	(156, 67, 3),
	(157, 68, 1),
	(158, 68, 2),
	(159, 68, 3),
	(160, 69, 1),
	(161, 69, 3),
	(162, 70, 1),
	(163, 70, 2),
	(164, 70, 3),
	(165, 71, 1),
	(166, 71, 2),
	(167, 71, 3),
	(168, 72, 1),
	(169, 72, 2),
	(170, 72, 3),
	(171, 73, 1),
	(172, 73, 2),
	(173, 73, 3),
	(174, 74, 1),
	(175, 74, 2),
	(176, 74, 3),
	(177, 75, 1),
	(178, 75, 2),
	(179, 76, 1),
	(180, 76, 2),
	(181, 76, 3),
	(182, 77, 2),
	(183, 77, 3),
	(184, 78, 1),
	(185, 78, 2),
	(186, 78, 3),
	(187, 79, 2),
	(188, 80, 1),
	(189, 80, 2),
	(190, 80, 3),
	(191, 81, 1),
	(192, 81, 2),
	(193, 81, 3),
	(194, 82, 1),
	(195, 82, 3),
	(196, 83, 1),
	(197, 83, 3),
	(198, 84, 1),
	(199, 84, 2),
	(200, 84, 3),
	(201, 85, 1),
	(202, 85, 2),
	(203, 85, 3),
	(204, 86, 1),
	(205, 86, 2),
	(206, 86, 3),
	(207, 87, 1),
	(208, 87, 2),
	(209, 87, 3),
	(210, 88, 1),
	(211, 88, 2),
	(212, 88, 3),
	(213, 89, 1),
	(214, 89, 2),
	(215, 89, 3),
	(216, 90, 1),
	(217, 90, 3),
	(218, 91, 1),
	(219, 92, 2),
	(220, 93, 1),
	(221, 93, 2),
	(222, 94, 1),
	(223, 94, 2),
	(224, 94, 3),
	(225, 95, 2),
	(226, 96, 1),
	(227, 96, 2),
	(228, 96, 3),
	(229, 97, 1),
	(230, 97, 2),
	(231, 97, 3),
	(232, 98, 1),
	(233, 98, 2),
	(234, 98, 3),
	(235, 99, 1),
	(236, 99, 2),
	(237, 99, 3),
	(238, 100, 1),
	(239, 100, 2),
	(240, 100, 3);

INSERT INTO `card_movimentacao` (`id_card_movimentacao`, `id_card`, `id_status`, `dt_registro`) VALUES
	(1, 1, 1, NOW()),
	(2, 2, 1, NOW()),
	(3, 3, 1, NOW()),
	(4, 4, 1, NOW()),
	(5, 5, 1, NOW()),
	(6, 6, 1, NOW()),
	(7, 7, 1, NOW()),
	(8, 8, 1, NOW()),
	(9, 9, 1, NOW()),
	(10, 10, 1, NOW()),
	(11, 11, 1, NOW()),
	(12, 12, 1, NOW()),
	(13, 13, 1, NOW()),
	(14, 14, 1, NOW()),
	(15, 15, 1, NOW()),
	(16, 16, 1, NOW()),
	(17, 17, 1, NOW()),
	(18, 18, 1, NOW()),
	(19, 19, 1, NOW()),
	(20, 20, 1, NOW()),
	(21, 21, 1, NOW()),
	(22, 22, 1, NOW()),
	(23, 23, 1, NOW()),
	(24, 24, 1, NOW()),
	(25, 25, 1, NOW()),
	(26, 26, 1, NOW()),
	(27, 27, 1, NOW()),
	(28, 28, 1, NOW()),
	(29, 29, 1, NOW()),
	(30, 30, 1, NOW()),
	(31, 31, 1, NOW()),
	(32, 32, 1, NOW()),
	(33, 33, 1, NOW()),
	(34, 34, 1, NOW()),
	(35, 35, 1, NOW()),
	(36, 36, 1, NOW()),
	(37, 37, 1, NOW()),
	(38, 38, 1, NOW()),
	(39, 39, 1, NOW()),
	(40, 40, 1, NOW()),
	(41, 41, 1, NOW()),
	(42, 42, 1, NOW()),
	(43, 43, 1, NOW()),
	(44, 44, 1, NOW()),
	(45, 45, 1, NOW()),
	(46, 46, 1, NOW()),
	(47, 47, 1, NOW()),
	(48, 48, 1, NOW()),
	(49, 49, 1, NOW()),
	(50, 50, 1, NOW()),
	(51, 51, 1, NOW()),
	(52, 52, 1, NOW()),
	(53, 53, 1, NOW()),
	(54, 54, 1, NOW()),
	(55, 55, 1, NOW()),
	(56, 56, 1, NOW()),
	(57, 57, 1, NOW()),
	(58, 58, 1, NOW()),
	(59, 59, 1, NOW()),
	(60, 60, 1, NOW()),
	(61, 61, 1, NOW()),
	(62, 62, 1, NOW()),
	(63, 63, 1, NOW()),
	(64, 64, 1, NOW()),
	(65, 65, 1, NOW()),
	(66, 66, 1, NOW()),
	(67, 67, 1, NOW()),
	(68, 68, 1, NOW()),
	(69, 69, 1, NOW()),
	(70, 70, 1, NOW()),
	(71, 71, 1, NOW()),
	(72, 72, 1, NOW()),
	(73, 73, 1, NOW()),
	(74, 74, 1, NOW()),
	(75, 75, 1, NOW()),
	(76, 76, 1, NOW()),
	(77, 77, 1, NOW()),
	(78, 78, 1, NOW()),
	(79, 79, 1, NOW()),
	(80, 80, 1, NOW()),
	(81, 81, 1, NOW()),
	(82, 82, 1, NOW()),
	(83, 83, 1, NOW()),
	(84, 84, 1, NOW()),
	(85, 85, 1, NOW()),
	(86, 86, 1, NOW()),
	(87, 87, 1, NOW()),
	(88, 88, 1, NOW()),
	(89, 89, 1, NOW()),
	(90, 90, 1, NOW()),
	(91, 91, 1, NOW()),
	(92, 92, 1, NOW()),
	(93, 93, 1, NOW()),
	(94, 94, 1, NOW()),
	(95, 95, 1, NOW()),
	(96, 96, 1, NOW()),
	(97, 97, 1, NOW()),
	(98, 98, 1, NOW()),
	(99, 99, 1, NOW()),
	(100, 100, 1, NOW());

INSERT INTO `card_professor` (`id_card_professor`, `id_card`, `id_professor`) VALUES
	(1, 1, 39),
	(3, 2, 14),
	(2, 2, 29),
	(4, 3, 8),
	(5, 3, 43),
	(6, 4, 9),
	(7, 4, 41),
	(8, 5, 35),
	(9, 6, 25),
	(10, 7, 40),
	(11, 8, 32),
	(13, 9, 35),
	(14, 10, 36),
	(16, 11, 10),
	(17, 12, 34),
	(18, 13, 35),
	(19, 14, 30),
	(23, 17, 47),
	(24, 18, 8),
	(27, 20, 37),
	(29, 21, 25),
	(28, 21, 32),
	(30, 22, 6),
	(35, 25, 1),
	(36, 26, 19),
	(37, 27, 27),
	(38, 27, 45),
	(39, 28, 29),
	(40, 29, 31),
	(43, 31, 20),
	(44, 32, 45),
	(46, 33, 8),
	(45, 33, 28),
	(47, 34, 15),
	(48, 35, 49),
	(49, 36, 20),
	(50, 36, 25),
	(51, 37, 39),
	(53, 38, 12),
	(52, 38, 17),
	(55, 39, 2),
	(54, 39, 3),
	(56, 40, 41),
	(57, 41, 32),
	(58, 41, 49),
	(59, 42, 10),
	(60, 43, 41),
	(61, 44, 6),
	(62, 45, 12),
	(63, 45, 30),
	(64, 46, 37),
	(65, 47, 6),
	(66, 47, 37),
	(67, 48, 18),
	(68, 49, 31),
	(69, 50, 28),
	(71, 51, 20),
	(70, 51, 48),
	(72, 52, 11),
	(73, 53, 28),
	(74, 54, 42),
	(76, 55, 34),
	(75, 55, 50),
	(78, 56, 1),
	(77, 56, 20),
	(79, 57, 11),
	(80, 57, 20),
	(81, 58, 37),
	(82, 59, 27),
	(84, 60, 42),
	(83, 60, 46),
	(85, 61, 20),
	(86, 61, 28),
	(87, 62, 13),
	(88, 63, 23),
	(89, 63, 47),
	(90, 64, 48),
	(91, 65, 24),
	(92, 66, 11),
	(94, 67, 30),
	(93, 67, 42),
	(95, 68, 26),
	(96, 69, 1),
	(97, 69, 23),
	(100, 71, 20),
	(101, 71, 40),
	(102, 72, 23),
	(104, 73, 3),
	(103, 73, 6),
	(105, 74, 39),
	(106, 75, 20),
	(107, 75, 32),
	(108, 76, 7),
	(109, 77, 49),
	(110, 78, 25),
	(113, 80, 29),
	(114, 80, 30),
	(115, 81, 21),
	(116, 81, 47),
	(117, 82, 4),
	(118, 82, 24),
	(120, 83, 7),
	(119, 83, 38),
	(121, 84, 44),
	(122, 85, 40),
	(124, 86, 17),
	(123, 86, 26),
	(125, 87, 32),
	(126, 88, 33),
	(127, 89, 49),
	(129, 90, 42),
	(128, 90, 49),
	(132, 92, 33),
	(133, 93, 7),
	(134, 94, 37),
	(135, 94, 41),
	(136, 95, 34),
	(142, 98, 30),
	(141, 98, 46),
	(143, 99, 6),
	(144, 99, 25),
	(145, 100, 14);

INSERT INTO `curso` (`id_curso`, `curso`) VALUES
	(1, 'Administração'),
	(2, 'Filosofia'),
	(3, 'Matemática'),
	(4, 'Geografia'),
	(5, 'Análise e Desenvolvimento de Sistemas'),
	(6, 'Pedagogia'),
	(7, 'Segurança Pública'),
	(8, 'Design de Interiores'),
	(9, 'Educação Física'),
	(10, 'Ciências Contábeis'),
	(11, 'Gestão da Produção Industrial'),
	(12, 'Marketing Digital'),
	(13, 'Processos Gerenciais'),
	(14, 'Publicidade e Propaganda'),
	(15, 'Serviço Social');


INSERT INTO `professor` (`id_professor`, `nome`) VALUES
	(1, 'Alexsandra Camara'),
	(2, 'Simone Freitas'),
	(3, 'Fernando Nera Lenarduzzi'),
	(4, 'Paulo Vasconcelos Jacobina'),
	(5, 'Franklin Castillo Retamal'),
	(6, 'Evelyn Fabricia de Arruda'),
	(7, 'André Luiz Delgado Corradini'),
	(8, 'Michelle Thomé'),
	(9, 'Antonio Carlos Tammenhain'),
	(10, 'Paulo Cesar da Silva'),
	(11, 'Mariana Lopes Teixeira'),
	(12, 'Rivaldo Lins Machado'),
	(13, 'Márcio Wislley Candelmo do Amaral'),
	(14, 'Maria Eunice de Oliveira'),
	(15, 'Luiz Alexandre Solano Rossi'),
	(16, 'Deisily de Quadros'),
	(17, 'Maura Vello'),
	(18, 'Nelson Pereira Castanheira'),
	(19, 'Rivael de Jesus Nacimento'),
	(20, 'Tiago Luiz Ferrazza'),
	(21, 'Martha Daisson Hameister'),
	(22, 'Gisele Farias'),
	(23, 'Felipe Martynetz'),
	(24, 'Danielly Dias Sandy'),
	(25, 'Paula Andrea da Rosa Garbuio'),
	(26, 'Cassiana Fagundes da Silva'),
	(27, 'Marcos Aurélio Nascimento'),
	(28, 'Rodrigo Ricardo Mayer'),
	(29, 'Lisbeth Soares'),
	(30, 'Elias Santos do Paraizo Junior'),
	(31, 'Carlos Eduardo Souza da Cunha'),
	(32, 'Flavia Sucheck Mateus da Rocha'),
	(33, 'Vinicius Ferreira dos Santos Andrade'),
	(34, 'Simone Diefenbach Borges'),
	(35, 'Carolina Mirando do Amaral e Silva'),
	(36, 'Camila de Carvalho Almeida de Bitencourt'),
	(37, 'Vitor Jorge Woytuski Brasil'),
	(38, 'Blanche Dreher Rodrigues'),
	(39, 'Patricia Santos Fernandes'),
	(40, 'Luciano Frontino de Medeiros'),
	(41, 'Taniele Loss Nesi'),
	(42, 'Luiz Guilherme Gaertner'),
	(43, 'Cassandra Coninck Costa'),
	(44, 'Christiane Kaminski'),
	(45, 'Claudia R. J. A. Cabral de Oliveira'),
	(46, 'Angela Christianne Lunedo de Mendonça'),
	(47, 'Paula Vizaco Rigo Cuellar Tramujas'),
	(48, 'Patricia de Camargo'),
	(49, 'Alex de Britto Rodrigues'),
	(50, 'Virginia Roters da Silva');

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;