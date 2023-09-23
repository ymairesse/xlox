-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : sam. 23 sep. 2023 à 10:54
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
(3, 'Sacoche'),
(4, 'Clef USB'),
(5, 'Souris sans fil'),
(27, 'Bidule');

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
(19, 1),
(19, 3),
(19, 5),
(21, 4),
(22, 3),
(22, 4),
(23, 1),
(23, 2);

-- --------------------------------------------------------

--
-- Structure de la table `ox_bonsAvancement`
--

CREATE TABLE `ox_bonsAvancement` (
  `idAvancement` int(11) NOT NULL,
  `numeroBon` int(11) NOT NULL COMMENT 'Numéro du bon',
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `texte` varchar(200) NOT NULL COMMENT 'Explication',
  `benevole` varchar(60) NOT NULL COMMENT 'Prénom du bénévole en charge',
  `barre` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Le commentaire est barré',
  `barrePar` varchar(60) DEFAULT NULL COMMENT 'Qui a barré le commentaire?',
  `interactionClient` enum('telephone','repondeur','mail','magasin') DEFAULT NULL COMMENT 'Type d''interaction avec le client'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Avancement du travail';

--
-- Déchargement des données de la table `ox_bonsAvancement`
--

INSERT INTO `ox_bonsAvancement` (`idAvancement`, `numeroBon`, `date`, `texte`, `benevole`, `barre`, `barrePar`, `interactionClient`) VALUES
(14, 18, '2023-08-28 19:40:43', 'Initialisation du système', 'Thomas', 0, 'Yves', NULL),
(16, 18, '2023-09-08 19:09:29', 'test', 'Thomas', 1, 'André', NULL),
(27, 23, '2023-09-15 20:12:03', 'test', 'Yves', 0, NULL, NULL),
(45, 18, '2023-09-16 17:55:34', '1234567890', 'Yves', 0, NULL, NULL);

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
  `mdp` varchar(40) DEFAULT NULL COMMENT 'Mot de passe éventuel',
  `data` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Faut-il préserver les data',
  `dateEntree` date NOT NULL,
  `dateSortie` date DEFAULT NULL,
  `benevole` varchar(100) NOT NULL COMMENT 'Adresse mail de la personne qui réception le matériel',
  `probleme` text NOT NULL,
  `etat` text DEFAULT NULL COMMENT 'État général du matériel',
  `devis` text NOT NULL COMMENT 'Solution proposée avec prix',
  `garantie` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Sous garantie',
  `remarque` text NOT NULL COMMENT 'Remarque technicien',
  `apayer` smallint(6) DEFAULT NULL COMMENT 'Montant à payer',
  `termine` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Réparation terminée'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bons de réparation';

--
-- Déchargement des données de la table `ox_bonsReparation`
--

INSERT INTO `ox_bonsReparation` (`numeroBon`, `idUser`, `typeMateriel`, `marque`, `modele`, `ox`, `mdp`, `data`, `dateEntree`, `dateSortie`, `benevole`, `probleme`, `etat`, `devis`, `garantie`, `remarque`, `apayer`, `termine`) VALUES
(18, 15, 1, 'HP', 'Probook', '', '123456', 1, '2023-08-12', NULL, 'Bidule', 'L\'ordinateur ne charge plus.\r\nBen, il n\'y a plus rien qui va, mon bon monsieur.\r\nQuand je mets la prise, ça fume et ça chauffe.\r\nJ\'ai peur.', 'Coin inférieur gauche du clavier cassé', 'Remplacement HDD par SSD.\r\nOn va refaire tout ça, hein.\r\n- Réinstallation de l\'OS\r\n- Réparation de la charnière', 0, 'C\'est réparé!! Bonne nouvelle', 40, 0),
(19, 15, 4, '', '', '123456', '', 0, '2023-08-12', NULL, 'Yves', 'test', '', '', 0, '', 20, 0),
(21, 1, 6, '', '', '', '', 0, '2023-08-11', NULL, 'Yves', '', '', '', 0, '', 0, 0),
(22, 1, 1, 'hp', 'Probook', 'qsdfqs', '12345678', 1, '2023-08-10', '2023-08-19', 'Yves', 'test', 'Bon état', 'test test test', 0, 'Bof et rebof', 75, 1),
(23, 15, 1, 'HP', '', '', '123456', 0, '2023-08-27', NULL, 'Yves', 'test', 'saleté repossante', '', 1, '', 0, 1);

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
-- Structure de la table `ox_mentionsTravail`
--

CREATE TABLE `ox_mentionsTravail` (
  `idMention` int(11) NOT NULL COMMENT 'Identifiant de la mention',
  `idUser` int(11) NOT NULL COMMENT 'Identifiant de l''auteur',
  `type` enum('probleme','solution') NOT NULL COMMENT 'Problème ou solution',
  `texte` varchar(100) NOT NULL COMMENT 'Texte prédéfini'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ox_mentionsTravail`
--

INSERT INTO `ox_mentionsTravail` (`idMention`, `idUser`, `type`, `texte`) VALUES
(1, 1, 'probleme', 'L\'ordinateur ne s\'allume plus'),
(2, 1, 'probleme', 'L\'ordinateur ne charge plus.'),
(3, 1, 'probleme', 'La batterie ne tient pas la charge.'),
(4, 1, 'solution', 'Changement de batterie'),
(5, 1, 'solution', 'Remplacement HDD par SSD.'),
(23, 1, 'probleme', 'Bidules');

-- --------------------------------------------------------

--
-- Structure de la table `ox_token`
--

CREATE TABLE `ox_token` (
  `token` int(11) DEFAULT NULL COMMENT 'Valeur actuelle du token'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ox_token`
--

INSERT INTO `ox_token` (`token`) VALUES
(5602);

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
(1, 'Desktop / Tour'),
(2, 'Laptop / Portable'),
(3, 'Écran'),
(4, 'Imprimante'),
(5, 'Disque'),
(6, 'Clef USB'),
(11, 'Bidules');

-- --------------------------------------------------------

--
-- Structure de la table `ox_users`
--

CREATE TABLE `ox_users` (
  `idUser` int(11) NOT NULL COMMENT 'Identifiant unique',
  `pseudo` varchar(12) DEFAULT NULL COMMENT 'Identifiant (à la place de l''adresse mail)',
  `civilite` enum('F','M','X') DEFAULT NULL COMMENT 'Civilité',
  `nom` varchar(60) NOT NULL COMMENT 'Nom du client',
  `prenom` varchar(60) DEFAULT NULL COMMENT 'Prénom',
  `telephone` varchar(15) DEFAULT NULL COMMENT 'Téléphone fixe',
  `gsm` varchar(15) DEFAULT NULL COMMENT 'GSM',
  `mail` varchar(100) DEFAULT NULL COMMENT 'Adresse mail',
  `adresse` varchar(100) DEFAULT NULL COMMENT 'Adresse rue n°',
  `cpost` varchar(6) DEFAULT NULL COMMENT 'Code Postal',
  `commune` varchar(50) DEFAULT NULL COMMENT 'Commune',
  `tva` varchar(12) DEFAULT NULL COMMENT 'Numéro de TVA',
  `droits` enum('root','oxfam','client') NOT NULL DEFAULT 'client' COMMENT 'Droits sur l''application',
  `rgpd` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Acceptation formule RGPD',
  `dateAcces` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Date du dernier accès',
  `md5passwd` varchar(32) DEFAULT NULL COMMENT 'Mot de passe md5'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Références client';

--
-- Déchargement des données de la table `ox_users`
--

INSERT INTO `ox_users` (`idUser`, `pseudo`, `civilite`, `nom`, `prenom`, `telephone`, `gsm`, `mail`, `adresse`, `cpost`, `commune`, `tva`, `droits`, `rgpd`, `dateAcces`, `md5passwd`) VALUES
(1, 'ymairesse', 'M', 'Mairesse', 'Yves', '', '0474754696', 'ymairesse@sio2.be', '', '1160', '', '', 'root', 0, '2023-07-31 12:03:03', '1224b6196e600af6d118b8d7a12fec76'),
(2, 'qsdfqsdf', 'M', 'Machin', 'Bidule', '0474754696', '', 'nomail@nomail.com', '', '1160', '', '1234567890', 'client', 0, '2023-07-31 12:00:47', '1224b6196e600af6d118b8d7a12fec76'),
(10, 'Dodo', 'M', 'Le Dauphin', 'Thomas', '0474754696', '', 'nomail@nomail.com', '', '1160', '', '1234567890', 'root', 0, '2023-07-31 14:11:23', 'b829dae101214d738a37fb571398ae04'),
(15, NULL, 'F', 'Esseriame', 'Sevy', '', '0474754696', 'yves@sio2.be', 'Rue de la Maison écroulée bla bla bla  blabla bla bla  blabla bla bla  bla', '1160', 'Houte-si-Plou les Bains', '', 'client', 1, '2023-09-20 08:32:59', ''),
(23, NULL, NULL, 'Bidule', 'Machin', '', '0474754696', '', '', '', '', '', 'client', 0, '2023-08-26 21:05:07', NULL),
(38, NULL, NULL, 'Poutine', 'Vladimir', '', 'qsdfq sdfqs', '', '', '', '', '', 'client', 0, '2023-09-08 16:55:29', NULL),
(40, NULL, NULL, 'Mairesse', 'Yves', '', '0474 754696', '', '', '', '', '', 'client', 0, '2023-09-19 16:45:48', NULL),
(41, NULL, NULL, 'd', 'd', '', '4', '', '', '', '', '', 'client', 0, '2023-09-19 17:39:58', NULL),
(42, NULL, NULL, 'd', 'd', '', '4', '', '', '', '', '', 'client', 0, '2023-09-19 17:47:23', NULL),
(44, NULL, 'M', 'Mairesse', 'Yves', '', '1111111', '', '', '', '', '', 'client', 0, '2023-09-19 23:22:16', NULL),
(45, NULL, 'M', 'Mairesse', 'Yves', '', '1', '', '', '', '', '', 'client', 0, '2023-09-21 23:02:12', NULL),
(47, NULL, 'M', 'Mairesse', 'Yvessss', '', '123', '', '', '', '', '', 'client', 0, '2023-09-19 18:02:50', NULL),
(49, NULL, NULL, 'qsdfq ', 'qsdf', '', '111', '', '', '', '', '', 'client', 1, '2023-09-19 18:10:07', NULL),
(50, NULL, 'M', 'Zorglub', 'zz', '', '1', '', '', '', '', '', 'client', 0, '2023-09-19 20:35:11', NULL);

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
-- Index pour la table `ox_bonsAvancement`
--
ALTER TABLE `ox_bonsAvancement`
  ADD PRIMARY KEY (`idAvancement`),
  ADD KEY `numeroBon` (`numeroBon`);

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
-- Index pour la table `ox_mentionsTravail`
--
ALTER TABLE `ox_mentionsTravail`
  ADD PRIMARY KEY (`idMention`),
  ADD KEY `idUser` (`idUser`);

--
-- Index pour la table `ox_token`
--
ALTER TABLE `ox_token`
  ADD UNIQUE KEY `token` (`token`);

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
  MODIFY `idAccessoire` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de l''accessoire', AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT pour la table `ox_bonsAvancement`
--
ALTER TABLE `ox_bonsAvancement`
  MODIFY `idAvancement` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT pour la table `ox_bonsReparation`
--
ALTER TABLE `ox_bonsReparation`
  MODIFY `numeroBon` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Numéro du bon de réparation', AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `ox_mentionsTravail`
--
ALTER TABLE `ox_mentionsTravail`
  MODIFY `idMention` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de la mention', AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `ox_typeMateriel`
--
ALTER TABLE `ox_typeMateriel`
  MODIFY `idTypeMateriel` smallint(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `ox_users`
--
ALTER TABLE `ox_users`
  MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identifiant unique', AUTO_INCREMENT=51;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `ox_bonsAccessoires`
--
ALTER TABLE `ox_bonsAccessoires`
  ADD CONSTRAINT `ox_bonsAccessoires_ibfk_1` FOREIGN KEY (`numeroBon`) REFERENCES `ox_bonsReparation` (`numeroBon`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ox_bonsAvancement`
--
ALTER TABLE `ox_bonsAvancement`
  ADD CONSTRAINT `ox_bonsAvancement_ibfk_2` FOREIGN KEY (`numeroBon`) REFERENCES `ox_bonsReparation` (`numeroBon`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ox_bonsReparation`
--
ALTER TABLE `ox_bonsReparation`
  ADD CONSTRAINT `ox_bonsReparation_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `ox_users` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ox_mentionsTravail`
--
ALTER TABLE `ox_mentionsTravail`
  ADD CONSTRAINT `ox_mentionsTravail_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `ox_users` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
