<div
  class="modal fade"
  id="modalEditUser"
  data-bs-backdrop="static"
  data-bs-keyboard="false"
  tabindex="-1"
  aria-labelledby="modalEditUserLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 w-100" id="modalEditUserLabel">Fiche Utilisateur</h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">

        <form autocomplete="false" id="modalFormUser">

          <form autocomplete="false" id="modalFormUser">

            <input type="hidden" name="idUser" id="idUser" value="{$dataUser.idUser|default:''}">
            <div class="row">
              <div class="pb-3 col-2">
                <label for="civilite">
                  <i class="fa fa-female" aria-hidden="true"></i> 
                  <i class="fa fa-male" aria-hidden="true"></i> 
                  <i class="fa fa-genderless" aria-hidden="true"></i>
                </label>
                <select name="civilite" id="civilite" class="form-control">
                  <option value="">Select</option>
                  <option value="F"{if $dataUser.civilite == 'F'} selected{/if}>Madame</option>
                  <option value="M"{if $dataUser.civilite == 'M'} selected{/if}>Monsieur</option>
                  <option value="X"{if $dataUser.civilite == 'X'} selected{/if}>MX</option>
                </select>
                
              </div>
              <div class="form-group pb-3 col-5">
                <label for="nom">
                    Nom
                </label>
                <input
                  type="text"
                  class="form-control"
                  name="nom"
                  id="nom"
                  value="{$dataUser.nom|default:''}"
                  placeholder="Nom"
                />
              </div>
              <div class="form-group pb-3 col-5">
                <label for="prenom">
                  Prénom
                </label>
                <input
                  type="text"
                  class="form-control"
                  name="prenom"
                  id="prenom"
                  value="{$dataUser.prenom|default:''}"
                  placeholder="Prénom"
                />
              </div>
  
              <div class="form-group pb-3 col-4">
                <label for="pseudo"><i class="fa fa-user-secret"></i> Alias</label>
                <input type="text"
                class="form-control"
                name="pseudo"
                id="pseudo"
                value="{$dataUser.pseudo|default:''}"
                >
              </div>
  
              <div class="form-group pb-3 col-4">
                <label for="password">M. passe</label>
                <div class="input-group mb-3">
                  <span class="input-group-text addonMdp"><i class="fa fa-eye"></i></span>
                    <input type="password" 
                      class="form-control" 
                      name="pwd" 
                      id="pwd" 
                      autocomplete="false" 
                      value="" 
                      placeholder="{if $idUser != ''}Laisser vide si inchangé{else}Au moins 6 caractères{/if}" 
                      aria-describedby="addonMdp">
                </div>
              </div>
  
  
              <div class="form-group pb-3 col-4">
                <label for="droits"><i class="fa fa-user-plus" aria-hidden="true"></i> Droits
                  {if ($self.idUser == $dataUser.idUser)} [non modifiable]{/if}
                </label>
                {if ($self.droits != 'root') || ($self.idUser != $dataUser.idUser)}
                <select name="droits" 
                  id="droits" 
                  class="form-control"
                  >
                  <option value="oxfam"{if $dataUser.droits == 'oxfam'} selected{/if}>oxfam</option>
                  <option value="root"{if $dataUser.droits == 'root'} selected{/if}>root</option>
                </select>
                {else} 
                <input type="text" id="droits" name="droits" class="form-control" readonly value="{$dataUser.droits}">
                {/if}
              </div>
              
              
              
  
              <div class="form-group pb-3 col-6 col-md-4">
                <label for="mail">
                  <i class="fa fa-send" aria-hidden="true"></i> Mail
                </label
                >
                <input
                  type="mail"
                  class="form-control"
                  name="mail"
                  id="mail"
                  value="{$dataUser.mail|default:''}"
                  placeholder="Adresse mail"
                />
              </div>
  
              <div class="form-group pb-3 col-6 col-md-4">
                <label for="gsm"
                  ><i class="fa fa-mobile" aria-hidden="true"></i> 
                  GSM
                  </label
                >
                <input
                  type="text"
                  class="form-control contact phone"
                  name="gsm"
                  id="gsm"
                  value="{$dataUser.gsm|default:''}"
                  placeholder="GSM"
                />
              </div>
  
              <div class="form-group pb-3 col-6 col-md-4">
                <label for="telephone"
                  ><i class="fa fa-phone" aria-hidden="true"></i> 
                  Téléphone
                  </label
                >
                <input
                  type="text"
                  class="form-control contact phone"
                  name="telephone"
                  id="telephone"
                  value="{$dataUser.telephone|default:''}"
                  placeholder="Téléphone"
                />
              </div>
  
            <div class="form-group pb-3 col-6 col-md-5">
              <label for="adresse">
                Adresse
              </label>
              <input
                type="text"
                class="form-control"
                name="adresse"
                id="adresse"
                value="{$dataUser.adresse|default:''}"
                placeholder="Adresse rue / numéro"
              />
            </div>
  
            <div class="form-group pb-3 col-5 col-md-3">
              <label for="cpost">
                Code postal
              </label>
              <input
                type="text"
                class="form-control"
                name="cpost"
                id="cpost"
                value="{$dataUser.cpost|default:''}"
                placeholder="Code Postal"
              />
            </div>
            
              <div class="form-group pb-3 col-7 col-md-4">
                <label for="commune">
                  Commune
                </label>
                <input
                  type="text"
                  class="form-control"
                  name="commune"
                  id="commune"
                  value="{$dataUser.commune|default:''}"
                  placeholder="Commune"
                />
              </div>
             
          </form>
           
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Annuler
        </button>
        <button type="button" class="btn btn-primary" id="btn-modalSaveUser">Enregistrer</button>
      </div>
    </div>
  </div>
</div>

<style>

  div.error {
    color: red;
  }

</style>

<script>

  function phoneFormatter() {
      $('.phone').on('input', function() {
        var number = $(this).val().replace(/[^\d+]/g, '')
        if (number.length == 9) {
            var pfx = number.substr(0,2);
            var no = number.substr(2,)
            number = pfx + " " + no;
        } else if (number.length == 10) {
            var pfx = number.substr(0,4);
            var no = number.substr(4,)
            number = pfx + " " + no;
        }
        $(this).val(number)
      });
    };

  $(document).ready(function () {

    $(phoneFormatter);

    var tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
    );
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    $("#modalFormUser").validate({
      lang: "fr",
      errorElement: "div",
      rules: {
        nom: {
          required: true,
        },
        prenom: {
          required: true,
        },
        telephone: {
          require_from_group: [1, ".contact"],
        },
        gsm: {
          require_from_group: [1, ".contact"],
        },
        pwd: {
          required: false,
          minlength: 8,
          pwcheck: true,
        },
        mail: {
          required: true,
          email: true,
        },
        droits: {
          required: true
        }
      },
      errorPlacement: function (error, element) {
        if (element.parent().hasClass("input-group")) {
          error.insertAfter(element.parent(".input-group"));
        } else {
          error.insertAfter(element);
        }
      },
      messages: {
        pwd: {
          pwcheck: "Au moins deux lettres et au moins 2 chiffres",
        },
      },
    });

    $.validator.addMethod("pwcheck", function (value, element) {
      var countNum = (value.match(/[0-9]/g) || []).length;
      var countLet = (value.match(/[a-zA-Z]/g) || []).length;
      // un mot de passe n'est pas obligatoire pour un compte déjà défini
      var idUser = $('#idUser').val();
      if ((element.value == "") && (idUser != '')) return true;
      else return countNum >= 2 && countLet >= 2;
    });

  });
</script>
