<select name="typeMateriel" 
    id="typeMateriel" 
    class="form-control"
    required
    >
    <option value="">Sélectionner</option>
    {foreach from=$listeMateriel key=id item=materiel} 
      <option value="{$id}"{if ($id == $idMatos)} selected{/if}>{$materiel}</option>
    {/foreach}
</select>