<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$benevole = $User->getUser();

$formulaire = isset($_POST['formulaire']) ? $_POST['formulaire'] : null;
$form = array();
parse_str($formulaire, $form);

$numeroBon = isset($form['numeroBon']) ? $form['numeroBon'] : Null;
$texte = isset($form['texte']) ? $form['texte'] : Null;
$interaction = isset($form['interaction']) && ($form['interaction'] != '') ? $form['interaction'] : Null;
$idClient = isset($form['idClient']) ? $form['idClient'] : Null;

$resultat = $Reparation->saveAvancement($numeroBon, $texte, $benevole['prenom'], $interaction);

$avancements = $Reparation->getAvancements($numeroBon);
$User->touchUser($idClient);

$smarty->assign('numeroBon', $numeroBon);
$smarty->assign('avancements', $avancements);
$smarty->assign('benevole', $benevole);
$smarty->assign('idClient', $idClient);

$smarty->display('reparations/inc/tableAvancement.tpl');
