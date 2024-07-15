<?php 

session_start();

require_once 'config.inc.php';

// initialisation des classes Application et User (y compris la définition du $User)
// initialisation de Smarty
require_once 'inc/entetes.inc.php';

if ($User != Null)
    $user = $User->getUser();
    else $user = Null;

$smarty->assign('user', $user);
$smarty->assign('VERSION', VERSION);
$smarty->assign('TITREGENERAL', TITREGENERAL);

$smarty->display('index.tpl');

