<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

$nbReparations = $User->getDependancesBons($idClient);

$delete = 'true';
$raisons = array();
if ($nbReparations > 0) {
    $raisons = sprintf("Effacement impossible: ce client a <strong>%d</strong> réparation(s) en cours.", $nbReparations);
    $delete = 'false';
}

echo json_encode(array('deleteOK'=>$delete, 'raisons'=>$raisons));

