<div class="row pb-3">
  <div class="col-3">
    <button
      type="button"
      class="btn btn-warning w-100 editCondPart"
      data-ticketcaisse="{$ticketCaisse}"
    >
      {assign var=type value=$uneGarantie.condPart.typeCondPart|default:''} 
      {if $type == "CPAS"} 
        Bon CPAS 
      {elseif $type == "Facture"} 
        Facture acquitée demandée 
      {else} 
      Aucune condition particulière 
      {/if}
    </button>
  </div>
  
  <div class="col-9 condPart">

    <div class="p-2 texteCondPart" data-ticketcaisse="{$ticketCaisse}">
      {assign var=texte value=$uneGarantie.condPart.texte|default:''} 
      
      {include file="garanties/inc/condPartHRText.tpl"}
      
    </div>
  </div>
  
</div>
