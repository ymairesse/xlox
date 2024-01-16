<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;
$idDevis = isset($_POST['idDevis']) ? $_POST['idDevis'] : null;

$dataDevis = $Devis->getDevis($idDevis);

$smarty->assign('idDevis', $idDevis);
$smarty->assign('idClient', $idClient);

$smarty->assign('dataDevis', $dataDevis);

$smarty->display('devis/modal/modalEditDevis.tpl');
