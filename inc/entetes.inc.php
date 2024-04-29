<?php

// définition de la class Application, y compris la lecture de config.ini
require_once INSTALL_DIR.'/inc/classes/class.Application.php';
$Application = new Application();

require_once INSTALL_DIR.'/inc/classes/class.garantie.php';
$Garantie = new Garantie();

require_once INSTALL_DIR.'/inc/classes/class.stock.php';
$Stock = new Stock();

require_once INSTALL_DIR.'/inc/classes/class.devis.php';
$Devis = new Devis();

require_once INSTALL_DIR.'/inc/classes/class.reparations.php';
$Reparation = new Reparation();

require_once INSTALL_DIR.'/inc/classes/class.User.php';

// récupération de l'objet $User depuis la $_SESSION
$User = isset($_SESSION[APPLICATION]) ? unserialize($_SESSION[APPLICATION]) : null;

// -------------------------------------------------------------
require_once INSTALL_DIR.'/vendor/autoload.php';

$smarty = new Smarty();
$smarty->template_dir = INSTALL_DIR."/templates";
$smarty->compile_dir = INSTALL_DIR."/templates_c";
// -------------------------------------------------------------

