<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

// pour le cas de l'édition
$idAccessoire = isset($_POST['idAccessoire']) ? $_POST['idAccessoire'] : Null;

$accessoire = isset($_POST['accessoire']) ? $_POST['accessoire'] : Null;
$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : Null;

$idAccessoire = $User->saveAccessoire($idAccessoire, $accessoire);

$allAccessoires = $User->getAllAccessoires();
$accessoires4bon = $User->getAccessoires4bon($numeroBon);

$smarty->assign('accessoires4bon', $accessoires4bon);
$smarty->assign('allAccessoires', $allAccessoires);

$smarty->display('inc/listeAccessoires.tpl');
