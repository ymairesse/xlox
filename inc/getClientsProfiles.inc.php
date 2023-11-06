<?php

// Édition des profils personnels des utilisateurs par un user "root"

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

$mode = isset($_POST['mode']) ? $_POST['mode'] : Null;
$sortClient = isset($_POST['sortClient']) ? $_POST['sortClient'] : 'alphaAsc';

$listeClients = $User->getListeUsers(array('client'), $sortClient);

// fiche personnelle
$profil = ($idClient != Null) ? $User->getDataUser($idClient) : Null;

$smarty->assign('listeClients', $listeClients);
$smarty->assign('idClient', $idClient);
$smarty->assign('profil', $profil);
$smarty->assign('sortClient', $sortClient);

$smarty->assign('mode', $mode);

$smarty->display('ficheClients.tpl');