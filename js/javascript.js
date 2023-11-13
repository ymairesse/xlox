var n = 1;

// provoque un session_start() toutes les "Intervalle" ms
function live4ever() {
  var neverDie = Cookies.get("neverDie");
  if (neverDie == 1)
    $.post("inc/live4ever.inc.php", {}, function () {
      console.log("live");
    });
}

function testSession() {
  $.post("inc/testSession.inc.php", {}, function (resultat) {
    if (resultat == "") {
      bootbox.alert({
        title: "Dépassement du délai",
        message: "Votre session s'est achevée. Veuillez vous reconnecter.",
        callback: function () {
          window.location.replace("index.php");
        },
      });
    }
  });
}

function clearForm(form) {
  form
    .find(":input")
    .not(":button, :submit, :reset, :hidden, :checkbox, :radio")
    .val("");
  form.find(":checkbox, :radio").prop("checked", false);
}

function isDoubleClicked(element) {
  //if already clicked return TRUE to indicate this click is not allowed
  if (element.data("isclicked")) return true;
  //mark as clicked for 1 second
  element.data("isclicked", true);
  setTimeout(function () {
    element.removeData("isclicked");
  }, 1000);

  //return FALSE to indicate this click was allowed
  return false;
}

// variables de service pour la session infinie
var timeOutLive4ever;
var intervalle = 12000; // toutes les 12 secondes

function liveOnOff(onOff) {
  if (onOff == 1) {
    timeOutLive4ever = setInterval(live4ever, intervalle);
    $("#neverDie i").addClass("fa-spin");
    $("#never").html('<i class="fa fa-spinner fa-spin"></i>');
  } else {
    clearTimeout(timeOutLive4ever);
    $("#neverDie i").removeClass("fa-spin");
    $("#never").html("");
  }
}

$(document).ready(function () {
  bootbox.setDefaults({
    locale: "fr",
    backdrop: false,
  });

  var live = Cookies.get("neverDie");

  liveOnOff(live);

  // le bouton #neverDie est une bascule on/off
  $("body").on("click", "#neverDie", function () {
    if (Cookies.get("neverDie") == 1) {
      Cookies.remove("neverDie", { sameSite: "strict" });
      liveOnOff(0);
    } else {
      bootbox.confirm({
        title: "Never Die",
        message:
          "Je sais que je prends un risque en utilisant cette fonctionnalité",
        callback: function (result) {
          if (result == true) {
            Cookies.set("neverDie", 1, { sameSite: "strict" });
            liveOnOff(1);
          }
        },
      });
    }
  });

  // login - logout ------------------------------------------------
  //
  $("body").on("click", "#btn-login", function () {
    $.post("inc/modalLogin.inc.php", {}, function (resultat) {
      $("#modal").html(resultat);
      $("#modalLogin").modal("show");
    });
  });

  $("body").on("click", "#btn-modalLogin", function () {
    if ($("#form-login").valid()) {
      var identifiant = $("#identifiant").val();
      var passwd = $("#passwd").val();
      $.post(
        "inc/login.inc.php",
        {
          identifiant: identifiant,
          passwd: passwd,
        },
        function (resultat) {
          $("#menu").html(resultat);
          $("#modalLogin").modal("hide");
          var loggedUser = $("#loggedUser").text();
          var title = "Connexion";
          if (loggedUser != "") {
            live4ever();
            message = "Bienvenue " + loggedUser;
          } else message = "Adresse mail, pseudo et/ou mot de passe incorrect";

          bootbox.alert({
            title: title,
            message: message,
          });
        }
      );
    }
  });

  $("body").on("click", "#btn-logout", function () {
    bootbox.confirm({
      title: "Déconnexion",
      message: "Veuillez confirmer la déconnexion",
      callback: function (result) {
        if (result == true) {
          $.post("inc/logout.inc.php", {}, function () {
            window.location.reload("index.php");
          });
        }
      },
    });
  });


 


  // visualisation du mot de passe dans un champ "password"
  $("body").on("click", ".addonMdp", function (event) {
    testSession(event);
    if ($(this).next().prop("type") == "password")
      $(this).next().prop("type", "text");
    else $(this).next().prop("type", "password");
  });

  $("body").on("click", ".visuChamps", function () {
    var type = $(this).data("type");
    $("input").removeClass("visu");
    switch (type) {
      case "reparation":
        $(".reparation").addClass("visu");
        break;
      case "devis":
        $(".devis").addClass("visu");
        break;
      case "facture":
        $(".facture").addClass("visu");
        break;
    }
  });
});
