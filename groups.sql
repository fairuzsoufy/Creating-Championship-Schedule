-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 31, 2021 at 08:10 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `groups`
--

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `group` text NOT NULL,
  `team` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `name`) VALUES
(1, 'Uttar Pradesh'),
(2, 'J&k'),
(3, 'Delhi'),
(4, 'Goa'),
(5, 'Haryana'),
(6, 'Madhya Pradesh'),
(7, 'Andra Pradesh'),
(8, 'Kerala'),
(9, 'Uttarakhand'),
(10, 'West Bengal'),
(11, 'Sikkim'),
(12, 'Rajasthan'),
(13, 'Punjab'),
(14, 'Himachal Pradesh'),
(15, 'Odisha'),
(16, 'Nagaland'),
(17, 'Maharashtra');

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `qualified` tinyint(1) NOT NULL,
  `state_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `team`
--

INSERT INTO `team` (`id`, `name`, `qualified`, `state_id`) VALUES
(1, 'Rhino Hurricanes', 0, 1),
(2, 'Midnight Stars', 0, 2),
(3, 'Rocky Assassins', 0, 3),
(4, 'Striking Sharpshooters', 1, 3),
(5, 'Skull Fireballs', 0, 4),
(6, 'Blue Bombers', 1, 6),
(7, 'Blue Geckos', 1, 6),
(8, 'Midnight Miners', 1, 1),
(9, 'Spirit Blockers', 0, 7),
(10, 'Wind Kamikaze Pilots', 0, 8),
(11, 'Retro Chuckers', 0, 9),
(12, 'Venomous Cyborgs', 0, 10),
(13, 'Quicksilver Ninjas', 0, 11),
(14, 'Alpha Blockers', 1, 12),
(15, 'Retro Heroes', 0, 5),
(16, 'Lions', 0, 13),
(17, 'Raging Spanners', 0, 14),
(18, 'Poison Spiders', 0, 15),
(19, 'Black Bullets', 0, 1),
(20, 'Thunder Commandos', 0, 1),
(21, 'Venomous Sharks', 0, 5),
(22, 'Killer Stars', 0, 16),
(23, 'Tomato Geckos', 1, 13),
(24, 'Knockout Busters', 0, 6),
(25, 'Muffin Racers', 1, 17),
(26, 'Real Madrid', 0, 3),
(27, 'Demolition Piledrivers', 0, 12),
(28, 'Flying Xpress', 0, 3),
(29, 'Silver Wasps', 0, 9),
(30, 'The Showstoppers', 0, 3),
(31, 'Wolfsburg', 0, 5),
(32, 'Black & White Gangstaz', 1, 7);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state` (`state_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `team`
--
ALTER TABLE `team`
  ADD CONSTRAINT `team_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
