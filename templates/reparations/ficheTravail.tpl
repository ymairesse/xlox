<!--
  Liste des onglets pour présenter les différents "formTravail"
-->

<h2>Travaux en cours pour <u>[{if $identiteClient.civilite == 'F'}Madame{elseif $identiteClient.civilite == 'M'}Monsieur{else}M./Mme{/if} {$identiteClient.prenom} {$identiteClient.nom}]</u></h2>

<div id="ficheTravail">
  <div class="row">
    <div class="w-75">
        <!-- 
          Onglets de navigation entre les différentes fiches de travail   
        -->
      <ul class="nav nav-tabs nav-justified" id="tabBons" role="tablist">
        {foreach from=$listeBons key=noBon item=travail name=bons}

        <li class="nav-item" role="presentation">
          <div class="btn-group w-100">
            <button
              class="nav-link {if $smarty.foreach.bons.index == 0}active{/if}"
              id="bon_{$noBon}-tab"
              data-bs-toggle="tab"
              data-bs-target="#bon_{$noBon}"
              data-numerobon="{$noBon}"
              type="button"
              role="tab"
              aria-selected="{if $smarty.foreach.bons.index == 0}true{else}false{/if}"
            >
              Fiche [{$noBon|string_format:"%05d"}] 
            </button>
  
          </div>
        </li>

        {/foreach}
      </ul>

    </div>
    
    <div class="w-25">
      <button 
      type="button" 
      class="btn btn-warning w-100 text-truncate" 
      id="btn-addBon"
      data-toggle="tooltip"
      title="Ajouter une fiche de travail pour ce client"
       {if $idClient == Null}disabled{/if}>
      <i class="fa fa-plus"></i> Ajouter fiche de travail
      </button>
    </div>
  </div>

  <div class="tab-content row" id="tabBonsContent">

    <!-- ********************************************
      Liste des différentes formTravail  
    ************************************************* --> 
    {foreach from=$listeBons key=numeroBon item=travail name=bons} 
      
      <!-- onglet pour cette fiche de travail -->
      <div
      class="tab-pane fade {if $smarty.foreach.bons.index == 0}show active{/if}"
      id="bon_{$numeroBon}"
      data-numerobon="{$numeroBon}"
      role="tabpanel"
      aria-labelledby="bon_{$numeroBon}"
    >
    <!-- formTravail.tpl est le formulaire fictif qui présente les informations -->
    <!-- de chaque fiche de travail                                             -->
    
      {include file="reparations/formTravail.tpl"}
    
    </div>

    {/foreach}
  </div>
</div>

{if $listeBons == Null}
<h1 id="travauxEnCours" class="null">Pas de travaux en cours</h1>
{/if}


<script>

  $(document).ready(function () {
      $('[data-toggle="tooltip"]').tooltip();
    });
  </script>