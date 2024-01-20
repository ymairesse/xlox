<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;
$sortClient = isset($_POST['sortClient']) ? $_POST['sortClient'] : 'parDate';
$ticketCaisse = isset($_POST['ticketCaisse']) ? $_POST['ticketCaisse'] : null;

// rechercher la liste des clients 
$droits = array('client');
$listeClients = $User->getListeUsers($droits, $sortClient);

// s'il n'y a pas de client en cours, on prend le premier de la liste
if ($idClient == null) {
    $idClient = reset($listeClients)['idUser'];
    setcookie('clientEnCours', $idClient, ['expires' => time() + 24*86400, 'path' => '/', 'sameSite' => 'Strict']);
}

// identite du client en cours
$identiteClient = $User->getDataUser($idClient);

// retrouver tous les bons de garantie pour le client $idClient
$listeBonsGarantie = $Garantie->getGaranties4Client($idClient);

$smarty->assign('listeClients', $listeClients);
$smarty->assign('idClient', $idClient);
$smarty->assign('identiteClient', $identiteClient);
$smarty->assign('sortClient', $sortClient);
$smarty->assign('mode', 'garantie');

$smarty->assign('listeBonsGarantie', $listeBonsGarantie);

// il y aura deux parties dans le document: 
// à gauche: la liste des clients 
// à droite: les différents onglets avec les garanties pour le client sélectionné

$smarty->display('garanties/bonsGarantie4clients.tpl');
