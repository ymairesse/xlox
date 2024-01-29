<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$idAvancement = isset($_POST['idAvancement']) ? $_POST['idAvancement'] : Null;
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;

$n = $Reparation->delAvancement($idAvancement);

$User->touchUser($idClient);

echo $n;
