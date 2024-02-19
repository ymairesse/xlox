<?php

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
require_once '../../inc/entetes.inc.php';


// si pas d'utilisateur authentifié en SESSION et répertorié dans la BD, on renvoie à l'accueil
if ($User == null) {
	
	header('Location: ../../index.php');
	exit;
}

$idDevis = isset($_GET['idDevis']) ? $_GET['idDevis'] : Null;

$dataClient = $Devis->getDataClient4devis($idDevis);
if ($dataClient != Null)
	$idClient = $dataClient['idClient'];
else
	$idClient = Null;

$smarty->assign('dataClient', $dataClient);

// informations générales sur le devis 
$dataDevis = $Devis->getDevis($idDevis);

$smarty->assign('dataDevis', $dataDevis);

// items présents sur la Devi
$listeItems = $Devis->getItems4devis($idDevis);
$smarty->assign('listeItems', $listeItems);

$smarty->assign('idDevis', $idDevis);
$smarty->assign('idClient', $idClient);

$dateGeneration = date("d/m/Y H:i");
$smarty->assign('dateGeneration', $dateGeneration);

// $dateFichier = date("y_m_d");

$fichePDF = $smarty->fetch('devis/ficheDevisPDF.tpl');


use Spipu\Html2Pdf\Html2Pdf;

$html2pdf = new Html2Pdf('P', 'A4', 'fr');

$html2pdf->WriteHTML($fichePDF);
$horodatage = date('Y/m');


// ajouter underscore pour séparer du numéro de référence
$nomClient = '_' . $dataClient['nom'];
$nomClient = str_replace(' ', '', $nomClient);

// création éventuelle du répertoire /année/mois
if (!file_exists(INSTALL_DIR . '/pdf/devis/' . $horodatage)) {
	mkdir(INSTALL_DIR . '/pdf/devis/' . $horodatage, 0777, true);
}


$ref = $dataDevis['ref'].$nomClient;

// le fichier est enregistré ET présenté dans le navigateur
$html2pdf->Output(INSTALL_DIR . "/pdf/devis/" . $horodatage . "/" .$ref .".pdf", 'FD');
