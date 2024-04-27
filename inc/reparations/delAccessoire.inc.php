<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$idAccessoire = isset($_POST['idAccessoire']) ? $_POST['idAccessoire'] : Null;

$n = $Reparation->delAccessoire($idAccessoire);

echo $n;
