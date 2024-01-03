<?php

// Édition des profils personnels des utilisateurs par un user "root"

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;
$bonGarantie = isset($_POST['bonGarantie']) ? $_POST['bonGarantie'] : Null;
$sortClient = isset($_POST['sortClient']) ? $_POST['sortClient'] : 'parDate';

$listeClients = $User->getListeUsers(array('clients'));

// si le client en cours ne figure pas dans la liste des clients avec un travail en cours
// on prend le premier de la liste
if (!isset($listeClients[$idClient])) {
    $keysClients = array_keys($listeClients);
    $idClient = $keysClients[0];
    setcookie('clientEnCours', $idClient, time()+24*86400, '/');
}

$profil = $User->getDataUser($idClient);

$listeGaranties = $User->getGaranties4Client($idClient);

$smarty->assign('listeClients', $listeClients);
$smarty->assign('idClient', $idClient);
$smarty->assign('profil', $profil);
$smarty->assign('listeGaranties', $listeGaranties);

$smarty->assign('mode', 'garantie');
$smarty->assign('selectHeight', 25); //hauteur du sélecteur de clients

$smarty->display('ficheGaranties4Client.tpl');