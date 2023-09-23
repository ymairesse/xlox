<!-- Modal -->
<div
  class="modal fade"
  id="modalEditClient"
  data-bs-backdrop="static"
  data-bs-keyboard="false"
  tabindex="-1"
  aria-labelledby="modalEditClientLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="modalEditClientLabel">Fiche Client</h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">

        <form autocomplete="false" id="modalFormClient">
          <input type="hidden" name="idUser" value="{$dataClient.idUser|default:''}">

          <div class="row">
            <div class="pb-3 col-2">
              <div class="form-check">
                <input class="form-check-input civilite" type="checkbox"
                name="civilite" id="civilite1" value="F" {if isset($dataClient.civilite) &&
                $dataClient.civilite == 'F'}checked{/if}>
                <label class="form-check-label" for="civilite1">Madame</label>
              </div>
              <div class="form-check">
                <input class="form-check-input civilite" type="checkbox"
                name="civilite" id="civilite2" value="M" {if isset($dataClient.civilite) &&
                $dataClient.civilite == 'M'}checked{/if}>
                <label class="form-check-label" for="civilite2">Monsieur</label>
              </div>
              <div class="form-check">
                <input class="form-check-input civilite" type="checkbox"
                name="civilite" id="civilite3" value="X" {if isset($dataClient.civilite) &&
                $dataClient.civilite == 'X'}checked{/if}>
                <label class="form-check-label" for="civilite3">MX</label>
              </div>
              <button
                type="button"
                class="btn btn-success btn-sm w-100"
                id="nosex"
              >
                <i class="fa fa-recycle"></i>
              </button>
            </div>
            <div class="form-group pb-3 col-5">
              <label for="nom">Nom</label>
              <input
                type="text"
                class="form-control"
                name="nom"
                id="nom"
                value="{$dataClient.nom|default:''}"
                placeholder="Nom"
                required
              />
            </div>
            <div class="form-group pb-3 col-5">
              <label for="prenom">Prénom</label>
              <input
                type="text"
                class="form-control"
                name="prenom"
                id="prenom"
                value="{$dataClient.prenom|default:''}"
                placeholder="Prénom"
              />
            </div>

            <div class="form-group pb-3 col-6 col-md-4" data-bs-toggle="tooltip" data-bs-title="Au moins l'un des trois (GSM, téléphone ou mail)">
              <label for="gsm"
                ><i class="fa fa-mobile" aria-hidden="true"></i> GSM</label
              >
              <input
                type="text"
                class="form-control contact phone"
                name="gsm"
                id="gsm"
                value="{$dataClient.gsm|default:''}"
                placeholder="GSM"
              />
            </div>

            <div class="form-group pb-3 col-6 col-md-4" data-bs-toggle="tooltip" data-bs-title="Au moins l'un des trois (GSM, téléphone ou mail)">
              <label for="telephone"
                ><i class="fa fa-phone" aria-hidden="true"></i> Téléphone</label
              >
              <input
                type="text"
                class="form-control contact phone"
                name="telephone"
                id="telephone"
                value="{$dataClient.telephone|default:''}"
                placeholder="Téléphone"
              />
            </div>

            <div class="form-group pb-3 col-6 col-md-4" data-bs-toggle="tooltip" data-bs-title="Au moins l'un des trois (GSM, téléphone ou mail)">
              <label for="mail"
                ><i class="fa fa-send" aria-hidden="true"></i> Mail</label
              >
              <input
                type="mail"
                class="form-control contact"
                name="mail"
                id="mail"
                value="{$dataClient.mail|default:''}"
                placeholder="Adresse mail"
              />
            </div>


          <div class="form-group pb-3 col-6 col-md-5" data-bs-toggle="tooltip" data-bs-title="Adresse nécessaire uniquement pour un devis ou une facturation">
            <label for="adresse">Adresse</label>
            <input
              type="text"
              class="form-control"
              name="adresse"
              id="adresse"
              value="{$dataClient.adresse|default:''}"
              placeholder="Adresse rue / numéro"
            />
          </div>

            <div class="form-group pb-3 col-7 col-md-4" data-bs-toggle="tooltip" data-bs-title="Adresse nécessaire uniquement pour un devis ou une facturation">
              <label for="commune">Commune</label>
              <input
                type="text"
                class="form-control"
                name="commune"
                id="commune"
                value="{$dataClient.commune|default:''}"
                placeholder="Commune"
              />
            </div>
            <div class="form-group pb-3 col-5 col-md-3" data-bs-toggle="tooltip" data-bs-title="Adresse nécessaire uniquement pour un devis ou une facturation">
              <label for="cpost">Code Postal</label>
              <input
                type="text"
                class="form-control"
                name="cpost"
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
                <input type="text" class="form-control" inputmode="numeric" pattern="[0-9]*" maxlength="10" id="tva" name="tva" value="{$dataClient.tva|default:''}">
              </div>
            </div>

            <div class="form-group pb-3 col-9">
              <label for="captcha">Prouvez que vous n'êtes pas un robot</label>
              <input type="text" name="captcha" id="captcha" class="form-control" style="text-transform: uppercase" placeholder="Veuillez recopier le texte ci-contre (en majuscules)" required>
            </div>
            <div class="pb-3 col-3">
            <img src="inc/captcha.php?nbchar=6&amp;rand=<?php echo rand(); ?>" id="captcha_image" class="img-responsive">
            <button type="button" class="btn btn-success w-100 btn-sm" id="recaptcha">Un autre</button>
          </div>

            <div class="form-group pb-3 col-12">
              <div class="form-check form-switch">
                <input class="form-check-input" type="checkbox" role="switch" id="rgpd" name="rgpd" {if isset($dataClient.rgpd) && $dataClient.rgpd == 1}checked{/if}>
                <label class="form-check-label" for="rgpd">J'accepte que mes données personnelles soient conservées pour usage ultérieur 
                  <button type="button" 
                    class="btn btn-primary btn-sm info-rgpd" 
                    data-bs-toggle="tooltip"
                    data-bs-title="<strong>Oxfam Informatique</strong> s'engage à n'utiliser vos informations que pour des raisons d'usages internes au magasin ou, si nécessaire, aux services techniques de Oxfam. En aucune cas, vos informations ne seront transmises à des tiers."
                    data-bs-html="true"
                    style="height:14pt; font-size: 60%; padding:0 5px"><i class="fa fa-info-circle" aria-hidden="true"></i>
                  </button> </label>
              </div>
             
            </div>
           
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Annuler
        </button>
        <button type="button" class="btn btn-primary" id="btn-autoSaveClient" disabled>Enregistrer</button>
      </div>
    </div>
  </div>
