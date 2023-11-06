<?php

// Édition du profil utilisateur oXFAM

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$idUser = isset($_POST['idUser']) ? $_POST['idUser'] : Null;

$dataUser = $User->getDataUser($idUser);
$smarty->assign('dataUser', $dataUser);
$smarty->assign('idUser', $idUser);

$smarty->display('ficheProfilUser.tpl');