<div
  class="modal fade"
  id="modalAvancement"
  tabindex="-1"
  aria-labelledby="modalAvancementLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="modalAvancementLabel">
          Avancement du travail
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
          <div
            class="col-lg-8 col"
            id="tableauAvancement"
            style="max-height: 20em; overflow: auto"
          >
            {include file='reparations/inc/tableAvancement.tpl'}
          </div>

          <div class="col-lg-4 col">
            <form id="form-avancement">
              <input type="hidden" name="numeroBon" value="{$numeroBon}" />
              <input type="hidden" name="idClient" value="{$idClient}" />

              <div class="mb-3">
                <label for="date" class="form-label">Date & heure</label>
                <input
                  data-bs-toggle="tooltip"
                  data-bs-title="L'heure sera fixée au moment de presser le bouton 'Enregistrer'"
                  type="text"
                  class="form-control"
                  id="date"
                  name="date"
                  value=""
                />
              </div>

              <div class="btn-group w-100">
                <input
                  type="radio"
                  class="btn-check"
                  name="interaction"
                  value=""
                  id="option1"
                  autocomplete="off"
                  checked
                />
                <label
                  class="btn btn-outline-primary"
                  data-bs-toggle="tooltip"
                  for="option1"
                  data-bs-title="Pas d'interaction client"
                  ><i class="fa fa-times"></i
                ></label>

                <input
                  type="radio"
                  class="btn-check"
                  name="interaction"
                  value="telephone"
                  id="option2"
                  autocomplete="off"
                />
                <label
                  class="btn btn-outline-primary"
                  data-bs-toggle="tooltip"
                  for="option2"
                  data-bs-title="Téléphone"
                  ><i class="fa fa-phone"></i
                ></label>

                <input
                  type="radio"
                  class="btn-check"
                  name="interaction"
                  value="mail"
                  id="option3"
                  autocomplete="off"
                />
                <label
                  class="btn btn-outline-primary"
                  data-bs-toggle="tooltip"
                  for="option3"
                  data-bs-title="Par mail"
                  ><i class="fa fa-send"></i
                ></label>

                <input
                  type="radio"
                  class="btn-check"
                  name="interaction"
                  value="magasin"
                  id="option4"
                  autocomplete="off"
                />
                <label
                  class="btn btn-outline-primary"
                  data-bs-toggle="tooltip"
                  for="option4"
                  data-bs-title="Au magasin"
                  ><i class="fa fa-user"></i
                ></label>

                <input
                  type="radio"
                  class="btn-check"
                  name="interaction"
                  value="repondeur"
                  id="option5"
                  autocomplete="off"
                />
                <label
                  class="btn btn-outline-primary"
                  data-bs-toggle="tooltip"
                  for="option5"
                  data-bs-title="Message sur répondeur"
                  ><i class="fa fa-hashtag"></i
                ></label>
              </div>

              <div class="mb-3">
                <label for="note" class="form-label">Note (max 200 caractères)</label>
                <textarea
                  class="form-control"
                  id="texte"
                  name="texte"
                  rows="4"
                ></textarea>
                <div class="help-block" id="maxCount">200 frappes</div>
              </div>

              <button
                type="button"
                class="btn btn-warning w-100"
                id="btn-saveAvancement"
                data-numerobon="{$numeroBon}"
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
  
  function charLimit(input, maxChar) {
    var x = $(input).val();
    var newLines = x.match(/(\r\n|\n|\r)/g);
    addition = 0;
    if (newLines != null) {
      addition = newLines.length;
    }
    
    if (x.length + addition > maxChar) {
      $(input).val($(input).val().substring(0, maxChar - addition));
      alert('Pas plus de 200 caractères');
    }
  }

  $(document).ready(function () {
    setInterval(() => $("#date").val(new Date().toLocaleString()), 1000);

    var tooltipTriggerList = [].slice.call(
      document.querySelectorAll('[data-bs-toggle="tooltip"]')
    );
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    $("#form-avancement").validate({
      rules: {
        texte: "required",
      },
    });

    $("#texte").on("input propertychange", function () {
      charLimit(this, 200);
      var x = $('#texte').val();
      var newLines = x.match(/(\r\n|\n|\r)/g);
        var addition = 0;
        if (newLines != null) {
            addition = newLines.length;
        }

      var nbChar = 200 - $(this).val().length - addition;
      $('#maxCount').text(nbChar + ' frappe(s)');
    });
  });
</script>
