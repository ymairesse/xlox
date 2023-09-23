-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : mar. 25 juil. 2023 à 18:54
-- Version du serveur : 10.6.12-MariaDB-0ubuntu0.22.04.1
-- Version de PHP : 8.1.2-1ubuntu2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `oxfamXL`
--

-- --------------------------------------------------------

--
-- Structure de la table `ox_materiel`
--

CREATE TABLE `ox_materiel` (
  `idTypeMateriel` int(11) NOT NULL COMMENT 'id',
  `type` varchar(50) NOT NULL COMMENT 'Type de matériel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ox_materiel`
--

INSERT INTO `ox_materiel` (`idTypeMateriel`, `type`) VALUES
(1, 'Desktop'),
(2, 'Laptop'),
(3, 'Écran'),
(4, 'Imprimante'),
(5, 'Disque'),
(6, 'Clef USB'),
(7, 'Desktop'),
(8, 'Laptop'),
(9, 'Écran'),
(10, 'Imprimante'),
(11, 'Disque'),
(12, 'Clef USB');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ox_materiel`
--
ALTER TABLE `ox_materiel`
  ADD PRIMARY KEY (`idTypeMateriel`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `ox_materiel`
--
ALTER TABLE `ox_materiel`
  MODIFY `idTypeMateriel` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
