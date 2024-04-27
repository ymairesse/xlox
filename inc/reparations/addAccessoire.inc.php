<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$accessoire = isset($_POST['accessoire']) ? $_POST['accessoire'] : Null;

$n = $Reparation->addAccessoire($accessoire);

echo $n;