<h2>Garantie anonyme</h2>

<form
  class="formGarantie px-2"
>
<div class="row">
<div class="form-group pb-3 col-6">
    <label for="ticketCaisse">Ticket de caisse</label>
    <input
      type="number"
      class="form-control"
      name="ticketCaisse"
      id="ticketCaisse"
      value="{$dataGarantie.ticketCaisse|default:''}"
      placeholder="Numéro du ticket de caisse"
    />
  </div>

  <div class="form-group pb-3 col-6">
    <label for="date">Date</label>
    <input
      type="date"
      class="form-control"
      name="dateGarantie"
      id="dateGarantie"
      value="{$smarty.now|date_format:'%Y-%m-%d'}"
    />
  </div>

</div>

  <div
    class="tableauGarantie"
  >
    <!-- emplacement pour reconstruire le tableau des items de garantie -->

    {include file='garanties/inc/tableauItems.tpl'}
  </div>
</form>
