<h2><u>[{if $dataUser.civilite == 'F'}Madame{elseif $dataUser.civilite == 'M'}Monsieur{else} {/if} {$dataUser.prenom} {$dataUser.nom}]</u></h2>

<form autocomplete="false" id="formUser">
  <div class="container-fluid">
    <div class="row">
      <input
        type="hidden"
        value="{$dataUser.idUser}"
        id="idUser"
        name="idUser"
      />

      <div class="form-group pb-3 col-2">
        <label for="genre">
          <i class="fa fa-female" aria-hidden="true"></i>
          <i class="fa fa-male" aria-hidden="true"></i>
          <i class="fa fa-genderless" aria-hidden="true"></i
        ></label>
        <input
          type="text"
          class="form-control"
          name="civilite"
          id="civilite"
          readonly
          value="{if $dataUser.civilite == 'F'}Madame 
            {elseif $dataUser.civilite == 'M'}Monsieur 
            {elseif $dataUser.civilie == 'X'}MX
            {else}-
          {/if}"
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
          autocomplete="false"
          value="{$dataUser.nom|default:''}"
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
          value="{$dataUser.prenom|default:''}"
          placeholder="Prénom"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-4">
        <label for="pseudo">
          <i class="fa fa-user-secret" aria-hidden="true"></i>
          Alias
        </label>
        <input
          type="text"
          class="form-control"
          name="pseudo"
          id="pseudo"
          maxlength="12"
          autocomplete="false"
          value="{$dataUser.pseudo|default:''}"
          placeholder="Alias"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-md-4 col-12">
        <label for="mdp">Mot de passe</label>
        <div class="input-group">
          <span class="input-group-text addonMdp"
            ><i class="fa fa-eye"></i
          ></span>
          <input
            type="password"
            class="form-control"
            name="pwd"
            id="pwd"
            autocomplete="false"
            value=""
            placeholder="{if $dataUser.md5passwd == ''}Mot de passe{else}Au moins 6 caractères{/if}"
            aria-describedby="addonMdp"
            readonly
          />
        </div>
      </div>

      <div class="form-group pb-3 col-4">
        <label for="droits"><i class="fa fa-user-plus" aria-hidden="true"></i> Droits</label>
        <input
          type="text"
          id="droits"
          name="droits"
          class="form-control"
          value="{$dataUser.droits|default:'oxfam'}"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-4">
        <label for="mail">
          <i class="fa fa-send" aria-hidden="true"></i>
          Adresse mail
        </label>
        <input
          type="mail"
          class="form-control"
          name="mail"
          id="mail"
          value="{$dataUser.mail|default:''}"
          placeholder="Adresse mail"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-4">
        <label for="gsm">
          <i class="fa fa-mobile" aria-hidden="true"></i>
          GSM
        </label>
        <input
          type="tel"
          class="form-control"
          name="gsm"
          id="gsm"
          autocomplete="false"
          value="{$dataUser.gsm|default:''}"
          placeholder="GSM"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-4">
        <label for="telephone">
          <i class="fa fa-phone" aria-hidden="true"></i>
          Téléphone
        </label>
        <input
          type="tel"
          class="form-control"
          name="telephone"
          id="telephone"
          autocomplete="false"
          value="{$dataUser.telephone|default:''}"
          placeholder="Téléphone"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-md-5 col-12">
        <label for="adresse">Adresse</label>
        <input
          type="text"
          class="form-control"
          name="adresse"
          autocomplete="false"
          id="adresse"
          value="{$dataUser.adresse|default:''}"
          placeholder="Adresse rue / numéro"
          readonly
        />
      </div>

      <div class="form-group pb-3 col-md-3 col-4">
        <label for="cpost">Code Postal</label>
        <input
          type="text"
          class="form-control"
          name="cpost"
          autocomplete="false"
          id="cpost"
          value="{$dataUser.cpost|default:''}"
          placeholder="Code Postal"
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
          value="{$dataUser.commune|default:''}"
          placeholder="Commune"
          readonly
        />
      </div>
    </div>
  </div>
</form>

<style>
  div.error {
    color: red;
  }
</style>
