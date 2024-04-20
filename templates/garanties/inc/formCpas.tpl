<div class="row">

  <div class="col-6 pb-3">
    <label class="form-label" for="commune">Commune</label>
    <input
      type="text"
      class="form-control"
      name="commune"
      id="commune"
      value="{$texte.commune|default:''}"
      placeholder="Commune"
    />
  </div>

  <div class="col-6 pb-3">
    <label for="date">Date du document CPAS</label>
    <input
      type="date"
      class="form-control"
      id="date"
      name="date"
      value="{$texte.date|default:''}"
      placeholder="Date CPAS"
    />
  </div>

  <div class="col-6 pb-3">
    <label for="dossier" class="form-label">Dossier</label>
    <input
      type="text"
      class="form-control"
      name="dossier"
      id="dossier"
      value="{$texte.dossier|default:''}"
      placeholder="Référence du dossier CPAS"
    />
  </div>

  <div class="col-6 pb3">
    <label for="montant" class="form-label">Montant alloué</label>
    <input
      type="text"
      class="form-control"
      id="montant"
      name="montant"
      value="{$texte.montant|default:''}"
      placeholder="Montant alloué"
    />
  </div>

  <div class="col-12 pb-3">
    <label for="remarque" class="form-label"
      >Différence payée par le client / remarque</label
    >
    <input
      type="text"
      class="form-control"
      id="remarque"
      name="remarque"
      value="{$texte.remarque|default:''}"
      placeholder="Ajouté par le client"
    />
  </div>
</div>
