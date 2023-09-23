<?php
/* Smarty version 4.3.1, created on 2023-09-22 15:17:40
  from '/home/yves/www/oxxl/templates/navbar.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.3.1',
  'unifunc' => 'content_650d93f49a9993_02326832',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'a047dea1faa599b9fe268882fbcf3c33674a32a1' => 
    array (
      0 => '/home/yves/www/oxxl/templates/navbar.tpl',
      1 => 1695127431,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_650d93f49a9993_02326832 (Smarty_Internal_Template $_smarty_tpl) {
?><nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.php"
      ><img src="images/computershop.png" alt="ComputerShop"
    /></a>
    <button
      class="navbar-toggler"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#navbarScroll"
      aria-controls="navbarScroll"
      aria-expanded="false"
      aria-label="Toggle navigation"
    >
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarScroll">
      <ul
        class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll"
        style="--bs-scroll-height: 100px"
      >

        <?php if ((isset($_smarty_tpl->tpl_vars['user']->value)) && in_array($_smarty_tpl->tpl_vars['user']->value['droits'],array('oxfam','root'))) {?>

        <li class="nav-item dropdown">
          <a
            class="nav-link dropdown-toggle"
            href="#"
            role="button"
            data-bs-toggle="dropdown"
            aria-expanded="false"
            >Réparations</a
          >

          <ul class="dropdown-menu">
            <li>
              <a href="#" class="dropdown-item" id="ficheReparation">
                <i class="fa fa-pencil"></i> Fiche de réparation
              </a>
            </li>
            <li><hr class="dropdown-divider" /></li>
            <li>
              <a href="#" class="dropdown-item" id="modalAddEditMateriel"
                >Ajout / Édition de matériel (à venir)</a
              >
            </li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a
            class="nav-link dropdown-toggle"
            href="#"
            role="button"
            data-bs-toggle="dropdown"
            aria-expanded="false"
          >
            Autres fonctions
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Devis (à venir)</a></li>
            <li><hr class="dropdown-divider" /></li>
            <li><a class="dropdown-item" href="#">Garantie (à venir)</a></li>
            <li>
              <a class="dropdown-item" href="#"
                >Ganrantie nominative (à venir)</a
              >
            </li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a
            class="nav-link dropdown-toggle"
            href="#"
            role="button"
            data-bs-toggle="dropdown"
            aria-expanded="false"
          >
            Profil
          </a>
          <ul class="dropdown-menu">
            <li>
              <a class="dropdown-item" id="profil" href="#">Profil personnel</a>
            </li>
            <?php if ($_smarty_tpl->tpl_vars['user']->value['droits'] == 'root') {?>
            <li>
              <a class="dropdown-item" id="gestUsers" href="#"
                >Gestion des utilisateurs</a
              >
            </li>
            <?php }?>
          </ul>
        </li>

        <?php }?>
      </ul>
      <ul class="text-end list-unstyled">
        <li class="nav-item">
          <?php if ($_smarty_tpl->tpl_vars['user']->value != Null) {?>
          <a
            type="button"
            class="btn btn-danger btn-sm"
            href="#"
            id="btn-logout"
            title="Déconnexion"
          >
            <i class="fa fa-sign-out" aria-hidden="true"></i>
            <span id="loggedUser"
              ><?php echo $_smarty_tpl->tpl_vars['user']->value['civilite'];?>
 <?php echo $_smarty_tpl->tpl_vars['user']->value['nom'];?>
 <?php echo $_smarty_tpl->tpl_vars['user']->value['prenom'];?>
</span
            >
          </a>
          <?php } else { ?>
          <a
            type="button"
            class="btn btn-success btn-sm"
            href="#"
            id="btn-login"
            title="Connexion"
          >
            <i class="fa fa-user"></i> Connexion</a
          >
          <?php }?>
        </li>
        <li class="nav-item"></li>
      </ul>
    </div>
  </div>
</nav>
<?php }
}
