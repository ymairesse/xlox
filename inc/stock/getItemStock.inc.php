<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

// dernier item du stock précédemment sélectionné
$idMateriel = isset($_POST['idMateriel']) ? $_POST['idMateriel'] : Null;

$itemStock = $Stock->getOneItemStock($idMateriel);


$itemStock['marque'] = isset($itemStock['marque']) ? htmlspecialchars($itemStock['marque'], ENT_QUOTES, 'UTF-8') : Null;
$itemStock['modele'] = isset($itemStock['modele']) ? htmlspecialchars($itemStock['modele'], ENT_QUOTES, 'UTF-8') : Null;
$itemStock['caracteristiques'] = isset($itemStock['caracteristiques']) ? htmlspecialchars($itemStock['caracteristiques'], ENT_QUOTES, 'UTF-8') : Null;

// an-nulation de l'identifiant cloné
$itemStock['idMateriel'] = Null;

$smarty->assign('idMateriel', $idMateriel);
$smarty->assign('itemStock', $itemStock);

$smarty->display('stock/modal/modalEditItemStock.tpl');
