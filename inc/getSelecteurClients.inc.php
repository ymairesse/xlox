<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$sortClient = isset($_COOKIE['sortClient']) ? $_COOKIE['sortClient'] : 'alphaAsc';
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;
$mode = isset($_POST['mode']) ? $_POST['mode'] : Null;

$listeClients = $User->getListeUsers('client', $sortClient);

$smarty->assign('idClient', $idClient);
$smarty->assign('listeClients', $listeClients);
$smarty->assign('mode', $mode);

$smarty->display('inc/selecteurClients.tpl');