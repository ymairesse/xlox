<?php

session_start();

require_once '../config.inc.php';

require_once 'entetes.inc.php';

require_once INSTALL_DIR.'/inc/classes/class.User.php';


$identifiant = isset($_POST['identifiant']) ? $_POST['identifiant'] : Null;
$passwd = isset($_POST['passwd']) ? $_POST['passwd'] : Null;

$md5passwd = md5($passwd);

$User = new User($identifiant, $md5passwd);

$user = $User->getUser();

if ($User != NULL) {
    $_SESSION[APPLICATION] = serialize($User);
    // suppression préventive du Cookie 'neverDie'
    setcookie('neverDie', ' ', time() - 3600, '/');
    $smarty->assign('user', $user);
    $smarty->display('navbar.tpl');
    }
else echo "ko";
