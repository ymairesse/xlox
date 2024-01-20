<?php

// Édition du profil personnel de l'utilisateur

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

$profil = $User->getDataUser($idClient);

$smarty->assign('profil', $profil);

// fiche personnelle

$smarty->display('clients/ficheProfilClient.tpl');