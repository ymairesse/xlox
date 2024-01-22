<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

// client actuellement actif
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

// mode de tri des clients
$sortClient = isset($_POST['sortClient']) ? $_POST['sortClient'] : 'alphaAsc';

// "gestion" ou "reparation" ou "garantie" ou ...
$mode = isset($_POST['mode']) ? $_POST['mode'] : Null;

// s'il s'agit de la liste des clients pour les réparations,
// on cherche uniquement ceux qui ont une réparation en cours
if ($mode == 'reparation') {
    // liste des clients (à l'exception des "oxfam" et "root") avec $travailTermine = false
    $listeClients = $User->getListeClientsTravail(0, $sortClient);
} else {
    // sinon, la liste de tous les utilisateurs avec les droits "client"
    $listeClients = $User->getListeUsers(array('client'), $sortClient);
}

// s'il n'y a plus de client actif, reprendre le premier de la liste
if ($idClient == null) {
    reset($listeClients);
    $idClient = key($listeClients);
}

$smarty->assign('idClient', $idClient);
$smarty->assign('listeClients', $listeClients);
$smarty->assign('sortClient', $sortClient);
$smarty->assign('mode', $mode);

$smarty->display('inc/tableClients.tpl');


