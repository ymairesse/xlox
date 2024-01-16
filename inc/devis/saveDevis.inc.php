<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$formulaire = isset($_POST['formulaire']) ? $_POST['formulaire'] : null;
$form = array();
parse_str($formulaire, $form);

$idClient = $form['idClient'];
$idDevis = isset($form['idDevis']) ? $form['idDevis'] : null;
$date = isset($form['dateDevis']) ? $form['dateDevis'] : null;


$idDevis = $Devis->saveDevis($idDevis, $idClient, $date);

echo $idDevis;