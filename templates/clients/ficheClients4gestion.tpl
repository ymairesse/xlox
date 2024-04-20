{debug}
<div class="row">
  <div class="col-xl-3 col-12" id="zoneGauche">

    {include file='inc/selecteurClients.tpl'}

    <button
      type="button"
      id="nouveauClient"
      class="btn btn-warning text-truncate w-100"
      data-toggle="tooltip" 
      title="Création d'un nouveau client"
    >
      <i class="fa fa-plus"></i> Nouveau Client
    </button>

  </div>

  <div class="col-xl-9 col-12" id="ficheProfilClient">
    {include file='clients/ficheProfilClient.tpl'}
  </div>
</div>

<script>

$(document).ready(function(){

  $('[data-toggle="tooltip"]').tooltip();

})

</script>