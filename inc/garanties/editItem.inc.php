<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$benevole = $User->getUser();
$smarty->assign('benevole', $benevole);

$idItem = isset($_POST['idItem']) ? $_POST['idItem'] : Null;
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;
$ticketCaisse = isset($_POST['ticketCaisse']) ? $_POST['ticketCaisse'] : Null;

$dataItem = $Garantie->getDataItemGarantie($idItem);

// liste des marchandises disponibles (voir la table ox_inventaire)
$listeMarchandises = $Garantie->getListeMarchandise();
$smarty->assign('listeMarchandises', $listeMarchandises);

$dataItem['materiel'] = isset($dataItem['materiel']) ? htmlspecialchars($dataItem['materiel'], ENT_QUOTES, 'UTF-8') : Null;
$dataItem['remarque'] = isset($dataItem['remarque']) ? htmlspecialchars($dataItem['remarque'], ENT_QUOTES, 'UTF-8') : Null;
$dataItem['ref'] = isset($dataItem['ref']) ? htmlspecialchars($dataItem['ref'], ENT_QUOTES, 'UTF-8') : Null;

$smarty->assign('dataItem', $dataItem);

$smarty->assign('idItem', $idItem);
$smarty->assign('idClient', $idClient);
$smarty->assign('ticketCaisse', $ticketCaisse);

$smarty->display('garanties/modal/modalEditItem.tpl');