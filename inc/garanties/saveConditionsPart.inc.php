<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : Null;
$formulaire = isset($_POST['formulaire']) ? $_POST['formulaire'] : Null;

$form = array();
parse_str($formulaire, $form);

$ticketCaisse = $form['ticketCaisse'];
$typeCondPart = ($form['typeCondPart'] != '') ? $form['typeCondPart'] : Null;
$texte = $form['texte'];

$nb = $Garantie->saveConditionsPart($ticketCaisse, $typeCondPart, $texte);
$User->touchUser($idClient);

switch ($typeCondPart) {
    case 'CPAS':
        $condPart = 'Bon CPAS';
        break;
    case 'Facture':
        $condPart = 'Facture acquitée demandée';
        break;
    default:
        $condPart = 'Aucune condition particulière';
}

echo json_encode(array('texte' => $texte, 'ticketCaisse' => $ticketCaisse, 'condPart' => $condPart));