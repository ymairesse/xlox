<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$idInteraction = isset($_POST['idInteraction']) ? $_POST['idInteraction'] : Null;

$n = $User->delInteraction($idInteraction);

echo $n;
