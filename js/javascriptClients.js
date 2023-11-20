$(document).ready(function () {
  //----------------------------------------------------------------
  // gestion des clients
  //----------------------------------------------------------------

  function restoreSelecteurClients(conteneur, idClient, sortClient, mode) {
    $.post(
      "inc/getSelecteurClients.inc.php",
      {
        idClient: idClient,
        sortClient: sortClient,
        mode: mode,
      },
      function (resultat) {
        conteneur.html(resultat);
        conteneur
          .find('.listeClients tr[data-idclient="' + idClient + '"]')
          .addClass("choosen");
        clearForm($("#formClient"));
        // cas où le client idClient a été supprimé
        conteneur.find(".listeClients tr.choosen").trigger("click");
      }
    );
  }

  // gestion des clients: page principale
  $("body").on("click", "#gestionClients", function (event) {
    testSession(event);
    var idClient = Cookies.get("clientEnCours");
    var sortClient = Cookies.get("sortClient");

    $.post(
      "inc/getClientsProfiles.inc.php",
      {
        idClient: idClient,
        mode: "gestion",
        sortClient: sortClient,
      },
      function (resultat) {
        $("#unique").html(resultat);
      }
    );
  });

  // ------------------------------------------------------
  // sélection d'un client
  $("body").on("click", ".listeClients tr", function (event) {
    testSession(event);
    // le widget "listeClients" doit se trouver dans un div .conteneurClients
    var conteneur = $(this).closest(".conteneurClients");
    var idClient = $(this).data("idclient");
    conteneur.find(".listeClients tr").removeClass("choosen");
    $(this).addClass("choosen");
    Cookies.set("clientEnCours", idClient, { sameSite: "strict" });
    // sommes-nous dans la gestion des clients? -------------------------
    if (conteneur.find("table").data("mode") == "gestion") {
      $.post(
        "inc/getProfilClient.inc.php",
        {
          idClient: idClient,
        },
        function (resultat) {
          $("#ficheProfilClient").html(resultat);
        }
      );
    }
    // sommes-nous dans un bon de réparation? ------------------------
    if ($(this).closest("table").data("mode") == "reparation") {
      // le dernier bon en cours est pris par défaut
      var numeroBon = Cookies.get("bonEnCours");
      $.post(
        "inc/getFichesTravail.inc.php",
        {
          idClient: idClient,
          numeroBon: numeroBon,
        },
        function (resultat) {
          $("#fichesReparation").html(resultat);
          $(
            '#formTravail .nav-link[data-numerobon="' + numeroBon + '"]'
          ).trigger("click");
        }
      );
    }
  });

  // --------------------------------------------------------------------
  // Suppression d'un client ---------------------------------------

  $("body").on("click", "#delClient", function (event) {
    testSession(event);
    var title = "Suppression d'un client";
    var mode = "gestion";
    // retrouver le conteneur entre les boutons d'ajout et de suppression
    // de client
    var conteneur = $(this).closest("div").find('.conteneurClients');;
    var clientToDelete = $(".listeClients tr.choosen").data("idclient");

    var sortClient =
    Cookies.get("sortClient") != undefined
        ? Cookies.get("sortClient")
        : "alphaAsc";
    var nomClient = $(".listeClients tr.choosen td").eq(0).text();
    $.post(
      "inc/getDependances.inc.php",
      {
        idClient: clientToDelete,
      },
      function (resultatJSON) {
        var resultat = JSON.parse(resultatJSON);
        var deleteOK = resultat["deleteOK"];
        if (deleteOK == "false") {
          bootbox.alert({
            title: title,
            message: resultat.raisons,
          });
        } else
          bootbox.confirm({
            title: title,
            message:
              "Veuillez confirmer la suppression définitive<br>du client <strong>" +
              nomClient +
              "</strong>",
            callback: function (result) {
              if (result == true){
                // choix du client sélectionné après la suppression du client actuel
                var nextClient = $(".listeClients tr.choosen").next().data('idclient');
                var prevClient = $(".listeClients tr.choosen").prev().data('idclient');
                // on sélectionne le client précédent dans le tableau
                var selectedClient = (prevClient == undefined) ? nextClient : prevClient;
                $.post(
                  "inc/deleteClient.inc.php",
                  {
                    idClient: clientToDelete,
                  },
                  function () {
                    restoreSelecteurClients(conteneur, selectedClient, sortClient, mode);
                  }
                );
            }
            },
          });
      }
    );
  });

  // Édition d'un client

  $("body").on("click", "#formClient", function (event) {
    testSession(event);
    var idClient = $("input#idClient").val();
    $.post(
      "inc/editClient.inc.php",
      {
        idClient: idClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditClient").modal("show");
      }
    );
  });

  // nouveau client

  $("body").on("click", "#nouveauClient", function (event) {
    testSession(event);
    var idClient = null;
    $.post(
      "inc/editClient.inc.php",
      {
        idClient: idClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditClient").modal("show");
      }
    );
  });

  $("body").on("click", "#btn-editClient", function (event) {
    testSession(event);
    var idClient = $("#listeClients").val();
    $.post(
      "inc/editClient.inc.php",
      {
        idClient: idClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditClient").modal("show");
      }
    );
  });

  $("body").on("click", "#btn-newClient", function (event) {
    testSession();
    var idUser = -1;
    $.post(
      "inc/editClient.inc.php",
      {
        idUser: idUser,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditClient").modal("show");
      }
    );
  });

  // -----------------------------------------------------------
  // Enregistrement d'une fiche client depuis la boîte modale

  $("body").on("click", "#btn-saveClient", function (event) {
    testSession(event);
    if ($("#modalFormClient").valid()) {
      var formulaire = $("#modalFormClient").serialize();
      $.post(
        "inc/saveUser.inc.php",
        {
          formulaire: formulaire,
        },
        function (resultatJSON) {
          var resultat = JSON.parse(resultatJSON);
          var idClient = resultat["idUser"];
          var nbModif = resultat["nb"];
          var sortClient = Cookies.get("sortClient");
          Cookies.set("clientEnCours", idClient, { sameSite: "strict" });

          $("#modalEditClient").modal("hide");

          $.post(
            "inc/getClientsProfiles.inc.php",
            {
              idClient: idClient,
              mode: "gestion",
              sortClient: sortClient,
            },
            function (resultat) {
              $("#unique").html(resultat);
            }
          );

          var message = " fiche client ";
          if (nbModif == 2) message = "1 " + message + " modifiée";
          else if (nbModif == 1) message = "1 " + message + " enregistrée";
          else message = "Aucune modification";
          bootbox.alert({
            title: "Enregistrement",
            message: message,
          });
        }
      );
    }
  });

  $("body").on("click", "#btn-resetClient", function (event) {
    testSession(event);
    clearForm($("#formClient"));
  });

  // ---------------------------------------------------------
  // présentation tri par date

  $("body").on("click", ".clientParDate", function (event) {
    testSession(event);
    var conteneur = $(this).closest(".conteneurClients");
    var sortClient = "parDate";
    Cookies.set("sortClient", "parDate", { sameSite: "strict" });
    var idClient = conteneur.find(".listeClients tr.choosen").data("idclient");
    var mode = conteneur.find(".listeClients").data("mode");
    conteneur
      .find(".btn-sort")
      .addClass("btn-default")
      .removeClass("btn-primary");
    conteneur.find(".clientParDate").addClass("btn-primary");
    restoreSelecteurClients(conteneur, idClient, sortClient, mode);
  });

  // présentation tri alphaAsc
  $("body").on("click", ".clientAlphaAsc", function (event) {
    testSession(event);
    var conteneur = $(this).closest(".conteneurClients");
    var sortClient = "alphaAsc";
    Cookies.set("sortClient", "alphaAsc", { sameSite: "strict" });
    var idClient = conteneur.find(".listeClients tr.choosen").data("idclient");
    var mode = conteneur.find(".listeClients").data("mode");

    conteneur
      .find(".btn-sort")
      .addClass("btn-default")
      .removeClass("btn-primary");
    conteneur.find(".clientAlphaAsc").addClass("btn-primary");
    restoreSelecteurClients(conteneur, idClient, sortClient, mode);
  });

  // présentation tri alphaDesc
  $("body").on("click", ".clientAlphaDesc", function (event) {
    testSession(event);
    var conteneur = $(this).closest(".conteneurClients");
    var sortClient = "alphaDesc";
    Cookies.set("sortClient", "alphaDesc", { sameSite: "strict" });
    var idClient = conteneur.find(".listeClients tr.choosen").data("idclient");
    var mode = conteneur.find(".listeClients").data("mode");

    conteneur
      .find(".btn-sort")
      .addClass("btn-default")
      .removeClass("btn-primary");
    conteneur.find(".clientAlphaDesc").addClass("btn-primary");
    restoreSelecteurClients(conteneur, idClient, sortClient, mode);
  });

  //
  // auto-enregistrement de fiche client ---------------------
  $("body").on("click", "#ficheClientPerso", function () {
    $.post(
      "inc/autoEditClient.inc.php",
      {
        idClient: null,
        autoFiche: true,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditClient").modal("show");
      }
    );
  });

  $("body").on("click", "#btn-autoSaveClient", function () {
    if ($("#modalFormClient").valid()) {
      var formulaire = $("#modalFormClient").serialize();
      var nom = $("#modalFormClient")[0]["nom"].value;
      var prenom = $("#modalFormClient")[0]["prenom"].value;
      var quidam = prenom + " " + nom;
      $.post(
        "inc/autoSaveClient.inc.php",
        {
          formulaire: formulaire,
        },
        function (resultatJSON) {
          var resultat = JSON.parse(resultatJSON);
          var nbModif = resultat["nb"];
          var message =
            nbModif != 0
              ? "<b>" +
                quidam +
                "</b>" +
                "<br>Merci! Votre compte client a été créé"
              : "L'enregistrement a échoué";
          bootbox.alert({
            title: "Création de votre compte client",
            message: message,
          });
          if (nbModif != 0) $("#modalEditClient").modal("hide");
        }
      );
    }
  });
});
