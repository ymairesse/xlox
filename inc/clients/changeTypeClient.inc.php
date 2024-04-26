<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;
$typeClient = isset($_POST['typeClient']) ? $_POST['typeClient'] : null;

$n = $User->changeTypeClient($idClient, $typeClient);

echo $n;