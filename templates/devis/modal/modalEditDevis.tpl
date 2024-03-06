<div
  class="modal fade"
  id="modalEditDevis"
  data-bs-backdrop="static"
  data-bs-keyboard="false"
  tabindex="-1"
  aria-labelledby="modalEditDevisLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 w-100" id="modalEditDevisLabel">
          {if isset($dataDevis.idDevis)} Édition du devis
          #{$dataDevis.ref} {else} Nouveau devis
          {/if}
        </h1>

        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <form id="modalFormDevis" autocomplete="off">
          <input
            type="hidden"
            name="idClient"
            id="idClient"
            value="{$idClient}"
          />
          <input type="hidden" name="idDevis" id="idDevis"
          value={$dataDevis.idDevis|default:''}>

          <div class="row">
            <div class="form-group pb-3 col-6">
              <label for="refDevis">Référence (non modifiable)</label>
              <input
                type="text"
                class="form-control"
                name=""
                id="refDevis"
                value="{if isset($dataDevis.ref)}{$dataDevis.ref}{else}{$smarty.now|date_format:'%Y.%m'}...{/if}"
                readonly
              />
              
              {if !(isset($dataDevis.idDevis))}
              <span class = "help-block">
              Cette référence sera précisée à l'enregistrement.
              </span>
              {/if}
            </div>

            <div class="form-group pb-3 col-6">
              <label for="dateDevis">Date</label>
              <input
                type="date"
                class="form-control"
                name="dateDevis"
                id="dateDevis"
                value="{if isset($dataDevis.date)}{$dataDevis.date}{else}{$smarty.now|date_format:'%Y-%m-%d'}{/if}"
              />
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="btn-saveDevis">
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

  input:read-only {
    color: #aaa;
} 

  .visu {
    background-color: #ffef007a;
  }
</style>

<script>
  $(document).ready(function () {
    $("#modalFormDevis").validate({
      lang: "fr",
      errorElement: "div",
      rules: {
        date: {
          required: true,
          date: true,
        },
      },
    });
  });
</script>
