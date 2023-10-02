<button type="button" id="nouveauUser" class="btn btn-success text-truncate w-100">Nouvel Utilisaeur Oxfam</button>
<!-- sélecteur des utilisateurs -->
<select class="form-select mb-3" aria-label="Nouvel utilisateur" name="user" id="listeUsers" size="15">
    {foreach from=$listeUsers key=idOneUser item=user}
    <option value="{$idOneUser}" {if $idOneUser == $idUser}selected{/if}>{$user.nom} {$user.prenom}</option>
    {/foreach}
</select>

<button type="button" class="btn btn-danger text-truncate w-100" id="delUser">Supprimer cet utilisateur</button>