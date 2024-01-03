<?php

// Édition des profils personnels des utilisateurs par un user "root"

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$idUser = isset($_POST['idUser']) ? $_POST['idUser'] : Null;

$listeUsers = $User->getListeUsers(array('oxfam', 'root'));
if ($idUser == Null) {
    reset($listeUsers);
    $idUser = key($listeUsers);
}

$idUserSelf = $User->getUser()['idUser'];

$smarty->assign('listeUsers', $listeUsers);

$smarty->assign('idUser', $idUser);
$smarty->assign('idUserSelf', $idUserSelf);

$smarty->display('users/inc/listeUsers.tpl');