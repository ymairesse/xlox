<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$sortClient = isset($_COOKIE['sortClient']) ? $_COOKIE['sortClient'] : 'alphaAsc';

$listeClients = $User->getListeUsers('client', $sortClient);
$smarty->assign('listeClients', $listeClients);


// fiche personnelle
$idUser = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

$formClient = isset($_COOKIE['formClient']) ? 'hidden' : '';
$extraForm = isset($_COOKIE['extraForm']) ? 'hidden' : '';

$dataClient = $idUser != Null ? $User->getDataUser($idUser, 'client') : Null;

$smarty->assign('idClient', $idUser);
$smarty->assign('dataClient', $dataClient);
$smarty->assign('sortClient', $sortClient);

$smarty->assign('formClient', $formClient);
$smarty->assign('extraForm', $extraForm);

$smarty->assign('oxxl', $_SESSION['oxxl']);

$smarty->display('ficheClient.tpl');