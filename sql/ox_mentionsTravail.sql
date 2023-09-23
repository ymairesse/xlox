-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : lun. 11 sep. 2023 à 18:27
-- Version du serveur : 10.6.12-MariaDB-0ubuntu0.22.04.1
-- Version de PHP : 8.1.2-1ubuntu2.14

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
-- Structure de la table `ox_mentionsTravail`
--

CREATE TABLE `ox_mentionsTravail` (
  `idMention` int(11) NOT NULL COMMENT 'Identifiant de la mention',
  `idUser` int(11) NOT NULL COMMENT 'Identifiant de l''auteur',
  `type` enum('probleme','solution') NOT NULL COMMENT 'Problème ou solution',
  `texte` varchar(100) NOT NULL COMMENT 'Texte prédéfini'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ox_mentionsTravail`
--
ALTER TABLE `ox_mentionsTravail`
  ADD PRIMARY KEY (`idMention`),
  ADD KEY `idUser` (`idUser`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `ox_mentionsTravail`
--
ALTER TABLE `ox_mentionsTravail`
  MODIFY `idMention` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de la mention';

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `ox_mentionsTravail`
--
ALTER TABLE `ox_mentionsTravail`
  ADD CONSTRAINT `ox_mentionsTravail_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `ox_users` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
