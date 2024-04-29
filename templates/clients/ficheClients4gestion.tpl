<div class="row">
  <div class="col-xl-3 col-12" id="zoneGauche">
    {include file='inc/selecteurClients.tpl'}

    <div class="btn-group w-100" role="group">
      <button
        type="button"
        id="nouveauClientPrive"
        data-typeclient="prive"
        class="btn btn-success text-truncate nouveauClient"
        data-toggle="tooltip"
        title="Création d'un nouveau client Privé"
      >
        <i class="fa fa-plus"></i> Client Privé
      </button>
      <button
        type="button"
        id="nouveauClientEntreprise"
        data-typeclient="entreprise"
        class="btn btn-primary text-truncate nouveauClient"
        data-toggle="tooltip"
        title="Création d'un nouveau client Entreprise"
      >
        <i class="fa fa-plus"></i> Client Entreprise
      </button>
    </div>
  </div>

  <div class="col-xl-9 col-12" id="ficheProfilClient">
    {include file='clients/ficheProfilClient.tpl'}
  </div>
</div>

<script>
  $(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();
  });
</script>
