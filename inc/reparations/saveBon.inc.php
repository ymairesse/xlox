<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$formulaire = isset($_POST['formulaire']) ? $_POST['formulaire'] : null;
$form = array();
parse_str($formulaire, $form);

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;
// Application::afficher($form, true);

$numeroBon = $Reparation->saveDataBon($form);
$User->touchUser($idClient);

echo $numeroBon;