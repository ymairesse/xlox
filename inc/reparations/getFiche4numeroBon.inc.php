<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

// numéro du bon de travail sélectionné
$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : null;

$allAccessoires = $User->getAllAccessoires();
$accessoires4Bon[$numeroBon] = $Reparation->getAccessoires4bon($numeroBon);

$avancements4bon = $Reparation->getNbAvancements4bons($numeroBon);

$travail = $Reparation->getData4Bon($numeroBon);

$dataClient = $Reparation->getClient4bon($numeroBon);

$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('listeAccessoires', $accessoires4Bon);
$smarty->assign('avancements4bons', $avancements4bon);
$smarty->assign('allAccessoires', $allAccessoires);
$smarty->assign('dataClient', $dataClient);

$smarty->assign('travail', $travail);

// ne pas ré-indiquer le nom  du client sur la fiche $formTravail
$smarty->assign('nomClient', true);
$smarty->assign('choice', 'listeBons');

$smarty->display('reparations/formTravail.tpl');
