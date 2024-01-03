<div class="row">
  <div class="col-md-3 col-12" id="zoneGauche">
    <button
      type="button"
      id="nouveauClient"
      class="btn btn-success text-truncate w-100"
    >
      Nouveau Client
    </button>

    {include file='inc/selecteurClients.tpl'}

    <button
      type="button"
      id="delClient"
      class="btn btn-danger text-truncate w-100"
      {if ($idClient == Null)} disabled{/if}
    >
      Supprimer ce client
    </button>
  </div>

  <div class="col-md-9 col-12" id="ficheProfilClient">
    {include file='ficheProfilClient.tpl'}
  </div>
</div>
