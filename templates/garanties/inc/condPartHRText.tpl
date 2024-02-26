<div class="row">
  {if $typeCondPart == 'CPAS'}
  <div class="col-6">
    <strong>Commune: </strong>{$formulaire.commune|default:''}
  </div>
  <div class="col-6">
    <strong>Montant alloué: </strong>{$formulaire.montant|default:''} €
  </div>
  <div class="col-6">
    <strong>Dossier: </strong>{$formulaire.dossier|default:''}
  </div>
  <div class="col-6">
    <strong>Décision du: </strong>
    {$formulaire.date|date_format:"d/m/Y"|default:''}
  </div>

  <div class="col-12">
    <strong>Remarque: </strong>{$formulaire.remarque|default:''}
  </div>
  {elseif $typeCondPart == 'Facture'}
  <div class="col-12">
    <strong>Facture: </strong>{$formulaire.facture|default:''}
  </div>
  <div class="col-12">
    <strong>Remarque: </strong>{$formulaire.remarque|default:''}
  </div>

  {/if}
</div>
