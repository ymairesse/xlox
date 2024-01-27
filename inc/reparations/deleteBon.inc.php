<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

$benevole = $User->getUser();
$smarty->assign('benevole', $benevole);

// fiche personnelle
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;
$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : null;

$n = $Reparation->deleteBon($idClient, $numeroBon);

$User->touchUser($idClient);

echo $n;
