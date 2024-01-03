<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
require_once '../../inc/entetes.inc.php';


// si pas d'utilisateur authentifié en SESSION et répertorié dans la BD, on renvoie à l'accueil
if ($User == null) {
	header('Location: '.BASEDIR.'/accueil.php');
	exit;
}

$ticketCaisse = isset($_GET['ticketCaisse']) ? $_GET['ticketCaisse'] : Null;

$dataClient = $Garantie->getDataClient4garantie($ticketCaisse);
if ($dataClient != Null)
	$idClient = $dataClient['idClient'];
else $idClient = Null;

$smarty->assign('dataClient', $dataClient);

// informations générales sur la garantie 
$dataGarantie = $Garantie->getDataGarantie($ticketCaisse);


$smarty->assign('dataGarantie', $dataGarantie);

// items présents sur la garantie
$listeItems = $Garantie->getItems4ticketCaisse($ticketCaisse);
$smarty->assign('listeItems', $listeItems);

// conditions particulières de vente
$condPart = $Garantie->getConditionsPart($ticketCaisse);
$smarty->assign('condPart', $condPart);


$smarty->assign('ticketCaisse', $ticketCaisse);
$smarty->assign('idClient', $idClient);

$dateGeneration = date("d/m/Y H:i");
$smarty->assign('dateGeneration', $dateGeneration);

$dateFichier = date("y_m_d");

$fichePDF = $smarty->fetch('garanties/ficheGarantiePDF.tpl');


use Spipu\Html2Pdf\Html2Pdf;

$html2pdf = new Html2Pdf('P','A4','fr');

$html2pdf->WriteHTML($fichePDF);
$horodatage = date('Y/m/');

if (!file_exists(INSTALL_DIR.'/pdf/garanties/'.$horodatage)) {
    mkdir(INSTALL_DIR.'/pdf/garanties/'.$horodatage, 0777, true);
}

$html2pdf->Output(INSTALL_DIR."/pdf/garanties/".$horodatage.$ticketCaisse.".pdf", 'FD');


