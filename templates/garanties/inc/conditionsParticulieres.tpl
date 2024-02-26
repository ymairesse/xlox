

{assign var=typeCondPart value=$uneGarantie.condPart.typeCondPart}
{assign var=formulaire value=$uneGarantie.condPart.formulaire}


<div class="row pb-3">
  <div class="col-3">
    <button
      type="button"
      class="btn btn-warning w-100 btn-editCondPart"
      data-ticketcaisse="{$ticketCaisse}"
    >
      <i class="fa fa-edit"></i> 
      {if isset($typeCondPart)} 

      {if $typeCondPart == 'CPAS'} 
            Bon CPAS 
            {elseif $typeCondPart == 'Facture'} 
            Facture acquitée
        {/if}

      {else}
      Conditions Particulières de vente
      {/if}
    </button>
  </div>

  {if isset($formulaire)}
  <div class="col-9 condPart">
    <div class="p-2 texteCondPart" data-ticketcaisse="{$ticketCaisse}">


        {include file="garanties/inc/condPartHRText.tpl"}

    
      
    </div>
  </div>
  {/if}
</div>
