<!-- Modal -->
<div
  class="modal fade"
  id="modalEditItem"
  data-bs-backdrop="static"
  data-bs-keyboard="false"
  tabindex="-1"
  aria-labelledby="modalEditItemLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 w-100" id="modalEditItemLabel">
          Édition d'un item garantie ticket # {$ticketCaisse|number_format:0:'.':' '}
        </h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <form id="formModalEditItem" autocomplete="off">
          <input
            type="hidden"
            name="idItem"
            value="{$dataItem.id|default:''}"
          />
          <input 
            type="hidden" 
            name="ticketCaisse" 
            id="ticketCaisse"
            value="{$ticketCaisse}" />
          <input type="hidden" name="idClient" id="idClient" value="{$idClient|default:''}" />

          <div class="row">
            <div class="form-group pb-3 col-8">
              <label class="w-100" for="materiel"
                >Marchandise
              </label>

              <input
                type="text"
                class="form-control"
                name="materiel"
                id="materiel"
                maxlength="100"
                value="{$dataItem.materiel|default:''}"
                placeholder="Dénomination du matériel"
              />

              <div class="modalSelectMarchandise">
                {include file="garanties/inc/tableMarchandises.tpl"}
              </div>
            </div>

            <div class="form-group pb-3 col-4">
              <label for="prix"></label>
              <div class="input-group">
                <input
                  type="text"
                  id="prix"
                  name="prix"
                  class="form-control"
                  placeholder="Prix"
                  aria-label="Prix"
                  aria-describedby="basic-addon1"
                  value="{$dataItem.prix|default:''}"
                />
                <div class="input-group-append">
                  <span class="input-group-text" id="basic-addon1">€</span>
                </div>
              </div>
            </div>

            <div class="col-6 form-group pb-3">
              <label for="ox">Numero OX</label>
              <div class="input-group mb-3">
                <span class="input-group-text">OX</span>
                <input
                  type="text"
                  class="form-control"
                  name="ox"
                  id="ox"
                  value="{$dataItem.ox|default:''}"
                  maxlength="6"
                  placeholder="Num OX"
                  autocomplete="off"
                />
              </div>
            </div>

            <div class="col-6 form-group pb-3">
              <label for="ref">Ref. Externe</label>

              <input
                type="text"
                class="form-control"
                name="ref"
                id="ref"
                value="{$dataItem.ref|default:''}"
                maxlength="30"
                placeholder="Ref ext."
                autocomplete="off"
              />
            </div>

            <div class="pb-3 col-12 form-group">
              <label for="remarque">Remarque</label>
              <input
                type="text"
                class="form-control"
                name="remarque"
                id="remarque"
                maxlength="100"
                value="{$dataItem.remarque|default:''}"
                placeholder="Remarque état du matériel"
              />
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Annuler
        </button>
        <button type="button" class="btn btn-primary" id="btn-saveItemGarantie">
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
    $("#formModalEditItem").validate({
      lang: "fr",
      errorElement: "div",
      rules: {
        materiel: {
          required: true,
          maxlength: 100,
        },
        prix: {
          required: true,
          number: true,
          maxlength: 4,
        },
      },
      errorPlacement: function (error, element) {
        if (element.parent().hasClass("input-group")) {
          error.insertAfter(element.parent());
        } else {
          error.insertAfter(element);
        }
      },
    });
  });
</script>
