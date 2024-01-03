<?php 

session_start();

require_once '../../config.inc.php';

// ressources principales toujours nécessaires: classes Application, User, Smarty, 
include '../entetes.inc.php';

$listeMarchandises = $Garantie->getListeMarchandise();

$smarty->assign('listeMarchandises', $listeMarchandises);

$smarty->display('garanties/inc/tableMarchandises.tpl');


