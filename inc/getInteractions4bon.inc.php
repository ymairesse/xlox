<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : Null;

$nb = $User->getInteractions4bon($numeroBon);

echo $nb;