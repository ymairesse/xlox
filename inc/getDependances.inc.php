<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$idUser = isset($_POST['idUser']) ? $_POST['idUser'] : Null;

$nbReparations = $User->getDependancesBons($idUser);


$delete = 'true';
$raisons = array();
if ($nbReparations > 0) {
    $raisons = sprintf("Cet utilisateur a %d réparation(s) en cours.", $nbReparations);
    $delete = 'false';
}

echo json_encode(array('deleteOK'=>$delete, 'raisons'=>$raisons));

