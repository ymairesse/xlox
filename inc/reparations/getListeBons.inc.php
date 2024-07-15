<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$termine = isset($_POST['termine']) ? $_POST['termine'] : 0;
$bonEnCours = isset($_POST['bonEnCours']) ? $_POST['bonEnCours'] : Null;


// informations pour le sélecteur de gauche
$listeReparations = $Reparation->getListeReparations($termine);

if (in_array($bonEnCours, array_keys($listeReparations))) {
    $numeroBon = $bonEnCours;
} else {
    reset($listeReparations);
    $numeroBon = key($listeReparations);
}

$smarty->assign('listeReparations', $listeReparations);
$smarty->assign('numeroBon', $numeroBon);


// informations "fiche de réparation" alias ficheTechnique à droite
$allAccessoires = $User->getAllAccessoires();
$listeAccessoires = array();
$listeAccessoires[$numeroBon] = $Reparation->getAccessoires4bon($numeroBon);

$avancements4bon = $Reparation->getNbAvancements4bons($numeroBon);

$travail = $Reparation->getData4Bon($numeroBon);
$dataClient = $Reparation->getClient4bon($numeroBon);

$smarty->assign('listeAccessoires', $listeAccessoires);
$smarty->assign('avancements4bons', $avancements4bon);
$smarty->assign('allAccessoires', $allAccessoires);
$smarty->assign('dataClient', $dataClient);

$smarty->assign('travail', $travail);
$smarty->assign('travailTermine', $termine);

// ré-indiquer le nom  du client sur la fiche $formTravail
$smarty->assign('nomClient', true);
$smarty->assign('choice', 'listeBons');

$smarty->display('reparations/fichesReparation.tpl');

