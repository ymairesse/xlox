<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$benevole = $User->getUser();
$token = $User->getToken();

if ($benevole != null) {
    $smarty->assign('benevole', $benevole);
    $smarty->assign('token', $token);

    $smarty->display('modal/modalToken.tpl');
}