<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include 'entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;
// numéro du bon de travail actuellement actif
$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : null;

$allAccessoires = $User->getAllAccessoires();

$listeBons = $User->getListeBonsReparation($idClient);

$listeNumerosBons = array_keys($listeBons);

$accessoires4Bons = array();
foreach ($listeNumerosBons as $noBon) {
    $accessoires4Bons[$noBon] = $User->getAccessoires4bon($noBon);
}

$avancements4bons = $User->getNbAvancements4bons();

$smarty->assign('idClient', $idClient); 
$smarty->assign('listeBons', $listeBons);
$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('listeAccessoires', $accessoires4Bons);
$smarty->assign('avancements4bons', $avancements4bons);

$smarty->assign('allAccessoires', $allAccessoires);

$smarty->display('ficheTravail.tpl');
