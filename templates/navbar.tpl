<nav class="navbar navbar-expand-lg bg-body-tertiary">
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
        {if isset($user) && in_array($user.droits, ['oxfam','root'])}
        <li class="nav-item dropdown">
          <a
            href="#"
            class="nav-link dropdown-toggle"
            role="button"
            data-bs-toggle="dropdown"
            aria-expanded="false"
            >Clients</a
          >
          <ul class="dropdown-menu">
            <li>
              <a href="#" class="dropdown-item" id="gestionClients">
                Gestion des clients
              </a>
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
            >Réparations</a
          >

          <ul class="dropdown-menu">
            <li>
              <a href="#" class="dropdown-item" id="ficheReparation">
                <i class="fa fa-pencil"></i> Fiche de réparation par client
              </a>
            </li>
            <li>
              <a href="#" class="dropdown-item" id="reparations4bons" >
                <i class="fa fa-wrench" aria-hidden="true"></i> Réparations en cours
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
              <a class="dropdown-item" id="profil" href="#"
                ><i class="fa fa-user"></i> Profil personnel</a
              >
            </li>

            {if $user.droits == 'root'}
            <li>
              <a class="dropdown-item" id="gestUsers" href="#"
                ><i class="fa fa-users"></i> Gestion des utilisateurs</a
              >
            </li>
            {/if}
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
            Préférences
          </a>
          <ul class="dropdown-menu">
            <li>
              <a class="dropdown-item" id="neverDie" href="#"
                ><i class="fa fa-spinner" aria-hidden="true"></i> Never die</a
              >
            </li>

          </ul>
        </li>
        {/if}
      </ul>

      <ul class="text-end list-unstyled">
        <li class="nav-item">
          {if $user != Null}
          <a
            role="button"
            class="btn btn-danger btn-sm"
            href="#"
            id="btn-logout"
            title="Déconnexion"
          >
            <i class="fa fa-sign-out" aria-hidden="true"></i>
            <span id="loggedUser">
              <span id="never"></span>
              {$user.civilite} {$user.nom} {$user.prenom}</span
            >
          </a>
          {else}
          <a
            type="button"
            class="btn btn-success btn-sm"
            href="#"
            id="btn-login"
            title="Connexion"
          >
            <i class="fa fa-user"></i> Connexion</a
          >
          {/if}
        </li>
        <li class="nav-item"></li>
      </ul>
    </div>
  </div>
</nav>
