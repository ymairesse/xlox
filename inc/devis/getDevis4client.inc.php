<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;

$sortClient = isset($_COOKIE['sortClient']) ? $_COOKIE['sortClient'] : 'alphaAsc';

// rechercher la liste des clients 
$droits = array('client');
$listeClients = $User->getListeUsers($droits, $sortClient);

// s'il n'y a pas de client en cours, on prend le premier de la liste
if ($idClient == null) {
    $idClient = reset($listeClients)['idUser'];
}

// identite du client en cours
$identiteClient = $User->getDataUser($idClient);

// retrouver tous les devis pour le client $idClient
$listeDevis = $Devis->getAllDevis4Client($idClient);

$smarty->assign('idClient', $idClient);
$smarty->assign('identiteClient', $identiteClient);

$smarty->assign('listeDevis', $listeDevis);

// à droite: les différents onglets avec les garanties pour le client sélectionné

$smarty->display('devis/devis4unClient.tpl');
