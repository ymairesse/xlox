<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$benevole = $User->getUser();
$smarty->assign('benevole', $benevole);

// fiche personnelle
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

if ($idClient != Null) {
    $dataClient = $User->getDataUser($idClient);
    $User->touchUser($idClient);
    $typeClient = $dataClient['typeClient'];
} else {
    $dataClient = Null;
    $typeClent = Null;
}

$smarty->assign('idClient', $idClient);
$smarty->assign('dataClient', $dataClient);
$smarty->assign('typeClient', $typeClient);

if (($typeClient == 'prive') || ($typeClient == Null))
    $smarty->display('clients/modal/modalEditClientPrive.tpl');
else
    $smarty->display('clients/modal/modalEditClientEntreprise.tpl');