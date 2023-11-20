<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include 'entetes.inc.php';

// numéro du bon de travail sélectionné
$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : null;

$allAccessoires = $User->getAllAccessoires();
$accessoires4Bon[$numeroBon] = $User->getAccessoires4bon($numeroBon);

$avancements4bon = $User->getNbAvancements4bons($numeroBon);

$travail = $User->getData4Bon($numeroBon);
$idClient = $travail['idUser'];
$identiteClient = $User->getDataUser($idClient);


$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('listeAccessoires', $accessoires4Bon);
$smarty->assign('avancements4bons', $avancements4bon);
$smarty->assign('allAccessoires', $allAccessoires);
$smarty->assign('identiteClient', $identiteClient);

$smarty->assign('travail', $travail);

$smarty->display('inc/formTravail.tpl');
