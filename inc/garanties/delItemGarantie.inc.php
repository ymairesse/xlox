<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$benevole = $User->getUser();
$smarty->assign('benevole', $benevole);

$idItem = isset($_POST['idItem']) ? $_POST['idItem'] : Null;

$n = $Garantie->delItemGarantie($idItem);

echo $n;