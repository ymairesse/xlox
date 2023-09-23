<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$benevole = $User->getUser();

if ($benevole != null) {
    $token = $User->renewToken();
    echo $token;
}