{debug}
<table class="table table-condensed table-striped w-100">
    <thead>
      <tr>
        <th style="width: 2em">
          &nbsp;
        </th>
        <th>Marchandise</th>
        <th>Réf. OX</th>
        <th>Réf. ext.</th>
        <th>Remarque</th>
        <th>Date</th>
        <th style="width: 6em">Prix</th>
        <th style="width: 5em">
          &nbsp;
        </th>
      </tr>
    </thead>
    {assign var=total value=0 scope="global"} 
    <tbody>
      
      {if isset($items)}
      {foreach from=$items key=id item=data} 
      <tr data-iditem="{$data.id}"
        data-ticketcaisse="{$ticketCaisse}"
        >
        <td>
          <button type="button" class="btn btn-danger btn-sm delItemGarantie" title="Supprimer cet item">
            <i class="fa fa-scissors" aria-hidden="true"></i>
          </button>
        </td>
        <td class="materiel">{$data.materiel}</td>
        <td>{$data.ox}</td>
        <td>{$data.ref}</td>
        <td>{$data.remarque}</td>
        <td>{$garantie4ticket.date|date_format:"%d/%m/%y"}</td>
        <td>{$data.prix} €</td>
        <td>
          <button type="button" class="btn btn-primary btn-sm btn-editItem w-100" data-ticketcaisse="{$ticketCaisse}">
            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
          </button>
        </td>
      </tr>
      
      {assign var=total value=$total + $data.prix} 

      {/foreach}
      {/if}

    </tbody>
    <tfoot>
        <tr>
            <th colspan="5">&nbsp;</th>
            <th class="d-flex justify-content-end">Total:</th>
            <th>{$total} €</th>
            <th>
              <button
              type="button"
              class="btn btn-warning btn-sm w-100 btn-addItem"
              title="Ajouter un article"

              data-ticketcaisse="{$ticketCaisse}"
            >
              <i class="fa fa-plus"></i>
            </button>
        
            </th>
          </tr>

    </tfoot>

</table>