<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include 'entetes.inc.php';

// mode de tri des clients
$sortClient = isset($_POST['sortClient']) ? $_POST['sortClient'] : 'alphaAsc';

// client actuellement actif
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;
// "gestion" ou "reparation"
$mode = isset($_POST['mode']) ? $_POST['mode'] : Null;
// liste des clients (à l'exception des "oxfam" et "root")
$listeClients = $User->getListeUsers(array('client'), $sortClient);

// s'il n'y a plus de client actif, reprendre le premier de la liste
if ($idClient == Null) {
    reset($listeClients);
    $idClient = key($listeClients);
}

$smarty->assign('idClient', $idClient);
$smarty->assign('listeClients', $listeClients);
$smarty->assign('sortClient', $sortClient);
$smarty->assign('mode', $mode);

if ($mode == 'reparation') {
    // uniquement la liste des clients
    $smarty->display('inc/selecteurClients.tpl');
} else {
    // avec les boutons "Nouveau" et "Supprimer"
    $smarty->display('inc/listeClients.tpl');
}
