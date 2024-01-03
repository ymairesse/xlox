<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$idMateriel = isset($_POST['idMateriel']) ? $_POST['idMateriel'] : Null;

$marchandise = $Garantie->getMateriel4id($idMateriel);

echo json_encode($marchandise);

