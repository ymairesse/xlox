<?php

// Édition des profils personnels des utilisateurs par un user "root"

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;
$droits = isset($_POST['droits']) ? $_POST['droits'] : Null;
$mode = isset($_POST['mode']) ? $_POST['mode'] : Null;

$listeClients = $User->getListeUsers($droits);

// fiche personnelle
$profil = $idClient != Null ? $User->getDataUser($idClient) : Null;

$smarty->assign('listeClients', $listeClients);
$smarty->assign('idClient', $idClient);
$smarty->assign('profil', $profil);

$smarty->assign('mode', $mode);
$smarty->assign('selectHeight', 15); // hauteur du sélecteur de clients

$smarty->display('ficheClients.tpl');