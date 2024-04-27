<h3>Liste des types d'accessoires</h3>
<table class="table table-condensed">
  <thead>
    <tr>
      <th style="width: 1em">&nbsp;</th>
      <th style="width: 40%">Item</th>
      <th style="width: 40%">Usage</th>
      <th style="width: 1em">&nbsp</th>
    </tr>
  </thead>
  <tbody>
    {foreach from=$listeAccessoires key=idAccessoire item=accessoire}
    <tr data-idaccessoire="{$idAccessoire}">
      <td  {if $accessoire.nb != 0} 
      title="Vous ne pouvez pas supprimer cet item (utilisé dans une ou plusieurs fiches de réparation)"
      data-toggle="tooltip"
      {/if}
      >
        <button
          type="button"
          data-toggle="tooltip"
          class="btn btn-sm btn-danger btn-delAccessoire"
          title="Supprimer cet item"
          {if $accessoire.nb != 0} disabled{/if}
        >
          <i class="fa fa-times"></i>
        </button>
      </td>
      <td>
        {$accessoire.accessoire}</td>
      <td>
        utilisé <strong>{$accessoire.nb}</strong> fois
      </td>
      <td>
        <button
          class="btn btn-warning btn-sm btn-editAccessoire"
          title="Modifier cet item"
          data-toggle="tooltip"
          data-nb="{$accessoire.nb}"
        >
          <i class="fa fa-edit"></i>
        </button>
      </td>
    </tr>
    {/foreach }
  </tbody>
</table>
<button
  type="button"
  class="btn btn-sm btn-warning w-100"
  id="btn-addAccessoire"
>
  <i class="fa fa-edit"></i>
  Ajouter un accessoire
</button>

<script>
  $(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();
  });
</script>
