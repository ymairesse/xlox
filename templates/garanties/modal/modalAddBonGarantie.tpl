<div
  class="modal fade"
  id="modalEditBonGarantie"
  data-bs-backdrop="static"
  data-bs-keyboard="false"
  tabindex="-1"
  aria-labelledby="modalEditBonGarantieLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 w-100" id="modalEditBonGarantieLabel">
          Nouveau bon de garantie
        </h1>

        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <form id="modalFormBonGarantie" autocomplete="off">
          <input
            type="hidden"
            name="idClient"
            id="idClient"
            value="{$idClient}"
          />

          <div class="row">
            <div class="form-group pb-3 col-6">
              <label for="ticketCaisse"
                >Ticket de caisse</label
              >
              <input
                type="text"
                class="form-control"
                name="ticketCaisse"
                id="ticketCaisse"
                maxlength="7"
                value="{if
              isset($dataGarantie.ticketCaisse)}{$dataGarantie.ticketCaisse}{/if}"
                placeholder="Numéro du ticket de caisse"
              />
            </div>

            <div class="form-group pb-3 col-6">
              <label for="dateGarantie">Date</label>
              <input
                type="date"
                class="form-control"
                name="dateGarantie"
                id="dateGarantie"
                value="{if isset($dataGarantie.date)}{$dataGarantie.date}{else}{$smarty.now|date_format:'%Y-%m-%d'}{/if}"
              />
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Annuler
        </button>
        <button type="button" class="btn btn-primary" id="btn-saveBonGarantie">
          Enregistrer
        </button>
      </div>
    </div>
  </div>
</div>

<style>
  div.error {
    color: red;
  }

  .visu {
    background-color: #ffef007a;
  }
</style>

<script>
  $(document).ready(function () {
    $("#modalFormBonGarantie").validate({
      lang: "fr",
      errorElement: "div",
      rules: {
        ticketCaisse: {
          required: true,
          maxlength: 7,
          number: true,
          remote: "inc/garanties/checkTicketUnique.php",
        },
        date: {
          required: true,
          date: true,
        },
      },
      messages: {
        ticketCaisse: {
          remote: "Un bon de garantie existe déjà pour ce ticket",
        },
      },
    });
  });
</script>
