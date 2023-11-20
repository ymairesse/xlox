<!-- Modal -->
<div
  class="modal fade"
  id="modalSelectClient"
  
  data-bs-keyboard="true"
  tabindex="-1"
  aria-labelledby="modalSelectClientLabel"
  aria-hidden="true"
>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Sélection d'un client</h5>
          
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body conteneurClients" style="max-height: 25em; overflow: auto">

        {include file="inc/selecteurClients.tpl"}

      </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Annuler
        </button>
        <button type="button" class="btn btn-primary" id="btn-modalChooseClient">Choisir ce client</button>
      </div>
    </div>
  </div>
</div>

