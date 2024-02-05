{if $listeMarchandises != Null}
<div class="input-group">
  <button class="btn btn-warning btn-pasteMarchandise" type="button">
    <i class="fa fa-angle-up"></i>
  </button>
  <select id="selectMarchandises" class="form-control">
    <option value="">Selectionner une marchandise</option>
    {foreach from=$listeMarchandises key=id item=marchandise}
    <option value="{$id}">
      {$marchandise.marque} &nbsp; {$marchandise.modele} &nbsp;
      {$marchandise.caracteristiques} : {$marchandise.prix} €
    </option>
    {/foreach}
  </select>
</div>
{/if}

<style>
  #selectMarchandises {
    height: 24px;
    font-size: 14px;
    padding: 0 10px;
    background-color: rgb(255, 212, 212);
    border: 1px solid #ccc;
  }

  .btn-pasteMarchandise {
    height: 24px;
    font-size: 14px;
    padding: 0 10px;
    background-color: rgb(255, 212, 212);
    border: 1px solid #ccc;
  }
</style>
