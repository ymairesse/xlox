<!-- ******************************************** -->
<!-- sélecteur des clients ci-dessous             -->
<!-- peut être précédé et/ou suivi par            -->
<!-- des boutons d'action (ajout, delClient)      -->
<!-- ******************************************** -->

<h5 class="boutonsTri">

  <button type="button" class="btn btn-sm btn-primary py-0">
   <i class="fa fa-eye"></i>
  </button> 
  Liste des clients
  <div class="btn-group float-end">
    <button
      class="btn btn-sm btn-sort clientParDate py-0 {if isset($sortClient) && ($sortClient == 'parDate')}btn-primary{else}btn-default{/if}"
      title="Par date"
    >
      <i class="fa fa-calendar" aria-hidden="true"></i>
    </button>
    <button
      class="btn btn-sm btn-sort clientAlphaAsc py-0 {if isset($sortClient) && ($sortClient == 'alphaAsc')}btn-primary{else}btn-default{/if}"
      title="Par ordre alphabétique ASC"
    >
      <i class="fa fa-sort-alpha-asc" aria-hidden="true"></i>
    </button>
    <button
      class="btn btn-sm btn-sort clientAlphaDesc py-0 {if isset($sortClient) && ($sortClient == 'alphaDesc')}btn-primary{else}btn-default{/if}"
      title="Par ordre alphabétique DESC"
    >
      <i class="fa fa-sort-alpha-desc" aria-hidden="true"></i>
    </button>
  </div>
</h5>

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
