<div style="max-height: 25em; overflow: auto">
  <h5>Liste des réparations en cours</h5>

  <table class="table table-sm w-100 mh-100" id="listeReparations">
    <tr>
      <th style="width: 1em">Fiche n°</th>
      <th>Matériel</th>
      <th style="width: 1em">&nbsp;</th>
    </tr>
    {foreach from=$listeReparations key=unNumeroBon item=materiel}
    <tr
      class="btn-numeroBon {if $unNumeroBon == $numeroBon}choosen{/if}"
      data-numerobon="{$unNumeroBon}"
    >
      <td>[{$unNumeroBon|string_format:"%05d"}]</td>

      <td>{$materiel.type} {$materiel.marque} {$materiel.modele}</td>
      <td>
        <span 
        class="badge bg-success btn-searchClient"
         data-iduser="{$materiel.idUser}"
         data-numerobon="{$unNumeroBon}"
         title="{$materiel.civilite} {$materiel.nom} {$materiel.prenom}">
         <i class="fa fa-user"></i>
        </span>

      </td>
    </tr>
    {/foreach}
  </table>
</div>
