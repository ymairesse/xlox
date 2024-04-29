{if $idClient != Null}
<h2>
  Garanties pour
  <u
    >[{if $identiteClient.civilite == 'F'}Mme{elseif $identiteClient.civilite ==
    'M'}M.{else} M./Mme {/if} {$identiteClient.prenom} {$identiteClient.nom}]</u
  >
</h2>

<div id="ficheGarantie">
  <div class="row">
    <div class="w-75">
      <!-- 
          Onglets de navigation entre les différents bons de garantie
        -->
      <ul class="nav nav-tabs nav-justified" id="tabGaranties" role="tablist">
        {foreach from=$listeBonsGarantie key=ticketCaisse item=uneGarantie
        name=garanties}
        <li
          class="nav-item"
          role="presentation"
          data-ticketcaisse="{$ticketCaisse}"
        >
          <div class="btn-group w-100">
            <button
              class="nav-link{if $smarty.foreach.garanties.index == 0} active{/if}"
              id="ticket_{$ticketCaisse}-tab"
              data-bs-toggle="tab"
              data-bs-target="#ticket_{$ticketCaisse}"
              data-ticketcaisse="{$ticketCaisse}"
              type="button"
              role="tab"
              aria-controls="ticket_{$ticketCaisse}"
              aria-selected="{if $smarty.foreach.garanties.index == 0}true{else}false{/if}"
              title="Ticket de caisse numéro {$ticketCaisse}"
            >
              #{$ticketCaisse}
            </button>
          </div>
        </li>
        {/foreach}
      </ul>
    </div>
    <div class="w-25">
      <button
        class="btn btn-warning w-100"
        id="btn-addBonGarantie"
        data-idclient="{$idClient}"
        title="Ajouter un bon de garantie pour ce client"
        data-toggle="tooltip"
      >
        <i class="fa fa-plus"></i> bon de garantie
      </button>
    </div>
  </div>
  {/if}

  <div class="tab-content row">
    {if $listeBonsGarantie|count > 0} 
    
    {foreach from=$listeBonsGarantie key=ticketCaisse item=uneGarantie name=garanties}

    <!-- La première fiche de garantie est active par défaut (pourra être modifié ensuite) -->
    <div
      class="tab-pane {if $smarty.foreach.garanties.index == 0} active{/if}"
      data-ticketcaisse="{$ticketCaisse}"
      id="ticket_{$ticketCaisse}"
      role="tabpanel"
      aria-labelledby="ticket_{$ticketCaisse}-tab"
    >
      <form
        class="formGarantie px-2"
        id="formGarantie_{$ticketCaisse}"
        data-ticketcaisse="{$ticketCaisse}"
      >
        <div class="tableauGarantie" data-ticketcaisse="{$ticketCaisse}">
          <!-- emplacement pour reconstruire le tableau des items de garantie -->

          <!-- le template reçoit $uneGarantie -->
          {include file='garanties/inc/tableauItems.tpl'} 

          {include file='garanties/inc/conditionsParticulieres.tpl'} 


          {include file='garanties/inc/boutonsEditDelPrint.tpl'}
        </div>
      </form>
    </div>

    {/foreach} {else} {if $idClient == Null}
    <h1 class="null">Aucun client sélectionné</h1>
    {else}
    <h1 class="null">Pas de garantie pour ce client</h1>
    {/if} {/if}
  </div>
</div>


<script>

  $(document).ready(function(){

    $('[data-toggle="tooltip"]').tooltip();

  })

</script>