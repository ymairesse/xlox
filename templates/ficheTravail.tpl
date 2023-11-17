<h2>Travaux en cours</h2>

<div class="container-fluid" id="ficheTravail">
  <div class="row">
    <div class="w-75">
          
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
              Bon [{$noBon|string_format:"%05d"}] 
            </button>
            <a type="button" 
              class="btn btn-primary btn-print{if $smarty.foreach.bons.index != 0} isDisabled{/if}"
              {if $smarty.foreach.bons.index == 0}
              href="inc/getFicheTravailPDF.php?numeroBon={$noBon}"
              {/if}
              data-numerobon="{$noBon}" 
              ><i class="fa fa-print"></i> 
            </a>
          </div>
        </li>
        {/foreach}
      </ul>

    </div>
    
    <div class="w-25">
      <button type="button" class="btn btn-success w-100 text-truncate" id="btn-addBon" {if $idClient == Null}disabled{/if}>
      Ajouter fiche de travail
      </button>
    </div>
  </div>

  <div class="tab-content row" id="tabBonsContent">
    {foreach from=$listeBons key=numeroBon item=travail name=bons} 
    <div class="col-12">
      {include file='inc/unBon.tpl'} 
    </div>
    {/foreach}
  </div>
</div>

{if $listeBons == Null}
<h1 id="travauxEnCours" class="void">Pas de travaux en cours</h1>
{/if}


