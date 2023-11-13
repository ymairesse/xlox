<div style="max-height: 25em; overflow: auto">
  <h5 for="listeClients" class="w-100">
    Liste des clients
    <div class="btn-group float-end">
      <button
        class="btn btn-sm btn-sort py-0 {if isset($sortClient) && ($sortClient == 'parDate')}btn-primary{else}btn-default{/if}"
        id="clientParDate"
        title="Par date"
      >
        <i class="fa fa-calendar" aria-hidden="true"></i>
      </button>
      <button
        class="btn btn-sm btn-sort py-0 {if isset($sortClient) && ($sortClient == 'alphaAsc')}btn-primary{else}btn-default{/if}"
        id="clientAlphaAsc"
        title="Par ordre alphabétique ASC"
      >
        <i class="fa fa-sort-alpha-asc" aria-hidden="true"></i>
      </button>
      <button
        class="btn btn-sm btn-sort py-0 {if isset($sortClient) && ($sortClient == 'alphaDesc')}btn-primary{else}btn-default{/if}"
        id="clientAlphaDesc"
        title="Par ordre alphabétique DESC"
      >
        <i class="fa fa-sort-alpha-desc" aria-hidden="true"></i>
      </button>
    </div>
  </h5>

  <table
    class="table table-sm w-100"
    id="listeClients"
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
</div>


<script>
  var tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
  );
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });
</script>
