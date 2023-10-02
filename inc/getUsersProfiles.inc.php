<?php

// Édition des profils personnels des utilisateurs par un user "root"

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$idUser = isset($_POST['idUser']) ? $_POST['idUser'] : Null;
$droits = isset($_POST['droits']) ? $_POST['droits'] : Null;

$listeUsers = $User->getListeUsers($droits);
$smarty->assign('listeUsers', $listeUsers);

// fiche personnelle

$profil = $idUser != Null ? $User->getDataUser($idUser) : Null;

$smarty->assign('idUser', $idUser);
$smarty->assign('profil', $profil);

$smarty->display('ficheUser.tpl');