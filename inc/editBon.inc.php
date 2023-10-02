<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$benevole = $User->getUser();
$smarty->assign('benevole', $benevole);

// fiche personnelle
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;
$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : Null;

$dataBon = ($numeroBon != Null) ? $User->getDataBon($idClient, $numeroBon) : Null;

$accessoiresBon = ($numeroBon != Null) ? $User->getAccessoires4bon($numeroBon) : Null;
$allAccessoires = $User->getAllAccessoires();
$allMateriel = $User->getAllMateriel();

$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('idClient', $idClient);

$smarty->assign('dataBon', $dataBon);
$smarty->assign('allAccessoires', $allAccessoires);
$smarty->assign('allMateriel', $allMateriel);
$smarty->assign('accessoiresBon', $accessoiresBon);

$smarty->display('modal/modalEditBon.tpl');