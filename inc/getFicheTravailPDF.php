<?php

session_start();

require_once '../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
// valeur de $action
require_once '../inc/entetes.inc.php';


// si pas d'utilisateur authentifié en SESSION et répertorié dans la BD, on renvoie à l'accueil
if ($User == null) {
	header('Location: '.BASEDIR.'/accueil.php');
	exit;
}

$numeroBon = isset($_GET['numeroBon']) ? $_GET['numeroBon'] : date('Y');

$client = $User->getClient4bon($numeroBon);
$idUser = $client['idUser'];

$dataBon = $User->getDataBon($idUser, $numeroBon);
$accessoiresBon = $User->getAccessoires4bon($numeroBon);


$dataBon['dateEntree'] = Application::datePHP($dataBon['dateEntree']);
$dataBon['dateSortie'] = Application::datePHP($dataBon['dateSortie']);

$allAccessoires = $User->getAllAccessoires();
$allMateriel = $User->getAllMateriel();

$smarty->assign('client', $client);
$smarty->assign('dataBon', $dataBon);

$dataBon['dateEntree'] = Application::datePHP($dataBon['dateEntree']);
$smarty->assign('accessoiresBon', $accessoiresBon);
$smarty->assign('allMateriel', $allMateriel);

$dateGeneration = date("d/m/Y H:i");
$smarty->assign('dateGeneration', $dateGeneration);

$fichePDF = $smarty->fetch('ficheTravailPDF.tpl');

// require INSTALL_DIR.'/vendor/autoload.php';

use Spipu\Html2Pdf\Html2Pdf;

$html2pdf = new Html2Pdf('P','A4','fr');

$html2pdf->WriteHTML($fichePDF);

$html2pdf->Output("fiche_{$numeroBon}_{$idUser}.pdf", 'D');
