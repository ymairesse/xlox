<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

$ticketCaisse = isset($_POST['ticketCaisse']) ? $_POST['ticketCaisse'] : null;

$listeBonsGarantie = $Garantie->getGarantiesAnonymes();

// s'il n'y a pas de ticket de caisse dans le Cookie ou s'il ne figure pas 
// dans la liste des bons de garantie anonymes
// on sélectionne le premier de la liste des bons de garantie anonyme
if (($ticketCaisse == null) || !(in_array($ticketCaisse, array_keys($listeBonsGarantie))))
    $ticketCaisse = reset($listeBonsGarantie)['ticketCaisse'];

$garantie4ticket = $Garantie->getDataGarantie($ticketCaisse);

$smarty->assign('listeBonsGarantie', $listeBonsGarantie);
// le ticket de caisse désigne la garantie correspondante
$smarty->assign('ticketCaisse', $ticketCaisse);
$smarty->assign('garantie4ticket', $garantie4ticket);


// il y aura deux parties dans le document: 
// à gauche: la liste des clients 
// à droite: les différents onglets avec les garanties pour le client sélectionné

$smarty->display('garanties/bonsGarantieAnonymes.tpl');
