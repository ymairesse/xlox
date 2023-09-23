<div
class="modal fade"
id="modalTest"
tabindex="-1"
aria-labelledby="modalInteractionLabel"
aria-hidden="true"
>
<div class="modal-dialog modal-xl">
  <div class="modal-content">
    <div class="modal-header">
      <h1 class="modal-title fs-5" id="modalInteractionLabel">
        Interactions avec le client
      </h1>
      <button
        type="button"
        class="btn-close"
        data-bs-dismiss="modal"
        aria-label="Close"
      ></button>
    </div>
    <div class="modal-body">
      <div class="row">

        <div class="col-lg-4 col">
          <form id="form-interactions">
            <input type="hidden" name="idUser" value="{$idUser}" />
            <input type="hidden" name="numeroBon" value="{$numeroBon}" />
            <div
              class="btn-group w-100"
              role="group"
              aria-label="Interactions"
            >
              <input
                type="radio"
                class="btn-check"
                name="typeInteraction"
                id="btnradio1"
                value="telephone"
                autocomplete="off"
                checked
              />
              <label
                class="btn btn-outline-primary"
                for="btnradio1"
                title="Par téléphone"
                ><i class="fa fa-phone" aria-hidden="true"></i>
              </label>

              <input
                type="radio"
                class="btn-check"
                name="typeInteraction"
                id="btnradio2"
                value="mail"
                autocomplete="off"
              />
              <label
                class="btn btn-outline-primary"
                for="btnradio2"
                title="Par mail"
                ><i class="fa fa-send" aria-hidden="true"></i>
              </label>

              <input
                type="radio"
                class="btn-check"
                name="typeInteraction"
                id="btnradio3"
                value="magasin"
                autocomplete="off"
              />
              <label
                class="btn btn-outline-primary"
                for="btnradio3"
                title="Au magasin"
                ><i class="fa fa-user" aria-hidden="true"></i
              ></label>

              <input
                type="radio"
                class="btn-check"
                name="typeInteraction"
                id="btnradio4"
                value="repondeur"
                autocomplete="off"
              />
              <label
                class="btn btn-outline-primary"
                for="btnradio4"
                title="Répondeur"
                ><i class="fa fa-hashtag" aria-hidden="true"></i
              ></label>
            </div>

            <div class="mb-3">
              <label for="date" class="form-label">Date & heure</label>
              <input
                type="datetime-local"
                class="form-control"
                id="date"
                name="date"
                value="{$dateInteraction}"
              />
            </div>

            <div class="mb-3">
              <label for="note" class="form-label">Note</label>
              <textarea
                class="form-control"
                id="note"
                name="note"
                rows="4"
              ></textarea>
            </div>

            <button
              type="button"
              class="btn btn-warning w-100"
              id="btn-saveInteraction"
              data-numerobon="{$numeroBon}"
              data-iduser="{$idUser}"
            >
              Enregistrer
            </button>
          </form>
        </div>
      </div>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
        Fermer
      </button>
    </div>
  </div>
</div>
</div>

<script>
$(document).ready(function () {
  $("#form-interactions").validate({
    rules: {
      date: "required",
      note: "required",
    },
  });
});
</script>
