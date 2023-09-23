<?php
/* Smarty version 4.3.1, created on 2023-09-22 15:17:40
  from '/home/yves/www/oxxl/templates/index.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.3.1',
  'unifunc' => 'content_650d93f4991440_40227079',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '8b8ee91e08c4defd21e6d2ce9639d9a1fe3aec3a' => 
    array (
      0 => '/home/yves/www/oxxl/templates/index.tpl',
      1 => 1693123680,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:navbar.tpl' => 1,
    'file:start.tpl' => 1,
    'file:footer.tpl' => 1,
  ),
),false)) {
function content_650d93f4991440_40227079 (Smarty_Internal_Template $_smarty_tpl) {
?><!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Oxfam Computershop</title>
    <link rel="stylesheet" href="bootstrap-5.3.0-dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/screen.css" />
    <link
      rel="stylesheet"
      href="fa/css/font-awesome.min.css"
      type="text/css"
      media="screen, print"
    />

    
    <?php echo '<script'; ?>
 src="bootstrap-5.3.0-dist/js/bootstrap.bundle.min.js"><?php echo '</script'; ?>
>

    <?php echo '<script'; ?>
 src="js/jquery-3.7.0.min.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="js/jsCookie/src/js.cookie.js"><?php echo '</script'; ?>
>

    <?php echo '<script'; ?>
 src="js/javascript.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="js/jqvalidate/dist/jquery.validate.min.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="js/jqvalidate/dist/additional-methods.min.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="js/jqvalidate/dist/localization/messages_fr.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
 src="js/bootbox.min.js"><?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
>
      bootbox.setDefaults({
        locale: "fr",
        backdrop: false,
      });
    <?php echo '</script'; ?>
>
  </head>
  <body>
    <div class="container-fluid" id="menu">
      
      <?php $_smarty_tpl->_subTemplateRender("file:navbar.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>
    
    </div>

    <div class="container-fluid" id="corpsPage">

      <div class="row">

        <div id="left">
          <?php $_smarty_tpl->_subTemplateRender("file:start.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>
        </div>

        <div id="right">

        </div>

        <div class="col-12" id="unique">
          
        </div>
      </div>

    </div>

      <div id="modal"></div>

    <?php $_smarty_tpl->_subTemplateRender("file:footer.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>

  </body>
</html>
<?php }
}
