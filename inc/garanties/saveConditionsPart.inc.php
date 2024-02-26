<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$formulaire = isset($_POST['formulaire']) ? $_POST['formulaire'] : Null;

$form = array();
parse_str($formulaire, $form);

$ticketCaisse = $form['ticketCaisse'];
$typeCondPart = ($form['typeCondPart'] != '') ? $form['typeCondPart'] : Null;

switch ($typeCondPart) {

    case 'CPAS': {
        $commune = isset($form['commune']) ? $form['commune'] : Null;
        $date = isset($form['date']) ? $form['date'] : Null;
        $dossier = isset($form['dossier']) ? $form['dossier'] : Null;
        $montant = isset($form['montant']) ? $form['montant'] : Null;
        $remarque = isset($form['remarque']) ? $form['remarque'] : Null;
        // création de la chaîne json
        $texteJSON = json_encode(
            array(
                'commune' => $commune,
                'date' => $date,
                'dossier' => $dossier,
                'montant' => $montant,
                'remarque' => $remarque,
            )
        );
        break;
    }
    case 'Facture': {
        $facture = isset($form['facture']) ? $form['facture'] : Null;
        $remarque = isset($form['remarque']) ? $form['remarque'] : Null;
        // création de la chaîne json
        $texteJSON = json_encode(
            array(
                'facture' => $facture,
                'remarque' => $remarque,
            )
        );
        break;
    }
}

$nb = 0;

if ($texteJSON != '') {
    // $texteJSON est du texte brut à enregistrer dans la BD
    $nb = $Garantie->saveConditionsPart($ticketCaisse, $typeCondPart, $texteJSON);
    if ($nb > 0)
        $User->touchUser($idClient);
}

echo $nb;