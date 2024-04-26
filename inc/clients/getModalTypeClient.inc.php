<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';


$typeClient = isset($_POST['typeClient']) ? $_POST['typeClient'] : Null;
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

if ($idClient != '')
    $dataClient = $User->getDataUser($idClient);
    else $dataClient = Null;

$smarty->assign('dataClient', $dataClient);

if ($typeClient == 'prive')
    $smarty->display('clients/modal/modalPrive.inc.tpl');
    else $smarty->display('clients/modal/modalEntreprise.inc.tpl');
    