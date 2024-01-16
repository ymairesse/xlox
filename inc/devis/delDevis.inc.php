<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$idDevis = isset($_POST['idDevis']) ? $_POST['idDevis'] : null;

$n = $Devis->delDevis($idDevis);

echo $n;