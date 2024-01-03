<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

$ticketCaisse = isset($_POST['ticketCaisse']) ? $_POST['ticketCaisse'] : null;

$garantie4ticket = $Garantie->getDataGarantie($ticketCaisse);
$items4ticket = $Garantie->getItems4ticketCaisse($ticketCaisse);

// le ticket de caisse désigne la garantie correspondante
$smarty->assign('ticketCaisse', $ticketCaisse);

$smarty->assign('garantie4ticket', $garantie4ticket);
$smarty->assign('items', $items4ticket);


$smarty->display('garanties/inc/formGarantieAnonyme.tpl');
