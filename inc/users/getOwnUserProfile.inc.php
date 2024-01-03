<?php

// Édition du profil personnel de l'utilisateur

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

// utilisateur actif en session
$dataUser = $User->getUser();
$idUser = $dataUser['idUser'];

// Application::afficher(array($dataUser, $idUser), true);

$smarty->assign('dataUser', $dataUser);
$smarty->assign('idUser', $idUser);

// fiche personnelle uniquement
$smarty->display('users/ficheProfilUser.tpl');
