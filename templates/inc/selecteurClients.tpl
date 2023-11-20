<div class="selecteurClients" style="max-height: 25em; overflow: auto">
  <h5>
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

  {include file="inc/tableClients.tpl"}

</div>

