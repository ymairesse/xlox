<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$typeClient = isset($_POST['typeClient']) ? $_POST['typeClient'] : 'prive';

$smarty->assign('typeClient', $typeClient);

if (($typeClient == 'prive') || ($typeClient == Null))
    $smarty->display('clients/modal/modalEditClientPrive.tpl');
else
    $smarty->display('clients/modal/modalEditClientEntreprise.tpl');