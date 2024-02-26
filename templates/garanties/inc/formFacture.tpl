<div class="row">

    <div class="col-12">
        <label for="facture" class="form-label"
          >Mention</label
        >
        <input
          type="text"
          class="form-control"
          id="facture"
          name="facture"
          value="{$texte.facture|default:'Facture acquitée demandée'}"
          placeholder="Demande de facture"
        />
      </div>

      <div class="col-12">
        <label for="remarque" class="form-label"
          >Remarque (optionnel)</label
        >
        <input
          type="text"
          class="form-control"
          id="remarque"
          name="remarque"
          value="{$texte.remarque|default:''}"
          placeholder="Remarque optionnelle"
        />
      </div>
</div>