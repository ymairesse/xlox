<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$idAvancement = isset($_POST['idAvancement']) ? $_POST['idAvancement'] : Null;

$n = $User->delAvancement($idAvancement);

echo $n;
