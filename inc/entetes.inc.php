<?php

// définition de la class Application, y compris la lecture de config.ini
require_once INSTALL_DIR.'/inc/classes/class.Application.php';
$Application = new Application();

require_once INSTALL_DIR.'/inc/classes/class.garantie.php';
$Garantie = new Garantie();

require_once INSTALL_DIR.'/inc/classes/class.stock.php';
$Stock = new Stock();

require_once INSTALL_DIR.'/inc/classes/class.User.php';

$User = isset($_SESSION[APPLICATION]) ? unserialize($_SESSION[APPLICATION]) : null;

// -------------------------------------------------------------
require_once INSTALL_DIR.'/vendor/autoload.php';

$smarty = new Smarty();
$smarty->template_dir = INSTALL_DIR."/templates";
$smarty->compile_dir = INSTALL_DIR."/templates_c";
// -------------------------------------------------------------

$smarty->assign('BASEDIR', BASEDIR);