<div class="row">

    <div class="col-xl-3 col-12" id="zoneGauche">
        <!-- LE widget de sélection des clients  -->
        {include file='inc/selecteurClients.tpl'}
        
        <!-- associé à un bouton d'action-->
        <button type="button" class="btn btn-warning w-100" id="btn-findClient4travail"><i class="fa fa-plus"></i> Ajouter fiche de travail</button>

    </div>

    <div class="col-xl-9 col-12" id="fichesReparation">
        
        {include file='reparations/ficheTravail.tpl'}

    </div>

</div>