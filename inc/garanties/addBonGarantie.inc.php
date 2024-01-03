<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$ticketCaisse = isset($_POST['ticketCaisse']) ? $_POST['ticketCaisse'] : Null;

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

$dataGarantie = ($ticketCaisse != Null) ? $User->getDataGarantie($ticketCaisse) : Null;
$smarty->assign('dataGarantie', $dataGarantie);
$smarty->assign('idClient', $idClient);

$smarty->display('garanties/modal/modalAddBonGarantie.tpl');
    