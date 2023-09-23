<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

// $benevole = $User->getUser();
// $idUser = $benevole['idUser'];

$idMatos = isset($_POST['idMatos']) ? $_POST['idMatos'] : Null;
$matos = isset($_POST['matos']) ? $_POST['matos'] : Null;

$idMatos = $User->saveMatos($idMatos, $matos);

$listeMateriel = $User->getTypeMateriel();

$smarty->assign('listeMateriel', $listeMateriel);
$smarty->assign('idMatos', $idMatos);

$smarty->display('inc/typeMateriel.tpl');
