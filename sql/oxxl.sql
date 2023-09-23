-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: siocssmls.mysql.db
-- Generation Time: Sep 08, 2023 at 06:40 PM
-- Server version: 5.7.42-log
-- PHP Version: 8.1.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `siocssmls`
--

-- --------------------------------------------------------

--
-- Table structure for table `oxxl_accessoires`
--

CREATE TABLE `oxxl_accessoires` (
  `idAccessoire` tinyint(4) NOT NULL COMMENT 'Identifiant de l''accessoire',
  `accessoire` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nom de l''accessoire'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Accessoires possibles';

--
-- Dumping data for table `oxxl_accessoires`
--

INSERT INTO `oxxl_accessoires` (`idAccessoire`, `accessoire`) VALUES
(1, 'Alimentation'),
(2, 'Disque dur externe'),
(3, 'Mallette'),
(4, 'Clef USB'),
(5, 'Souris sans fil');

-- --------------------------------------------------------

--
-- Table structure for table `oxxl_bonsAccessoires`
--

CREATE TABLE `oxxl_bonsAccessoires` (
  `numeroBon` int(11) NOT NULL COMMENT 'Numéro du bon de réparation',
  `idAccessoire` tinyint(4) NOT NULL COMMENT 'Identifiant de l''accessoire'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table des accessoires pour un matériel déposé';

--
-- Dumping data for table `oxxl_bonsAccessoires`
--

INSERT INTO `oxxl_bonsAccessoires` (`numeroBon`, `idAccessoire`) VALUES
(1, 1),
(18, 1),
(19, 1),
(21, 1),
(1, 3),
(18, 3),
(19, 3),
(1, 4),
(1, 5),
(19, 5);

-- --------------------------------------------------------

--
-- Table structure for table `oxxl_bonsAvancement`
--

CREATE TABLE `oxxl_bonsAvancement` (
  `idAvancement` int(11) NOT NULL,
  `numeroBon` int(11) NOT NULL COMMENT 'Numéro du bon',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `texte` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Explication',
  `benevole` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Prénom du bénévole en charge'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Avancement du travail';

--
-- Dumping data for table `oxxl_bonsAvancement`
--

INSERT INTO `oxxl_bonsAvancement` (`idAvancement`, `numeroBon`, `date`, `texte`, `benevole`) VALUES
(2, 18, '2023-08-29 08:32:02', 'Installation Win10 et mises à jour terminées', 'Yves'),
(3, 20, '2023-09-03 16:05:30', 'dddddddddddddd  xxxxxxxxxxxxxxxx', 'Michel'),
(4, 21, '2023-09-05 12:47:11', 'Listes modifiable des interventions', 'Thomas'),
(5, 21, '2023-09-05 12:50:48', 'Certains champs (style ox ou marque ordi) ne devraient pas être modifiable a posteriori ou alors changements doivent être repris en remarque que part', 'Thomas'),
(7, 21, '2023-09-05 12:51:08', 'Certains champs (style ox ou marque ordi) ne devraient pas être modifiable a posteriori ou alors changements doivent être repris en remarque que part', 'Thomas'),
(8, 21, '2023-09-05 12:52:10', 'Idem pour mentions supprimée a barrer plutôt qui effacer?', 'Thomas'),
(9, 21, '2023-09-06 10:01:23', 'Dans \"données\" ne faudrait\'il pas indiquer plus clairement qu\'elles peuvent être effacées/formatées...pour éviter toutes contestations ?', 'Michel'),
(10, 21, '2023-09-06 10:04:21', 'L\'OS Win/Linux ne devrait\'il pas apparaitre ?', 'Michel'),
(11, 21, '2023-09-06 10:09:17', 'Oui pour les photos mais pas systématiquement ! A 2 avec des clients qui attendent cela risque de devenir très lourd !', 'Michel'),
(12, 21, '2023-09-06 10:16:43', 'Yves: \"Ajouter fiche de travail \" au lieu \"d\'ajouter\" ?', 'Michel'),
(13, 21, '2023-09-06 10:21:26', 'Yves: Après avoir remplis la partie données du client il ne suffit pas de cliquer sur \"ajouter\", il faut re-sélectionner celui-ci dans la liste des clients pour ouvrir la partie \"travaux\" ...d\'ou  mes', 'Michel');

-- --------------------------------------------------------

--
-- Table structure for table `oxxl_bonsReparation`
--

CREATE TABLE `oxxl_bonsReparation` (
  `numeroBon` int(11) NOT NULL COMMENT 'Numéro du bon de réparation',
  `idUser` int(11) NOT NULL COMMENT 'Identifiant du client',
  `typeMateriel` smallint(6) NOT NULL COMMENT 'Type de matériel (table oxxl_typeMateriel)',
  `marque` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Marque',
  `modele` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Modèle',
  `ox` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Numéro OX éventuel du matériel',
  `mdp` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Mot de passe éventuel',
  `data` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Conservation des données?',
  `dateEntree` date NOT NULL,
  `dateSortie` date DEFAULT NULL,
  `benevole` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Adresse mail de la personne qui réception le matériel',
  `probleme` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `etat` text COLLATE utf8mb4_unicode_ci COMMENT 'État général du matériel',
  `devis` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Solution proposée avec prix',
  `garantie` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Sous garantie',
  `remarque` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Remarque technicien',
  `apayer` smallint(6) DEFAULT NULL COMMENT 'Montant à payer',
  `termine` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Réparation terminée'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bons de réparation';

--
-- Dumping data for table `oxxl_bonsReparation`
--

INSERT INTO `oxxl_bonsReparation` (`numeroBon`, `idUser`, `typeMateriel`, `marque`, `modele`, `ox`, `mdp`, `data`, `dateEntree`, `dateSortie`, `benevole`, `probleme`, `etat`, `devis`, `garantie`, `remarque`, `apayer`, `termine`) VALUES
(1, 1, 1, 'Dell', 'Probook', '', '', 1, '2023-08-17', NULL, 'Thomas', 'Très lent', 'Capot griffé.', 'Ajout de 4GB RAM -> 25€\r\nChangement du disque dur -> SSD 256GB -> 50€', 0, 'Nettoyage interne pour éliminer la poussière nécessaire...', 50, 0),
(18, 10, 1, 'Dell', 'Le mod\' DELLL', '123456', 'MOTDEPASSE', 1, '2023-08-12', NULL, 'Yves', 'L\'ordinateur ne démarre plus. Aucun affichage à l\'écran.', 'charnière gauche cassée', 'Reconnexion de la batterie 15€\r\nInstallation Win 10 20€\r\n', 0, 'Réparation effectuée selon le devis', 35, 1),
(19, 10, 4, '', '', '123456', '', 0, '2023-08-12', NULL, 'Yves', '', '', '', 0, '', 20, 1),
(21, 10, 2, 'hp modif', '820', '452007', 'Oxfamplan#', 1, '2023-09-05', NULL, 'Thomas', 'Liste préétablie extensible et modifiable??', 'Si on savait associer une/des photos de l appareils ca éviterait des litiges et faciliterait la recherche des ordis perdus', 'Liste?', 0, '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oxxl_config`
--

CREATE TABLE `oxxl_config` (
  `ordre` tinyint(4) DEFAULT NULL,
  `parametre` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Label',
  `size` smallint(6) DEFAULT NULL,
  `valeur` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `signification` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oxxl_config`
--

INSERT INTO `oxxl_config` (`ordre`, `parametre`, `label`, `size`, `valeur`, `signification`) VALUES
(2, 'NOMNOREPLY', 'Nom adresse No Reply', 30, 'Merci de ne pas \"répondre\"', 'Nom de l\'adresse pour la diffusion de mails \"no reply\"'),
(1, 'NOREPLY', 'Ne pas répondre', 40, 'ne_pas_repondre@noMail.com', 'Adresse pour la diffusion de mails \"no reply\"');

-- --------------------------------------------------------

--
-- Table structure for table `oxxl_interactionsClient`
--

CREATE TABLE `oxxl_interactionsClient` (
  `idInteraction` int(11) NOT NULL COMMENT 'Identifiant de l''interaction',
  `numeroBon` int(11) NOT NULL COMMENT 'Numéro du bon',
  `idUser` int(11) NOT NULL COMMENT 'Identifiant du client',
  `benevole` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Prénom du bénévole',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date de l''interaction',
  `typeInteraction` enum('telephone','repondeur','mail','magasin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Type d''interaction avec le client',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Résultat de l''interaction'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `oxxl_interactionsClient`
--

INSERT INTO `oxxl_interactionsClient` (`idInteraction`, `numeroBon`, `idUser`, `benevole`, `date`, `typeInteraction`, `note`) VALUES
(26, 19, 10, 'Yves', '2023-08-08 12:13:37', 'mail', 'test'),
(27, 18, 10, 'Yves', '2023-08-16 14:52:45', 'mail', 'demande pour les data');

-- --------------------------------------------------------

--
-- Table structure for table `oxxl_typeMateriel`
--

CREATE TABLE `oxxl_typeMateriel` (
  `idTypeMateriel` smallint(11) NOT NULL COMMENT 'id',
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Type de matériel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Type de matériel';

--
-- Dumping data for table `oxxl_typeMateriel`
--

INSERT INTO `oxxl_typeMateriel` (`idTypeMateriel`, `type`) VALUES
(1, 'Desktop/Tour'),
(2, 'Laptop/portable'),
(3, 'Écran'),
(4, 'Imprimante'),
(5, 'Disque'),
(6, 'Clef USB');

-- --------------------------------------------------------

--
-- Table structure for table `oxxl_users`
--

CREATE TABLE `oxxl_users` (
  `idUser` int(11) NOT NULL COMMENT 'Identifiant unique',
  `pseudo` varchar(18) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Identifiant (à la place de l''adresse mail)',
  `civilite` enum('F','M','X') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Civilité',
  `nom` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nom du client',
  `prenom` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Prénom',
  `telephone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Téléphone fixe',
  `gsm` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'GSM',
  `mail` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Adresse mail',
  `adresse` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Adresse rue n°',
  `cpost` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Code Postal',
  `commune` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Commune',
  `tva` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Numéro de TVA',
  `droits` enum('root','oxfam','client') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'client' COMMENT 'Droits sur l''application',
  `rgpd` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Acceptation de la formule RGPD',
  `dateAcces` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date du dernier accès',
  `md5passwd` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Mot de passe md5'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Références client';

--
-- Dumping data for table `oxxl_users`
--

INSERT INTO `oxxl_users` (`idUser`, `pseudo`, `civilite`, `nom`, `prenom`, `telephone`, `gsm`, `mail`, `adresse`, `cpost`, `commune`, `tva`, `droits`, `rgpd`, `dateAcces`, `md5passwd`) VALUES
(1, 'maiyve', 'M', 'Mairesse', 'Yves', '', '+32474754694', 'ymairesse@sio2.be', 'Av. Daniel Boon, 59', '1160', 'Auderghem', '', 'root', 0, '2023-07-31 12:03:03', '1224b6196e600af6d118b8d7a12fec76'),
(2, 'Michel', 'M', 'Rouserez', 'Michel', '027820574', '0475850747', 'michel.rouserez@skynet.be', 'In De Poort n°10', '1970', 'Wezembeek-Oppem', '', 'root', 0, '2023-07-31 12:00:47', 'b829dae101214d738a37fb571398ae04'),
(10, NULL, 'M', 'Machin', 'Bidule', 'ddd', '0474754696', 'nomail@nomail.com', '', '1070', '', '', 'client', 0, '2023-07-31 14:11:23', 'b829dae101214d738a37fb571398ae04'),
(15, 'nomail', NULL, 'Isidore', 'Tranquille', '0474754696', '', 'nomail@nomail.com', '', '', '', '', 'root', 0, '2023-08-05 23:13:47', 'b829dae101214d738a37fb571398ae04'),
(17, 'Thomas', NULL, 'Ledauphin', 'Thomas', '', '0485359367', 'thomas.ledauphin@oxfam.org', '', '', '', '', 'root', 0, '2023-09-05 10:32:41', 'b829dae101214d738a37fb571398ae04'),
(19, 'babelkot', NULL, 'germain', 'jean claude', '', '0479393026', 'babelkot@gmail.com', '', '', '', '', 'root', 0, '2023-09-07 12:20:30', '26473d30784a7c5494ea01c57ae7f007');

-- --------------------------------------------------------

--
-- Table structure for table `ox_accessoires`
--

CREATE TABLE `ox_accessoires` (
  `idAccessoire` tinyint(4) NOT NULL COMMENT 'Identifiant de l''accessoire',
  `accessoire` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nom de l''accessoire'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Accessoires possibles';

--
-- Dumping data for table `ox_accessoires`
--

INSERT INTO `ox_accessoires` (`idAccessoire`, `accessoire`) VALUES
(1, 'Alimentation'),
(2, 'Disque dur externe'),
(3, 'Mallette'),
(4, 'Clef USB'),
(5, 'Souris sans fil');

-- --------------------------------------------------------

--
-- Table structure for table `ox_bonsAvancement`
--

CREATE TABLE `ox_bonsAvancement` (
  `idAvancement` int(11) NOT NULL,
  `numeroBon` int(11) NOT NULL COMMENT 'Numéro du bon',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `texte` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Explication',
  `benevole` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Prénom du bénévole en charge'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Avancement du travail';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `oxxl_accessoires`
--
ALTER TABLE `oxxl_accessoires`
  ADD PRIMARY KEY (`idAccessoire`);

--
-- Indexes for table `oxxl_bonsAccessoires`
--
ALTER TABLE `oxxl_bonsAccessoires`
  ADD PRIMARY KEY (`numeroBon`,`idAccessoire`),
  ADD KEY `idAccessoire` (`idAccessoire`);

--
-- Indexes for table `oxxl_bonsAvancement`
--
ALTER TABLE `oxxl_bonsAvancement`
  ADD PRIMARY KEY (`idAvancement`),
  ADD KEY `numeroBon` (`numeroBon`);

--
-- Indexes for table `oxxl_bonsReparation`
--
ALTER TABLE `oxxl_bonsReparation`
  ADD PRIMARY KEY (`numeroBon`),
  ADD KEY `typeMateriel` (`typeMateriel`),
  ADD KEY `oxxl_bonsReparation_ibfk_1` (`idUser`);

--
-- Indexes for table `oxxl_config`
--
ALTER TABLE `oxxl_config`
  ADD PRIMARY KEY (`parametre`);

--
-- Indexes for table `oxxl_interactionsClient`
--
ALTER TABLE `oxxl_interactionsClient`
  ADD PRIMARY KEY (`idInteraction`),
  ADD KEY `numeroBon` (`numeroBon`);

--
-- Indexes for table `oxxl_passwd`
--
ALTER TABLE `oxxl_passwd`
  ADD PRIMARY KEY (`mail`);

--
-- Indexes for table `oxxl_typeMateriel`
--
ALTER TABLE `oxxl_typeMateriel`
  ADD PRIMARY KEY (`idTypeMateriel`);

--
-- Indexes for table `oxxl_users`
--
ALTER TABLE `oxxl_users`
  ADD PRIMARY KEY (`idUser`),
  ADD KEY `nom` (`nom`),
  ADD KEY `mail` (`mail`),
  ADD KEY `telephone` (`telephone`);

--
-- Indexes for table `ox_accessoires`
--
ALTER TABLE `ox_accessoires`
  ADD PRIMARY KEY (`idAccessoire`);

--
-- Indexes for table `ox_bonsAvancement`
--
ALTER TABLE `ox_bonsAvancement`
  ADD PRIMARY KEY (`idAvancement`),
  ADD KEY `numeroBon` (`numeroBon`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `oxxl_accessoires`
--
ALTER TABLE `oxxl_accessoires`
  MODIFY `idAccessoire` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de l''accessoire', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `oxxl_bonsAvancement`
--
ALTER TABLE `oxxl_bonsAvancement`
  MODIFY `idAvancement` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `oxxl_bonsReparation`
--
ALTER TABLE `oxxl_bonsReparation`
  MODIFY `numeroBon` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Numéro du bon de réparation', AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `oxxl_interactionsClient`
--
ALTER TABLE `oxxl_interactionsClient`
  MODIFY `idInteraction` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de l''interaction', AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `oxxl_typeMateriel`
--
ALTER TABLE `oxxl_typeMateriel`
  MODIFY `idTypeMateriel` smallint(11) NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oxxl_users`
--
ALTER TABLE `oxxl_users`
  MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identifiant unique', AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `ox_accessoires`
--
ALTER TABLE `ox_accessoires`
  MODIFY `idAccessoire` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de l''accessoire', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ox_bonsAvancement`
--
ALTER TABLE `ox_bonsAvancement`
  MODIFY `idAvancement` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `oxxl_bonsAccessoires`
--
ALTER TABLE `oxxl_bonsAccessoires`
  ADD CONSTRAINT `oxxl_bonsAccessoires_ibfk_1` FOREIGN KEY (`numeroBon`) REFERENCES `oxxl_bonsReparation` (`numeroBon`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `oxxl_bonsReparation`
--
ALTER TABLE `oxxl_bonsReparation`
  ADD CONSTRAINT `oxxl_bonsReparation_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `oxxl_users` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `oxxl_interactionsClient`
--
ALTER TABLE `oxxl_interactionsClient`
  ADD CONSTRAINT `oxxl_interactionsClient_ibfk_1` FOREIGN KEY (`numeroBon`) REFERENCES `oxxl_bonsReparation` (`numeroBon`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ox_bonsAvancement`
--
ALTER TABLE `ox_bonsAvancement`
  ADD CONSTRAINT `ox_bonsAvancement_ibfk_1` FOREIGN KEY (`numeroBon`) REFERENCES `oxxl_bonsReparation` (`numeroBon`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
