<table class="items" style="width: 100%">
  <thead>
    <tr class="inverse">
      <th style="width: 50%; text-align:center;">Description</th>
      <th style="width: 30%;">Remarque</th>
      
      <th style="width: 20%">Prix</th>
    </tr>
  </thead>
  <tbody>
    <!-- calcul du prix total -->
    {assign var=total value=0} 

    {foreach from=$listeItems key=id item=unItem name=boucle}
    <tr>
      <td style="width: 50%; text-align:left;">
        <p>{$unItem.materiel|regex_replace:"/[\r\n]/" : "<br />"}</p>
      </td>
      <td style="width: 25%; text-align:left;">
        <p>{$unItem.remarque|regex_replace:"/[\r\n]/" : "<br />"}</p>
      </td>
      
      <td style="text-align: right; width: 10%">{$unItem.prix} €</td>
    </tr>
    {assign var=total value = $total + $unItem.prix} {/foreach}
    <tr>
      <td colspan="2" style="text-align: right; width: 15%">Total&nbsp;</td>
      <td style="text-align: right"><strong>{$total} €</strong></td>
    </tr>
  </tbody>
</table>

<style>
  table.items {
    border-collapse: collapse;
  }
  table.items td,
  table.items tr,
  table.items th {
    border: 1px solid grey;
    font-size: 9pt;
    text-align:center;
  }


li::before {
  display:          inline-block;
  vertical-align:   middle;
  width:            2px;
  height:           2px;
  background-color: #000000;
  content:          '.'
}
</style>
