<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include 'entetes.inc.php';

$appli = 'oxxl';

$captcha = isset($_POST['captcha']) ? $_POST['captcha'] : Null;

if ($_SESSION[$appli]['captcha'] == strtoupper($captcha))
    echo true;
    else echo $_SESSION[$appli]['captcha'];
