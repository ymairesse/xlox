<select class="form-select mb-3" aria-label="Liste clients" name="client" id="listeClients">
    {foreach from=$listeClients key=unClient item=client}
    <option value="{$unClient}" {if $idClient == $unClient}selected{/if}>{$client.nom} {$client.prenom}</option>
    {/foreach}
</select>