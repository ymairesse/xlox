<?php

// Édition du profil personnel de l'utilisateur

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$sortClient = isset($_POST['sortClient']) ? $_POST['sortClient'] : 'alphaAsc';
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

$listeClients = $User->getListeUsers(array('client'), $sortClient);

// s'il n'y a plus de client actif, reprendre le premier de la liste
if ($idClient == Null) {
    reset($listeClients);
    $idClient = key($listeClients);
}

$smarty->assign('listeClients', $listeClients);
$smarty->assign('idClient', $idClient);
$smarty->assign('sortClient', $sortClient);

$smarty->display('clients/modal/modalSelectClient.tpl');
