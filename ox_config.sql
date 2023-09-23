-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : lun. 17 juil. 2023 à 16:14
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
-- Base de données : `sandrine`
--

-- --------------------------------------------------------

--
-- Structure de la table `sa_config`
--

CREATE TABLE `sa_config` (
  `ordre` tinyint(4) DEFAULT NULL,
  `parametre` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `label` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT 'Label',
  `size` smallint(6) DEFAULT NULL,
  `valeur` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `signification` varchar(80) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `domaine` enum('admin','bulletin','bullTQ') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `sa_config`
--

INSERT INTO `sa_config` (`ordre`, `parametre`, `label`, `size`, `valeur`, `signification`, `domaine`) VALUES
(2, 'NOMNOREPLY', 'Nom adresse No Reply', 30, 'Merci de ne pas \"répondre\"', 'Nom de l\'adresse pour la diffusion de mails \"no reply\"', NULL),
(1, 'NOREPLY', 'Ne pas répondre', 40, 'ne_pas_repondre@noMail.com', 'Adresse pour la diffusion de mails \"no reply\"', NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `sa_config`
--
ALTER TABLE `sa_config`
  ADD PRIMARY KEY (`parametre`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
