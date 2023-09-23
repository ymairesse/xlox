<?php


session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$user = $User->getUser();
$benevole = $user['prenom'];

$formulaire = isset($_POST['formulaire']) ? $_POST['formulaire'] : null;
$form = array();
parse_str($formulaire, $form);

$numeroBon = isset($form['numeroBon']) ? $form['numeroBon'] : Null;
$typeInteraction = isset($form['typeInteraction']) ? $form['typeInteraction'] : Null;
$note = isset($form['note']) ? $form['note'] : Null;
$data = isset($form['date']) ? $form['date'] : Null;

$resultat = $User->saveInteraction($numeroBon, $typeInteraction, $note, $benevole);

$interactions = $User->getInteractions($numeroBon);

$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('interactions', $interactions);

$smarty->display('inc/tableInteractions.tpl');
