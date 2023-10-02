<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$sortClient = isset($_COOKIE['sortClient']) ? $_COOKIE['sortClient'] : 'alphaAsc';

$listeClients = $User->getListeUsers('client', $sortClient);
$smarty->assign('listeClients', $listeClients);

// référence du client
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;
$smarty->assign('idClient', $idClient);

$smarty->assign('sortClient', $sortClient);

$smarty->display('ficheClient.tpl');