<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

// derner item du stock précédemment sélectionné
$idMateriel = isset($_POST['idMateriel']) ? $_POST['idMateriel'] : Null;

$listeItemsStock = $Stock->getItemsStock();

// si l'item ne figure pas dans la liste du stock, on prend le premier item de la liste
if (!(in_array($idMateriel, array_keys($listeItemsStock))))   {
    reset($listeItemsStock);
    $idMateriel = key($listeItemsStock);
}

$smarty->assign('idMateriel', $idMateriel);
$smarty->assign('listeItemsStock', $listeItemsStock);

$smarty->display('stock/gestionStock.tpl');