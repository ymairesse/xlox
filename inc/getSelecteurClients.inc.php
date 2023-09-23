<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$sortClient = isset($_COOKIE['sortClient']) ? $_COOKIE['sortClient'] : 'alphaAsc';
$idClient = isset($_COOKIE['clientEnCours']) ? $_COOKIE['clientEnCours'] : Null;

$listeClients = $User->getListeUsers('client', $sortClient);

$smarty->assign('idClient', $idClient);
$smarty->assign('listeClients', $listeClients);

$smarty->display('inc/selecteurClients.tpl');