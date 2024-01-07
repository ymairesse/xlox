{if $profil != Null}

<h2>
  <u
    >[{if $profil.civilite == 'F'}Madame{elseif $profil.civilite ==
    'M'}Monsieur{else} {/if} {$profil.prenom} {$profil.nom}]</u
  >
  {if $profil.rgpd == 0}<i class="fa fa-unlock" aria-hidden="true"></i>{else}<i
    class="fa fa-lock"
    aria-hidden="true"
    title="Peut être conservé"
  ></i
  >{/if}
</h2>

<form autocomplete="false" id="formClient">
  <div class="container-fluid">
    <div class="row">
      <input
        type="hidden"
        value="{$profil.idUser}"
        name="idClient"
        id="idClient"
      />
      <div class="pb-3 col-2">
        <label for="civilite">Genre</label>
        <input
          name="civilite"
          id="civilite"
          class="form-control"
          type="text"
          value="{if $profil.civilite == 'F'}Madame 
          {elseif $profil.civilite == 'M'}Monsieur 
          {elseif $profil.civilite == 'X'}MX
          {else}-
          {/if}"
        />
      </div>

      <div class="form-group pb-3 col-6">
        <label for="nom">Nom</label>
        <input
          type="text"
          class="form-control"
          name="nom"
          id="nom"
          autocomplete="false"
          value="{$profil.nom|default:''}"
          placeholder="Nom"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-4">
        <label for="prenom">Prénom</label>
        <input
          type="text"
          class="form-control"
          name="prenom"
          id="prenom"
          autocomplete="false"
          value="{$profil.prenom|default:''}"
          placeholder="Prénom"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-md-4">
        <label for="mail"
          ><i class="fa fa-send" aria-hidden="true"></i> Adresse mail</label
        >
        <input
          type="mail"
          class="form-control"
          name="mail"
          id="mail"
          value="{$profil.mail|default:''}"
          placeholder="Adresse mail"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-4">
        <label for="gsm"
          ><i class="fa fa-mobile" aria-hidden="true"></i> GSM</label
        >
        <input
          type="tel"
          class="form-control contact"
          name="gsm"
          id="gsm"
          autocomplete="false"
          value="{$profil.gsm|default:''}"
          placeholder="GSM"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-4">
        <label for="telephone"
          ><i class="fa fa-phone" aria-hidden="true"></i> Téléphone</label
        >
        <input
          type="tel"
          class="form-control contact"
          name="telephone"
          id="telephone"
          autocomplete="false"
          value="{$profil.telephone|default:''}"
          placeholder="Téléphone"
          readonly
        />
      </div>
    </div>

    <div class="row">
      <div class="form-group pb-3 col-md-4 col-12">
        <label for="adresse">Adresse</label>
        <input
          type="text"
          class="form-control"
          name="adresse"
          autocomplete="false"
          id="adresse"
          value="{$profil.adresse|default:''}"
          placeholder="Adresse rue / numéro"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-md-4 col-8">
        <label for="commune">Commune</label>
        <input
          type="text"
          class="form-control"
          name="commune"
          autocomplete="false"
          id="commune"
          value="{$profil.commune|default:''}"
          placeholder="Commune"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-md-4 col-4">
        <label for="cpost">Code Postal</label>
        <input
          type="text"
          class="form-control"
          name="cpost"
          autocomplete="false"
          id="cpost"
          value="{$profil.cpost|default:''}"
          placeholder="Code Postal"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-12">
        <label for="tva">N° TVA</label>
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <span class="input-group-text">BE</span>
          </div>
          <input
            type="text"
            class="form-control"
            id="tva"
            autocomplete="false"
            name="tva"
            value="{$profil.tva|default:''}"
            readonly
          />
        </div>
      </div>
    </div>
  </div>
</form>

{else}

<h1 class="null">Aucun client sélectionné</h1>

{/if}
