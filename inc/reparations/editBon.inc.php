<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$benevole = $User->getUser();
$smarty->assign('benevole', $benevole);

// fiche personnelle
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;
$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : Null;

$dataClient = $User->getDataUser($idClient);

$dataBon = ($numeroBon != Null) ? $Reparation->getDataBon($idClient, $numeroBon) : Null;
if ($dataBon != Null) {
    $dataBon['marque'] = htmlspecialchars($dataBon['marque'], ENT_QUOTES, 'UTF-8');
    $dataBon['modele'] = htmlspecialchars($dataBon['modele'], ENT_QUOTES, 'UTF-8');
    $dataBon['mdp'] = htmlspecialchars($dataBon['mdp'], ENT_QUOTES, 'UTF-8');
    $dataBon['probleme'] = htmlspecialchars($dataBon['probleme'], ENT_QUOTES, 'UTF-8');
    $dataBon['etat'] = htmlspecialchars($dataBon['etat'], ENT_QUOTES, 'UTF-8');
    $dataBon['devis'] = htmlspecialchars($dataBon['devis'], ENT_QUOTES, 'UTF-8');
    $dataBon['remarque'] = htmlspecialchars($dataBon['remarque'], ENT_QUOTES, 'UTF-8');
}

$accessoiresBon = ($numeroBon != Null) ? $Reparation->getAccessoires4bon($numeroBon) : Null;
// liste de tous les accessoies possibles
$allAccessoires = $User->getAllAccessoires();
// liste de tous les types de matériel en réparation possibles  
$allMateriel = $User->getAllMateriel();

$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('idClient', $idClient);

$smarty->assign('dataBon', $dataBon);
$smarty->assign('dataClient', $dataClient);
$smarty->assign('allAccessoires', $allAccessoires);
$smarty->assign('allMateriel', $allMateriel);
$smarty->assign('accessoiresBon', $accessoiresBon);

$smarty->display('reparations/modal/modalEditBon.tpl');