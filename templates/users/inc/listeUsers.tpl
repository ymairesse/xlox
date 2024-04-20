<button 
    type="button" 
    id="btn-newUser" 
    class="btn btn-success text-truncate w-100"
    data-toggle="tooltip"
    title="Créer un nouvel utilisateur de l'application"
    >Nouvel Utilisateur Oxfam</button>

<label for="listeUsers">Liste des utilisateurs Oxfam</label>

<table class="table table-sm w-100" id="listeUsers">

    <tr>
        <th class="w-75">Nom</th>
        <th class="w-25">Droits</th>
    </tr>
        <!-- L'utlisateur actif ne peut modifier son propre profil -->
    {foreach from=$listeUsers key=idOneUser item=user}

        <tr class="{if $idOneUser == $idUser}choosen{/if}" data-iduser="{$idOneUser}">
            <td
                data-toggle="tooltip"
                title="Nom et prénom de cet utilisateur"
            >{$user.nom} {$user.prenom}</td>
            <td
                data-toggle="tooltip"
                title="Droits pour cet utilisateur"
            >{$user.droits}</td>
        </tr>

    {/foreach}

</table>

<button 
    type="button" 
    class="btn btn-danger text-truncate w-100" 
    id="btn-delUser"
    data-toggle="tooltip"
    title="Supprimer cet utilisateur de l'application"
    >Supprimer cet utilisateur</button>