<div class="btn-group w-100">
  <a href="#" class="btn btn-danger btn-delGarantie"
    data-ticketcaisse="{$ticketCaisse}"
    data-idclient="{$idClient|default:''}"
    ><i class="fa fa-times"></i> Supprimer la garantie #{$ticketCaisse|number_format:0:'.':' '}</a
  >

  <a
    type="button"
    class="btn btn-warning btn-editBonGarantie"
    data-idclient="{$idClient|default:''}"
    data-ticketcaisse="{$ticketCaisse}"
    title="Édition de la garantie"
  >
    <i class="fa fa-edit"></i> Modifier la garantie #{$ticketCaisse|number_format:0:'.':' '}
  </a>

  <a
    type="button"
    class="btn btn-success btn-print"
    href="inc/garanties/getFicheGarantiePDF.php?ticketCaisse={$ticketCaisse}"
    target="_blank"
    data-ticketcaisse="{$ticketCaisse}"
    title="Impression PDF"
  >
    <i class="fa fa-print"> </i> Imprimer la garantie #{$ticketCaisse|number_format:0:'.':' '}
  </a>
</div>
