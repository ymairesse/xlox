<!-- Informations nécessaires:                                   -->
<!-- data-mode (gestion, reparation, ...) pour pouvoir choisir   -->
<!-- le comportement du widget au click sur une ligne du tableau -->
<!-- le $idClient actuellement sélectionné                       -->
<!-- la liste des clients                                        -->
<!-- la table elle-même pourra à la demande être subsituée par   -->
<!-- une autre qui sera insérée dans le div.tableClients         -->
<div class="tableClients" style="max-height: 25em; overflow: auto">

  <!-- LA TABLE DES CLIENTS                                      -->
  <table
    class="table table-sm w-100 listeClients"
    data-mode="{$mode|default:''}"
  >
    <tr>
      <th class="w-75">Nom</th>
      <th
        class="w-25"
        title="Date du dernier accès"
      >
        Date
      </th>
    </tr>
    {foreach from=$listeClients key=idOneClient item=client}
    <tr
      {if $idOneClient == $idClient}class="choosen"{/if}
      data-idclient="{$idOneClient}"
      data-nom="{$client.nom}"
      data-toggle="tooltip"
      data-bs-html="true"
      title="{$client.civilite} {$client.nom} {$client.prenom}<br>Dernier accès le {$client.date}"
    >
      <td>{$client.nom} {$client.prenom}</td>
      <td
        title="Date du dernier accès {$client.date} {$client.heure}"
      >
        {$client.date|substr:0:5}
      </td>
    </tr>
    {/foreach}
  </table>
  <!-- LA TABLE DES CLIENTS                                      -->
  
</div>
