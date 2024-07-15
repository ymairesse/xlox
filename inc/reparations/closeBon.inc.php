<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';


// fiche personnelle
$idUser = isset($_POST['idUser']) ? $_POST['idUser'] : Null;
$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : Null;

$nb = $Reparation->closeBon($numeroBon, $idUser);

echo $nb;