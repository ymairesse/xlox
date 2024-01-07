<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$termine = isset($_POST['termine']) ? $_POST['termine'] : false;
$bonEnCours = isset($_POST['bonEnCours']) ? $_POST['bonEnCours'] : Null;

$numeroBon = $bonEnCours;

// informations pour le sélecteur de gauche
$listeReparations = $User->getListeReparations($termine);
$smarty->assign('listeReparations', $listeReparations);
$smarty->assign('numeroBon', $numeroBon);


// informations "fiche de réparation" alias ficheTechnique à droite
$allAccessoires = $User->getAllAccessoires();
$listeAccessoires = array();
$listeAccessoires[$numeroBon] = $User->getAccessoires4bon($numeroBon);

$avancements4bon = $User->getNbAvancements4bons($numeroBon);

$travail = $User->getData4Bon($numeroBon);
$dataClient = $User->getClient4bon($numeroBon);

$smarty->assign('listeAccessoires', $listeAccessoires);
$smarty->assign('avancements4bons', $avancements4bon);
$smarty->assign('allAccessoires', $allAccessoires);
$smarty->assign('dataClient', $dataClient);

$smarty->assign('travail', $travail);

// ré-indiquer le nom  du client sur la fiche $formTravail
$smarty->assign('nomClient', true);

$smarty->display('reparations/fichesReparation.tpl');

