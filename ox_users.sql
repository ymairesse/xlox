-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : mar. 25 juil. 2023 à 18:58
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
-- Structure de la table `ox_users`
--

CREATE TABLE `ox_users` (
  `civilite` enum('Mme','M.') DEFAULT NULL COMMENT 'Civilité',
  `nom` varchar(60) NOT NULL COMMENT 'Nom du client',
  `prenom` varchar(60) DEFAULT NULL COMMENT 'Prénom',
  `telephone` varchar(15) DEFAULT NULL COMMENT 'Téléphone fixe',
  `gsm` varchar(15) DEFAULT NULL COMMENT 'GSM',
  `mail` varchar(100) NOT NULL COMMENT 'Adresse mail',
  `adresse` varchar(100) DEFAULT NULL COMMENT 'Adresse rue n°',
  `cpost` varchar(6) DEFAULT NULL COMMENT 'Code Postal',
  `commune` varchar(50) DEFAULT NULL COMMENT 'Commune',
  `droits` enum('root','oxfam','client') NOT NULL DEFAULT 'client' COMMENT 'Droits sur l''application'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Références client';

--
-- Déchargement des données de la table `ox_users`
--

INSERT INTO `ox_users` (`civilite`, `nom`, `prenom`, `telephone`, `gsm`, `mail`, `adresse`, `cpost`, `commune`, `droits`) VALUES
('M.', 'Tartempion', 'Bidule', '0474754696', NULL, 'ymairesse@gmail.com', NULL, '1050', 'Ixelles', 'client'),
('M.', 'Mairesse', 'Yves', '026737220', '0474754696', 'ymairesse@sio2.be', 'Av. Daniel Boon, 59', '1160', 'Bruxelles', 'root');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ox_users`
--
ALTER TABLE `ox_users`
  ADD PRIMARY KEY (`mail`),
  ADD KEY `mail` (`mail`),
  ADD KEY `nom` (`nom`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
