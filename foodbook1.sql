-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.21-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for foodbook1
CREATE DATABASE IF NOT EXISTS `foodbook1` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `foodbook1`;

-- Dumping structure for table foodbook1.ingredients
CREATE TABLE IF NOT EXISTS `ingredients` (
  `recipeid` int(11) NOT NULL,
  `ingredient` text NOT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `qtymeas_ingredient` tinytext,
  PRIMARY KEY (`ID`),
  KEY `recipeid` (`recipeid`),
  CONSTRAINT `FK_ingredients_recipe` FOREIGN KEY (`recipeid`) REFERENCES `recipe` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Dumping data for table foodbook1.ingredients: ~10 rows (approximately)
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
REPLACE INTO `ingredients` (`recipeid`, `ingredient`, `ID`, `qtymeas_ingredient`) VALUES
	(1, 'Raw Chicken', 1, '1 Breast'),
	(2, 'Raw Chicken', 2, '1 Breast'),
	(2, 'Seasoning', 3, '1 Pinch'),
	(2, 'Love', 4, '0'),
	(3, 'Raw Chicken', 5, '1 Breast'),
	(5, 'Love', 6, 'Lots'),
	(4, 'Raw Chicken', 7, '1 Breast'),
	(5, 'Raw Chicken', 8, '1 Breast'),
	(4, 'Seasoning', 9, '1 Pinch'),
	(5, 'Seasoning', 10, '1 Pinch');
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;

-- Dumping structure for table foodbook1.recipe
CREATE TABLE IF NOT EXISTS `recipe` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `recipename` tinytext NOT NULL,
  `recipesteps` longtext,
  `favoritecount` int(11) NOT NULL DEFAULT '0',
  `recipeimagepath` tinytext,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table foodbook1.recipe: ~5 rows (approximately)
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
REPLACE INTO `recipe` (`ID`, `recipename`, `recipesteps`, `favoritecount`, `recipeimagepath`) VALUES
	(1, 'One Star Chicken', '1. Place Raw Chicken On Plate', 0, '../onestarchicken.jpg'),
	(2, 'Two Star Chicken', '1. Season Raw Chicken\r\n2. Place Seasoned Raw Chicken on Plate', 0, '../bigchick.jpg'),
	(3, 'Three Star Chicken', '1. Cook Raw Chicken at 450 degrees', 1, '../cookedchick.jpg'),
	(4, 'Four Star Chicken', '1. Season Raw Chicken\r\n2. Cook Raw Chicken at 450 degrees\r\n', 50, '../seasonedcookedchicken.jpg'),
	(5, 'Five Star Chicken', '1. Season Chicken Breast\r\n2. Cook Chicken Breast at 450 degrees\r\n3. Put on Plate\r\n4. Serve with Love', 1000000, '../fivestarchicken.jpg');
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;

-- Dumping structure for table foodbook1.users
CREATE TABLE IF NOT EXISTS `users` (
  `username` tinytext NOT NULL,
  `passhash` longtext NOT NULL,
  `picturepath` tinytext,
  `recipesauthored` longtext,
  `recipesfavorited` longtext,
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table foodbook1.users: ~0 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
usersfoodbook1foodbook1users