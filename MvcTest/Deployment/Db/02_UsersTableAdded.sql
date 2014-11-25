USE `sakila`;

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `Password` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

LOCK TABLES `users` WRITE;
INSERT INTO `users` VALUES (1,'TestUser','123456');
UNLOCK TABLES;