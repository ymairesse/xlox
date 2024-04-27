<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$listeAccessoires = $Reparation->getListeAccessoires();
$accessoiresInBons = $Reparation->getAccessoiresInBons();

foreach ($accessoiresInBons AS $idAccessoire => $compte) {
    $listeAccessoires[$idAccessoire]['nb'] = $compte;
}
$smarty->assign('listeAccessoires', $listeAccessoires);

$smarty->display('reparations/editAccessoires.tpl');