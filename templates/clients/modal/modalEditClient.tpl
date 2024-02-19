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
        <h1 class="modal-title fs-5 w-100" id="modalEditClientLabel">
          Fiche Client
          <div class="btn-group float-end">
            <select name="lang" id="lang">
              <option value="fr" selected>FR</option>
              <option value="nl">NL</option>
              <option value="gb">EN</option>
              <option value="ukr">UKR</option>
              <option value="ru">RU</option>
            </select>
            <button
              class="btn btn-warning btn-sm py-0 visuChamps"
              data-type="reparation"
              data-bs-toggle="tooltip"
              data-bs-title="Pour une réparation"
            >
              Réparation
            </button>
            <button
              class="btn btn-success btn-sm py-0 visuChamps"
              data-type="devis"
              data-bs-toggle="tooltip"
              data-bs-title="Pour un devis"
            >
              Devis
            </button>
            <button
              class="btn btn-danger btn-sm py-0 visuChamps"
              data-type="facture"
              data-bs-toggle="tooltip"
              data-bs-title="Pour une facture"
            >
              Facture
            </button>
          </div>
        </h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <form autocomplete="false" id="modalFormClient">
          <input
            type="hidden"
            name="idUser"
            value="{$dataClient.idUser|default:''}"
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
 
                <option data-lang="fr" value="F">Madame</option>
                <option class="d-none" data-lang="nl" value="F">Mevrouw</option>
                <option class="d-none" data-lang="gb" value="F">Mrs</option>
                <option class="d-none" data-lang="ukr" value="F">Мадам.</option>
                <option class="d-none" data-lang="ru" value="F">мадам</option>
                <option data-lang="fr" value="M">Monsieur</option>
                <option class="d-none" data-lang="nl" value="M">
                  Mijnheer
                </option>
                <option class="d-none" data-lang="gb" value="M">Mr.</option>
                <option class="d-none" data-lang="ukr" value="M">Пане.</option>
                <option class="d-none" data-lang="ru" value="M">Г-н.</option>
                <option value="X" data-lang="fr">MX</option>
                <option value="X" class="d-none" data-lang="nl">MX</option>
                <option value="X" class="d-none" data-lang="gb">MX</option>
                <option value="X" class="d-none" data-lang="ukr">MX</option>
                <option value="X" class="d-none" data-lang="ru">MX</option>
              </select>
            </div>

            <div class="form-group pb-3 col-5">
              <label for="nom">
                <span data-lang="fr">Nom</span>
                <span data-lang="nl" class="d-none">Naam</span>
                <span data-lang="gb" class="d-none">Family Name</span>
                <span data-lang="ukr" class="d-none">прізвище</span>
                <span data-lang="ru" class="d-none">фамилия</span>
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
                <span data-lang="nl" class="d-none">Voornaam</span>
                <span data-lang="gb" class="d-none">First Name</span>
                <span data-lang="ukr" class="d-none">ім'я та прізвище</span>
                <span data-lang="ru" class="d-none">имя</span>
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
                <span data-lang="nl" class="d-none">GSM</span>
                <span data-lang="gb" class="d-none">Mobile phone</span>
                <span data-lang="ukr" class="d-none">Мобільний телефон</span>
                <span data-lang="ru" class="d-none">Мобильный телефон</span>
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
                <span data-lang="nl" class="d-none">Telefoon</span>
                <span data-lang="gb" class="d-none">Telephone</span>
                <span data-lang="ukr" class="d-none">Телефон</span>
                <span data-lang="ru" class="d-none">Телефон</span>
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
                <span data-lang="nl" class="d-none">Mail</span>
                <span data-lang="gb" class="d-none">Mail</span>
                <span data-lang="ukr" class="d-none">пошта</span>
                <span data-lang="ru" class="d-none">почта</span>
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
                <span data-lang="nl" class="d-none">Adres</span>
                <span data-lang="gb" class="d-none">Address</span>
                <span data-lang="ukr" class="d-none">Адреса</span>
                <span data-lang="ru" class="d-none">Адрес</span>
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
                <span data-lang="nl" class="d-none">Postcode</span>
                <span data-lang="gb" class="d-none">Zip code</span>
                <span data-lang="ukr" class="d-none">Поштовий індекс</span>
                <span data-lang="ru" class="d-none">Почтовый индекс</span>
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
                <span data-lang="nl" class="d-none">Gemeente</span>
                <span data-lang="gb" class="d-none">Municipality</span>
                <span data-lang="ukr" class="d-none">Муніципалітет</span>
                <span data-lang="ru" class="d-none">Адрес</span>
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
                <span data-lang="nl" class="d-none">BTW nummer</span>
                <span data-lang="gb" class="d-none">VAT number</span>
                <span data-lang="ukr" class="d-none">Номер ПДВ</span>
                <span data-lang="ru" class="d-none">Номер НДС</span>
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
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Annuler
        </button>
        <button
          type="button"
          class="btn btn-primary"
          id="btn-autoSaveClient"
          disabled
        >
          Enregistrer
        </button>
      </div>
    </div>
  </div>
</div>

<style>
  div.error {
    color: red;
  }

  .visu {
    background-color: #ffef007a;
  }
</style>

