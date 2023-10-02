<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$sortClient = isset($_POST['sortClient']) ? $_POST['sortClient'] : 'alphaAsc';
$selectHeight = isset($_POST['selectHeight']) ? $_POST['selectHeight'] : 1;

$listeClients = $User->getListeUsers('client', $sortClient);

$smarty->assign('idClient', $idClient);
$smarty->assign('listeClients', $listeClients);
$smarty->assign('selectHeight', $selectHeight);
$smarty->assign('sortClient', $sortClient);

$smarty->display('inc/selecteurClients.tpl');