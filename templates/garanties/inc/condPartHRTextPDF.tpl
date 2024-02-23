<table class="table table-condensed" style="width: 100%">
  {if $type == 'CPAS'}
  <tr>
    <td style="width: 50%"><strong>Commune:</strong> {$texte.commune|default:''}</td>
    <td style="width: 50%">
      <strong>Montant alloué: </strong> {$texte.montant|default:''} €
    </td>
  </tr>
  <tr>
    <td style="width: 50%"><strong>Dossier: </strong> {$texte.dossier|default:''}</td>
    <td style="width: 50%">
      <strong>Décision du </strong> {$texte.date|date_format:"d/m/Y"|default:''}
    </td>
  </tr>
  <tr>
    <td colspan="2" style="width: 100%">
      <strong>Remarque: </strong> {$texte.remarque|default:''}
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
    <td style="width: 100%"><strong>Facture:</strong> {$texte.facture|default:''}</td>
  </tr>
  <tr>
    <td style="width: 100%"><strong>Remarque: </strong> {$texte.remarque|default:''}</td>
  </tr>

  {/if}
</table>
