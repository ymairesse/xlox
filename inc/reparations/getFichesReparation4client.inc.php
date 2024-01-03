<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;
$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : null;
$mode = isset($_POST['mode']) ? $_POST['mode'] : null;
$sortClient = isset($_POST['sortClient']) ? $_POST['sortClient'] : 'alphaAsc';


// rechercher la liste des clients qui ont au moins un travail non terminé ($travailTermine = false)
$travailTermine = false;
$listeClients = $User->getListeClientsTravail($travailTermine, $sortClient);

// si le client en cours ne figure pas dans la liste des clients avec un travail en cours
// on prend le premier de la liste
if (!isset($listeClients[$idClient])) {
    $keysClients = array_keys($listeClients);
    $idClient = $keysClients[0];
    setcookie('clientEnCours', $idClient, time()+24*86400, '/');
}

$identiteClient = $User->getDataUser($idClient);

    
// liste de toutes les fiches de travail, y compris terminés, pour le client en cours
$listeBons = $User->getListeBonsReparation($idClient);

// recherche des accessoires déposés pour chaque fiche de travail
$allAccessoires = $User->getAllAccessoires();
$listeNumerosBons = array_keys($listeBons);

$accessoires4Bons = array();
foreach ($listeNumerosBons as $noBon) {
    $accessoires4Bons[$noBon] = $User->getAccessoires4bon($noBon);
}

$smarty->assign('listeClients', $listeClients);
$smarty->assign('idClient', $idClient);
$smarty->assign('identiteClient', $identiteClient);
$smarty->assign('sortClient', $sortClient);
$smarty->assign('mode', $mode);

$smarty->assign('listeBons', $listeBons);
$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('allAccessoires', $allAccessoires);

$smarty->assign('listeAccessoires', $accessoires4Bons);

// ne pas ré-indiquer le nom  du client sur la fiche $formTravail
$smarty->assign('nomClient', false);

// il y aura deux parties dans le document: 
// à gauche: la liste des clients avec travail
// à droite: les différents onglets avec les travaux du client en cours

$smarty->display('reparations/fichesReparation4clients.tpl');
