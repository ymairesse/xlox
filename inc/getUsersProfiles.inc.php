<?php

// Édition des profils personnels des utilisateurs par un user "root"

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$benevole = $User->getUser();
if ($benevole['droits'] != 'root')
    die('get out of here');

$smarty->assign('benevole', $benevole);

$listeUsers = $User->getListeUsers();
$smarty->assign('listeUsers', $listeUsers);

// fiche personnelle
$idUser = isset($_POST['idUser']) ? $_POST['idUser'] : Null;
$profil = $idUser != Null ? $User->getDataUser($idUser) : Null;

$smarty->assign('idUser', $idUser);
$smarty->assign('profil', $profil);

$smarty->display('ficheUser.tpl');