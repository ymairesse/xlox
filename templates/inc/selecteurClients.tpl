<label for="selectClients {$mode|default:'gestion'}" class="w-100">Liste des clients
     <div class="btn-group float-end">
      <button 
        class="btn btn-sm btn-sort py-0 
        {if isset($sortClient) && ($sortClient == 'parDate')}btn-primary{else}btn-default{/if}" 
        id="clientParDate" 
        data-bs-toggle="tooltip" 
        data-bs-title="Par date"
        data-height = {$selectHeight}>
        <i class="fa fa-calendar" aria-hidden="true"></i>
      </button>
      <button 
        class="btn btn-sm btn-sort py-0 
        {if isset($sortClient) && ($sortClient == 'alphaAsc')}btn-primary{else}btn-default{/if}" 
        id="clientAlphaAsc" 
        data-bs-toggle="tooltip" 
        data-bs-title="Par ordre alphabétique ASC"
        data-height = {$selectHeight}>
        <i class="fa fa-sort-alpha-asc" aria-hidden="true"></i>
      </button>
      <button 
        class="btn btn-sm btn-sort py-0 
        {if isset($sortClient) && ($sortClient == 'alphaDesc')}btn-primary{else}btn-default{/if}" 
        id="clientAlphaDesc" 
        data-bs-toggle="tooltip" 
        data-bs-title="Par ordre alphabétique DESC"
        data-height = {$selectHeight}>
        <i class="fa fa-sort-alpha-desc" aria-hidden="true"></i>
      </button>
    </div>
  </label>

<!-- sélecteur des utilisateurs -->
<select class="form-select mb-3" data-mode="{$mode}" name="selectClients" id="selectClients" size="15">
    {foreach from=$listeClients key=idOneClient item=client}
    <option value="{$idOneClient}" {if $idOneClient == $idClient}selected{/if}>{$client.nom} {$client.prenom}</option>
    {/foreach}
</select>


<script>

  $(document).ready(function(){

    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))


    $(document).on('shown.bs.tooltip', function (e) {
      setTimeout(function () {
        $(e.target).tooltip('hide');
      }, 10000);
   });  

  })

</script>