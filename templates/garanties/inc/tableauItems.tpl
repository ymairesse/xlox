<!--
  L'élément $uneGarantie est du type
Array
(
    [ticketCaisse] => 1007457 
    [idClient] => 60 
    [date] => 2024-02-19
    [items] => Array
        (
            [66] => Array
                (
                    [id] => 66
                    [ticketCaisse] => 1007457
                    [ox] => 
                    [ref] => 
                    [materiel] => Fujitsu E736 I3 13.3" 8GB 256GB SSD
                    [prix] => 150
                    [remarque] => 
                )

        )

    [condPart] => Array
        (
            [typeCondPart] => CPAS
            [texte] => Array
                (
                    [commune] => Anderlecht
                    [date] => 2024-02-02
                    [dossier] => S456789
                    [montant] => 300
                    [remarque] => 
                )

        )

)

-->

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
      <td class="materiel">{$unItem.materiel|default:''}</td>
      <td>{$unItem.ox|default:''}</td>
      <td>{$unItem.ref|default:''}</td>
      <td>{$unItem.remarque|default:''}</td>
      <td>{$uneGarantie.date|date_format:"%d/%m/%Y"|default:''}</td>
      <td>{$unItem.prix|default} {if $unItem.prix|default:'' != ''}€{/if}</td>
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

    {assign var=total value=$total + $unItem.prix|default:0} 
    
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
