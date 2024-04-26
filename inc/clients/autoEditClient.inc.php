<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;
$typeClient = isset($_POST['typeClient']) ? $_POST['typeClient'] : 'prive';

// fiche personnelle vide
$dataClient = Null;

$smarty->assign('idClient', $idClient);
$smarty->assign('dataClient', $dataClient);
$smarty->assign('typeClient', $typeClient);

$smarty->display('clients/modal/modalAutoEditClient.tpl');