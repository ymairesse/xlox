{if $idClient != Null}
<h2>
  Devis pour
  <u
    >[{if $identiteClient.civilite == 'F'}Mme{elseif $identiteClient.civilite ==
    'M'}M.{else} M./Mme {/if} {$identiteClient.prenom} {$identiteClient.nom}]</u
  >
</h2>

<div id="ficheDevis">
  <div class="row">
    <div class="w-75">
      <!-- 
          Onglets de navigation entre les différents bons de garantie
        -->
      <ul class="nav nav-tabs nav-justified" id="tabdevis" role="tablist">
        {foreach from=$listeDevis key=idDevis item=unDevis name=devis}

        <li
          class="nav-item"
          role="presentation"
          data-iddevis="{$idDevis}"
        >
          <div class="btn-group w-100">
            <button
              class="nav-link{if $smarty.foreach.devis.index == 0} active{/if}"
              id="devis_{$idDevis}-tab"
              data-bs-toggle="tab"
              data-bs-target="#devis_{$idDevis}"
              data-iddevis="{$idDevis}"
              type="button"
              role="tab"
              aria-controls="devis_{$idDevis}"
              aria-selected="{if $smarty.foreach.devis.index == 0}true{else}false{/if}"
              title="Devis {$unDevis.ref}"
            >
              Devis #{$unDevis.ref} du {$unDevis.date|date_format:"%d/%m/%Y"}
            </button>
          </div>
        </li>
        {/foreach}
      </ul>
    </div>
    <div class="w-25">
      <button
        class="btn btn-warning w-100"
        id="btn-addDevis"
        data-idclient="{$idClient}"
        title="Ajouter un devis"
      >
        <i class="fa fa-plus"></i> Devis
      </button>
    </div>
  </div>
  {/if}

  <div class="tab-content row">
    {if $listeDevis|count > 0} 

    {foreach from=$listeDevis key=idDevis item=unDevis name=devis}

    <div
      class="tab-pane {if $smarty.foreach.devis.index == 0} active{/if}"
      data-iddevis="{$idDevis}"
      id="devis_{$idDevis}"
      role="tabpanel"
      aria-labelledby="devis_{$idDevis}-tab"
    >
      <form
        class="formDevis px-2"
        id="formDevis_{$idDevis}"
        data-iddevis="{$idDevis}"
      >
        <div class="tableauDevis" data-iddevis="{$idDevis}">
          <!-- emplacement pour reconstruire le tableau des items de garantie -->

          {include file='devis/inc/tableauItems.tpl'} 
          
          {include file='devis/inc/boutonsEditDelPrint.tpl'}
        </div>
      </form>
    </div>

    {/foreach}
     {else} 
      
      {if $idClient == Null}
    <h1 class="null">Aucun client sélectionné</h1>
    {else}
    <h1 class="null">Pas de devis pour ce client</h1>
    {/if} 
  
  {/if}
  </div>
</div>
