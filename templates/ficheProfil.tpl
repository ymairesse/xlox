<form autocomplete="false" id="formUser">

  <div class="container-fluid">
    <div class="row">
      <input type="hidden" value="{$profil.idUser}" name="idUser">
      <div class="pb-3 col-2">
        <label for="civilite">Genre</label>
        <select name="civilite" id="civilite" class="form-control">
          <option value="">Sélectionner </option>
          <option value="F" {if $profil.civilite == 'F'}selected{/if}>Madame</option>
          <option value="M" {if $profil.civilite == 'M'}selected{/if}>Monsieur</option>
        </select>
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
          autocomplete="false"
          value="{$profil.prenom|default:''}"
          placeholder="Prénom"
          required
        />
      </div>

      <div class="form-group pb-3 col-md-4">
        <label for="mail"
          ><i class="fa fa-send" aria-hidden="true"></i> Adresse
          mail</label
        >
        <input
          type="mail"
          class="form-control"
          name="mail"
          id="mail"
        
          value="{$profil.mail|default:''}"
          placeholder="Adresse mail"
          required
        >
      </div>

    <div class="form-group pb-3 col-md-4">
      <label for="pseudo"><i class="fa fa-user-secret" aria-hidden="true"></i> Alias</label>
      <input 
        type="text" 
        class="form-control"
        name="pseudo" 
        id="pseudo" 
        maxlength="12" 
        autocomplete="false"
        value="{$profil.pseudo|default:''}"
        placeholder="Alias"
        required
        >
    </div>

    <div class="form-group pb-3 col-md-4 col-12">
      <label for="mdp">Mot de passe</label>
      <div class="input-group mb-3">
        <span class="input-group-text addonMdp"><i class="fa fa-eye"></i></span>
          <input type="password"
          class="form-control"
          name="pwd"
          id="pwd"
          autocomplete="false"
          value=""
          {if $profil.md5passwd == ''}required{/if}
          placeholder="{if $profil.md5passwd == ''}Mot de passe{else}Laisser vide si inchangé{/if}"
          aria-describedby="addonMdp"
          >
      </div>

    </div>

    <div class="form-group pb-3 col-6">
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
      />
    </div>
      
      <div class="form-group pb-3 col-6">
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
        value="{$profil.adresse|default:''}"
        placeholder="Adresse rue / numéro"
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
          value="{$profil.cpost|default:''}"
          placeholder="Code Postal"
        />
      </div>

      <div class="form-group pb-3 col-8">
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
          />
        </div>
      </div>
{if isset($idUser)}
      <div class="form-group pb-3 col-4">
        <label for="droits">Droits</label>
        <select id="droits" class="form-control" name="droits">
          <option value="client" {if $profil.droits =="client"}selected{/if}>Client</option>
          <option value="oxfam" {if $profil.droits =="oxfam"}selected{/if}>Oxfam</option>
          <option value="root" {if $profil.droits =="root"}selected{/if}>Administrateur</option>
        </select>
      </div>
{/if}
      <button type="button" class="btn btn-warning w-100" id="btn-saveProfil"><i class="fa fa-floppy-o" aria-hidden="true"></i> Enregistrer</button>

    </div>
  
</form>

<style>

  div.error {
    color: red;
  }

</style>

<script>

  $(document).ready(function(){

    function passwordRequired() {
      return $('#pwd').val().length > 0;
    }

    $('#formUser').validate({
      lang: 'fr',
      errorElement: 'div',
      rules: {
        nom: {
          required: true
        },
        prenom: {
          required: true
        },
        telephone: {
          require_from_group: [1, ".contact"]
        },
        gsm: {
          require_from_group: [1, ".contact"]
        },
        pwd: {
          required: false,
          minlength: 8,
          pwcheck: true,
        },
        mail: {
          required: true,
          email: true
        },
        tva: {
          number: true
        }
      },
      errorPlacement: function ( error, element ) {
        if(element.parent().hasClass('input-group')){
          error.insertAfter(element.parent('.input-group'));
        }else{
            error.insertAfter( element );
        }
        },
        messages: {
          pwd: {
            pwcheck: "Au moins deux lettres et au moins 2 chiffres",
          },
      },
    })

    $.validator.addMethod("pwcheck", function (value, element) {
      var countNum = (value.match(/[0-9]/g) || []).length;
      var countLet = (value.match(/[a-zA-Z]/g) || []).length;
      if (element.value == '') return true
        else return countNum >= 2 && countLet >= 2;
    });

  })

</script>