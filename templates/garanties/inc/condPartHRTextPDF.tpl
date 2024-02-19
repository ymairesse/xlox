<table class="table table-condensed" style="width: 100%">
  {if $type == 'CPAS'}
  <tr>
    <td style="width: 50%"><strong>Commune:</strong> {$texte.commune}</td>
    <td style="width: 50%">
      <strong>Montant alloué: </strong> {$texte.montant} €
    </td>
  </tr>
  <tr>
    <td style="width: 50%"><strong>Dossier: </strong> {$texte.dossier}</td>
    <td style="width: 50%">
      <strong>Décision du </strong> {$texte.date|date_format:"d/m/Y"}
    </td>
  </tr>
  <tr>
    <td colspan="2" style="width: 100%">
      <strong>Remarque: </strong> {$texte.remarque}
    </td>
  </tr>
  <tr>
    <td colspan="2" style="width:100%; height: 25px">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" style="width: 100%; height: 25px">
      <strong>Date et signature pour enlèvement: </strong> _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
    </td>
  </tr>

  {elseif $type == 'Facture'}
  <tr>
    <td style="width: 100%"><strong>Facture:</strong> {$texte.facture}</td>
  </tr>
  <tr>
    <td style="width: 100%"><strong>Remarque: </strong> {$texte.remarque}</td>
  </tr>

  {/if}
</table>
