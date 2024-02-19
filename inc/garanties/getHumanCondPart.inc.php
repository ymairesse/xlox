<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

// texte t'el qu'enregistré dans la BD
$texte = isset($_POST['texte']) ? $_POST['texte'] : Null;
$typeCondPart = isset($_POST['typeCondPart']) ? $_POST['typeCondPart'] : Null;

// conversion en array
$texte = json_decode($texte, true);

$smarty->assign('texte', $texte[$typeCondPart]);
$smarty->assign('type', $typeCondPart);

$smarty->display('garanties/inc/condPartHRText.tpl');