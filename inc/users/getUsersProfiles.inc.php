<?php

// Édition des profils des utilisateurs par un user "root"

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

// utilisateur désigné par le click dans la colonne de gauche
$idUser = isset($_POST['idUser']) ? $_POST['idUser'] : Null;
// liste de tous les utilisateurs oxfam et root
$listeUsers = $User->getListeUsers(array('oxfam', 'root'));

// s'il n'y a pas d'utilisateur désigné, prendre le premier de la liste
if ($idUser == Null) {
    reset($listeUsers);
    $idUser = key($listeUsers);
}

// data de l'utilisateur désigné dans la liste (ou le premier, par défaut)
$dataUser = $User->getDataUser($idUser);

$smarty->assign('listeUsers', $listeUsers);

$smarty->assign('idUser', $idUser);
$smarty->assign('dataUser', $dataUser);

// ficheUser.tpl contiendra deux zones distinctes
// inc/listeUsers.tpl avec la liste des utilisateurs et
//  ficheProfilUser.tpl pour le détail du profil de l'utilisateur sélectionné

$smarty->display('users/ficheUser.tpl');