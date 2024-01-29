<?php


session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$benevole = $User->getUser();

$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : Null;
$idAvancement = isset($_POST['idAvancement']) ? $_POST['idAvancement'] : Null;

$n = $Reparation->strikeAvancement($numeroBon, $idAvancement, $benevole['prenom']);

echo $n;