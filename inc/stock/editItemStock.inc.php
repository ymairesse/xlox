<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

// dernier item du stock précédemment sélectionné
$idMateriel = isset($_POST['idMateriel']) ? $_POST['idMateriel'] : Null;

$itemStock = $Stock->getOneItemStock($idMateriel);

$smarty->assign('idMateriel', $idMateriel);
$smarty->assign('itemStock', $itemStock);

$smarty->display('stock/modal/modalEditItemStock.tpl');
