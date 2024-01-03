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
    <td title="{$data.date|date_format:"%d/%m/%Y"}">{$data.date|date_format:"%d/%m/%y"}</td>
    <td>{$unTicketCaisse|number_format:0:'.':' '}</td>
    </tr>
    {/foreach}
  </tbody>
  </table>

  <button type="button" class="btn btn-warning w-100" id="btn-addGarantieAnonyme"><i class="fa fa-plus"></i> bon de garantie</button>

</div>

