<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$benevole = $User->getUser();
$smarty->assign('benevole', $benevole);

$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : Null;
$idUser = isset($_POST['idUser']) ? $_POST['idUser'] : Null;


// fiche personnelle
$travail = $User->getDataBon($idUser, $numeroBon);
$listeAccessoires[$numeroBon] = $User->getAccessoires4bon($numeroBon);
$allAccessoires = $User->getAllAccessoires();

$smarty->assign('travail', $travail);
$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('listeAccessoires', $listeAccessoires);
$smarty->assign('allAccessoires', $allAccessoires);

$smarty->display('inc/formBon.tpl');