
<div style="max-height: 25em; overflow: auto">
    <h5>Liste des marchandises</h5>

    <table class="table table-condensed" id="selecteurStock" >
        <thead>
        <tr>
            <th>&nbsp;</th>
            <th>Marque</th>
            <th>Modèle</th>
            <th>Caractéristiques</th>
            <th>Prix</th>
            <th style="width:2em;"></th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$listeItemsStock key=unIdMateriel item=unItemStock} 
        <tr data-idmateriel="{$unIdMateriel}" class="{if $idMateriel == $unIdMateriel}choosen{/if}">
            <td><button type="button" class="btn btn-sm btn-danger btn-delItemStock">
                <i class="fa fa-scissors"></i>
            </button></td>
            <td>{$unItemStock.marque}</td>
            <td>{$unItemStock.modele}</td>
            <td>{$unItemStock.caracteristiques}</td>
            <td>{$unItemStock.prix} €</td>
            <td><button class="btn btn-sm btn-warning w-100 btn-editItemStock"><i class="fa fa-edit"></i> </button></td>
        </tr>

        {/foreach}
    </tbody>
    </table>


</div>

<button type=button" class="btn btn-warning w-100" id="btn-addItemStock"><i class="fa fa-plus"></i> Ajouter un matériel</button>

