<form
  class="formGarantie px-2"
  id="formGarantie_{$ticketCaisse}"
  data-ticketcaisse="{$ticketCaisse}"
>
<h2>Garantie pour le ticket de caisse # {$ticketCaisse|number_format:0:'.':' '}</h2>

  <div class="tableauGarantie" data-ticketcaisse="{$ticketCaisse}">
    <!-- emplacement pour reconstruire le tableau des items de garantie -->

    {include file="garanties/inc/tableauItemsAnonyme.tpl"}

    {include file='garanties/inc/boutonsEditDelPrint.tpl'}
  </div>
</form>


<script>

  $(document).ready(function(){

    $('[data-toggle="tooltip"]').tooltip();
    
  })

</script>