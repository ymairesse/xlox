-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : lun. 01 jan. 2024 à 11:01
-- Version du serveur : 8.0.35-0ubuntu0.22.04.1
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
  `idAccessoire` tinyint NOT NULL COMMENT 'Identifiant de l''accessoire',
  `accessoire` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nom de l''accessoire'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Accessoires possibles';

--
-- Déchargement des données de la table `ox_accessoires`
--

INSERT INTO `ox_accessoires` (`idAccessoire`, `accessoire`) VALUES
(1, 'Alimentation'),
(2, 'Disque dur externe'),
(3, 'Mallette'),
(4, 'Clef USB'),
(5, 'Souris sans fil'),
(7, 'bidule');

-- --------------------------------------------------------

--
-- Structure de la table `ox_bonsAccessoires`
--

CREATE TABLE `ox_bonsAccessoires` (
  `numeroBon` int NOT NULL COMMENT 'Numéro du bon de réparation',
  `idAccessoire` tinyint NOT NULL COMMENT 'Identifiant de l''accessoire'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table des accessoires pour un matériel déposé';

--
-- Déchargement des données de la table `ox_bonsAccessoires`
--

INSERT INTO `ox_bonsAccessoires` (`numeroBon`, `idAccessoire`) VALUES
(1, 1),
(27, 1),
(32, 1),
(33, 1),
(36, 1),
(37, 1),
(45, 1),
(46, 1),
(48, 1),
(49, 1),
(52, 1),
(53, 1),
(78, 1),
(79, 1),
(80, 1),
(82, 1),
(84, 1),
(1, 3),
(1, 4),
(1, 5);

-- --------------------------------------------------------

--
-- Structure de la table `ox_bonsAvancement`
--

CREATE TABLE `ox_bonsAvancement` (
  `idAvancement` int NOT NULL,
  `numeroBon` int NOT NULL COMMENT 'Numéro du bon',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `texte` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Explication',
  `benevole` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Prénom du bénévole en charge',
  `barre` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Le commentaire est barré',
  `barrePar` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Qui a barré le commentaire',
  `interactionClient` enum('telephone','repondeur','mail','magasin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'type d''interaction avec le client'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Avancement du travail';

--
-- Déchargement des données de la table `ox_bonsAvancement`
--

INSERT INTO `ox_bonsAvancement` (`idAvancement`, `numeroBon`, `date`, `texte`, `benevole`, `barre`, `barrePar`, `interactionClient`) VALUES
(2, 18, '2023-08-29 08:32:02', 'Installation Win10 et mises à jour terminées', 'Yves', 0, NULL, 'telephone'),
(3, 20, '2023-09-03 16:05:30', 'dddddddddddddd  xxxxxxxxxxxxxxxx', 'Michel', 0, NULL, 'telephone'),
(4, 21, '2023-09-05 12:47:11', 'Listes modifiable des interventions', 'Thomas', 0, NULL, 'telephone'),
(5, 21, '2023-09-05 12:50:48', 'Certains champs (style ox ou marque ordi) ne devraient pas être modifiable a posteriori ou alors changements doivent être repris en remarque que part', 'Thomas', 0, NULL, 'telephone'),
(7, 21, '2023-09-05 12:51:08', 'Certains champs (style ox ou marque ordi) ne devraient pas être modifiable a posteriori ou alors changements doivent être repris en remarque que part', 'Thomas', 0, NULL, 'telephone'),
(8, 21, '2023-09-05 12:52:10', 'Idem pour mentions supprimée a barrer plutôt qui effacer?', 'Thomas', 1, 'Yves', 'telephone'),
(9, 21, '2023-09-06 10:01:23', 'Dans \"données\" ne faudrait\'il pas indiquer plus clairement qu\'elles peuvent être effacées/formatées...pour éviter toutes contestations ?', 'Michel', 0, NULL, 'telephone'),
(10, 21, '2023-09-06 10:04:21', 'L\'OS Win/Linux ne devrait\'il pas apparaitre ?', 'Michel', 0, NULL, 'telephone'),
(11, 21, '2023-09-06 10:09:17', 'Oui pour les photos mais pas systématiquement ! A 2 avec des clients qui attendent cela risque de devenir très lourd !', 'Michel', 0, NULL, 'telephone'),
(12, 21, '2023-09-06 10:16:43', 'Yves: \"Ajouter fiche de travail \" au lieu \"d\'ajouter\" ?', 'Michel', 0, NULL, 'telephone'),
(13, 21, '2023-09-06 10:21:26', 'Yves: Après avoir remplis la partie données du client il ne suffit pas de cliquer sur \"ajouter\", il faut re-sélectionner celui-ci dans la liste des clients pour ouvrir la partie \"travaux\" ...d\'ou  mes', 'Michel', 0, NULL, 'telephone'),
(14, 21, '2023-09-08 18:57:02', 'Augmenter le nombre de caractères admissibles dans les notes d\'avancement du travail: actuellement, 200 caractères. Le reste est perdu à l\'enregistrement.', 'Yves', 0, NULL, 'telephone'),
(15, 21, '2023-09-08 18:57:56', 'Au minimum,  bloquer la frappe après 200 caractères.', 'Yves', 0, NULL, 'telephone'),
(16, 21, '2023-09-08 19:01:35', 'Remarque de Michel du 06/09 10:21: je pense que c\'est corrigé.', 'Yves', 0, NULL, 'telephone'),
(18, 21, '2023-09-09 10:18:59', 'On peut effacer ses propres notes.\r\nOn peut barrer / dé-barrer les notes d\'autres utilisateurs\r\nOn ne peut pas dé-barrer les notes barrées par d\'autres.', 'Yves', 0, NULL, 'telephone'),
(20, 22, '2023-09-13 11:41:09', 'déjà démonté et remplacer la carte mère mais pas testé si le pbolème est résolu', 'Jean Claude', 0, 'Yves', 'telephone'),
(21, 22, '2023-09-13 11:42:02', 'Test de la CM ne fonctionne pas', 'Yves', 1, 'Jean Claude', 'telephone'),
(22, 22, '2023-09-13 11:43:38', 'Retesté avec une autre battérie et ça fonctionne', 'Jean Claude', 0, 'Yves', 'telephone'),
(23, 24, '2023-09-14 17:54:54', 'Nettoyé à l\'eau de javel', 'Michel', 0, NULL, 'telephone'),
(25, 22, '2023-09-17 07:45:49', 'sqdfqsdf', 'Yves', 0, NULL, NULL),
(26, 24, '2023-09-20 12:11:47', 'réinstallation de windows', 'carole', 0, NULL, NULL),
(27, 18, '2023-09-21 18:54:00', 'Essais', 'Michel', 0, NULL, NULL),
(28, 28, '2023-09-22 16:16:16', 'marche tout seul', 'Michel', 0, NULL, NULL),
(29, 29, '2023-09-26 13:56:20', 'Impossible de sélectionner une entrée.\r\nEchangé contre un autre écran', 'Michel', 0, NULL, NULL),
(31, 29, '2023-09-26 18:17:44', 'Nouvel écran 24 pouces fournis', 'Michel', 0, NULL, 'magasin'),
(32, 30, '2023-10-10 12:45:17', 'Ouverture pc\r\nVentilateur ne tourne pass\r\nTrouver un autre ventilateur \r\n', 'Michel', 0, NULL, NULL),
(33, 30, '2023-10-10 12:46:54', 'PS Initialement j\'ai rédigé un bon papier N°085 - celui-ci le compléte\r\n', 'Michel', 0, NULL, NULL),
(34, 34, '2023-10-12 13:26:55', 'Mises à jour effectuées\r\nAutre clavier testé\r\nEn attente d\'un clavier de la centrale.', 'Yves', 0, NULL, NULL),
(35, 34, '2023-10-12 13:27:11', 'Client accepte d\'attendre 1 semaine.', 'Yves', 0, NULL, 'telephone'),
(36, 35, '2023-10-18 11:23:55', 'Avec alimentation, le PC a démarré.\r\nRetiré la batterie, le PC ne démarre pas.\r\nRemis la batterie: la led d\'alimentation s\'allume 5 fois de suite puis plus rien. Plus de boot.', 'Yves', 0, NULL, NULL),
(37, 30, '2023-10-18 19:37:03', 'Le client abandonne son PC et en achète un autre pour 100 €. (Thomas)', 'Michel', 0, NULL, NULL),
(38, 35, '2023-10-25 10:18:41', 'Message laissé sur le répondeur de la cliente le 19/10.', 'Yves', 0, NULL, 'telephone'),
(39, 37, '2023-10-25 10:20:55', 'Installation Linux acceptée par la cliente', 'Yves', 0, NULL, 'telephone'),
(40, 49, '2023-10-28 17:45:11', 'Installé un SSD de 256 Gb + Win 10 Pro + mise à jour\r\nVente d\'un boitier pour son HDD', 'Michel', 0, NULL, NULL),
(41, 49, '2023-10-28 17:46:41', 'Cliente prévenue .\r\nRécupérera son PC +alim+boitier vendredi', 'Michel', 0, NULL, NULL),
(42, 48, '2023-10-28 17:52:04', 'SSD 250 GB + Win10 + M à jour\r\nHDD dans boitier\r\nCliente prévenue - Répondeur téléphonique', 'Michel', 0, NULL, NULL),
(43, 53, '2023-11-04 18:19:34', 'M2 extrait du PC et recopié sur un HDD externe', 'Michel', 0, NULL, NULL),
(44, 53, '2023-11-04 18:20:24', 'Le M2 semble OK - Réinstaller Win 10', 'Michel', 0, NULL, NULL),
(45, 51, '2023-11-04 18:22:16', 'Réinstallé Win 10\r\nMaj OK\r\nProgrammes OK\r\nTerminé - Client Prévenu', 'Michel', 0, NULL, 'telephone'),
(46, 53, '2023-11-08 08:19:07', 'Extrait M2 - copie externe des données - réinstallé Win 10 - recopié données', 'Michel', 0, NULL, NULL),
(47, 36, '2023-11-08 12:31:07', 'RAM changée et Disque changé: pas mieux.', 'Yves', 0, NULL, NULL),
(48, 36, '2023-11-08 12:31:32', 'Contact téléphone avec cliente: OK pour sortir le HDD et boîtier ', 'Yves', 0, NULL, 'telephone'),
(49, 78, '2023-11-08 12:41:10', 'Client OK pour data dans boîtier externe', 'Yves', 0, NULL, 'telephone'),
(50, 78, '2023-11-08 13:05:56', 'PC démonté à la recherche du disque dur. Trouvé un deuxième jamais utilisé.', 'Yves', 0, NULL, NULL),
(51, 78, '2023-11-08 13:06:14', 'Disque Windows placé dans boîtier externe OK', 'Yves', 0, NULL, NULL),
(53, 40, '2023-12-27 13:23:48', 'SQDFQSFD', 'Yves', 0, NULL, 'magasin');

-- --------------------------------------------------------

--
-- Structure de la table `ox_bonsGarantie`
--

CREATE TABLE `ox_bonsGarantie` (
  `date` date NOT NULL COMMENT 'Date de prise d''effet de la garantie',
  `idClient` int DEFAULT NULL COMMENT 'idUser du client dans la table des ox_users',
  `ticketCaisse` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Numéro du ticket de caisse'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table des bons de garantie';

--
-- Déchargement des données de la table `ox_bonsGarantie`
--

INSERT INTO `ox_bonsGarantie` (`date`, `idClient`, `ticketCaisse`) VALUES
('2023-12-01', NULL, '1004565'),
('2023-12-19', 102, '1004567'),
('2023-12-14', 40, '1004568'),
('2023-12-07', 72, '1004569'),
('2023-12-27', NULL, '1007456'),
('2023-12-27', NULL, '1007457'),
('2023-12-11', 34, '123'),
('2023-12-29', NULL, '1234444'),
('2023-12-19', 38, '12345'),
('2023-12-11', 34, '12345678'),
('2023-12-28', 49, '1234568'),
('2023-12-27', NULL, '2458743'),
('2023-12-07', NULL, '5465465'),
('2023-12-27', NULL, '5555555'),
('2023-12-30', 62, '698789'),
('2023-12-23', 63, '9876541'),
('2023-12-23', 63, '9876542'),
('2023-12-23', 58, '9876543');

-- --------------------------------------------------------

--
-- Structure de la table `ox_bonsGarantieCondPart`
--

CREATE TABLE `ox_bonsGarantieCondPart` (
  `ticketCaisse` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Références du ticket de caisse',
  `texte` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Texte des conditions particulières'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ox_bonsGarantieCondPart`
--

INSERT INTO `ox_bonsGarantieCondPart` (`ticketCaisse`, `texte`) VALUES
('1234444', 'test');

-- --------------------------------------------------------

--
-- Structure de la table `ox_bonsGarantieItems`
--

CREATE TABLE `ox_bonsGarantieItems` (
  `id` int NOT NULL COMMENT 'Identifiant de l''item sur le bon de garantie',
  `ticketCaisse` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Numéro du ticket de caisse',
  `ox` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Référence Oxfam',
  `ref` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Référence hors Oxfam (serial #,...)',
  `materiel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Description du matériel',
  `prix` smallint DEFAULT NULL COMMENT 'Prix de ce matériel',
  `remarque` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Remarque sur l''état du matériel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table des items pour un bon de garantie';

--
-- Déchargement des données de la table `ox_bonsGarantieItems`
--

INSERT INTO `ox_bonsGarantieItems` (`id`, `ticketCaisse`, `ox`, `ref`, `materiel`, `prix`, `remarque`) VALUES
(43, '1004565', '125478', '', 'Fujitsu E736 I3 13.3 8GB RAM 256GB SSD Azerty', 150, 'environ \"8GB\"'),
(46, '1007457', '425987', '', 'Fujitsu E736 I3 13.3 8GB RAM 256GB SSD Azerty', 175, 'Batterie ++'),
(52, '9876542', '', '', 'Fujitsu E736 I3 13.3\" 8GB RAM 256GB SSD Azerty', 150, '');

-- --------------------------------------------------------

--
-- Structure de la table `ox_bonsReparation`
--

CREATE TABLE `ox_bonsReparation` (
  `numeroBon` int NOT NULL COMMENT 'Numéro du bon de réparation',
  `idUser` int NOT NULL COMMENT 'Identifiant du client',
  `typeMateriel` smallint NOT NULL COMMENT 'Type de matériel (table oxxl_typeMateriel)',
  `marque` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Marque',
  `modele` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Modèle',
  `ox` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Numéro OX éventuel du matériel',
  `mdp` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Mot de passe éventuel',
  `data` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Conservation des données?',
  `dateEntree` date NOT NULL,
  `dateSortie` date DEFAULT NULL,
  `benevole` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Adresse mail de la personne qui réception le matériel',
  `probleme` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `etat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'État général du matériel',
  `devis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Solution proposée avec prix',
  `garantie` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Sous garantie',
  `remarque` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Remarque technicien',
  `apayer` smallint DEFAULT NULL COMMENT 'Montant à payer',
  `termine` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Réparation terminée'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bons de réparation';

--
-- Déchargement des données de la table `ox_bonsReparation`
--

INSERT INTO `ox_bonsReparation` (`numeroBon`, `idUser`, `typeMateriel`, `marque`, `modele`, `ox`, `mdp`, `data`, `dateEntree`, `dateSortie`, `benevole`, `probleme`, `etat`, `devis`, `garantie`, `remarque`, `apayer`, `termine`) VALUES
(1, 1, 1, 'Dell', 'Probook', ' ', '', 1, '2023-08-17', NULL, 'Thomas', 'Très lent', 'Capot griffé.', 'Ajout de 4GB RAM -> 25€\r\nChangement du disque dur -> SSD 256GB -> 50€', 0, 'Nettoyage interne pour éliminer la poussière nécessaire...', 50, 1),
(27, 28, 2, 'Apple', 'Macbookpro 2013', '', '', 1, '2023-09-22', NULL, 'Thomas', 'No boot', '', 'Install SSD + MacOS + Tentative recup data', 0, '', 80, 0),
(31, 35, 1, 'HP', 'Prodesk 600G2', ' ', '', 1, '2023-10-11', NULL, 'Yves', 'Mises à jour impossibles.\r\nBoote trop lentement. Pas d\'accès à l\'interface Windows. ', '', 'Réinstallation Win10', 0, 'Roblox occupe 79.9 GB dans le profil. Le disque était complètement saturé. Aucune mise à jour n\'aurait été possible\r\nIl faudrait que les données Roblox soient enregistrées sur les disque de 1To. Le disque SSD ne devrait être utilisé que pour installer les logiciels. Le disque 1To semblait tout à fait inutilisé.\r\nJ\'ai tenté de sauvegarder la configuration initiale: zonder succes.\r\n', 20, 1),
(32, 36, 2, 'Mac', '', ' ', 'laure', 1, '2023-10-11', NULL, 'Yves', 'Eau sur le clavier. ne démarre plus.', '', '', 0, '', 0, 0),
(33, 37, 2, 'HP', '450', ' ', '', 1, '2023-10-11', NULL, 'Yves', 'il démarre et après s’éteint ', '', '', 0, '', 0, 0),
(34, 38, 2, 'Fujitsu', 'E736', '400761', 'INES0801', 0, '2023-10-12', NULL, 'Yves', 'Le clavier ne fonctionne plus', '', 'Changer le clavier', 1, 'Mises à jour effectuées sans résultat.\r\nAutre clavier (trop abimé pour être vendu) testé OK.\r\nEn attente d\'un clavier de la Centrale.\r\nRéparation terminée.\r\npas joignable le 19/10/2023 à 12h40', 0, 0),
(35, 39, 2, 'Acer', '', ' ', '', 1, '2023-10-18', NULL, 'Yves', 'Souci sur la réparation de la charnière. Le PC ne s\'alimente plus.', '', 'Envoi à John après inspection.\r\nConfirmer l\'envoi par téléphone.', 1, 'Tentative d\'allumage: 5 clignotements de la LED puis plus rien. Sans batterie, rien.\r\nDémontage complet: pas de défaut apparent visible. Non réparable pour nous.\r\nProposition de remplacement par un autre PC à prix intéressant.', 0, 1),
(36, 40, 2, 'hp', '', ' ', '', 1, '2023-10-18', NULL, 'Carole', 'pc qui ne s\'allume plus ', 'propre', 'regarder en interne et envoyer à la centrale si pas de solution ', 0, '', 20, 0),
(37, 41, 2, 'Compaq', ' ', ' ', 'CARMEN030729', 0, '2023-10-18', NULL, 'Yves', 'Devis pour restauration', '', '', 0, 'Processeur environ équivalent i3-2\r\n4GB RAM 1 seul slot?', 0, 1),
(38, 43, 2, 'hp', '', ' ', '', 1, '2023-10-19', NULL, 'Carole', 'ne detecte pas les wifi disponible', '', 'mise à jour ', 0, 'Touche F9 pour activer le Wifi', 0, 1),
(39, 45, 2, 'acer', '', ' ', '', 0, '2023-10-20', NULL, 'Carole', 'liquide qui s\'est versé dessus', '', 'faire sécher le pc', 0, '', 0, 0),
(40, 47, 1, 'hp', '', ' ', '', 1, '2023-10-25', NULL, 'Carole', 'à échanger contre un nouveau.mais le client n\'a plus son ticket de garantie ', '', '', 1, '', 0, 0),
(41, 48, 1, 'Gigabyte', '', ' ', '', 0, '2023-10-25', NULL, 'Yves', 'Réinstallation Win10', '', 'Réinstallation Win10', 0, '', 0, 0),
(42, 49, 2, 'HP', '14', ' 42500', 'magie212', 0, '2023-10-25', NULL, 'Yves', 'Ecran cassé', '', 'Nouvel écran', 0, 'Envoi à l\'atelier', 50, 0),
(44, 51, 2, 'HP', '\"test\"', '368409', '\"test\"', 0, '2023-10-26', NULL, 'Yves', 'Clavier et touchpad en panne \"dit-on\"', 'te\"st', '??? A voir \"test\"\'', 0, '\"test\"', 0, 0),
(45, 53, 2, 'Sony', 'Vaio', NULL, NULL, 0, '2023-10-27', NULL, 'Yves', 'Lenteur linux', '', 'Install SSD 250 + Ubuntu 22 / login bruno', 0, 'Client prévenu le 28/10. Récupérera son PC la semaine prochaine', 70, 1),
(46, 54, 2, 'fijustu', '', ' ', '', 0, '2023-10-27', NULL, 'Carole', 'transfert de données', '', '', 1, '', 0, 0),
(47, 55, 2, 'hp', '', NULL, NULL, 1, '2023-10-27', NULL, 'Yves', 'installation  ssd 250 , drivers', '', '', 0, 'Deux disques 00052 trouvés sur la table. Restaurés sur le bureau.\r\nInstallation Win10\r\n', 70, 1),
(48, 56, 2, 'DELL', 'Inspiron 15', NULL, NULL, 0, '2023-10-27', NULL, 'Yves', 'Lenteur + Install imprimante', '', 'Install SSD 250 + Win 10 + Boitier USB pour HDD', 0, 'ssd 50 / Boitier usb 12 / MO 20', 82, 1),
(49, 57, 2, 'HP', 'Elite Book', ' ', '', 1, '2023-10-28', NULL, 'Michel', 'Ne boot plus\r\n', '', 'Récupérer les données sur boitier extrne\r\nÉventuellement installer Win 10 sur un ssd', 0, '', 62, 1),
(50, 58, 1, 'HP', '', '416247', '', 0, '2023-10-31', NULL, 'Michel', 'Remplacemnt du disque systéme. Des fichiers indésirables se trouvait sur le précédent\r\n\r\nLa cliente à récupérer le SSD de 256 GB \r\nles données se trouvant sur le HDD de 500 GB peut être effacé. La cliente à vérifier avec nous la pertinence de cet effacement', '', '', 0, '', 0, 0),
(51, 59, 1, 'Acer', 'Aspire', ' ', NULL, 0, '2023-10-31', NULL, 'Michel', '', '', 'PC tout en un\r\nInstaller Windows 10', 0, 'La clef de produit sur le sticker à l\'arrière du PC ne fonctionne pas.\r\nC\'est pourtant bien un Windows7 familial au départ et un Win10 famille installé', 20, 1),
(52, 60, 2, 'Toshiba', '', ' ', ' ', 0, '2023-10-31', '2023-11-10', 'Michel', '', '', 'Remplacer HDD par SSD 250 Gb\r\nInstaller Win 10 (famille?) + mises jour\r\nSi RAM à 4 GB ajouter 4 GB ( pour arriver à 8 GB', 0, '+4GB DDR3 12800 Samsung au lieu de 2GB\r\n\r\nLe disque dans le PC semble être un disque d\'initialisation de Windows.\r\n', 70, 1),
(53, 62, 2, 'Asus', 'Zenbook', ' ', 'Mimi01', 1, '2023-11-04', NULL, 'Michel', 'Ne boot plus', '', 'Vérifier bOOT\r\nhdd\r\nEventuellement le remplacer par un SSD\r\nWindows 10', 0, '', 0, 1),
(78, 64, 2, 'HP', '17 pouces', ' ', 'PLMKJH', 1, '2023-11-07', NULL, 'Michel', 'Ne boot plus', 'Touches fixées avec du plastique', 'Vérifier contact alimentation en interne\r\nSi pas de solution tenter récupérerle disque dur', 0, 'PC irréparable\r\nRécupération des data dans boîtier externe OK', 15, 1),
(79, 65, 2, 'Acers', 'Core I5', ' ', '2minotto', 1, '2023-11-07', NULL, 'Michel', 'Ne BOOT plus', '', '', 0, 'Cliente communiquera mot de passe', 0, 0),
(80, 63, 2, 'HPx', '19 poucess', ' ', 'spekenbonen12', 1, '2023-11-07', '2023-11-09', 'Michel', '', 'Manque des touches', 'Le clients à acheté et payé un nouveau PC à 100 €\r\nIl demande le transfert de ses données sur -  - celui-ci ( déjà payé - 15 €)', 0, '', 0, 1),
(81, 66, 2, 'hp', 'probook 650G2', '', '', 0, '2023-11-08', NULL, 'Carole', 'petite tache en bas de l\'écran  ', '', 'renvoyé à l\'atelier', 1, '', 0, 0),
(82, 67, 2, 'ACER', 'core i3', ' ', NULL, 0, '2023-11-08', NULL, 'Yves', 'Changement de clavier', 'Manque une touche', '', 0, '', 0, 1),
(83, 69, 1, 'hp', 'I7', ' ', '', 0, '2023-11-09', '2023-11-10', 'Yves', 'Ne boote plus', '', 'Changement de la RAM en 1R8', 0, 'RAM changée -> 1R8\r\nTester et retest\r\nMise à jour effectuée\r\nNombreux redémarrages', 10, 1),
(84, 72, 2, 'HP', 'Atom 2Go /32GoSSD', '', '', 0, '2023-11-10', NULL, 'Yves', 'Pb mises à jours bloquées faute d espace disque', '', 'Finir MAJ et reinstaller libreoffice', 0, '', 0, 0),
(86, 65, 1, 'Bidule', '', ' ', '', 0, '2023-11-17', NULL, 'Yves', '', '', '', 0, '', 0, 0),
(90, 63, 6, 'hpxxxxx', '', NULL, 'mai76641', 0, '2023-11-18', NULL, 'Yves', '', '', '', 0, '', 0, 0),
(137, 27, 6, '', '', ' ', '', 0, '2023-11-21', NULL, 'Yves', 'Le problème technique est difficile à résoudre par une méthode simple qui permettrait de tout écrire dans une seule cellule. La faute morale réside dans le savoir lucide et le vouloir avéré d\'un mal ontologique en son agir.', '', '', 0, '', 0, 0),
(143, 58, 6, '12345', '', NULL, 'mai76641', 0, '2023-12-04', NULL, 'Yves', '', '', '', 0, '', 0, 0),
(147, 50, 6, '', '', ' ', '', 0, '2023-12-11', NULL, 'Yves', '', '', '', 0, '', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `ox_config`
--

CREATE TABLE `ox_config` (
  `ordre` tinyint DEFAULT NULL,
  `parametre` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Label',
  `size` smallint DEFAULT NULL,
  `valeur` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `signification` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ox_config`
--

INSERT INTO `ox_config` (`ordre`, `parametre`, `label`, `size`, `valeur`, `signification`) VALUES
(2, 'NOMNOREPLY', 'Nom adresse No Reply', 30, 'Merci de ne pas \"répondre\"', 'Nom de l\'adresse pour la diffusion de mails \"no reply\"'),
(1, 'NOREPLY', 'Ne pas répondre', 40, 'ne_pas_repondre@noMail.com', 'Adresse pour la diffusion de mails \"no reply\"');

-- --------------------------------------------------------

--
-- Structure de la table `ox_garantiesAnonymes`
--

CREATE TABLE `ox_garantiesAnonymes` (
  `idBonGarantie` int NOT NULL COMMENT 'Identifiant du bon de garantie',
  `date` date NOT NULL COMMENT 'Date de prise d''effet',
  `ticketCaisse` int NOT NULL COMMENT 'Numéro du ticket de caisse'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ox_interactionsClient`
--

CREATE TABLE `ox_interactionsClient` (
  `idInteraction` int NOT NULL COMMENT 'Identifiant de l''interaction',
  `numeroBon` int NOT NULL COMMENT 'Numéro du bon',
  `idUser` int NOT NULL COMMENT 'Identifiant du client',
  `benevole` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Prénom du bénévole',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date de l''interaction',
  `typeInteraction` enum('telephone','repondeur','mail','magasin') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Type d''interaction avec le client',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Résultat de l''interaction'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ox_inventaire`
--

CREATE TABLE `ox_inventaire` (
  `idMateriel` int NOT NULL COMMENT 'Identifiant numérique du matériel',
  `marque` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Marque du matériel',
  `modele` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Modèle',
  `caracteristiques` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Caractéristiques techniques (RAM, SSD,...)',
  `prix` smallint DEFAULT NULL COMMENT 'Prix de vente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Liste du matériel disponible à la vente';

--
-- Déchargement des données de la table `ox_inventaire`
--

INSERT INTO `ox_inventaire` (`idMateriel`, `marque`, `modele`, `caracteristiques`, `prix`) VALUES
(1, 'Fujitsu', 'E736', 'I3 13.3\" 8GB RAM 256GB SSD Azerty', 150),
(2, 'Samsung Printer', 'M4020ND', 'Laser noir', 60);

-- --------------------------------------------------------

--
-- Structure de la table `ox_mentionsTravail`
--

CREATE TABLE `ox_mentionsTravail` (
  `idMention` int NOT NULL COMMENT 'Identifiant de la mention',
  `idUser` int NOT NULL COMMENT 'Identifiant de l''auteur',
  `type` enum('probleme','solution') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Problème ou solution',
  `texte` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Texte prédéfini'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `ox_mentionsTravail`
--

INSERT INTO `ox_mentionsTravail` (`idMention`, `idUser`, `type`, `texte`) VALUES
(1, 1, 'solution', 'Changement de la batterie.'),
(2, 1, 'solution', 'Échange HDD contre SSD (plus rapide)'),
(3, 1, 'solution', 'Réinstallation du système Windows 10'),
(4, 1, 'solution', 'Réinstallation du système Linux (Mint).'),
(5, 1, 'probleme', 'L\'ordinateur ne démarre plus.'),
(6, 1, 'probleme', 'L\'ordinateur ne fonctionne plus sans le chargeur.'),
(7, 1, 'probleme', 'L\'ordinateur redémarre constamment après un écran bleu.'),
(8, 1, 'probleme', 'PC chauffe beaucoup');

-- --------------------------------------------------------

--
-- Structure de la table `ox_typeMateriel`
--

CREATE TABLE `ox_typeMateriel` (
  `idTypeMateriel` smallint NOT NULL COMMENT 'id',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Type de matériel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Type de matériel';

--
-- Déchargement des données de la table `ox_typeMateriel`
--

INSERT INTO `ox_typeMateriel` (`idTypeMateriel`, `type`) VALUES
(1, 'Desktop/Tour'),
(2, 'Laptop/portable'),
(3, 'Écran'),
(4, 'Imprimante'),
(5, 'Disque'),
(6, 'Clef '),
(7, 'hp'),
(8, 'test');

-- --------------------------------------------------------

--
-- Structure de la table `ox_users`
--

CREATE TABLE `ox_users` (
  `idUser` int NOT NULL COMMENT 'Identifiant unique',
  `pseudo` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Identifiant (à la place de l''adresse mail)',
  `civilite` enum('F','M','X','') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Civilité',
  `nom` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nom du client',
  `prenom` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Prénom',
  `telephone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Téléphone fixe',
  `gsm` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'GSM',
  `mail` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Adresse mail',
  `adresse` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Adresse rue n°',
  `cpost` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Code Postal',
  `commune` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Commune',
  `tva` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Numéro de TVA',
  `droits` enum('root','oxfam','client') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'client' COMMENT 'Droits sur l''application',
  `rgpd` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Acceptation de la formule RGPD',
  `dateAcces` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date du dernier accès',
  `md5passwd` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Mot de passe md5'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Références client';

--
-- Déchargement des données de la table `ox_users`
--

INSERT INTO `ox_users` (`idUser`, `pseudo`, `civilite`, `nom`, `prenom`, `telephone`, `gsm`, `mail`, `adresse`, `cpost`, `commune`, `tva`, `droits`, `rgpd`, `dateAcces`, `md5passwd`) VALUES
(1, 'maiyve', 'M', 'Mairesse', 'Yves', '', '+32474754694', 'ymairesse@sio2.be', 'Av. Daniel Boon, 59', '1160', 'Auderghem', NULL, 'root', 0, '2023-12-30 16:37:09', '1224b6196e600af6d118b8d7a12fec76'),
(2, 'Michel', 'M', 'Rouserez', 'Michel', '', '0475850747', 'michel.rouserez@skynet.be', '', '', 'Wezembeek-Oppem', '', 'root', 0, '2023-09-21 18:57:23', 'b829dae101214d738a37fb571398ae04'),
(10, NULL, '', 'Machin', 'Bidule', '', '0474754696', 'nomail@nomail.com', '', '1070', 'Anderlecht', '', 'client', 0, '2023-10-11 21:49:07', 'b829dae101214d738a37fb571398ae04'),
(17, 'Thomas', '', 'Le Dauphin', 'Thomas', '', '0485359367', 'thomas.ledauphin@oxfam.org', '', '', '', '', 'root', 0, '2023-10-24 17:38:39', 'c0ed4855078c32fc96eede7899d4b0e5'),
(19, 'babelkot', NULL, 'Germain', 'Jean-Claude', '', '0479393026', 'babelkot@gmail.com', '', '', '', '', 'root', 0, '2023-09-07 12:20:30', '26473d30784a7c5494ea01c57ae7f007'),
(22, 'kjc', 'M', 'KWIZERA', 'Jean Claude', '', '0465115104', 'kjclaude2020@gmail.com', '', '', '', '', 'oxfam', 0, '2023-09-13 11:05:24', 'e6c277aad22a8eef91bf6c1e51701a63'),
(25, 'carole', 'F', 'Guedem', 'Carole', '', '+32467600936', 'o.guedem@yahoo.fr', '', '', '', '', 'root', 0, '2023-10-17 14:52:04', '805e144839171ed0b20c77ab68e80051'),
(26, NULL, '', 'Brupower', '-', '', '', 'invoicing@brupower.be', 'rue bissé 17/0029', '1070', 'Anderlecht ', '0787241013', 'client', 1, '2023-10-11 20:59:33', NULL),
(27, NULL, NULL, 'Barbé', 'Alexandre ', '', '+33754376977', '', '', '', '', '', 'client', 1, '2023-09-21 17:14:24', NULL),
(28, NULL, 'F', 'Mac-Baye', 'Naomi', '', '0488 265174', '', '', '', '', '', 'client', 0, '2023-09-22 12:00:21', NULL),
(34, NULL, 'M', 'Boland ', 'Vincent', '', '0473 502733', '', '', '', '', '', 'client', 0, '2023-10-10 12:38:24', NULL),
(35, NULL, '', 'Venderickx', 'Birgit', '', '0476 292662', '', '', '', '', '', 'client', 0, '2023-10-11 13:10:42', NULL),
(36, NULL, '', 'Valentinelli', 'Laure', '', '0033624146185', 'laure-valentinelli@hotmail.fr', 'rue montagne des cerisiers 31', '1200', 'Wolluwe Saint Lambert', '', 'client', 1, '2023-10-24 17:37:12', NULL),
(37, NULL, '', 'wantiez', 'Nicole', '02 6571815', '', '', '', '', '', '', 'client', 0, '2023-12-02 12:10:28', NULL),
(38, NULL, '', 'Charlier', 'Mathieu', '', '04712803074', '', 'icii', '', '', '', 'client', 0, '2023-12-11 16:03:53', NULL),
(39, NULL, '', 'Gits', 'Catheline', '', '0472 568202', '', '', '', '', '', 'client', 0, '2023-10-18 10:23:25', NULL),
(40, NULL, '', 'Honnay', 'Sandrine', '', '0474 854280', '', '', '', '', '', 'client', 0, '2023-10-18 11:06:00', NULL),
(41, NULL, 'F', 'Gonzalez Gomez', 'MJ', '', '0475 910448', '', '0475910448', '', '', '', 'client', 0, '2023-10-18 17:46:14', NULL),
(42, NULL, 'M', 'GODEFROID', 'ARTHUR', '', '0496 747806', 'arthur.godefroid@hotmail.com', 'place Louis Morichar 39', '1060', 'Saint Gilles', '0775347724', 'client', 1, '2023-10-19 10:37:57', NULL),
(43, NULL, 'M', 'KEMBE TSANANG', 'Leonel Stève', '', '0465 940978', '', '', '', '', '', 'client', 1, '2023-10-19 13:52:54', NULL),
(44, 'edgar', 'M', 'edgar', 'junior', '', '0465 522512', 'edgarmbouega@gmail.com', '', '', '', '', 'oxfam', 0, '2023-10-20 14:38:05', 'eff4344ecc78152ace6a555f9b9a1d26'),
(45, NULL, '', 'fatima ', 'billah', '0467 656842', '', '', '', '', '', '', 'client', 0, '2023-10-20 15:35:08', NULL),
(47, NULL, '', 'hedhili', 'rachid', '', '0485 548434', '', 'rue', '', '', '', 'client', 0, '2023-10-25 15:21:47', NULL),
(48, NULL, 'M', 'moncayo', 'charles', '0486 174832', '', 'charlesmoncayo3@gmail.com', '', '', '', '', 'client', 0, '2023-10-25 17:27:44', NULL),
(49, NULL, '', 'Gilbert', 'Phitsamone', '0470 538117', '', '', '', '', '', '', 'client', 0, '2023-10-25 17:29:09', NULL),
(50, NULL, '', 'beauduin', '', '+33615656564', '+33615656564', '', '', '', '', '', 'client', 0, '2023-11-21 09:20:49', NULL),
(51, NULL, '', 'Everard de Harzir ', 'Anne', '0478 633714', '', '', '', '', '', '', 'client', 0, '2023-10-26 10:33:59', NULL),
(52, NULL, '', 'Dia', 'Fatimata', '', '0467 775478', '', 'Rue d Anderlecht 113', '1000', 'Bruxelles', '', 'client', 0, '2023-10-26 12:42:57', NULL),
(53, NULL, '', 'de clynsen', 'bruno', '', '0478 666665', '', '', '', '', '', 'client', 1, '2023-10-27 11:22:22', NULL),
(54, NULL, '', 'Poncé', 'Louise', '', '0497 266718', 'ponce.louise@gmail.com', '', '', '', '', 'client', 0, '2023-10-27 11:31:40', NULL),
(55, NULL, '', 'givron', 'stephane', '0467 698342', '0467 698342', '', '', '', '', '', 'client', 0, '2023-10-27 14:25:40', NULL),
(56, NULL, '', 'Recour', 'Grietje', '', '0478 757991', 'grietrecour@hotmail.com', 'Rue Tervaete 63', '1040', 'Etterbeek', '', 'client', 1, '2023-10-27 17:57:08', NULL),
(57, NULL, 'F', 'Brault', 'Chloé', '', '0474 090252', 'chloe.brault@gmail.com', '', '', '', '', 'client', 1, '2023-10-28 14:23:04', NULL),
(58, NULL, '', 'Sepulveda', 'Ortiz', '0472 782591', '', '', '', '', '', '', 'client', 0, '2023-10-31 12:49:23', NULL),
(59, NULL, '', 'Ranieri', 'marco', '', '0495 594876', '', '', '', '', '', 'client', 0, '2023-10-31 15:34:38', NULL),
(60, NULL, '', 'Vandemoortele', 'Luc', '', '0478 886567', '', '', '', '', '', 'client', 0, '2023-10-31 17:44:55', NULL),
(62, NULL, '', 'Tinant', 'Marie Thérése', '', '0479 746373', 'marieThé@nomail.com', '', '', '', '123456789', 'client', 0, '2023-11-04 15:03:00', NULL),
(63, NULL, 'M', 'Rider', 'John', '', '0456 192430', '', '', '', '', '', 'client', 0, '2023-11-20 10:27:16', NULL),
(64, NULL, '', 'Csako', 'Janos', '', '0470 206528', '', '', '', '', '', 'client', 0, '2023-11-07 12:00:06', NULL),
(65, NULL, '', 'Bellanger', 'Claire', '', '0479 436098', 'bellanger.claire@hotmail.com', 'chaussée de Forest 157', '', '', '', 'client', 0, '2023-11-07 12:11:33', NULL),
(66, NULL, 'X', 'oxfam', 'computer', '', '02 6474851', '', '', '', '', '', 'client', 1, '2023-11-08 14:57:17', NULL),
(67, NULL, 'F', 'Gonçalves Gomes', 'Raquel', '', '0493 982717', '', '', '', '', '', 'client', 1, '2023-11-08 17:51:34', NULL),
(69, NULL, 'M', 'de Duve', 'Diego', '', '0489/45.48.73', '', '', '', '', '', 'client', 0, '2023-11-09 14:18:09', NULL),
(71, NULL, '', 'Bouzarouata', 'Mariam', '', '0483360006', 'mariam1050@hotmail.com', 'rue de l\'abbatoir 27', '1000', 'bruxelles', '', 'client', 1, '2023-11-10 14:55:11', NULL),
(72, NULL, 'F', 'KAMPUNDU', 'Epiphanie', '', '0484042836', '', '', '', '', '', 'client', 0, '2023-11-10 18:04:27', NULL),
(102, 'csOxfam', NULL, '_ComputerShop', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'client', 0, '2023-12-19 17:39:59', NULL);

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
-- Index pour la table `ox_bonsGarantie`
--
ALTER TABLE `ox_bonsGarantie`
  ADD PRIMARY KEY (`ticketCaisse`);

--
-- Index pour la table `ox_bonsGarantieCondPart`
--
ALTER TABLE `ox_bonsGarantieCondPart`
  ADD PRIMARY KEY (`ticketCaisse`);

--
-- Index pour la table `ox_bonsGarantieItems`
--
ALTER TABLE `ox_bonsGarantieItems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticketCaisse` (`ticketCaisse`);

--
-- Index pour la table `ox_bonsReparation`
--
ALTER TABLE `ox_bonsReparation`
  ADD PRIMARY KEY (`numeroBon`),
  ADD KEY `typeMateriel` (`typeMateriel`),
  ADD KEY `oxxl_bonsReparation_ibfk_1` (`idUser`);

--
-- Index pour la table `ox_config`
--
ALTER TABLE `ox_config`
  ADD PRIMARY KEY (`parametre`);

--
-- Index pour la table `ox_garantiesAnonymes`
--
ALTER TABLE `ox_garantiesAnonymes`
  ADD PRIMARY KEY (`idBonGarantie`);

--
-- Index pour la table `ox_interactionsClient`
--
ALTER TABLE `ox_interactionsClient`
  ADD PRIMARY KEY (`idInteraction`),
  ADD KEY `numeroBon` (`numeroBon`);

--
-- Index pour la table `ox_inventaire`
--
ALTER TABLE `ox_inventaire`
  ADD PRIMARY KEY (`idMateriel`);

--
-- Index pour la table `ox_mentionsTravail`
--
ALTER TABLE `ox_mentionsTravail`
  ADD PRIMARY KEY (`idMention`),
  ADD KEY `idUser` (`idUser`);

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
  MODIFY `idAccessoire` tinyint NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de l''accessoire', AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `ox_bonsAvancement`
--
ALTER TABLE `ox_bonsAvancement`
  MODIFY `idAvancement` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT pour la table `ox_bonsGarantieItems`
--
ALTER TABLE `ox_bonsGarantieItems`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de l''item sur le bon de garantie', AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT pour la table `ox_bonsReparation`
--
ALTER TABLE `ox_bonsReparation`
  MODIFY `numeroBon` int NOT NULL AUTO_INCREMENT COMMENT 'Numéro du bon de réparation', AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT pour la table `ox_interactionsClient`
--
ALTER TABLE `ox_interactionsClient`
  MODIFY `idInteraction` int NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de l''interaction';

--
-- AUTO_INCREMENT pour la table `ox_inventaire`
--
ALTER TABLE `ox_inventaire`
  MODIFY `idMateriel` int NOT NULL AUTO_INCREMENT COMMENT 'Identifiant numérique du matériel', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `ox_mentionsTravail`
--
ALTER TABLE `ox_mentionsTravail`
  MODIFY `idMention` int NOT NULL AUTO_INCREMENT COMMENT 'Identifiant de la mention', AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `ox_typeMateriel`
--
ALTER TABLE `ox_typeMateriel`
  MODIFY `idTypeMateriel` smallint NOT NULL AUTO_INCREMENT COMMENT 'id', AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `ox_users`
--
ALTER TABLE `ox_users`
  MODIFY `idUser` int NOT NULL AUTO_INCREMENT COMMENT 'Identifiant unique', AUTO_INCREMENT=104;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `ox_bonsAccessoires`
--
ALTER TABLE `ox_bonsAccessoires`
  ADD CONSTRAINT `ox_bonsAccessoires_ibfk_1` FOREIGN KEY (`numeroBon`) REFERENCES `ox_bonsReparation` (`numeroBon`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ox_bonsGarantieCondPart`
--
ALTER TABLE `ox_bonsGarantieCondPart`
  ADD CONSTRAINT `ox_bonsGarantieCondPart_ibfk_1` FOREIGN KEY (`ticketCaisse`) REFERENCES `ox_bonsGarantie` (`ticketCaisse`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ox_bonsGarantieItems`
--
ALTER TABLE `ox_bonsGarantieItems`
  ADD CONSTRAINT `ox_bonsGarantieItems_ibfk_1` FOREIGN KEY (`ticketCaisse`) REFERENCES `ox_bonsGarantie` (`ticketCaisse`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ox_bonsReparation`
--
ALTER TABLE `ox_bonsReparation`
  ADD CONSTRAINT `ox_bonsReparation_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `ox_users` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ox_interactionsClient`
--
ALTER TABLE `ox_interactionsClient`
  ADD CONSTRAINT `ox_interactionsClient_ibfk_1` FOREIGN KEY (`numeroBon`) REFERENCES `ox_bonsReparation` (`numeroBon`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `ox_mentionsTravail`
--
ALTER TABLE `ox_mentionsTravail`
  ADD CONSTRAINT `ox_mentionsTravail_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `ox_users` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
