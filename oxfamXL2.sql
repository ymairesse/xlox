-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : dim. 06 août 2023 à 16:11
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
-- Structure de la table `ox_accessoires`
--

CREATE TABLE `ox_accessoires` (
  `idAccessoire` tinyint(4) NOT NULL COMMENT 'Identifiant de l''accessoire',
  `accessoire` varchar(30) NOT NULL COMMENT 'Nom de l''accessoire'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Accessoires possibles';

--
-- Déchargement des données de la table `ox_accessoires`
--

INSERT INTO `ox_accessoires` (`idAccessoire`, `accessoire`) VALUES
(1, 'Alimentation'),
(2, 'Disque dur externe'),
(3, 'Mallette'),
(4, 'Clef USB'),
(5, 'Souris sans fil');

-- --------------------------------------------------------

--
-- Structure de la table `ox_bonsAccessoires`
--

CREATE TABLE `ox_bonsAccessoires` (
  `numeroBon` int(11) NOT NULL COMMENT 'Numéro du bon de réparation',
  `idAccessoire` tinyint(4) NOT NULL COMMENT 'Identifiant de l''accessoire'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table des accessoires pour un matériel déposé';

--
-- Déchargement des données de la table `ox_bonsAccessoires`
--

INSERT INTO `ox_bonsAccessoires` (`numeroBon`, `idAccessoire`) VALUES
(1, 3),
(1, 4),
(1, 5),
(18, 1),
(18, 2),
(19, 1),
(19, 3),
(19, 5);

-- --------------------------------------------------------

--
-- Structure de la table `ox_bonsReparation`
--

CREATE TABLE `ox_bonsReparation` (
  `numeroBon` int(11) NOT NULL COMMENT 'Numéro du bon de réparation',
  `idUser` int(11) NOT NULL COMMENT 'Identifiant du client',
  `typeMateriel` smallint(6) NOT NULL COMMENT 'Type de matériel (table ox_typeMateriel)',
  `marque` varchar(50) NOT NULL COMMENT 'Marque',
  `modele` varchar(50) NOT NULL COMMENT 'Modèle',
  `ox` varchar(7) DEFAULT NULL COMMENT 'Numéro OX éventuel du matériel',
  `dateEntree` date NOT NULL,
  `dateSortie` date DEFAULT NULL,
  `benevole` varchar(100) NOT NULL COMMENT 'Adresse mail de la personne qui réception le matériel',
  `probleme` text NOT NULL,
  `etat` text DEFAULT NULL COMMENT 'État général du matériel',
  `devis` text NOT NULL COMMENT 'Solution proposée avec prix',
  `remarque` text NOT NULL COMMENT 'Remarque technicien',
  `apayer` smallint(6) DEFAULT NULL COMMENT 'Montant à payer',
  `termine` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Réparation terminée'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bons de réparation';

--
-- Déchargement des données de la table `ox_bonsReparation`
--

INSERT INTO `ox_bonsReparation` (`numeroBon`, `idUser`, `typeMateriel`, `marque`, `modele`, `ox`, `dateEntree`, `dateSortie`, `benevole`, `probleme`, `etat`, `devis`, `remarque`, `apayer`, `termine`) VALUES
(1, 1, 1, 'Dell', 'Probook', '', '2023-08-17', NULL, 'Thomas', 'Très lent', 'Capot griffé.', 'Ajout de 4GB RAM -> 25€\r\nChangement du disque dur -> SSD 256GB -> 50€', 'Nettoyage interne pour éliminer la poussière nécessaire...', 50, 0),
(18, 10, 6, '', '', '', '2023-08-12', NULL, 'Yves', '', '', '', '', 0, 0),
(19, 10, 4, '', '', '123456', '2023-08-12', NULL, 'Yves', '', '', '', '', 70, 0);

-- --------------------------------------------------------

--
-- Structure de la table `ox_config`
--

CREATE TABLE `ox_config` (
  `ordre` tinyint(4) DEFAULT NULL,
  `parametre` varchar(20) NOT NULL,
  `label` varchar(40) DEFAULT NULL COMMENT 'Label',
  `size` smallint(6) DEFAULT NULL,
  `valeur` varchar(60) NOT NULL,
  `signification` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ox_config`
--

INSERT INTO `ox_config` (`ordre`, `parametre`, `label`, `size`, `valeur`, `signification`) VALUES
(2, 'NOMNOREPLY', 'Nom adresse No Reply', 30, 'Merci de ne pas \"répondre\"', 'Nom de l\'adresse pour la diffusion de mails \"no reply\"'),
(1, 'NOREPLY', 'Ne pas répondre', 40, 'ne_pas_repondre@noMail.com', 'Adresse pour la diffusion de mails \"no reply\"');

-- --------------------------------------------------------

--
-- Structure de la table `ox_passwd`
--

CREATE TABLE `ox_passwd` (
  `mail` varchar(100) NOT NULL COMMENT 'adresse mail de l''utilisateur',
  `md5passwd` varchar(40) NOT NULL COMMENT 'Mot de passe crypté'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ox_passwd`
--

INSERT INTO `ox_passwd` (`mail`, `md5passwd`) VALUES
('ymairesse@sio2.be', '1224b6196e600af6d118b8d7a12fec76');

-- --------------------------------------------------------

--
-- Structure de la table `ox_typeMateriel`
--

CREATE TABLE `ox_typeMateriel` (
  `idTypeMateriel` smallint(11) NOT NULL COMMENT 'id',
  `type` varchar(50) NOT NULL COMMENT 'Type de matériel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Type de matériel';

--
-- Déchargement des données de la table `ox_typeMateriel`
--

INSERT INTO `ox_typeMateriel` (`idTypeMateriel`, `type`) VALUES
(1, 'Desktop'),
(2, 'Laptop'),
(3, 'Écran'),
(4, 'Imprimante'),
(5, 'Disque'),
(6, 'Clef USB');

-- --------------------------------------------------------

--
-- Structure de la table `ox_users`
--

CREATE TABLE `ox_users` (
  `idUser` int(11) NOT NULL COMMENT 'Identifiant unique',
  `civilite` enum('F','M','X') DEFAULT NULL COMMENT 'Civilité',
  `nom` varchar(60) NOT NULL COMMENT 'Nom du client',
  `prenom` varchar(60) DEFAULT NULL COMMENT 'Prénom',
  `telephone` varchar(15) DEFAULT NULL COMMENT 'Téléphone fixe',
  `gsm` varchar(15) DEFAULT NULL COMMENT 'GSM',
  `mail` varchar(100) DEFAULT NULL COMMENT 'Adresse mail',
  `adresse` varchar(100) DEFAULT NULL COMMENT 'Adresse rue n°',
  `cpost` varchar(6) DEFAULT NULL COMMENT 'Code Postal',
  `commune` varchar(50) DEFAULT NULL COMMENT 'Commune',
  `droits` enum('root','oxfam','client') NOT NULL DEFAULT 'client' COMMENT 'Droits sur l''application',
  `dateAcces` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Date du dernier accès'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Références client';

--
-- Déchargement des données de la table `ox_users`
--

INSERT INTO `ox_users` (`idUser`, `civilite`, `nom`, `prenom`, `telephone`, `gsm`, `mail`, `adresse`, `cpost`, `commune`, `droits`, `dateAcces`) VALUES
(1, 'M', 'tests', 'Bidule', '0474754696', '', 'toto@hotmail.com', '', '1050', 'Ixelles', 'client', '2023-07-31 12:03:03'),
(2, 'M', 'Mairesse', 'Yves', '026737220', '0474754696', 'ymairesse@sio2.be', 'Av. Daniel Boon, 59', '1160', 'Bruxelles', 'root', '2023-07-31 12:00:47'),
(10, NULL, 'Machin', '', '0474754696', '', '', '', '1160', '', 'client', '2023-07-31 14:11:23'),
(15, NULL, 'Mairesse', 'Yves', '0474754696d', '', '', '', '', '', 'client', '2023-08-05 23:13:47'),
(17, NULL, 'qsdfq', 'qsdfq', 'qsdf', '', '', '', '', '', 'client', '2023-08-05 23:39:47');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ox_accessoires`
--
ALTER TABLE `ox_accessoires`
  ADD PRIMARY KEY (`idAccessoire`);

--
-- Index pour la table `ox_bonsAccessoires`
--
ALTER TABLE `ox_bonsAccessoires`
  ADD PRIMARY KEY (`numeroBon`,`idAccessoire`),
  ADD KEY `idAccessoire` (`idAccessoire`);

--
-- Index pour la table `ox_bonsReparation`
--
ALTER TABLE `ox_bonsReparation`
  ADD PRIMARY KEY (`numeroBon`),
  ADD KEY `typeMateriel` (`typeMateriel`),
  ADD KEY `ox_bonsReparation_ibfk_1` (`idUser`);

--
-- Index pour la table `ox_config`
--
ALTER TABLE `ox_config`
  ADD PRIMARY KEY (`parametre`);

--
-- Index pour la table `ox_passwd`
--
ALTER TABLE `ox_passwd`
  ADD PRIMARY KEY (`mail`);

--
-- Index pour la table `ox_typeMateriel`
--
ALTER TABLE `ox_typeMateriel`
  ADD PRIMARY KEY (`idTypeMateriel`);

--
-- Index pour la table `ox_users`
--
ALTER TABLE `ox_users`
  ADD PRIMARY KEY (`idUser`),
  ADD KEY `nom` (`nom`),
  ADD KEY `mail` (`mail`),
  ADD KEY `telephone` (`telephone`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `ox_accessoires`
--
ALTER TABLE `ox_accessoires`
  MODIFY `idAccessoire` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de l''accessoire', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `ox_bonsReparation`
--
ALTER TABLE `ox_bonsReparation`
  MODIFY `numeroBon` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Numéro du bon de réparation', AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `ox_typeMateriel`
--
ALTER TABLE `ox_typeMateriel`
  MODIFY `idTypeMateriel` smallint(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `ox_users`
--
ALTER TABLE `ox_users`
  MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identifiant unique', AUTO_INCREMENT=19;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `ox_bonsAccessoires`
--
ALTER TABLE `ox_bonsAccessoires`
  ADD CONSTRAINT `ox_bonsAccessoires_ibfk_1` FOREIGN KEY (`numeroBon`) REFERENCES `ox_bonsReparation` (`numeroBon`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ox_bonsReparation`
--
ALTER TABLE `ox_bonsReparation`
  ADD CONSTRAINT `ox_bonsReparation_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `ox_users` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
