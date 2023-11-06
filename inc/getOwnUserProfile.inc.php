<?php

// Édition du profil personnel de l'utilisateur

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';


// utilisateur actif en session
$dataUser = $User->getUser();
$smarty->assign('dataUser', $dataUser);

// fiche personnelle uniquement
$smarty->display('ficheProfilUser.tpl');
