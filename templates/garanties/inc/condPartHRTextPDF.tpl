<table class="table table-condensed" style="width: 100%">
  {if $typeCondPart == 'CPAS'}
  <tr>
    <td style="width: 50%"><strong>Commune:</strong> {$tableau.commune|default:''}</td>
    <td style="width: 50%">
      <strong>Montant alloué: </strong> {$tableau.montant|default:''} €
    </td>
  </tr>
  <tr>
    <td style="width: 50%"><strong>Dossier: </strong> {$tableau.dossier|default:''}</td>
    <td style="width: 50%">
      <strong>Décision du </strong> {$tableau.date|date_format:"d/m/Y"|default:''}
    </td>
  </tr>
  <tr>
    <td colspan="2" style="width: 100%">
      <strong>Remarque: </strong> {$tableau.remarque|default:''}
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

  {elseif $typeCondPart == 'Facture'}
  <tr>
    <td style="width: 100%"><strong>Facture:</strong> {$tableau.facture|default:''}</td>
  </tr>
  <tr>
    <td style="width: 100%"><strong>Remarque: </strong> {$tableau.remarque|default:''}</td>
  </tr>

  {/if}
</table>
