<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

require_once INSTALL_DIR.'/inc/classes/class.newClient.php';
$Client = new NewClient();

$formulaire = isset($_POST['formulaire']) ? $_POST['formulaire'] : null;

$form = array();
parse_str($formulaire, $form);

$resultat = $Stock->saveItemStock($form);

echo $resultat;