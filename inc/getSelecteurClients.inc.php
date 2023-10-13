<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include 'entetes.inc.php';

$sortClient = isset($_POST['sortClient']) ? $_POST['sortClient'] : 'alphaAsc';
$selectHeight = isset($_POST['selectHeight']) ? $_POST['selectHeight'] : null;
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;
$mode = isset($_POST['mode']) ? $_POST['mode'] : null;

$listeClients = $User->getListeUsers(array('client'), $sortClient);

$smarty->assign('idClient', $idClient);
$smarty->assign('listeClients', $listeClients);
$smarty->assign('selectHeight', $selectHeight);
$smarty->assign('sortClient', $sortClient);
$smarty->assign('mode', $mode);

if ($mode == 'reparation') {
    $smarty->display('inc/selecteurClients.tpl');
} else {
    $smarty->display('inc/listeClients.tpl');
}
