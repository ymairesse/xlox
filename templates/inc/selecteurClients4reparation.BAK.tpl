<label for="listeClients" class="w-100">Liste des clientsssss 
    <div class="btn-group float-end">
      <button class="btn btn-sm btn-sort py-0 {if $sortClient == 'parDate'}btn-primary{else}btn-default{/if}" id="clientParDate" data-bs-toggle="tooltip" data-bs-title="Par date"><i class="fa fa-calendar" aria-hidden="true"></i></button>
      <button class="btn btn-sm btn-sort py-0 {if $sortClient == 'alphaAsc'}btn-primary{else}btn-default{/if}" id="clientAlphaAsc" data-bs-toggle="tooltip" data-bs-title="Par ordre alphabétique ASC"><i class="fa fa-sort-alpha-asc" aria-hidden="true"></i></button>
      <button class="btn btn-sm btn-sort py-0 {if $sortClient == 'alphaDesc'}btn-primary{else}btn-default{/if}" id="clientAlphaDesc" data-bs-toggle="tooltip" data-bs-title="Par ordre alphabétique DESC"><i class="fa fa-sort-alpha-desc" aria-hidden="true"></i></button>
    </div>
  </label>

<!-- sélecteur des utilisateurs -->
<select class="form-select mb-3 {$mode}" name="selectClients" id="selectClients" size="{$selectHeight|default:1}">
    {foreach from=$listeClients key=idOneClient item=client}
    <option value="{$idOneClient}" {if $idOneClient == $idClient}selected{/if}>{$client.nom} {$client.prenom}</option>
    {/foreach}
</select>


<script>
    $(document).ready(function () {



      var tooltipTriggerList = [].slice.call(
        document.querySelectorAll('[data-bs-toggle="tooltip"]')
      );
      var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
      });
    });
  </script>