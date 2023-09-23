<?php

// Édition du profil personnel de l'utilisateur

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$benevole = $User->getUser();
$smarty->assign('benevole', $benevole);

$type = isset($_POST['type']) ? $_POST['type'] : Null;

$listeMentions = $User->getMentionsBon($type);

$smarty->assign('listeMentions', $listeMentions);

$smarty->display('inc/tableMentions.tpl');