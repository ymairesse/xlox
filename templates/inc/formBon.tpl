<form id="formTravail_{$numeroBon}">
  <div class="row">
    <div class="form-group pb-3 col-md-3 col-sm-3 col-4">
      <label for="type_{$numeroBon}">Type</label>
      <input
        type="text"
        class="form-control"
        name="type_{$numeroBon}"
        id="type_{$numeroBon}"
        readonly
        value="{$travail.type|default:''}"
        placeholder="Type d'appareil"
      />
    </div>
    <div class="form-group pb-3 col-md-3 col-sm-3 col-4">
      <label for="marque_{$numeroBon}">Marque</label>
      <input
        type="text"
        class="form-control"
        name="marque{$numeroBon}"
        id="marque_{$numeroBon}"
        readonly
        value="{$travail.marque|default:''}"
        placeholder="Modèle"
      />
    </div>

    <div class="form-group pb-3 col-md-3 col-sm-3 col-4">
      <label for="modele_{$numeroBon}">Modèle</label>
      <input
        type="text"
        class="form-control"
        name="modele{$numeroBon}"
        id="modele_{$numeroBon}"
        readonly
        value="{$travail.modele|default:''}"
        placeholder="Modèle"
      />
    </div>
    <div class="form-group pb-3 col-md-3 col-sm-3 col-4">
      <label for="dateEntree_{$numeroBon}">Entrée le</label>
      <input
        type="date"
        class="form-control"
        name="dateEntree_{$numeroBon}"
        id="dateEntree_{$numeroBon}"
        readonly
        value="{$travail.dateEntree}"
        placeholder="Date d'entrée"
      />
    </div>

    <div class="form-group pb-3 col-md-3 col-4">
      <label for="benevole_{$numeroBon}">Reçu par</label>
      <input
        type="text"
        class="form-control"
        name="benevole_{$numeroBon}"
        readonly
        value="{$travail.benevole|default:$benevole.prenom}"
        placeholder="Reçu par"
      />
    </div>

    <div class="form-group pb-3 col-4">
      <label for="ox_{$numeroBon}">Num. OX</label>
      <div class="input-group mb-3">
        <span class="input-group-text d-none d-lg-block" id="addonOX">OX</span>
        <input
          type="text"
          class="form-control"
          name="ox_{$numeroBon}"
          id="ox_{$numeroBon}"
          value="{$travail.ox|default:''}"
          placeholder="Num OX"
          aria-label="numOX"
          aria-describedby="addonOX"
          readonly
        />
      </div>
    </div>

    <div class="form-group pb-3 col-4">
      <label for="mdp">Mot de passe</label>
      <div class="input-group mb-3">
        <span class="input-group-text addonMdp"><i class="fa fa-eye"></i></span>
        <input type="password"
        class="form-control"
        name="mdp_{$numeroBon}"
        id="mdp_{$numeroBon}"
        value="{$travail.mdp|default:''}"
        placeholder="Mot de passe"
        aria-describedby="addonMdp"
        readonly>
      </div>
  </div>

  <div class="col-md-4 form-group pb-3 col-4">
    <label for="data">Données</label>
    {if $travail.data == 1}
      <button type="button" title="Données à conserver" class="btn btn-danger w-100 text-truncate"><i class="fa fa-warning" aria-hidden="true"></i> Données <i class="fa fa-warning" aria-hidden="true"></i></button>
      {else}
      <button type="button" title="Pas de données" class="btn btn-default w-100 text-truncate">No Data</button>
      {/if}
  </div>

    <div class="form-group pb-3 col-md-8 col-12">
      <h5>Accessoires déposés</h5>
      {foreach from=$allAccessoires key=idAccessoire item=data}
      <div class="form-check form-check-inline">
        <input class="form-check-input" type="checkbox"
        name="{$data}_{$numeroBon}" id="{$data}_{$numeroBon}"
        value="{$idAccessoire}" {if in_array($idAccessoire,
        array_keys($listeAccessoires.$numeroBon))} checked {/if} disabled />

        <label class="form-check-label" for="{$data}_{$numeroBon}"
          >{$data}</label
        >
      </div>
      {/foreach}
    </div>
  </div>

  <div class="row">
    <div class="col-md-6 mb-3">
      <label for="probleme_{$numeroBon}" class="form-label"
        >Description de la panne</label
      >
      <textarea
        class="form-control"
        id="probleme_{$numeroBon}"
        rows="3"
        readonly
      >
{$travail.probleme}</textarea
      >
    </div>

    <div class="col-md-6 mb-3">
      <label for="devis_{$numeroBon}" class="form-label"
        >À faire & devis</label
      >
      <textarea class="form-control" id="devis_{$numeroBon}" rows="3" readonly>
{$travail.devis}</textarea
      >
    </div>
  </div>

  <div class="row">
    <div class="col-md-5 mb-3">
      <label for="etat_{$numeroBon}" class="form-label"
        >État de l'appareil</label
      >
      <textarea class="form-control" id="etat_{$numeroBon}" rows="2" readonly>
{$travail.etat}</textarea
      >
    </div>

    <div class="col-md-5 col-sm-10 mb-3">
      <label for="remarque_{$numeroBon}" class="form-label"
        >Remarques du technicien</label
      >
      <textarea
        class="form-control"
        id="remarque_{$numeroBon}"
        name="remarque_{$numeroBon}"
        rows="2"
        readonly
      >
{$travail.remarque}</textarea
      >
    </div>
    <div class="col-md-2 mt-5 col-3">
      <button
        type="button"
        class="btn btn-warning btn-interaction w-100"
        data-numerobon="{$numeroBon}"
        data-iduser="{$idUser}"
        title="Interactions avec le client"
      >
        <i class="fa fa-phone" aria-hidden="true"></i>
        <span data-numerobon="{$numeroBon}" class="idInt"
          >{$interactions4bons.$numeroBon|default:''}</span
        >
      </button>
    </div>

      <div class="form-group pb-3 col-4 col-md-4">
      <label for="dateSortie_{$numeroBon}">Sortie le</label>
      <input
        type="date"
        class="form-control"
        name="dateSortie_{$numeroBon}"
        id="dateSortie_{$numeroBon}"
        readonly
        value="{$travail.dateSortie|default:''}"
        placeholder="Date de sortie"
      />
    </div>

    <div class="form-group pb-3 col-4">
      <label for="apayer_{$numeroBon}">À payer</label>

      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">€</span>
        </div>
        <input
          type="text"
          class="form-control"
          id="apayer_{$numeroBon}"
          name="apayer_{$numeroBon}"
          value="{$travail.apayer|default:''}"
          readonly
        />
      </div>
    </div>
    
    <div class="col-md-3 pb-3 col-6">
      <label for="avancement">Avancement</label>
      <button
        type="button"
        class="btn btn-success btn-avancement w-100"
        data-numerobon="{$numeroBon}"
        data-iduser="{$idUser}"
        id="avancement"
        title="Avancement du travail"
      >
        <i class="fa fa-hand-o-right" aria-hidden="true"></i>
      </button>
    </div>

    <div class="col-md-3 col-6 pb-3 w100">

      <label for="termine">En cours / Terminé</label>
        
      {if $travail.termine == 1}
        <button type="button" title="Travail terminé" class="btn btn-success w-100 text-truncate">Terminé <i class="fa fa-smile-o" aria-hidden="true"></i></button>
        {else}
        <button type="button" title="Travail en cours" class="btn btn-danger w-100 text-truncate">En cours <i class="fa fa-meh-o" aria-hidden="true"></i></button>
        {/if}

    </div>

  </div>

  <!-- -------------------------------------------------------- -->

  <div
    class="btn-group btn-group-justified w-100"
    role="group"
    aria-label="btn-group"
  >
  
    <button
      type="button"
      class="btn btn-danger deleteBon w-25 mt-4 text-truncate"
      data-numerobon="{$numeroBon}"
      data-iduser="{$idUser}"
      title="Supprimer ce bon de réparation"
    >
      <i class="fa fa-exclamation-triangle" aria-hidden="true"></i> Supprimer
      ce bon <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    </button>
  

  
    <button
      type="button"
      data-numerobon="{$numeroBon}"
      class="btn btn-warning editBon w-75 mt-4 text-truncate"
      title="Modifier ce bon de réparation"
    >
      Modifier ce bon
    </button>
  

  </div>
</form>
