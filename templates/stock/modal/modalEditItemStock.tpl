<div
  class="modal fade"
  id="modalEditItemStock"
  data-bs-backdrop="static"
  data-bs-keyboard="false"
  tabindex="-1"
  aria-labelledby="modalEditItemStockLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 w-100" id="modalEditItemStockLabel">
          Item stock
        </h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <form autocomplete="false" id="modalFormItemStock">
          <input
            type="hidden"
            name="idMateriel"
            value="{$itemStock.idMateriel|default:''}"
          />
          <div class="row">
            <div class="form-group pb-3 col-6">
              <label for="marque"> Marque </label>
              <input
                type="text"
                class="form-control"
                name="marque"
                id="marque"
                value="{$itemStock.marque|default:''}"
                placeholder="Marque"
                required
              />
            </div>

            <div class="form-group pb-3 col-6">
              <label for="modele"> Modèle </label>
              <input
                type="text"
                class="form-control"
                name="modele"
                id="modele"
                value="{$itemStock.modele|default:''}"
                placeholder="Modèle"
                required
              />
            </div>
          </div>
          <div class="row">
            <div class="form-group pb-3 col-9">
              <label for="caracteristiques"> Caractéristiques </label>
              <input
                type="text"
                class="form-control"
                name="caracteristiques"
                id="caracteristiques"
                value="{$itemStock.caracteristiques|default:''}"
                placeholder="Caractéristiques"
                required
              />
            </div>

            <div class="form-group pb-3 col-3">
              <label for="prix">Prix</label>
              <div class="input-group">
                <input
                  type="text"
                  id="prix"
                  name="prix"
                  class="form-control"
                  placeholder="Prix"
                  aria-label="Prix"
                  aria-describedby="basic-addon1"
                  value="{$itemStock.prix|default:''}"
                />
                <div class="input-group-append">
                  <span class="input-group-text" id="basic-addon">€</span>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Annuler
        </button>
        <button type="button" class="btn btn-primary" id="btn-saveItemStock">
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
    $("#modalFormItemStock").validate({
      lang: "fr",
      errorElement: "div",
      errorPlacement: function (error, element) {
        if (element.parent().hasClass("input-group")) {
          error.insertAfter(element.parent());
        } else {
          error.insertAfter(element);
        }
      },
      rules: {
        marque: {
          required: true,
        },
        modele: {
          required: true,
        },
        caracteristiques: {
          required: true,
        },
        prix: {
          digits: true,
          required: true,
        },
      },
    });
  });
</script>
