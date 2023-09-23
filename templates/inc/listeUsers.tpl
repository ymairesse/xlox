<!-- sélecteur des utilisateurs -->
<select class="form-select mb-3" aria-label="Nouvel utilisateur" name="user" id="listeUsers" size="15">
    <option value="" {if $idUser == Null}selected{/if}>Nouvel utilisateur</option>
    {foreach from=$listeUsers key=idOneUser item=user}
    <option value="{$idOneUser}" {if $idOneUser == $idUser}selected{/if}>{$user.nom} {$user.prenom}</option>
    {/foreach}
</select>