<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include 'entetes.inc.php';

$benevole = $User->getUser();
$smarty->assign('benevole', $benevole);

// fiche personnelle
$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;
$numeroBon = isset($_POST['numeroBon']) ? $_POST['numeroBon'] : null;
$confirm = isset($_POST['confirm']) ? $_POST['confirm'] : null;

if ($confirm == true) {
    $User->deleteBon($idClient, $numeroBon);
    }
    else {
        $user = $User->getDataUser($idClient);
        $civilites = array('Madame' => 'F', 'Monsieur' => 'M', '' => 'X');
        $civ = array_search($user['civilite'], $civilites); 
        $nom = $user['nom'];
        $prenom = $user['prenom'];
        $numeroBond = sprintf("%05d", $numeroBon);
        $message = sprintf('Suppression définitive du bon n° <strong>%s</strong> <br>de <strong>%s %s %s</strong>', $numeroBond, $civ, $nom, $prenom);
        echo $message;
    }
