<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$idItem = isset($_POST['idItem']) ? $_POST['idItem'] : Null;

$n = $Devis->delItemDevis($idItem);

echo $n;