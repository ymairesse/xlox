<?php
/* Smarty version 4.3.1, created on 2023-09-22 15:17:40
  from '/home/yves/www/oxxl/templates/footer.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.3.1',
  'unifunc' => 'content_650d93f49bcb78_49785291',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '234d360dabc23623aa09ded853539da6e09c32b3' => 
    array (
      0 => '/home/yves/www/oxxl/templates/footer.tpl',
      1 => 1691430430,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_650d93f49bcb78_49785291 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'/home/yves/www/oxxl/vendor/smarty/smarty/libs/plugins/modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<nav class="navbar fixed-bottom navbar-light bg-light">
	<div class="container-fluid">

	  <div class="d-lg-none"><?php echo smarty_modifier_date_format(time(),"%A, %e %b %Y");?>
 <?php echo smarty_modifier_date_format(time(),"%Hh%M");?>
</div>
	  <div class="d-none d-lg-block">Le <?php echo smarty_modifier_date_format(time(),"%A, %e %b %Y");?>
 à <?php echo smarty_modifier_date_format(time(),"%Hh%M");?>
</div>
	
	</div>
  </nav><?php }
}
