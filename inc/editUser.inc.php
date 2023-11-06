<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$idUser = isset($_POST['idUser']) ? $_POST['idUser'] : Null;
$selfEdit = isset($_POST['selfEdit']) && ($_POST['selfEdit'] == 1) ? 1 : 0;
$dataUser = ($idUser != Null) ? $User->getDataUser($idUser) : Null;

$droits = $User->getUser()['droits'];

$smarty->assign('idUser', $idUser);
$smarty->assign('dataUser', $dataUser);
$smarty->assign('selfEdit', $selfEdit);
$smarty->assign('droits', $droits);

$smarty->display('modal/modalEditUser.tpl');