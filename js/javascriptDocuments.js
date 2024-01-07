$(document).ready(function () {
  //
  // *******************************************************
  // Gestion des garanties
  // *******************************************************

  // clic dans la navbar pour les bons de garantie
  $("body").on("click", "#garantieNominative", function (event) {
    testSession(event);
    // le client en cours est pris par défaut
    var idClient = Cookies.get("clientEnCours");
    // le dernier bon de garantie en cours est pris par défaut
    var ticketCaisse = Cookies.get("ticketCaisse");
    // mode de tri dans la liste des clients
    var sortClient = Cookies.get("sortClient");
    $.post(
      "inc/garanties/getBonsGarantie.inc.php",
      {
        idClient: idClient,
        ticketCaisse: ticketCaisse,
        sortClient: sortClient,
      },
      function (resultat) {
        $("#unique").html(resultat);
        var obj = $('tr[data-idclient="' + idClient + '"]');
        // y a-t-il une ligne correspondant à idClient dans la liste de gauche?
        if (obj.length != 0)
          $("table.listeClients tr.choosen")[0].scrollIntoView();
      }
    );
  });

  // ********************************************************
  // Accès aux garanties anonymes depuis le menu général
  // ********************************************************
  $("body").on("click", "#garantieAnonyme", function (event) {
    testSession(event);
    var ticketCaisse = Cookies.get("ticketCaisse");
    $.post(
      "inc/garanties/getGarantiesAnonymes.inc.php",
      {
        ticketCaisse: ticketCaisse,
      },
      function (resultat) {
        $("#unique").html(resultat);
        $(
          'table#listeGarantiesAnonymes tr[data-ticketcaisse="' +
            ticketCaisse +
            '"]'
        ).trigger("click");
        $("table#listeGarantiesAnonymes tr.choosen")[0].scrollIntoView();
      }
    );
  });

  // ---------------------------------------------------------
  // Ajout d'un nouveau bon de garantie pour le client $idClient
  // (seulement le #ticketCaisse et la date)
  // ---------------------------------------------------------
  $("body").on("click", "#btn-addBonGarantie", function (event) {
    testSession(event);
    var idClient = $(this).data("idclient");

    $.post(
      "inc/garanties/addBonGarantie.inc.php",
      {
        idClient: idClient,
        // pas encore de numéro de ticket de caisse
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditBonGarantie").modal("show");
      }
    );
  });

  // Ajout d'un nouveau bon de garantie anonyme
  // -------------------------------------------------------
  $("body").on("click", "#btn-addGarantieAnonyme", function (event) {
    testSession(event);
    $.post("inc/garanties/addBonGarantie.inc.php", {}, function (resultat) {
      $("#modal").html(resultat);
      $("#modalEditBonGarantie").modal("show");
    });
  });

  // -----------------------------------------------------------------
  // gestion des conditions particulières (bons CPAS,...)
  // -----------------------------------------------------------------
  $("body").on("click", ".editCondPart", function (event) {
    testSession(event);
    var ticketCaisse = $(this).data("ticketcaisse");
    if (isDoubleClicked($(this))) return;
    $.post(
      "inc/garanties/getConditionsPart.inc.php",
      {
        ticketCaisse: ticketCaisse,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalCondPart").modal("show");
      }
    );
  });

  // -----------------------------------------------------------------
  // Enregistrement du texte des cond. Part. pour le $ticketCaisse
  // -----------------------------------------------------------------
  $("body").on("click", "#btn-savemodalCondPart", function (event) {
    testSession(event);
    var formulaire = $("#formmodalCondPart").serialize();
    var ticketCaisse = $("#formmodalCondPart input#ticketCaisse").val();
    $.post(
      "inc/garanties/saveConditionsPart.inc.php",
      {
        formulaire: formulaire,
      },
      function (resultatJSON) {
        $("#modalCondPart").modal("hide");
        var resultat = JSON.parse(resultatJSON);
        var ticketcaisse = resultat["ticketCaisse"];
        var texte = resultat["texte"];
        var condPart = resultat["condPart"];
        // placer le texte dans le textarea
        $("textarea").val(texte);
        // placer le type dans le bouton
        $('#btn-conditionsPart[data-ticketcaisse="' + ticketCaisse + '"]').text(
          condPart
        );
      }
    );
  });

  // ------------------------------------------------------------------
  // Édition de l'entête () d'un bon de garantie $ticketCaisse
  // pour le client $idClient
  // -----------------------------------------------------------------
  $("body").on("click", ".btn-editBonGarantie", function (event) {
    testSession(event);
    var ticketCaisse = $(this).data("ticketcaisse");
    var idClient = $(this).data("idclient");

    $.post(
      "inc/garanties/editBonGarantie.inc.php",
      {
        idClient: idClient,
        ticketCaisse: ticketCaisse,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditBonGarantie").modal("show");
      }
    );
  });

  // -------------------------------------------------------------
  // Sélection d'un bon de garantie pour un client
  // à enregistrer dans un Cookie
  // -------------------------------------------------------------
  $("body").on("click", "#tabGaranties .nav-link", function (event) {
    testSession(event);
    var ticketCaisse = $(this).data("ticketcaisse");
    Cookies.set("ticketCaisse", ticketCaisse, { sameSite: "strict" });
    // la sélection et la présentation du bon de garantie sont asurés par Bootstrap
  });

  // ------------------------------------------------------
  // sélection d'un client dans le cadre "listeClients à gauche"
  // -------------------------------------------------------
  $("body").on(
    "click",
    "table.listeClients[data-mode='garantie'] tr",
    function (event) {
      testSession(event);
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

      var ticketCaisse = Cookies.get("ticketCaisse");
      $.post(
        "inc/garanties/getGaranties4unClient.inc.php",
        {
          idClient: idClient,
        },
        function (resultat) {
          $("#bonsGarantie").html(resultat);
          $(
            '#tabGaranties .nav-link[data-ticketcaisse="' + ticketCaisse + '"]'
          ).trigger("click");
        }
      );
    }
  );

  // -------------------------------------------------------------
  // Enregistrement d'un bon de garantie depuis la boîte modale
  // -------------------------------------------------------------
  $("body").on("click", "#btn-saveBonGarantie", function (event) {
    testSession(event);
    if ($("#modalFormBonGarantie").valid()) {
      var idClient = $("#modalFormBonGarantie input#idClient").val();
      var formulaire = $("#modalFormBonGarantie").serialize();
      var sortClient = Cookies.get("sortClient");
      $.post(
        "inc/garanties/saveBonGarantie.inc.php",
        {
          formulaire: formulaire,
        },
        function (resultatJSON) {
          var resultat = JSON.parse(resultatJSON);
          var rows = resultat["rows"];
          var ticketCaisse = resultat["ticketCaisse"];
          var title = "Bon de garantie";

          if (rows != 0) {
            Cookies.set("ticketCaisse", ticketCaisse, { sameSite: "strict" });
            $("#modalEditBonGarantie").modal("hide");
            bootbox.alert({
              title: title,
              message:
                "Enregistrement du bon de garantie pour le ticket <strong>" +
                ticketCaisse +
                "</strong>",
            });
            if (idClient != "") {
              // c'est une garantie nominative
              $.post(
                "inc/garanties/getBonsGarantie.inc.php",
                {
                  idClient: idClient,
                  sortClient: sortClient,
                },
                function (resultat) {
                  $("#unique").html(resultat);
                  $(
                    'table.listeClients tr[data-idclient="' + idClient + '"]'
                  ).trigger("click");
                  $(
                    '#tabGaranties .nav-link[data-ticketcaisse="' +
                      ticketCaisse +
                      '"]'
                  ).trigger("click");
                  $("table.listeClients tr.choosen")[0].scrollIntoView();
                }
              );
            } else {
              // c'est une garantie anonyme
              $.post(
                "inc/garanties/getGarantiesAnonymes.inc.php",
                {
                  ticketCaisse: ticketCaisse,
                },
                function (resultat) {
                  $("#unique").html(resultat);
                  $(
                    '#listeGarantiesAnonymes [data-ticketcaisse="' +
                      ticketCaisse +
                      '"]'
                  ).trigger("click");
                  // $('table#listeGarantiesAnonymes tr.choosen')[0].scrollIntoView();
                }
              );
            }
          } else
            bootbox.alert({
              title: title,
              message:
                "Le bon de garantie <strong>" +
                ticketCaisse +
                "</strong> n'a pas pu être créé. Existerait-il déjà?",
            });
        }
      );
    }
  });

  // ---------------------------------------------------------------
  // Effacement du bon de garantie $ticketCaisse et de tous les items
  // ----------------------------------------------------------------

  $("body").on("click", ".btn-delGarantie", function (event) {
    testSession();
    var ticketCaisse = $(this).data("ticketcaisse");
    var title = "Effacement du bon de garantie";
    bootbox.confirm({
      title: title,
      message:
        "Veuillez confirmer l'effacement définitif du bon de garantie pour le ticket de caisse <strong>" +
        ticketCaisse +
        "</strong>",
      callback: function (result) {
        if (result == true) {
          $.post(
            "inc/garanties/delBonGarantie.inc.php",
            {
              ticketCaisse: ticketCaisse,
            },
            function (resultat) {
              if (resultat == 1)
                bootbox.alert({
                  title: title,
                  message: "Bon de garantie supprimé",
                });
              if ($("table.listeClients tr").length != 0) {
                // C'est une garantie nominative
                $(
                  'table.listeClients[data-mode="garantie"] tr.choosen'
                ).trigger("click");
              } else {
                // c'est une garantie anonyme
                // quelle est la précédente ou la suivante garantie dans la table?
                var prevGarantie = $("table#listeGarantiesAnonymes tr.choosen")
                  .prev()
                  .data("ticketcaisse");
                // s'il n'y a pas de précédente, on choisit la suivante
                if (prevGarantie == undefined){
                  prevGarantie = $(
                    "table#listeGarantiesAnonymes tr.choosen"
                  )
                    .next()
                    .data("ticketcaisse");
                }
                // effacement de la garantie supprimée hors de la liste
                $(
                  'table#listeGarantiesAnonymes tr[data-ticketcaisse="' +
                    ticketCaisse +
                    '"'
                ).remove();
                // sélection de la garantie précédent celle qui a été supprimées
                $(
                  'table#listeGarantiesAnonymes tr[data-ticketcaisse="' +
                    prevGarantie +
                    '"]'
                ).trigger("click");
              }
            }
          );
        }
      },
    });
  });

  // ---------------------------------------------------
  // modification d'un item existant sur un bon de garantie
  // ---------------------------------------------------
  $("body").on("click", ".btn-editItem", function (event) {
    testSession(event);
    var idItem = $(this).closest("tr").data("iditem");
    var idClient = $(this).data("idclient");
    var ticketCaisse = $(this).data("ticketcaisse");
    $.post(
      "inc/garanties/editItem.inc.php",
      {
        idItem: idItem,
        idClient: idClient,
        ticketCaisse: ticketCaisse,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditItem").modal("show");
      }
    );
  });

  // ---------------------------------------------------
  // Ajout d'un nouvel item sur un bon de garantie
  // -----------------------------------------------------
  $("body").on("click", ".btn-addItem", function (event) {
    testSession(event);
    var ticketCaisse = $(this).data("ticketcaisse");
    var idClient = $(this).data("idclient");
    $.post(
      "inc/garanties/editItem.inc.php",
      {
        ticketCaisse: ticketCaisse,
        idClient: idClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditItem").modal("show");
      }
    );
  });

  // ---------------------------------------------------
  // enregistrement de la boîte modale d'édition des items
  // sur les bons de garantie
  // ---------------------------------------------------
  $("body").on("click", "#btn-saveItemGarantie", function (event) {
    testSession(event);
    if ($("#formModalEditItem").valid()) {
      var idClient = $("#modalEditItem input#idClient").val();
      var formulaire = $("#formModalEditItem").serialize();
      var ticketCaisse = $("#formModalEditItem input#ticketCaisse").val();
      $.post(
        "inc/garanties/saveItemGarantie.inc.php",
        {
          formulaire: formulaire,
        },
        function () {
          $("#modalEditItem").modal("hide");
          if (idClient == "") {
            $(
              'table#listeGarantiesAnonymes tr[data-ticketcaisse="' +
                ticketCaisse +
                '"]'
            ).trigger("click");
          } else
            $(
              'table.listeClients tr[data-idclient="' + idClient + '"]'
            ).trigger("click");
        }
      );
    }
  });

  // ---------------------------------------------------
  // suppression d'un item d'un bon de garantie
  // ---------------------------------------------------
  $("body").on("click", ".delItemGarantie", function (event) {
    testSession(event);
    var ceci = $(this);
    var idItem = ceci.closest("tr").data("iditem");
    var idBonGarantie = ceci.closest("tr").data("idbongarantie");
    var denomination = ceci.closest("tr").find(".materiel").text();
    var idClient = ceci.closest("tr").data("idclient");

    bootbox.confirm({
      title: "Suppression d'un item",
      message:
        "Voulez-vous vraiment supprimer l'article <br><strong style='text-align:center'>" +
        denomination +
        "</strong><br>de ce bon de garantie?",
      callback: function (result) {
        if (result == true) {
          $.post(
            "inc/garanties/delItemGarantie.inc.php",
            {
              idItem: idItem,
            },
            function (resultat) {
              // forcer la re-génération de l'ensemble des garanties (à améliorer?)
              $(
                'table.listeClients tr[data-idclient="' + idClient + '"]'
              ).trigger("click");
            }
          );
        }
      },
    });
  });

  // ------------------------------------------------------------------------------
  // boutons helpers pour l'édition des marchandises dans bon de garantie ou devis
  // ------------------------------------------------------------------------------
  $("body").on("click", "#btn-modalShowMarchandises", function (event) {
    testSession(event);
    var ceci = $(this);
    if (
      ceci.closest(".form-group").find(".modalSelectMarchandise").is(":hidden")
    ) {
      $.post(
        "inc/garanties/getSelecteurMarchandise.inc.php",
        {},
        function (resultat) {
          ceci
            .closest(".form-group")
            .find(".modalSelectMarchandise")
            .html(resultat);
        }
      );
    }
    ceci.closest(".form-group").find(".modalSelectMarchandise").toggle("slow");
  });

  // -----------------------------------------------------------------
  // sélection d'un article issu de la table du stock
  // -----------------------------------------------------------------
  $("body").on("change", ".modalSelectMarchandise", function (event) {
    testSession(event);
    var ceci = $(this);
    var idMateriel = $("#marchandises option:selected").val();
    $.post(
      "inc/garanties/getMateriel4id.inc.php",
      {
        idMateriel: idMateriel,
      },
      function (resultatJSON) {
        var resultat = JSON.parse(resultatJSON);
        var texte =
          resultat["marque"] +
          " " +
          resultat["modele"] +
          " " +
          resultat["caracteristiques"];
        var prix = resultat["prix"];

        $("#materiel").val(texte);
        $("#prix").val(prix);

        ceci
          .closest(".form-group")
          .find(".modalSelectMarchandise")
          .toggle("slow");
      }
    );
  });

  // -----------------------------------------------------------
  //  Sélection d'une garantie anonyme dans le sélecteur gauche
  // -----------------------------------------------------------
  $("body").on("click", "#listeGarantiesAnonymes tr", function (event) {
    testSession(event);
    var ticketCaisse = $(this).data("ticketcaisse");
    $("#listeGarantiesAnonymes tr").removeClass("choosen");
    $(this).addClass("choosen");
    Cookies.set("ticketCaisse", ticketCaisse, { sameSite: "strict" });
    $.post(
      "inc/garanties/getGarantie4ticket.inc.php",
      {
        ticketCaisse: ticketCaisse,
      },
      function (resultat) {
        $("#bonsGarantie").html(resultat);
      }
    );
  });
});
