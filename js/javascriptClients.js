function restoreSelecteurClients4gestion(
  conteneur,
  idClient,
  sortClient,
  mode
) {
  $.post(
    "inc/clients/refreshSelecteurClients.inc.php",
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

      // activer le client en cours
      conteneur.find(".listeClients tr.choosen").trigger("click");
    }
  );
}

$(function () {
  $('[data-toggle="tooltip"]').tooltip();

  $("body").on("change", "#rgpd", function () {
    var info = $(this).is(":checked");
    $(".btn-save").prop("disabled", !info);
  });

  $("body").on("click", "#infoRgpd", function () {
    var texte = $("#textRgpd").html();
    bootbox.alert({
      title: "RGPD",
      message: texte,
      backdrop: false,
    });
  });

  // --------------------------------------------------------------------
  // Mise en évidence des champs nécessaires dans tel ou tel contexte
  // --------------------------------------------------------------------
  $("body").on("click", "#visuChamps", function () {
    var type = $(this).data("type");
    $("input").removeClass("visu").removeClass("contact");
    switch (type) {
      case "reparation":
        $(".reparation").addClass("visu").addClass("contact");
        break;
      case "devis":
        $(".devis").addClass("visu");
        break;
      case "facture":
        $(".facture").addClass("visu").addClass("contact");
        break;
    }
  });

  //----------------------------------------------------------------
  // gestion des clients
  //----------------------------------------------------------------

  // --------------------------------------------------------------------
  // gestion des clients: page principale
  // --------------------------------------------------------------------
  $("body").on("click", "#gestionClients", function (event) {
    testSession(event);
    var idClient = Cookies.get("clientEnCours");
    var sortClient = Cookies.get("sortClient");

    $.post(
      "inc/clients/getClientsProfiles.inc.php",
      {
        idClient: idClient,
        mode: "gestion",
        sortClient: sortClient,
      },
      function (resultat) {
        $("#corpsPage").html(resultat);
        if ($("table.listeClients tr.choosen").length != 0)
          $("table.listeClients tr.choosen")[0].scrollIntoView({
            behavior: "smooth",
            block: "center",
          });
      }
    );
  });

  // --------------------------------------------------------------------
  // mise en évidence du client actuellement actif dans la liste des clients
  // --------------------------------------------------------------------
  $("body").on("click", "h5.boutonsTri", function () {
    var ceci = $(this);
    if (ceci.siblings(".tableClients").find("tr.choosen").length > 0)
      ceci
        .siblings(".tableClients")
        .find("tr.choosen")[0]
        .scrollIntoView({ behavior: "smooth", block: "center" });
  });

  // ------------------------------------------------------
  // sélection d'un client dans le cadre "listeClients à gauche"
  // -------------------------------------------------------
  $("body").on("click", "table.listeClients tr", function (event) {
    testSession(event);
    // le widget "listeClients" doit se trouver dans un div .tableClients
    var idClient = $(this).data("idclient");
    var sortClient = Cookies.get("sortClient");

    // dans le conteneur trouvé ci-dessus et pas dans un autre
    // qui contiendrait aussi la liste des clients
    $(this)
      .closest(".tableClients")
      .find(".listeClients tr")
      .removeClass("choosen");
    // on indique que le client $idClient est sélectionné
    $(this).addClass("choosen");
    Cookies.set("clientEnCours", idClient, { sameSite: "strict" });
    //
    //
    // xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    // sommes-nous dans la gestion des clients? -------------------------
    // xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    if ($(this).closest("table").data("mode") == "gestion") {
      $("#delClient").prop("disabled", false);
      $.post(
        "inc/clients/getProfilClient.inc.php",
        {
          idClient: idClient,
        },
        function (resultat) {
          $("#ficheProfilClient").html(resultat);
        }
      );
    }
  });

  // --------------------------------------------------------------------
  // Suppression d'un client ---------------------------------------
  // --------------------------------------------------------------------
  $("body").on("click", "#delClient", function (event) {
    testSession(event);
    var clientToDelete = $(".listeClients tr.choosen").data("idclient");
    if (clientToDelete != undefined) {
      var title = "Suppression d'un client";
      var mode = "gestion";
      // le div.tableClients contient le tableau de la liste des clients
      // c'est là qu'il faudra réinsérer ce tableau
      var conteneur = $(this).closest("div").find(".tableClients");

      var sortClient =
        Cookies.get("sortClient") != undefined
          ? Cookies.get("sortClient")
          : "alphaAsc";
      var nomClient = $(".listeClients tr.choosen td").eq(0).text();
      $.post(
        "inc/clients/getDependances.inc.php",
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
                if (result == true) {
                  // choix du client sélectionné après la suppression du client actuel
                  var nextClient = $(".listeClients tr.choosen")
                    .next()
                    .data("idclient");
                  var prevClient = $(".listeClients tr.choosen")
                    .prev()
                    .data("idclient");
                  // on sélectionne le client précédent (ou, à déraut, le suivent) dans le tableau
                  var selectedClient =
                    prevClient == undefined ? nextClient : prevClient;
                  Cookies.set("clientEnCours", selectedClient, {
                    sameSite: "strict",
                  });
                  $.post(
                    "inc/clients/deleteClient.inc.php",
                    {
                      idClient: clientToDelete,
                    },
                    function () {
                      // retour de la page de gestion des clients
                      $.post(
                        "inc/clients/getClientsProfiles.inc.php",
                        {
                          idClient: selectedClient,
                          mode: "gestion",
                          sortClient: sortClient,
                        },
                        function (resultat) {
                          $("#corpsPage").html(resultat);
                        }
                      );
                    }
                  );
                }
              },
            });
        }
      );
    }
  });

  // ---------------------------------------------------------
  // Édition d'un client par cliic dans sa fiche écran
  // ---------------------------------------------------------
  $("body").on("click", "#formClient", function (event) {
    testSession(event);
    if (isDoubleClicked($(this))) return;
    var idClient = $("input#idClient").val();
    $.post(
      "inc/clients/editClient.inc.php",
      {
        idClient: idClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditClient").modal("show");
      }
    );
  });

  // ---------------------------------------------------------
  // Création d'un nouveau client par clic sur le bouton
  // dans la colonne des clients
  // ---------------------------------------------------------
  $("body").on("click", ".nouveauClient", function (event) {
    testSession(event);
    if (isDoubleClicked($(this))) return;
    var typeClient = $(this).data('typeclient');
    $.post(
      "inc/clients/newClient.inc.php",{
        typeClient: typeClient
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditClient").modal("show");
      }
    );
  });

  // ---------------------------------------------------------
  // édition des données d'un client existant
  // ---------------------------------------------------------
  $("body").on("click", "#btn-editClient", function (event) {
    testSession(event);
    var idClient = $("table.listeClients tr.choosen").data("idclient");
    $.post(
      "inc/clients/editClient.inc.php",
      {
        idClient: idClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditClient").modal("show");
      }
    );
  });

  $('body').on('change', '#rgpd', function(){
    var info = $(this).is(":checked");
    $("#btn-saveClient").prop("disabled", !info);
  })

  // -----------------------------------------------------------
  // Enregistrement d'une fiche client depuis la boîte modale
  // ---------------------------------------------------------
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
          // retour de la page de gestion des clients
          $.post(
            "inc/clients/getClientsProfiles.inc.php",
            {
              idClient: idClient,
              mode: "gestion",
              sortClient: sortClient,
            },
            function (resultat) {
              $("#corpsPage").html(resultat);
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

  // ---------------------------------------------------------
  // présentation tri par date
  // ---------------------------------------------------------
  $("body").on("click", ".clientParDate", function (event) {
    testSession(event);
    var ceci = $(this);
    // le div.tableClients contient le tableau de la liste des clients
    // c'est là qu'il faudra réinsérer ce tableau
    var conteneur = ceci.closest(".boutonsTri").siblings(".tableClients");

    var idClient = conteneur.find("tr.choosen").data("idclient");
    var mode = conteneur.find("table.listeClients").data("mode");

    var sortClient = "parDate";
    Cookies.set("sortClient", "parDate", { sameSite: "strict" });

    ceci.closest(".boutonsTri").find("button").removeClass("btn-primary");
    ceci
      .closest(".boutonsTri")
      .find("button.clientParDate")
      .addClass("btn-primary");
    $.post(
      "inc/clients/refreshSelecteurClients.inc.php",
      {
        idClient: idClient,
        sortClient: sortClient,
        mode: mode,
      },
      function (resultat) {
        conteneur.html(resultat);
        if ($("table.listeClients tr.choosen").length != 0)
          $("table.listeClients tr.choosen")[0].scrollIntoView({
            behavior: "smooth",
            block: "center",
          });
      }
    );
  });

  // ---------------------------------------------------------
  // présentation tri alphaAsc
  // ---------------------------------------------------------
  $("body").on("click", ".clientAlphaAsc", function (event) {
    testSession(event);
    var ceci = $(this);

    // le div.tableClients contient le tableau de la liste des clients
    // c'est là qu'il faudra réinsérer ce tableau
    var conteneur = ceci.closest(".boutonsTri").siblings(".tableClients");

    var idClient = conteneur.find("tr.choosen").data("idclient");
    var mode = conteneur.find("table.listeClients").data("mode");

    var sortClient = "alphaAsc";
    Cookies.set("sortClient", "alphaAsc", { sameSite: "strict" });

    ceci.closest(".boutonsTri").find("button").removeClass("btn-primary");
    ceci
      .closest(".boutonsTri")
      .find("button.clientAlphaAsc")
      .addClass("btn-primary");

    $.post(
      "inc/clients/refreshSelecteurClients.inc.php",
      {
        idClient: idClient,
        sortClient: sortClient,
        mode: mode,
      },
      function (resultat) {
        conteneur.html(resultat);
        if ($("table.listeClients tr.choosen").length != 0)
          $("table.listeClients tr.choosen")[0].scrollIntoView({
            behavior: "smooth",
            block: "center",
          });
      }
    );
  });

  // ---------------------------------------------------------
  // présentation tri alphaDesc
  // ---------------------------------------------------------
  $("body").on("click", ".clientAlphaDesc", function (event) {
    testSession(event);
    var ceci = $(this);
    // le div.tableClients contient le tableau de la liste des clients
    // c'est là qu'il faudra réinsérer ce tableau
    var conteneur = ceci.closest(".boutonsTri").siblings(".tableClients");

    var idClient = conteneur.find("tr.choosen").data("idclient");
    var mode = conteneur.find("table.listeClients").data("mode");

    var sortClient = "alphaDesc";
    Cookies.set("sortClient", "alphaDesc", { sameSite: "strict" });

    ceci.closest(".boutonsTri").find("button").removeClass("btn-primary");
    ceci
      .closest(".boutonsTri")
      .find("button.clientAlphaDesc")
      .addClass("btn-primary");
    $.post(
      "inc/clients/refreshSelecteurClients.inc.php",
      {
        idClient: idClient,
        sortClient: sortClient,
        mode: mode,
      },
      function (resultat) {
        conteneur.html(resultat);
        if ($("table.listeClients tr.choosen").length != 0)
          $("table.listeClients tr.choosen")[0].scrollIntoView({
            behavior: "smooth",
            block: "center",
          });
      }
    );
  });

  // auto-création de fiche client ---------------------
  $("body").on("click", ".autoEditClient", function () {
    var ceci = $(this);
    var typeClient;
    if (ceci.hasClass("prive")) typeClient = "prive";
    else typeClient = "entreprise";
    $.post(
      "inc/clients/autoEditClient.inc.php",
      {
        idClient: null,
        typeClient: typeClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditClient").modal("show");
      }
    );
  });

  // $("body").on("click", "#ficheClientPerso", function () {
  //   $.post(
  //     "inc/clients/autoEditClient.inc.php",
  //     {
  //       idClient: null,
  //       autoFiche: true,
  //       typeClient: 'prive'
  //     },
  //     function (resultat) {
  //       $("#modal").html(resultat);
  //       $("#modalEditClient").modal("show");
  //     }
  //   );
  // });

  // $("body").on("click", "#ficheClientEntreprise", function () {
  //   $.post(
  //     "inc/clients/autoEditClient.inc.php",
  //     {
  //       idClient: null,
  //       autoFiche: true,
  //       typeClient: 'entreprise'
  //     },
  //     function (resultat) {
  //       $("#modal").html(resultat);
  //       $("#modalEditClient").modal("show");
  //     }
  //   );
  // });

  // ---------------------------------------------------------
  // auto-enregistrement de fiche client ---------------------
  // ---------------------------------------------------------
  $("body").on("click", "#btn-autoSaveClient", function () {
    if ($("#modalFormClient").valid()) {
      var formulaire = $("#modalFormClient").serialize();
      $.post(
        "inc/clients/autoSaveClient.inc.php",
        {
          formulaire: formulaire,
        },
        function (resultatJSON) {
          var resultat = JSON.parse(resultatJSON);
          var nbModif = resultat["nb"];
          var quidam = resultat["quidam"];
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

  $("body").on("click", "#btn-autoSaveEntreprise", function () {
    if ($("#modalFormEntreprise").valid()) {
      var formulaire = $("#modalFormClient").serialize();
      var nom = $("#modalFormClient")[0]["nom"].value;

      $.post(
        "inc/clients/autoSaveClient.inc.php",
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

  // -----------------------------------------------------------------
  // changer de formulaire en fonction du type de client (privé ou entreprise)
  // -----------------------------------------------------------------
  function vasY(typeClient) {
    // rechercher le $idClient éventuellement déjà défini
    var idClient = $("#modal").find('input:hidden[name="idUser"]').val();
    // réaliser le changement
    $.post(
      "inc/clients/changeTypeClient.inc.php",
      {
        idClient: idClient,
        typeClient: typeClient,
      },
      function (resultat) {
        console.log(resultat);
      }
    );
    $("#modalEditClient").modal("hide");
    // édition dans la boîte modale après changement
    $.post(
      "inc/clients/editClient.inc.php",
      {
        idClient: idClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditClient").modal("show");
        $(".tableClients tr.choosen").trigger("click");
      }
    );
  }

  // ---------------------------------------------------------
  // Changement du type de client: privé ou entreprise
  // ---------------------------------------------------------
  $("body").on("click", ".btn-typeClient", function (event) {
    testSession(event);
    // inversion du type
    if ($(this).hasClass("btn4prive")) typeClient = "prive";
    else typeClient = "entreprise";
    var modified = $('input[name="modified"]').val();
    // Si le formulaire a été modifié, on demande une confirmation
    if (modified == 1) {
      bootbox.confirm({
        title: "Changement de statut du client",
        message:
          "Vous allez perdre toute modification récente de cette fiche. Veuillez confirmer.",
        backdrop: false,
        callback: function (result) {
          if (result == true) vasY(typeClient);
        },
      });
    }
    // c'est OK, aucune modification n'a eu lieu
    else vasY(typeClient);
  });

  // --------------------------------------------------------------------
  // "écoute" s'il y a des modifications dans la fiche client
  // --------------------------------------------------------------------
  $("body").on("change", "#modalFormClient input, #modalFormClient select", function () {
    $("input[name='modified']").val(1);
  });
});
