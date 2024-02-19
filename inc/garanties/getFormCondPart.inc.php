<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$type = isset($_POST['type']) ? $_POST['type'] : Null;

switch ($type) {
    case 'CPAS': 
        $smarty->display('garanties/inc/formCpas.tpl');
        break;
    case 'Facture':
        $smarty->display('garanties/inc/formFacture.tpl');
        break;
    default :
        echo "";
}


