<?php

// Édition du profil personnel de l'utilisateur

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include 'entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;
$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : null;
$mode = isset($_POST['mode']) ? $_POST['mode'] : null;
$sortClient = isset($_POST['sortClient']) ? $_POST['sortClient'] : 'alphaAsc';

$listeClients = $User->getListeUsers(array('client'), $sortClient);

$listeBons = $User->getListeBonsReparation($idClient);

$allAccessoires = $User->getAllAccessoires();

$listeNumerosBons = array_keys($listeBons);

$accessoires4Bons = array();
foreach ($listeNumerosBons as $noBon) {
    $accessoires4Bons[$noBon] = $User->getAccessoires4bon($noBon);
}

$smarty->assign('listeClients', $listeClients);
$smarty->assign('idClient', $idClient);

$smarty->assign('listeBons', $listeBons);
$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('allAccessoires', $allAccessoires);

$smarty->assign('listeAccessoires', $accessoires4Bons);


$smarty->assign('sortClient', $sortClient);
$smarty->assign('mode', $mode);

$smarty->display('fichesReparation4clients.tpl');
