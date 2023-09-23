<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$benevole = $User->getUser();
$idUser = $benevole['idUser'];

$mention = isset($_POST['mention']) ? $_POST['mention'] : Null;
$type = isset($_POST['type']) ? $_POST['type'] : Null;
$idMention = isset($_POST['idMention']) ? $_POST['idMention'] : Null;

$resultat = $User->saveMentionBon($idMention, $mention, $type, $idUser);

$listeMentions = $User->getMentionsBon($type);

$smarty->assign('listeMentions', $listeMentions);

$smarty->display('inc/tableMentions.tpl');
