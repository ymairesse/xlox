<form id="formTravail">
  <div class="container-fluid">
    <div class="row">
      <div class="w-75">
        <ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
          {foreach from=$listeBons key=numeroBon item=travail name=bons}
          <li class="nav-item" role="presentation">
            
              <button
                class="nav-link {if $smarty.foreach.bons.index == 0}active{/if}"
                id="bon_{$numeroBon}-tab"
                data-bs-toggle="tooltip"
                data-bs-target="#bon_{$numeroBon}"
                data-numerobon="{$numeroBon}"
                type="button"
                role="tab"
                aria-selected="{if $smarty.foreach.bons.index == 0}true{else}false{/if}"
              >
                Bon [{$numeroBon|string_format:"%05d"}]
              </button>
            
          </li>
          {/foreach}
        </ul>
      </div>
      <div class="w-25">
        <button type="button" class="btn btn-success w-100" id="btn-addBon" {if $idUser == Null}disabled{/if}>
          Ajouter
        </button>
      </div>
    </div>

    <div class="tab-content" id="myTabContent">
      {foreach from=$listeBons key=numeroBon item=travail name=bons}
        
        {include file='inc/unBon.tpl'}

      {/foreach}
    </div>
  </div>
</form>

{if $listeBons == Null}
  <h1 id="travauxEnCours" class="void">Pas de travaux en cours</h1>  
{/if}

<style>
  #formTravail .nav-link.active {
    background-color: #f99 !important;
    color: #666;
  }

  #formTravail .nav-link {
    background-color: #99f;
    color: #666;
  }

</style>

<script>

  $(document).ready(function(){

    var tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
    );
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
    });

  })

</script>