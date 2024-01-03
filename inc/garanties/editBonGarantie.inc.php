<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$ticketCaisse = isset($_POST['ticketCaisse']) ? $_POST['ticketCaisse'] : Null;
$edition = isset($_POST['edition']) ? $_POST['edition'] : Null;

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

$dataGarantie = ($ticketCaisse != Null) ? $Garantie->getDataGarantie($ticketCaisse) : Null;
$smarty->assign('dataGarantie', $dataGarantie);
$smarty->assign('idClient', $idClient);

$smarty->display('garanties/modal/modalEditBonGarantie.tpl');


    