
{if $numeroBon != Null}

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->

<!-- formulaire fictif dont tous les champs sont désactivés -->
<!-- cliquer dans un champ pour faire apparaître une boîte  -->
<!-- modale dans laquelle se fera l'édition                 -->

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx-->
{if $nomClient == 'true'}
<h2>Fiche de travail #<u>{$numeroBon}</u> [{$dataClient.civilite|default:'M./Mme'} {$dataClient.nom} {$dataClient.prenom}]</h2>
{/if}

<form
  class="formTravail px-2"
  id="formTravail_{$numeroBon}"
  data-numerobon="{$numeroBon}"
>
  <input type="hidden" name="numeroBon" value="{$travail.numeroBon}" />
  <input type="hidden" name="idClient" value="{$travail.idUser}" />

  <div class="row">
    <div class="form-group pb-3 col-md-3 col-4">
      <label for="type_{$numeroBon}">Type</label>
      <input
        type="text"
        class="form-control openModalTravail"
        name="type_{$numeroBon}"
        id="type_{$numeroBon}"
        readonly
        value="{$travail.type|default:''}"
        placeholder="Type d'appareil"
      />
    </div>

    <div class="form-group pb-3 col-md-3 col-4">
      <label for="marque_{$numeroBon}">Marque</label>
      <input
        type="text"
        class="form-control openModalTravail"
        name="marque{$numeroBon}"
        id="marque_{$numeroBon}"
        readonly
        value="{$travail.marque|default:''}"
        placeholder="Modèle"
      />
    </div>

    <div class="form-group pb-3 col-md-3 col-4">
      <label for="modele_{$numeroBon}">Modèle</label>
      <input
        type="text"
        class="form-control openModalTravail"
        name="modele{$numeroBon}"
        id="modele_{$numeroBon}"
        readonly
        value="{$travail.modele|default:''}"
        placeholder="Modèle"
      />
    </div>
    <div class="form-group pb-3 col-md-3 col-4">
      <label for="dateEntree_{$numeroBon}">Date de réception</label>
      <input
        type="date"
        class="form-control openModalTravail"
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
        class="form-control openModalTravail"
        name="benevole_{$numeroBon}"
        id="benevole_{$numeroBon}"
        readonly
        value="{$travail.benevole|default:$benevole.prenom}"
        placeholder="Reçu par"
      />
    </div>

    <div class="form-group pb-3 col-md-3 col-4">
      <label for="ox_{$numeroBon}">Num. OX</label>
      <div class="input-group mb-3">
        <span class="input-group-text d-none d-lg-block" id="addonOX">OX</span>
        <input
          type="text"
          class="form-control openModalTravail"
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

    <div class="form-group pb-3 col-md-3 col-4">
      <label for="mdp_{$numeroBon}"><span class="{if $travail.mdp == ''}strike{/if}">Mot de passe</span></label>
      <div class="input-group mb-3">
        
        <button style="width:20%" type="button" class="btn btn-sm btn-outline-secondary showHiddenMdp"><i class="fa fa-eye"></i></button>
        <span class="hiddenMdp openModalTravail" id="mdp_{$numeroBon}" style="width:80%; padding-left: 5px;">{$travail.mdp|default:''}</span>

      </div>
    </div>

    <div class="col-md-3 form-group pb-3 col-4">
      <label for="data_{$numeroBon}">Données</label>
      {if $travail.data == 1}
      <button
        type="button"
        title="Données à conserver"
        class="btn btn-danger w-100 text-truncate openModalTravail"
        id="data_{$numeroBon}"
      >
        <i class="fa fa-warning" aria-hidden="true"></i> Données
        <i class="fa fa-warning" aria-hidden="true"></i>
      </button>
      {else}
      <button
        type="button"
        title="Pas de données"
        class="btn btn-default w-100 text-truncate openModalTravail"
        id="data_{$numeroBon}"
      >
        No Data
      </button>
      {/if}
    </div>

    <div class="form-group pb-3 col-md-8 col-12">
      <h5>Accessoires déposés</h5>

      {foreach from=$allAccessoires key=idAccessoire item=data}

      <div class="form-check form-check-inline openModalTravail">
        <input class="form-check-input" type="checkbox"
        name="{$data}_{$numeroBon}" id="{$data}_{$numeroBon}"
        value="{$idAccessoire}" {if in_array($idAccessoire,
        array_keys($listeAccessoires.$numeroBon))} checked {/if} readonly />

        <label class="form-check-label">{$data}</label>
      </div>
      {/foreach}
    </div>

    <div class="col-6 mb-3">
      <label class="form-label">Problème technique</label>
      <textarea
        class="form-control openModalTravail"
        id="probleme_{$numeroBon}"
        rows="3"
        readonly
      >
{$travail.probleme}</textarea
      >
    </div>

    <div class="col-6 mb-3">
      <label for="etat_{$numeroBon}" class="form-label"
        >État à la réception</label
      >
      <textarea
        class="form-control openModalTravail"
        id="etat_{$numeroBon}"
        rows="2"
        readonly
        openModalTravail
      >
{$travail.etat}</textarea
      >
    </div>

    <div class="col-6 mb-3">
      <label class="form-label">Solution & devis</label>
      <textarea
        class="form-control openModalTravail"
        id="devis_{$numeroBon}"
        rows="3"
        readonly
        openModalTravail
      >
{$travail.devis}</textarea
      >
    </div>

    <div class="col-6 mb-3">
      <label for="remarque_{$numeroBon}" class="form-label"
        >Remarques technicien</label
      >
      <textarea
        class="form-control openModalTravail"
        id="remarque_{$numeroBon}"
        name="remarque_{$numeroBon}"
        rows="2"
        readonly
      >
{$travail.remarque}</textarea
      >
    </div>

    <div class="pb-3 col-2 col-md-3">
      <label for="avancement_{$numeroBon}">Avancement</label>
      <button
        type="button"
        class="btn btn-success btn-avancement w-100"
        id="avancement_{$numeroBon}"
        data-numerobon="{$numeroBon}"
        title="Avancement du travail"
      >
        <i class="fa fa-hand-o-right" aria-hidden="true"></i>
        <span data-numerobon="{$numeroBon}" class="idAv"
          >{$avancements4bons.$numeroBon|default:''}</span
        >
      </button>
    </div>

    

    <div class="form-group pb-3 col-4 col-md-2">
      <label for="dateSortie_{$numeroBon}">Sortie le</label>
      <input
        type="date"
        class="form-control openModalTravail"
        name="dateSortie_{$numeroBon}"
        id="dateSortie_{$numeroBon}"
        readonly
        value="{$travail.dateSortie|default:''}"
        placeholder="Date de sortie"
      />
    </div>

    <div class="pb-3 col-4 col-md-2">
      <label for="garantie_{$numeroBon}">Garantie</label>
      <button
        type="button"
        id="garantie_{$numeroBon}"
        class="btn btn-garantie w-100 openModalTravail {if $travail.garantie == 1}btn-warning{else}btn-default{/if}"
      >
        {if $travail.garantie == 0}<s>Garantie</s>{else}Garantie{/if}
      </button>
    </div>

    <div class="form-group pb-3 col-5 col-md-2">
      <label for="apayer_{$numeroBon}">À payer</label>

      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">€</span>
        </div>
        <input
          type="text"
          class="form-control openModalTravail"
          id="apayer_{$numeroBon}"
          name="apayer_{$numeroBon}"
          value="{if ($travail.apayer == 0)}
           &nbsp;
           {else} 
            {$travail.apayer}
            {/if}"
          readonly
        />
      </div>
    </div>

    <div class="pb-3 col-2 col-md-3 w100">
      <label for="termine_{$numeroBon}"
        >{if $travail.termine == 1}Terminé{else}En cours{/if}</label
      >

      {if $travail.termine == 1}
      <button
        type="button"
        title="Travail terminé"
        class="btn btn-success w-100 text-truncate openModalTravail"
        id="termine_{$numeroBon}"
      >
        Terminé <i class="fa fa-smile-o" aria-hidden="true"></i>
      </button>
      {else}
      <button
        type="button"
        title="Travail en cours"
        class="btn btn-danger w-100 text-truncate openModalTravail"
        id="termine_{$numeroBon}"
      >
        En cours <i class="fa fa-meh-o" aria-hidden="true"></i>
      </button>
      {/if}
    </div>

  </div>

  {include file="reparations/inc/boutonsEditDelPrint.tpl"}

</form>


{else}

<h1 class="null">Aucune fiche sélectionnée</h1>

{/if}

<script>
  $("document").ready(function () {
    $(".form-check-input").click(function () {
      // pour empêcher la prise en compte du clic sur une case à cocher
      return false;
    });
  });
</script>
