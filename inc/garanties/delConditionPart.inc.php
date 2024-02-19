<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$ticketCaisse = isset($_POST['ticketCaisse']) ? $_POST['ticketCaisse'] : null;

$nb = $Garantie->delConditionPart($ticketCaisse);

