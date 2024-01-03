<!--  Enfant de "ficheTravail.tpl " -->
<!--  Ceci est la page contenant une fiche de travail -->
<div
  class="tab-pane fade {if $smarty.foreach.bons.index == 0}show active{/if}"
  id="bon_{$numeroBon}"
  data-numerobon="{$numeroBon}"
  role="tabpanel"
  aria-labelledby="bon_{$numeroBon}"
>
<!-- formTravail.tpl est le formulaire fictif qui présente les informations -->
<!-- de chaque fiche de travail                                             -->

  {include file="reparations/formTravail.tpl"}

</div>
