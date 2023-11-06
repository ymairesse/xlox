<?php

// Édition des profils personnels des utilisateurs par un user "root"

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$idUser = isset($_POST['idUser']) ? $_POST['idUser'] : Null;

$listeUsers = $User->getListeUsers(array('oxfam', 'root'));

// s'il n'y a plus d'utilisateur actif, reprendre le premier de la liste
if ($idUser == Null) {
    reset($listeUsers);
    $idUser = key($listeUsers);
}

// utilisateur actif en session
$soi = $User->getUser();
$idUserSelf = $soi['idUser'];
$droits = $soi['droits'];

$dataUser = $User->getDataUser($idUser);

$smarty->assign('listeUsers', $listeUsers);

$smarty->assign('idUser', $idUser);
$smarty->assign('idUserSelf', $idUserSelf);
$smarty->assign('dataUser', $dataUser);

// ficheUser.tpl contiendra deux zones distinctes
// inc/listeUsers.tpl avec la liste des utilisateurs et
//  ficheProfilUser.tpl pour le détail du profil de l'utilisateur sélectionné

$smarty->display('ficheUser.tpl');