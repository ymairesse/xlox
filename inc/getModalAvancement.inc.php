<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$benevole = $User->getUser();

$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : Null;
$avancements = $User->getAvancements($numeroBon);

$dateAvancement = date('Y-m-d H:i');

$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('avancements', $avancements);
$smarty->assign('dateAvancement', $dateAvancement);

$smarty->assign('benevole', $benevole);

$smarty->display('modal/modalAvancement.tpl');