<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;
$identiteClient = $User->getDataUser($idClient);

// numéro du bon de travail actuellement actif
$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : null;

$allAccessoires = $User->getAllAccessoires();

$listeBons = $Reparation->getListeBonsReparation($idClient);

$listeNumerosBons = array_keys($listeBons);

$accessoires4Bons = array();
foreach ($listeNumerosBons as $noBon) {
    $accessoires4Bons[$noBon] = $Reparation->getAccessoires4bon($noBon);
}

$avancements4bons = $Reparation->getNbAvancements4bons();

$smarty->assign('idClient', $idClient); 
$smarty->assign('identiteClient', $identiteClient);
$smarty->assign('listeBons', $listeBons);
$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('listeAccessoires', $accessoires4Bons);
$smarty->assign('avancements4bons', $avancements4bons);

$smarty->assign('allAccessoires', $allAccessoires);

// ré-indiquer le nom  du client sur la fiche $formTravail
$smarty->assign('nomClient', false);
$smarty->assign('choice', 'listeClients');

// liste de toutes les fiches de travail pour ce client
$smarty->display('reparations/ficheTravail.tpl');
