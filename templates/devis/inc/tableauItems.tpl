<table class="table table-condensed table-striped">
  <thead>
    <tr>
      <th style="width: 2em">&nbsp;</th>
      <th>Dénomination</th>

      <th>Remarque</th>
      
      <th style="width: 6em">Prix</th>
      <th style="width: 5em">&nbsp;</th>
    </tr>
  </thead>

  <tbody>
    <!-- Calcul du montant total de l'achat  (initialisation)      -->
    {assign var=total value=0 scope="global"}

    {if isset($unDevis.items)}

      {foreach from=$unDevis.items key=idItem item=unItem name=boucle}

        <tr data-iddevis="{$idDevis}" data-iditem="{$idItem}" data-idclient="{$idClient}">
          <td>
            <button type="button" class="btn btn-danger btn-sm delItemDevis" title="Supprimer cet item">
              <i class="fa fa-scissors" aria-hidden="true"></i>
            </button>
          </td>
          <td class="materiel">{$unItem.materiel}</td>

          <td>{$unItem.remarque}</td>
          
          <td>{$unItem.prix} {if $unItem.prix != ''}€{/if}</td>
          <td>
            <button type="button" class="btn btn-primary btn-sm btn-editItemDevis w-100" data-idclient="{$idClient}"
              data-iddevis="{$idDevis}">
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

      <th colspan="2">&nbsp;</th>
      <th class="d-flex justify-content-end">Total:</th>
      <th>{$total|default:''} €</th>
      <th>
        <button type="button" class="btn btn-warning btn-sm w-100 btn-addItemDevis" title="Ajouter un article"
          data-idclient="{$idClient}" data-iddevis="{$idDevis}">
          <i class="fa fa-plus"></i>
        </button>
      </th>
    </tr>
  </tfoot>
</table>