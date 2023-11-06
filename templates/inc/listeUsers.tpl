<button type="button" id="btn-newUser" class="btn btn-success text-truncate w-100">Nouvel Utilisateur Oxfam</button>

<label for="listeUsers">Liste des utilisateurs Oxfam</label>

<table class="table table-sm w-100" id="listeUsers">

    <tr>
        <th class="w-75">Nom</th>
        <th class="w-25">Droits</th>
    </tr>
    {foreach from=$listeUsers key=idOneUser item=user}

        {if $idOneUser != $idUserSelf}
        <tr class="{if $idOneUser == $idUser}choosen{/if}" data-iduser="{$idOneUser}">
            <td>{$user.nom} {$user.prenom}</td>
            <td>{$user.droits}</td>
        </tr>
        {/if}

    {/foreach}

</table>

<button type="button" class="btn btn-danger text-truncate w-100" id="btn-delUser">Supprimer cet utilisateur</button>