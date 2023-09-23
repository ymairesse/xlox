<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include 'entetes.inc.php';


$idUser = isset($_POST['idUser']) ? $_POST['idUser'] : null;

$n = $User->delUser($idUser);