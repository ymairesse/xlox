<div class="btn-group w-100">
  <a
  type="button"
  class="btn btn-danger deleteBon mb-4"
  data-numerobon="{$travail.numeroBon}"
  data-idclient="{$travail.idUser}"
  data-choice="{$choice}"
  data-toggle="tooltip"
  title="Supprimer le bon de réparation"
>
  <i class="fa fa-exclamation-triangle" aria-hidden="true"></i> Supprimer la fiche #{$travail.numeroBon|string_format:"%05d"}
</a>

  <a
    type="button"
    class="btn btn-warning openModalTravail mb-4"
    title="Édition de la fiche"
    data-toggle="tooltip"
  >
    <i class="fa fa-edit"></i> Modifier la fiche #{$travail.numeroBon|string_format:"%05d"}
  </a>

  <a type="button" 
  class="btn btn-success mb-4"
    href="inc/reparations/getFicheTravailPDF.php?numeroBon={$travail.numeroBon}"
    data-numerobon="{$travail.numeroBon}" 
    title="Impression au format PDF"
    data-toggle="tooltip">
  <i class="fa fa-print"></i> Imprimer la fiche #{$travail.numeroBon|string_format:"%05d"}
</a>
</div>