<table
    class="table table-sm w-100 listeClients"
    data-mode="{$mode|default:'gestion'}"
  >
    <tr>
      <th class="w-75">Nom</th>
      <th
        class="w-25"
        data-bs-toggle="tooltip"
        data-bs-title="Date du dernier accès"
      >
        Date
      </th>
    </tr>
    {foreach from=$listeClients key=idOneClient item=client}
    <tr
      class="{if $idOneClient == $idClient}choosen{/if}"
      data-idclient="{$idOneClient}"
      data-nom="{$client.nom}"
    >
      <td>{$client.nom} {$client.prenom}</td>
      <td
        data-bs-toggle="tooltip"
        data-bs-title="Date du dernier accès {$client.date} {$client.heure}"
      >
        {$client.date|substr:0:5}
      </td>
    </tr>
    {/foreach}
  </table>


