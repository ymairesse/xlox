<form id="formClient" class="extended" data-zone="formClient">

  <div class="container-fluid">
    <div class="row">
      
      <div class="form-group pb-3 col-2">
        <label for="genre">F/M/X</label>
        <input
          type="text"
          class="form-control"
          name="civilite"
          id="civilite"
          readonly
          value="{$dataClient.civilite|default:''}"
          placeholder="Civ."
        />
      </div>

      <div class="form-group pb-3 col-6">
        <label for="nom">Nom</label>
        <input
          type="text"
          class="form-control"
          name="nom"
          id="nom"
          readonly
          value="{$dataClient.nom|default:''}"
          placeholder="Nom"
          required
        />
      </div>

      <div class="form-group pb-3 col-4">
        <label for="prenom">Prénom</label>
        <input
          type="text"
          class="form-control"
          name="prenom"
          id="prenom"
          readonly
          value="{$dataClient.prenom|default:''}"
          placeholder="Prénom"
        />
      </div>

      <div class="form-group pb-3 col-6 col-md-4">
        <label for="gsm"
          ><i class="fa fa-mobile" aria-hidden="true"></i> GSM</label
        >
        <input
          type="text"
          class="form-control"
          name="gsm"
          id="gsm"
          readonly
          value="{$dataClient.gsm|default:''}"
          placeholder="GSM"
        />
      </div>

      <div class="form-group pb-3 col-6 col-md-3">
        <label for="telephone"
          ><i class="fa fa-phone" aria-hidden="true"></i> Téléphone</label
        >
        <input
          type="text"
          class="form-control"
          name="telephone"
          id="telephone"
          readonly
          value="{$dataClient.telephone|default:''}"
          placeholder="Téléphone"
        />
      </div>

      <div class="form-group pb-3 col-11 col-md-4">
        <label for="mail"
          ><i class="fa fa-send" aria-hidden="true" readonly></i> Adresse
          mail</label
        >
        <input
          type="mail"
          class="form-control"
          name="mail"
          id="mail"
          readonly
          value="{$dataClient.mail|default:''}"
          placeholder="Adresse mail"
        />
      </div>

      <div class="form-group pt-4 col-1">
        <button type="button" class="btn btn-secondary btn-sm btn-extended w-100" data-zone="extraForm"><i class="fa fa-plus"></i></button>
      </div>
    </div>


    
<div class="row d-none extended" data-zone="extraForm">

    <div class="form-group pb-3 col-12">
      <label for="adresse">Adresse</label>
      <input
        type="text"
        class="form-control"
        name="adresse"
        readonly
        id="adresse"
        value="{$dataClient.adresse|default:''}"
        placeholder="Adresse rue / numéro"
      />
    </div>

      <div class="form-group pb-3 col-7">
        <label for="commune">Commune</label>
        <input
          type="text"
          class="form-control"
          name="commune"
          readonly
          id="commune"
          value="{$dataClient.commune|default:''}"
          placeholder="Commune"
        />
      </div>

      <div class="form-group pb-3 col-5">
        <label for="cpost">Code Postal</label>
        <input
          type="text"
          class="form-control"
          name="cpost"
          readonly
          id="cpost"
          value="{$dataClient.cpost|default:''}"
          placeholder="Code Postal"
        />
      </div>

      <div class="form-group pb-3 col-12">
        <label for="tva">Numéro de TVA</label>
  
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <span class="input-group-text">BE</span>
          </div>
          <input
            type="text"
            class="form-control"
            id="tva"
            name="tva"
            value="{$dataClient.tva|default:''}"
          />
        </div>
      </div>

    </div>
  
</form>

<div class="btn-group btn-group-justified w-100 {if $idUser == Null}visually-hidden{/if}"
      role="group"
      aria-label="btn-group"
    >
      <button type="button" id="delClient" class="btn btn-danger w-25 text-truncate" title="Supprimer cette fiche client">
        <i class="fa fa-warning"></i> Supprimer ce client
        <i class="fa fa-warning"></i>
      </button>
      <button type="button" id="btn-editClient" class="btn btn-warning w-75 text-truncate" title="Modifier cette fiche client">
        Modifier
      </button>
    </div>

    
    <button type="button" id="btn-editClient" class="btn btn-success w-100 {if $idUser != Null}visually-hidden{/if}">
      Nouveau client
    </button>

