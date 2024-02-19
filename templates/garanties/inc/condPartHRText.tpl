
<div class="row">
  {if $type == 'CPAS'}
  <div class="col-6"><strong>Commune: </strong>{$texte.commune}</div>
  <div class="col-6"><strong>Montant alloué: </strong>{$texte.montant} €</div>
  <div class="col-6"><strong>Dossier: </strong>{$texte.dossier}</div>
  <div class="col-6">
    <strong>Décision du: </strong>
    {$texte.date|date_format:"d/m/Y"}
  </div>

  <div class="col-12"><strong>Remarque: </strong>{$texte.remarque}</div>
  {elseif $type == 'Facture'}
  <div class="col-12"><strong>Facture: </strong>{$texte.facture}</div>
  <div class="col-12"><strong>Remarque: </strong>{$texte.remarque}</div>

  {/if}
</div>
