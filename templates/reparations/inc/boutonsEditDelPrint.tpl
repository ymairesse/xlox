<div class="btn-group w-100">
  <a
  type="button"
  class="btn btn-danger deleteBon mb-4"
  data-numerobon="{$numeroBon}"
  data-idclient="{$travail.idUser}"
  title="Supprimer le bon de réparation"
>
  <i class="fa fa-exclamation-triangle" aria-hidden="true"></i> Supprimer la fiche #{$noBon|string_format:"%05d"}
</a>

  <a
    type="button"
    class="btn btn-warning openModalTravail mb-4"
    title="Édition de la fiche"
  >
    <i class="fa fa-edit"></i> Modifier la fiche #{$noBon|string_format:"%05d"}
  </a>

  <a type="button" 
  class="btn btn-success mb-4"
    href="inc/reparations/getFicheTravailPDF.php?numeroBon={$noBon}"
    data-numerobon="{$noBon}" >
  <i class="fa fa-print"></i> Imprimer la fiche #{$noBon|string_format:"%05d"}
</a>
</div>
