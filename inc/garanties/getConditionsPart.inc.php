<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

$ticketCaisse = isset($_POST['ticketCaisse']) ? $_POST['ticketCaisse'] : null;

$condPart = $Garantie->getConditionsPart($ticketCaisse);

$type = $condPart['typeCondPart'];
$texte = $condPart['texte'];

// À ce moment, la présentation du texte extrait de la BD est du type suivant:
// {"CPAS":
//     {
//         "commune":"Ixelles",
//         "date":"2024-02-17",
//         "dossier":"S56789",
//         "montant":"300",
//         "remarque":"25€ payés par le client"
//     }
// }

$texte = json_decode($texte, true)[$type];

// il ne reste plus que 
//     array (
//      'commune' => 'Ixelles',
//      'date' => '2024-02-17',
//      'dossier' => 'S56789',
//      'montant' => '300',
//      'remarque' => '',
//      )
// qui sera injecté dans le formulaire de la boîte modale
// précautions par l'échappement des caractères spéciaux
$texte['commune'] = htmlspecialchars($texte['commune'], ENT_QUOTES, 'UTF-8');
$texte['dossier'] = htmlspecialchars($texte['dossier'], ENT_QUOTES, 'UTF-8');
$texte['date'] = htmlspecialchars($texte['date'], ENT_QUOTES, 'UTF-8');
$texte['montant'] = htmlspecialchars($texte['montant'], ENT_QUOTES, 'UTF-8');
$texte['remarque'] = htmlspecialchars($texte['remarque'], ENT_QUOTES, 'UTF-8');

$smarty->assign('type', $type);
$smarty->assign('ticketCaisse', $ticketCaisse);
$smarty->assign('texte', $texte);

$smarty->display('garanties/modal/modalCondPart.tpl');

