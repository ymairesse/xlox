{if $listeMarchandises != Null}
<div class="input-group">
  <button class="btn btn-warning btn-pasteMarchandise" type="button"><i class="fa fa-angle-down"></i></button>
  <select  id="marchandises" class="form-control">
    <option value="">Selectionner une marchandise</option>
    {foreach from=$listeMarchandises key=id item=marchandise}
    <option value="{$id}">{$marchandise.marque} &nbsp; {$marchandise.modele} &nbsp; {$marchandise.caracteristiques} : {$marchandise.prix} €</option>
    {/foreach}
  </select>
</div>
{/if}

<style>
  #marchandises {
    height: 24px;
    font-size: 14px;
    padding: 0 10px;
  }

  .btn-pasteMarchandise {
    height: 24px;
    font-size: 14px;
    padding: 0 10px;
  }
</style>

