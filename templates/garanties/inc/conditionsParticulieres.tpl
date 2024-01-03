<div class="row pb-3">
<div class="col-3">
    <button
    type="button"
    class="btn btn-warning w-100"
    id="btn-conditionsPart"
    data-ticketcaisse="{$ticketCaisse}"
  >
    Conditions particulières (CPAS,...) >>
  </button>

</div>
<div class="col-9 condPart"">

    <textarea 
        class="form-control" 
        class="condPart"
        data-ticketcaisse="{$ticketCaisse}" 
        rows="3"
        readonly
        >{$listeBonsGarantie.$ticketCaisse.condPart}</textarea>

</div>


</div>