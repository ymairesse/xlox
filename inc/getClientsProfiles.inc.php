<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

$mode = 'gestion';
$sortClient = isset($_POST['sortClient']) ? $_POST['sortClient'] : 'alphaAsc';

$listeClients = $User->getListeUsers(array('client'), $sortClient);

// fiche personnelle
$profil = ($idClient != Null) ? $User->getDataUser($idClient) : Null;

// informations pour le widget "selectClients"
$smarty->assign('listeClients', $listeClients);
$smarty->assign('idClient', $idClient);
$smarty->assign('sortClient', $sortClient);
$smarty->assign('mode', $mode);

// profil du client actuellement sélectionné
$smarty->assign('profil', $profil);

$smarty->display('ficheClients4gestion.tpl');