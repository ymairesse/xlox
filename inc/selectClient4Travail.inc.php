<?php

// Édition du profil personnel de l'utilisateur

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$listeClientsSansTravail = $User->getListeClientsTravail($travailTermine = true, $sort = 'parDate');

$smarty->assign('listeClients', $listeClientsSansTravail);

$smarty->display('modal/modalSelectClient.tpl');
