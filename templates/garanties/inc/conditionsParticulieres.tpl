
<div class="row pb-3">
<div class="col-3">

    <button
    type="button"
    class="btn btn-warning w-100 editCondPart"
    id="btn-conditionsPart"
    data-ticketcaisse="{$ticketCaisse}"
  >
  {assign var=type value=$listeBonsGarantie.$ticketCaisse.condPart.typeCondPart|default:''} 
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

    <textarea 
        class="form-control editCondPart" 
        id="texteCondPart"
        name="texte"
        data-ticketcaisse="{$ticketCaisse}" 
        rows="3"
        readonly
        >{$listeBonsGarantie.$ticketCaisse.condPart.texte|default:''}</textarea>

</div>


</div>

