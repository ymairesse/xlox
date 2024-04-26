<!-- ******************************************** -->
<!-- sélecteur des clients ci-dessous             -->
<!-- peut être précédé et/ou suivi par            -->
<!-- des boutons d'action (ajout, delClient)      -->
<!-- ******************************************** -->

<h5 class="boutonsTri">

  <button type="button" class="btn btn-sm btn-primary py-0" data-toggle="tooltip" title="Retour au client sélectionné">
   <i class="fa fa-eye"></i>
  </button> 
  Liste des clients
  <div class="btn-group float-end">
    <button
      class="btn btn-sm btn-sort clientParDate py-0 {if isset($sortClient) && ($sortClient == 'parDate')}btn-primary{else}btn-default{/if}"
      title="Tri par date (les plus récents en haut)"
      
    >
      <i class="fa fa-calendar" aria-hidden="true"></i>
    </button>
    <button
      class="btn btn-sm btn-sort clientAlphaAsc py-0 {if isset($sortClient) && ($sortClient == 'alphaAsc')}btn-primary{else}btn-default{/if}"
      title="Tri ar ordre alphabétique ASC"
      
    >
      <i class="fa fa-sort-alpha-asc" aria-hidden="true"></i>
    </button>
    <button
      class="btn btn-sm btn-sort clientAlphaDesc py-0 {if isset($sortClient) && ($sortClient == 'alphaDesc')}btn-primary{else}btn-default{/if}"
      title="Tri par ordre alphabétique DESC"
      
    >
      <i class="fa fa-sort-alpha-desc" aria-hidden="true"></i>
    </button>
  </div>
</h5>

{include file="inc/tableClients.tpl"}

<script>

$(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();

  });
</script>
