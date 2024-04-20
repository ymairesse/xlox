 <div style="max-height: 25em; overflow: auto">
  <h5>Garanties anonymes</h5>

  <table class="table table-sm w-100 mh-100" id="listeGarantiesAnonymes">
    <thead>
    <tr>
      <th class="w-25">Date</th>
      <th class="w-75">Ticket</th>
    </tr>
  </thead>
  <tbody>
    {foreach from=$listeBonsGarantie key=unTicketCaisse item=data}
    <tr
      class="{if $data.ticketCaisse == $ticketCaisse} choosen{/if}"
      data-ticketcaisse="{$unTicketCaisse}"
    >
    <td 
      title="Date de la vente:   {$data.date|date_format:'%d/%m/%Y'}"
      data-toggle="tooltip"
      >
      {$data.date|date_format:"%d/%m/%y"}
    </td>
    <td       
      title="Ticket de caisse n° {$unTicketCaisse}"
      data-toggle="tooltip"
      >
      {$unTicketCaisse|number_format:0:'.':' '}
    </td>
    </tr>
    {/foreach}
  </tbody>
  </table>

</div>

<button 
  type="button" 
  class="btn btn-warning w-100" 
  id="btn-addGarantieAnonyme"
  data-toggle="tooltip"
  title="Créer un nouveau bon de garantie"
  ><i class="fa fa-plus"></i> bon de garantie</button>

<script>

  $(document).ready(function(){

    $('[data-toggle="tooltip"]').tooltip();

  })


</script>