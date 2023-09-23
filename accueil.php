<?php

session_start();

require_once 'config.inc.php';

// chargement de la class Application et $smarty
// y compris les répertoires template et template_c
require_once 'inc/entetes.inc.php';

$smarty->display('accueil.tpl');
