<div class="btn-group w-100">
  <a href="#" class="btn btn-danger btn-delDevis"
    data-iddevis="{$idDevis}"
    data-idclient="{$idClient|default:''}"
    data-ref="{$unDevis.ref}"
    ><i class="fa fa-times"></i> Supprimer le devis #{$unDevis.ref}</a
  >

  <a
    type="button"
    class="btn btn-warning btn-editDevis"
    data-idclient="{$idClient|default:''}"
    data-iddevis="{$idDevis}"
    title="Édition du devis"
  >
    <i class="fa fa-edit"></i> Modifier le devis #{$unDevis.ref}
  </a>

  <a
    type="button"
    class="btn btn-success btn-print"
    href="inc/devis/getDevisPDF.php?idDevis={$idDevis}"
    target="_blank"
    data-iddevis="{$idDevis}"
    title="Impression PDF"
  >
    <i class="fa fa-print"> </i> Imprimer le devis #{$unDevis.ref}
  </a>
</div>
