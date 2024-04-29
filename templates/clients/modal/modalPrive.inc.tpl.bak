<form autocomplete="off" id="modalFormClientPrive">
    <input
      type="hidden"
      name="idUser"
      value="{$dataClient.idUser|default:''}"
    />
    <input 
      type="hidden"
      name="typeClient"
      value="{$typeClient|default:'prive'}"
      />
    <input 
      type="hidden"
      name="modified"
      id="modified"
      value="0"
      />

    <div class="row">
      
    <div class="pb-3 col-2">
        <label for="civilite">
          <i class="fa fa-female" aria-hidden="true"></i>
          <i class="fa fa-male" aria-hidden="true"></i>
          <i class="fa fa-genderless" aria-hidden="true"></i>
        </label>
        <select
          name="civilite"
          id="civilite"
          class="form-control reparation facture devis"
        >
          <!-- les options d-none ne sont pas affichées a priori -->
          <option data-lang="fr" value="">Genre</option>
          <option data-lang="fr" value="F"{if $dataClient.civilite == 'F'} selected{/if}>Madame</option>
          <option data-lang="fr" value="M"{if $dataClient.civilite == 'M'} selected{/if}>Monsieur</option>
          <option data-lang="fr" value="X"{if $dataClient.civilite == 'X'} selected{/if}>Madame/Monsieur</option>
        </select>
      </div>
    
      <div class="form-group pb-3 col-5">
        <label for="nom">
          <span data-lang="fr">Nom</span>
        </label>
        <input
          type="text"
          class="form-control devis facture reparation"
          name="nom"
          id="nom"
          value="{$dataClient.nom|default:''}"
          placeholder="Nom"
          required
        />
      </div>
    
      <div class="form-group pb-3 col-5">
        <label for="prenom">
          <span data-lang="fr">Prénom</span>
        </label>
        <input
          type="text"
          class="form-control devis facture reparation"
          name="prenom"
          id="prenom"
          value="{$dataClient.prenom|default:''}"
          placeholder="Prénom"
        />
      </div>
      <div
        class="form-group pb-3 col-6 col-md-4"
        data-bs-toggle="tooltip"
        data-bs-title="Au moins l'un des trois (GSM, téléphone ou mail)"
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
        data-bs-title="Au moins l'un des trois (GSM, téléphone ou mail)"
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
        data-bs-title="Au moins l'un des trois (GSM, téléphone ou mail)"
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
        data-bs-title="Adresse nécessaire uniquement pour un devis ou une facturation"
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
        data-bs-title="Adresse nécessaire uniquement pour un devis ou une facturation"
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
        data-bs-title="Adresse nécessaire uniquement pour un devis ou une facturation"
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
        <div class="form-check form-switch">
          <input class="form-check-input" type="checkbox" role="switch"
          id="rgpd" name="rgpd" {if isset($dataClient.rgpd) &&
          $dataClient.rgpd == 1}checked{/if}>
          <label
            class="form-check-label reparation facture devis"
            id="lblrgpd"
            for="rgpd"
            >J'accepte que mes données personnelles soient conservées le
            temps nécessaire au service fourni par Oxfam asbl.
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
            ><strong> Oxfam Informatique</strong> s'engage à n'utiliser
            vos informations que pour des raisons d'usages internes au
            magasin ou, si nécessaire, aux services techniques de Oxfam.
            En aucune cas, vos informations ne seront transmises à des
            tiers.</span
          >
        </button>
      </div>
    </div>
  </form>
  
  <script>

    $(document).ready(function(){


    })

  </script>