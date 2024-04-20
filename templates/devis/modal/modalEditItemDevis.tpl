<!-- Modal -->
<div
  class="modal fade"
  id="modalEditItemDevis"
  data-bs-backdrop="static"
  data-bs-keyboard="false"
  tabindex="-1"
  aria-labelledby="modalEditItemDevisLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 w-100" id="modalEditItemDevisLabel">
          Édition d'un item, devis # {$idDevis|number_format:0:'.':' '}
        </h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <form id="formModalEditItemDevis" autocomplete="off">
          <input type="hidden" name="idItem" value="{$idItem|default:''}" />
          <input type="hidden" name="idDevis" value="{$idDevis|default:''}" />

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

            <div class="pb-3 col-12 form-group">
              <label for="remarque">Remarque</label>
              <input
                type="text"
                class="form-control"
                name="remarque"
                id="remarque"
                maxlength="100"
                value="{$dataItem.remarque|default:''}"
                placeholder="Remarque"
              />
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="btn-saveItemDevis">
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
    $("#formModalEditItemDevis").validate({
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
