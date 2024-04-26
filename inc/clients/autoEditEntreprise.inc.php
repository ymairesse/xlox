<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

// fiche personnelle
$idClient = Null;
$dataClient = Null;

$smarty->assign('idClient', $idClient);
$smarty->assign('dataClient', $dataClient);

$smarty->display('clients/modal/modalAutoEditEntreprise.tpl');