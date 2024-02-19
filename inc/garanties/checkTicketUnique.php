<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
require_once '../../inc/entetes.inc.php';


// si pas d'utilisateur authentifié en SESSION et répertorié dans la BD, on renvoie à l'accueil
if ($User == null) {
	header('Location: ../../index.php');
	exit;
}

$ticketCaisse = $_GET['ticketCaisse'];

$isBad = $Garantie->checkTicket4client($ticketCaisse);

echo $isBad ? "false" : "true";
