<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$formulaire = isset($_POST['formulaire']) ? $_POST['formulaire'] : null;

$form = array();
parse_str($formulaire, $form);

$resultatJSON = $User->saveUser($form);

echo $resultatJSON;