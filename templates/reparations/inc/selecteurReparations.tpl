<div style="max-height: 25em; overflow: auto">
  <h5 class="scrollReparations">
    Liste des réparations
    <span class="text-bg-warning">
      {if $travailTermine == 1} terminées {else} en cours{/if}</span
    >
  </h5>

  <table class="table table-sm w-100 mh-100" id="listeReparations">
    <tr>
      {if $travailTermine != 1}
      <th style="width: 1em">&nbsp;</th>
      {/if}
      <th style="width: 5em">Fiche n°</th>
      <th>Matériel</th>
      <th style="width: 1em">&nbsp;</th>
    </tr>
    {foreach from=$listeReparations key=unNumeroBon item=materiel}
    <tr
      class="{if $unNumeroBon == $numeroBon}choosen{/if}"
      data-numerobon="{$unNumeroBon}"
      data-nom="{$materiel.civilite} {$materiel.prenom} {$materiel.nom}"
    >
    <!-- 
    Le bouton de clôture d'une fiche n'apparaît que dans la liste des travaux en cours (pas terminés, donc) 
    -->
    {if $travailTermine != 1}
      <td
        title="Clôturer le bon {$unNumeroBon|string_format:'%05d'}"
        data-toggle="tooltip"
      >
        <span
          class="badge bg-danger btn-closeBon"
          data-iduser="{$materiel.idUser}"
          data-numerobon="{$unNumeroBon}"
        >
          <i class="fa fa-check-square-o" aria-hidden="true"></i>
        </span>
      </td>
      {/if}
      <td>[{$unNumeroBon|string_format:"%05d"}]</td>

      <td
        title="{$materiel.civilite} {$materiel.nom} {$materiel.prenom}"
        data-toggle="tooltip"
      >
        {$materiel.type} <strong>{$materiel.nom}</strong>
      </td>
      <td>
        <span
          class="badge bg-success btn-searchClient"
          data-iduser="{$materiel.idUser}"
          data-numerobon="{$unNumeroBon}"
        >
          <i class="fa fa-user"></i>
        </span>
      </td>
    </tr>
    {/foreach}
  </table>
</div>

<script>
  $(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();
  });
</script>
