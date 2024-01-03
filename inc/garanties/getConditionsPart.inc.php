<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

$ticketCaisse = isset($_POST['ticketCaisse']) ? $_POST['ticketCaisse'] : null;

$texte = $Garantie->getConditionsPart($ticketCaisse);

$smarty->assign('texte', $texte);
$smarty->assign('ticketCaisse', $ticketCaisse);

$smarty->display('garanties/modal/modalCondPart.tpl');

