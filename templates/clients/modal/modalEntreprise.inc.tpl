<form autocomplete="off" id="modalFormClientEntreprise">
  <input 
    type="hidden" 
    name="idUser" 
    value="{$dataClient.idUser|default:''}" 
  />
  <input
    type="hidden"
    name="typeClient"
    value="{$typeClient|default:'entreprise'}"
  />
  <input 
    type="hidden"
    name="modified"
    id="modified"
    value="0"
  />

  <div class="row">
    <div
      class="form-group pb-3 col-12 col-md-12"
      data-bs-toggle="tooltip"
      data-bs-title="Nom de l'entreprise"
    >
      <label for="entreprise">Nom de l'entreprise</label>
      <input
        type="text"
        name="entreprise"
        id="entreprise"
        class="form-control facture reparation devis"
        value="{$dataClient.nom|default:''}"
        placeholder="Nom de l'entreprise"
      />
    </div>

    <div
      class="form-group pb-3 col-6 col-md-4"
      data-bs-toggle="tooltip"
      data-bs-title="Au moins l'un des deux (GSM ou téléphone)"
    >
      <label for="gsm"
        ><i class="fa fa-mobile" aria-hidden="true"></i>
        <span data-lang="fr">GSM</span>
      </label>
      <input
        type="text"
        class="form-control contact phone facture reparation"
        name="gsm"
        id="gsm"
        value="{$dataClient.gsm|default:''}"
        placeholder="GSM"
      />
    </div>

    <div
      class="form-group pb-3 col-6 col-md-4"
      data-bs-toggle="tooltip"
      data-bs-title="Au moins l'un des deux (GSM ou téléphone)"
    >
      <label for="telephone"
        ><i class="fa fa-phone" aria-hidden="true"></i>
        <span data-lang="fr">Téléphone</span>
      </label>
      <input
        type="text"
        class="form-control contact phone facture reparation"
        name="telephone"
        id="telephone"
        value="{$dataClient.telephone|default:''}"
        placeholder="Téléphone"
      />
    </div>

    <div
      class="form-group pb-3 col-6 col-md-4"
      data-bs-toggle="tooltip"
      data-bs-title="Adresse mail (pour l'envoi d'une facture)"
    >
      <label for="mail"
        ><i class="fa fa-send" aria-hidden="true"></i>
        <span data-lang="fr">Mail</span>
      </label>
      <input
        type="mail"
        class="form-control contact facture reparation"
        name="mail"
        id="mail"
        value="{$dataClient.mail|default:''}"
        placeholder="Adresse mail"
      />
    </div>

    <div
      class="form-group pb-3 col-6 col-md-5"
      data-bs-toggle="tooltip"
      data-bs-title="Adresse du siège de l'entreprise"
    >
      <label for="adresse">
        <span data-lang="fr">Adresse</span>
      </label>
      <input
        type="text"
        class="form-control devis facture"
        name="adresse"
        id="adresse"
        value="{$dataClient.adresse|default:''}"
        placeholder="Adresse rue / numéro"
      />
    </div>

    <div
      class="form-group pb-3 col-5 col-md-3"
      data-bs-toggle="tooltip"
      data-bs-title="Adresse du siège de l'entreprise"
    >
      <label for="cpost">
        <span data-lang="fr">Code postal</span>
      </label>
      <input
        type="text"
        class="form-control devis facture"
        name="cpost"
        id="cpost"
        value="{$dataClient.cpost|default:''}"
        placeholder="Code Postal"
      />
    </div>

    <div
      class="form-group pb-3 col-7 col-md-4"
      data-bs-toggle="tooltip"
      data-bs-title="Adresse du siège de l'entreprise"
    >
      <label for="commune">
        <span data-lang="fr">Commune</span>
      </label>
      <input
        type="text"
        class="form-control devis facture"
        name="commune"
        id="commune"
        value="{$dataClient.commune|default:''}"
        placeholder="Commune"
      />
    </div>

    <div class="form-group pb-3 col-12">
      <label for="tva">
        <span data-lang="fr">Numéro de TVA</span>
      </label>
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">BE</span>
        </div>
        <input
          type="text"
          class="form-control facture"
          inputmode="numeric"
          pattern="[0-9]*"
          maxlength="10"
          id="tva"
          name="tva"
          value="{$dataClient.tva|default:''}"
          placeholder="Numéro de TVA"
        />
      </div>
    </div>

    <div class="form-group pb-3 col-12">
      <div class="form-check form-switch">
        <input class="form-check-input" type="checkbox" role="switch" id="rgpd"
        name="rgpd" {if isset($dataClient.rgpd) && $dataClient.rgpd ==
        1}checked{/if}>
        <label
          class="form-check-label reparation facture devis"
          id="lblrgpd"
          for="rgpd"
          >J'accepte que mes données personnelles soient conservées le temps
          nécessaire au service fourni par Oxfam asbl.
        </label>
      </div>
    </div>
    <div class="pb-3 col-12">
      <button
        type="button"
        id="infoRgpd"
        class="btn btn-primary w-100 text-start"
        style="font-size: 80%"
      >
        <i class="fa fa-info-circle"> </i>
        <span id="textRgpd"
          ><strong> Oxfam Informatique</strong> s'engage à n'utiliser vos
          informations que pour des raisons d'usages internes au magasin ou, si
          nécessaire, aux services techniques de Oxfam. En aucune cas, vos
          informations ne seront transmises à des tiers.</span
        >
      </button>
    </div>
  </div>
</form>
