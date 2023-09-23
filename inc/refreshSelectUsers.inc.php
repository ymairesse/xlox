<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$listeUsers = $User->getListeUsers();
$smarty->assign('listeUsers', $listeUsers);

$smarty->display('inc/listeUsers.tpl');

