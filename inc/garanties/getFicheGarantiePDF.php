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
$horodatage = date('Y/m');
// ajouter underscore pour séparer du numéro de ticket de caisse
$nomClient = ($dataClient['nom'] != '') ? $dataClient['nom'].'_' : '';
$nomClient = str_replace(' ', '', $nomClient);

// création éventuelle du répertoire /année/mois
if (!file_exists(INSTALL_DIR.'/pdf/garanties/'.$horodatage)) {
    mkdir(INSTALL_DIR.'/pdf/garanties/'.$horodatage, 0777, true);
}

$ssDestination = '';
if ($condPart['typeCondPart'] == 'Facture') {
	if (!file_exists(INSTALL_DIR.'/pdf/garanties/'.$horodatage.'/factures')) {
		mkdir(INSTALL_DIR.'/pdf/garanties/'.$horodatage.'/factures', 0777, true);
	}
	$ssDestination = 'factures';
}
if ($condPart['typeCondPart'] == 'CPAS') {
	if (!file_exists(INSTALL_DIR.'/pdf/garanties/'.$horodatage.'/cpas')) {
		mkdir(INSTALL_DIR.'/pdf/garanties/'.$horodatage.'/cpas', 0777, true);
	}
	$ssDestination = 'cpas';
}

// le fichier est enregistré ET présenté dans le navigateur
$html2pdf->Output(INSTALL_DIR."/pdf/garanties/".$horodatage."/".$ssDestination."/".$nomClient.$ticketCaisse.".pdf", 'FD');