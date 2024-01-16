<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$benevole = $User->getUser();
$smarty->assign('benevole', $benevole);

$idDevis = isset($_POST['idDevis']) ? $_POST['idDevis'] : Null;
$idItem = isset($_POST['idItem']) ? $_POST['idItem'] : Null;
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

if ($idItem == Null)
    $dataItem = array();
else $dataItem = $Devis->getDataItemDevis($idItem);

$dataItem['materiel'] = isset($dataItem['materiel']) ? htmlspecialchars($dataItem['materiel'], ENT_QUOTES, 'UTF-8') : Null;
$dataItem['remarque'] = isset($dataItem['remarque']) ? htmlspecialchars($dataItem['remarque'], ENT_QUOTES, 'UTF-8') : Null;

$smarty->assign('dataItem', $dataItem);

$smarty->assign('idDevis', $idDevis);
$smarty->assign('idClient', $idClient);
$smarty->assign('idItem', $idItem);

$smarty->display('devis/modal/modalEditItemDevis.tpl');