<script>
  // function refreshCaptcha(){
  //   var image = $('#captcha_image');
  //   var source = image.attr('src');
  //   $('#captcha_image').attr('src', source.substring(0, source.lastIndexOf("?")) + "?rand=" + Math.random()*1000);
  // }

  function phoneFormatter() {
    $(".phone").on("input", function () {
      var number = $(this)
        .val()
        .replace(/[^\d+]/g, "");
      if (number.length == 9) {
        var pfx = number.substr(0, 2);
        var no = number.substr(2);
        number = pfx + " " + no;
      } else if (number.length == 10) {
        var pfx = number.substr(0, 4);
        var no = number.substr(4);
        number = pfx + " " + no;
      }
      $(this).val(number);
    });
  }

  var rgpd = [];
  rgpd["fr"] =
    "J'accepte que mes données personnelles soient conservées le temps nécessaire au service fourni par Oxfam asbl.";
  rgpd["nl"] =
    "Ik ga ermee akkoord dat mijn persoonlijke gegevens bewaard worden zolang dat nodig is voor de dienstverlening van Oxfam vzw.";
  rgpd["gb"] =
    "I agree to my personal data being stored for as long as is necessary for the service provided by Oxfam asbl.";
  rgpd["ukr"] =
    "Я погоджуюсь, що мої персональні дані зберігатимуться стільки, скільки це необхідно для надання послуг, що надаються Oxfam asbl.";
  rgpd["ru"] =
    "Я согласен на то, что мои персональные данные будут храниться столько, сколько необходимо для оказания услуг, предоставляемых Oxfam asbl.";

  var infoRgpd = [];
  infoRgpd["fr"] =
    "<strong>Oxfam Informatique</strong> s'engage à n'utiliser vos informations que pour des raisons d'usages internes au magasin ou, si nécessaire, aux services techniques de Oxfam. En aucune cas, vos informations ne seront transmises à des tiers.";
  infoRgpd["nl"] =
    "<strong>Oxfam Informatique</strong> verbindt zich ertoe uw gegevens uitsluitend te gebruiken voor intern gebruik door de winkel of, indien nodig, door de technische diensten van Oxfam. Uw gegevens worden in geen geval doorgegeven aan derden.";

  infoRgpd["gb"] =
    "<strong>Oxfam Informatique</strong> undertakes to use your information only for internal use by the shop or, if necessary, by Oxfam's technical services. Under no circumstances will your information be passed on to third parties.";

  infoRgpd["ukr"] =
    "<strong>Oxfam Informatique</strong> зобов'язується використовувати вашу інформацію лише для внутрішнього використання магазином або, за необхідності, технічними службами Oxfam. За жодних обставин ваша інформація не буде передана третім особам.";

  infoRgpd["ru"] =
    "<strong>Oxfam Informatique</strong> обязуется использовать вашу информацию только для внутреннего использования магазином или, при необходимости, техническими службами Oxfam. Ни при каких обстоятельствах ваша информация не будет передана третьим лицам.";

  var civilite1 = [];
  civilite1['fr'] = "Genre";
  civilite1['nl'] = "Gender";
  civilite1['gb'] = "Gender";
  civilite1['ukr'] = "стать";
  civilite1['ru'] = "пол";

  $(document).ready(function () {
    // refreshCaptcha();

    $("#rgpd").on("change", function () {
      var info = $(this).is(":checked");
      $("#btn-autoSaveClient").prop("disabled", !info);
    });

    $("#lang").on("change", function () {
      var lang = $(this).val();
      // cacher les contenus de tous les éléments "span" contenus dans des "label"
      $("label span").addClass("d-none");
      $("#civilite option").addClass("d-none");
      // rétablir ceux dont la langue a été sélectionnée
      $(
        'label [data-lang="' + lang + '"], option[data-lang="' + lang + '"]'
      ).removeClass("d-none");
      $("#lblrgpd").text(rgpd[lang]);
      $("#textRgpd").html(infoRgpd[lang]);
      $("input:text").each(function (index) {
        if ($(this).prev().is("label")) {
          var leTexte = $(this)
            .prev("label")
            .find('span[data-lang="' + lang + '"]')
            .text();
        } else
          var leTexte = $(this)
            .closest(".form-group")
            .find('span[data-lang="' + lang + '"]')
            .text();
        $(this).attr("placeholder", leTexte);

        var texteOption = civilite1[lang];
        $('#civilite option').first().text(texteOption);
      });
    });

    // $('#nom').prev('label').find('span[data-lang="ukr"]').text()

    $("input#captcha").on("keyup", function (event) {
      var captcha = $("#captcha").val();
      $.post(
        "inc/checkCaptcha.inc.php",
        {
          captcha: captcha,
        },
        function (resultat) {
          // if (resultat == true)
          //   $('#btn-autoSaveClient').prop('disabled', false);
          // else $('#btn-autoSaveClient').prop('disabled', true);
        }
      );
    });

    $("#infoRgpd").click(function () {
      var texte = $("#textRgpd").html();
      bootbox.alert({
        title: "RGPD",
        message: texte,
      });
    });

    $("#recaptcha").click(function () {
      refreshCaptcha();
    });

    $(phoneFormatter);

    var tooltipTriggerList = [].slice.call(
      document.querySelectorAll('[data-bs-toggle="tooltip"]')
    );
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    $("#modalFormClient").validate({
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
        mail: {
          require_from_group: [1, ".contact"],
        },
        tva: {
          number: true,
        },
      },
    });
  });
</script>
