<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty,
include '../entetes.inc.php';

$idClient = isset($_POST['idClient']) ? $_POST['idClient'] : null;

// identité du client
$identiteClient = $User->getDataUser($idClient);
    
// liste de toutes les fiches de garanties pour le client en cours
// y compris les marchandises
// y compris les conditions particulières de vente
$listeBonsGarantie = $Garantie->getGaranties4Client($idClient);


$listeNumerosBons = array_keys($listeBonsGarantie);

$smarty->assign('idClient', $idClient);
$smarty->assign('identiteClient', $identiteClient);
$smarty->assign('listeBonsGarantie', $listeBonsGarantie);
$smarty->assign('listeNumerosBons', $listeNumerosBons);

$smarty->display('garanties/fichesGarantie4unClient.tpl');
