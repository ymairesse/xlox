<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : Null;

$interactions = $User->getInteractions($numeroBon);

$dateInteraction = date('Y-m-d H:i');

$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('interactions', $interactions);
$smarty->assign('dateInteraction', $dateInteraction);

$smarty->display('modal/modalInteractions.tpl');