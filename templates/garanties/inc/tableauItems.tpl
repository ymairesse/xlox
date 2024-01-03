<table class="table table-condensed table-striped w-100">
  <thead>
    <tr>
      <th style="width: 2em">&nbsp;</th>
      <th>Marchandise</th>
      <th>Réf. OX</th>
      <th>Réf. ext.</th>
      <th>Remarque</th>
      <th>Date</th>
      <th style="width: 6em">Prix</th>
      <th style="width: 5em">&nbsp;</th>
    </tr>
  </thead>

  <tbody>
    <!-- Calcul du montant total de l'achat  (initialisation)      -->
    {assign var=total value=0 scope="global"} 
    
    {if isset($uneGarantie.items)}

    {foreach from=$uneGarantie.items key=idItem item=unItem name=boucle}

    <tr
      data-ticketcaisse="{$ticketCaisse}"
      data-iditem="{$idItem}"
      data-idclient="{$idClient}"
    >
      <td>
        <button
          type="button"
          class="btn btn-danger btn-sm delItemGarantie"
          title="Supprimer cet item"
        >
          <i class="fa fa-scissors" aria-hidden="true"></i>
        </button>
      </td>
      <td class="materiel">{$unItem.materiel}</td>
      <td>{$unItem.ox}</td>
      <td>{$unItem.ref}</td>
      <td>{$unItem.remarque}</td>
      <td>{$uneGarantie.date|date_format:"%d/%m/%Y"}</td>
      <td>{$unItem.prix} {if $unItem.prix != ''}€{/if}</td>
      <td>
        <button
          type="button"
          class="btn btn-primary btn-sm btn-editItem w-100"
          data-idclient="{$idClient}"
          data-ticketcaisse="{$ticketCaisse}"
        >
          <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
        </button>
      </td>
    </tr>

    {assign var=total value=$total + $unItem.prix} 
    
    {/foreach} 
    
    {/if}
  </tbody>

  <tfoot>
    <tr>

      <th colspan="5">&nbsp;</th>
      <th class="d-flex justify-content-end">Total:</th>
      <th>{$total|default:''} €</th>
      <th>
        <button
          type="button"
          class="btn btn-warning btn-sm w-100 btn-addItem"
          title="Ajouter un article"
          data-idclient="{$idClient}"
          data-ticketcaisse="{$ticketCaisse}"
        >
          <i class="fa fa-plus"></i>
        </button>
      </th>
    </tr>
  </tfoot>
</table>
