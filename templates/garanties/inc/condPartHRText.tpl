<div class="row">
  {if $typeCondPart == 'CPAS'}
  <div class="col-6" data-toggle="tooltip" title="Bon émis par le CPAS de la commune">
    <strong>Commune: </strong>{$formulaire.commune|default:''}
  </div>
  <div class="col-6" data-toggle="tooltip" title="Montant du bon">
    <strong>Montant alloué: </strong>{$formulaire.montant|default:''} €
  </div>
  <div class="col-6" data-toggle="tooltip" title="Numéro du dossier">
    <strong>Dossier: </strong>{$formulaire.dossier|default:''}
  </div>
  <div class="col-6" data-toggle="tooltip" title="Date de la décision d'octroi du bon">
    <strong>Décision du: </strong>
    {$formulaire.date|date_format:"d/m/Y"|default:''}
  </div>

  <div class="col-12" data-toggle="tooltip" title="Remarque complémentaire">
    <strong>Remarque: </strong>{$formulaire.remarque|default:''}
  </div>
  {elseif $typeCondPart == 'Facture'}
  <div class="col-12" data-toggle="tooltip" title="Une facture acquitée est demandée">
    <strong>Facture: </strong>{$formulaire.facture|default:''}
  </div>
  <div class="col-12" data-toggle="tooltip" title="Autre condition particulière">
    <strong>Remarque: </strong>{$formulaire.remarque|default:''}
  </div>

  {/if}
</div>
