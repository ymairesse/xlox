<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

// idUser sélectionné à l'écran précédent
$idUser = isset($_POST['idUser']) ? $_POST['idUser'] : Null;
// $data de cet utilisateur 
$dataUser = ($idUser != Null) ? $User->getDataUser($idUser) : Null;

// l'utilisateur actif dans l'application
$self = $User->getUser();

// si l'utilisateur actif a le même idUser que celui qui est désigné
// alors, le test checkIfNotSelf échoue
echo ($dataUser['idUser'] == $self['idUser']);

