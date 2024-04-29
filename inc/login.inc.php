<?php

session_start();

require_once '../config.inc.php';

require_once 'entetes.inc.php';

$identifiant = isset($_POST['identifiant']) ? $_POST['identifiant'] : Null;
$passwd = isset($_POST['passwd']) ? $_POST['passwd'] : Null;

$md5passwd = md5($passwd);

$User = new User($identifiant, $md5passwd);

// $user = array identite de l'utilisateur
$user = $User->getUser();

if ($user != false) {

    $_SESSION[APPLICATION] = serialize($User);
    // suppression préventive du Cookie 'neverDie'
    setcookie('neverDie', ' ', 
    [
    "expires" => time() -3600,
    "path" => '/',
    "domain" => "",
    "secure" => true,
    "httponly" => false,
    "samesite" => "Strict"]
    );

    // numéro de version dans config.ini
    $smarty->assign('VERSION', VERSION);
    $smarty->assign('user', $user);
    $smarty->display('navbar.tpl');
    }
else echo "ko";

