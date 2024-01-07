<div
  class="modal fade"
  id="modalCondPart"
  data-bs-backdrop="static"
  data-bs-keyboard="false"
  tabindex="-1"
  aria-labelledby="modalCondPartLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 w-100" id="modalCondPartLabel">
          Conditions particulières # {$ticketCaisse|number_format:0:'.':' '}
        </h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>

      <div class="modal-body">
        <form id="formmodalCondPart">
          <input
            type="hidden"
            name="ticketCaisse"
            id="ticketCaisse"
            value="{$ticketCaisse}"
          />
          <div class="mb-3">
          <label for="typeCondPart" class="form-label">
            Conditions particulières de vente
          </label>
          <select class="form-select" 
          aria-label="Condition particulière" 
          name="typeCondPart" 
          id="typeCondPart"
          data-ticketcaisse="{$ticketCaisse}">
          <option value="">Aucune condition particulière</option>
          <option value="CPAS"{if $condPart.typeCondPart == 'CPAS'} selected{/if}>Bon CPAS</option>
          <option value="Facture"{if $condPart.typeCondPart == 'Facture'} selected{/if}>Facture acquitée demandée</option>
        </select>
      </div>

          <div class="mb-3">
            <label for="textCondPart" class="form-label"
              >Informations complémentaires</label
            >
            <textarea
              class="form-control"
              name="texte"
              id="textCondPart"
              rows="3"
            >
{$condPart.texte|default:''}</textarea
            >
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Annuler
        </button>
        <button
          type="button"
          class="btn btn-primary"
          id="btn-savemodalCondPart"
        >
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
