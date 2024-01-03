<?php

// Édition du profil personnel de l'utilisateur

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$sortClient = isset($_COOKIE['sortClient']) ? $_COOKIE['sortClient'] : 'alphaAsc';
$idClient = isset($_COOKIE['clientEnCours']) ? $_COOKIE['clientEnCours'] : Null;

$mode = 'modalSelect';

$listeClients = $User->getListeUsers(array('client'), $sortClient);

// s'il n'y a plus de client actif, reprendre le premier de la liste
if ($idClient == Null) {
    reset($listeClients);
    $idClient = key($listeClients);
}

$smarty->assign('listeClients', $listeClients);
$smarty->assign('idClient', $idClient);
$smarty->assign('sortClient', $sortClient);
$smarty->assign('mode', $mode);

$smarty->display('modal/modalSelectClient.tpl');