</div>

<style>
  #nosex {
    height: 2em;
    font-size: 8pt;
  }

  div.error {
    color: red;
  }

</style>

<script>

  function refreshCaptcha(){
    var image = $('#captcha_image');
    var source = image.attr('src');
    $('#captcha_image').attr('src', source.substring(0, source.lastIndexOf("?")) + "?rand=" + Math.random()*1000);
  }

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

    refreshCaptcha();

    $('input#captcha').on('keyup', function(event){
      var captcha = $('#captcha').val();
      $.post('inc/checkCaptcha.inc.php', {
        captcha: captcha
      }, function(resultat){
        if (resultat == true)
          $('#btn-autoSaveClient').prop('disabled', false);
        else $('#btn-autoSaveClient').prop('disabled', true);
      })
    })

      $('#recaptcha').click(function(){
          refreshCaptcha();
        })

        $(phoneFormatter);


    // Ne permettre qu'une seule case cochée pour la civilité
    $("#modal .civilite").on("change", function () {
      $("input[type=checkbox]").each(function (index, checkbox) {
        checkbox.checked = false;
      });

      $(this).prop("checked", true);
    });

    var tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
    );
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    $('#modalFormClient').validate({
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
        mail: {
          require_from_group: [1, ".contact"]
        },
        tva: {
          number: true
        }
      }
    })

  });
</script>
