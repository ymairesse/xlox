<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$formulaire = isset($_POST['formulaire']) ? $_POST['formulaire'] : null;
$form = array();
parse_str($formulaire, $form);

$ticketCaisse = $form['ticketCaisse'];
$texte = $form['texte'];

$nb = $Garantie->saveConditionsPart($ticketCaisse, $texte);

echo json_encode(array('nb' => $nb, 'texte' => $texte, 'ticketCaisse' => $ticketCaisse));