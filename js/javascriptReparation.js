$(function () {
  // Actions sur les fiches de travail ---------------------------------
  // -------------------------------------------------------------------

  // clic dans la navbar principale pour la fiche de réparation par clients
  //
  $("body").on("click", "#ficheReparation", function (event) {
    testSession(event);

    // le client en cours est pris par défaut
    var idClient = Cookies.get("clientEnCours");
    // le dernier bon en cours est pris par défaut
    var numeroBon = Cookies.get("bonEnCours");
    // mode de tri des clients dans la liste
    var sortClient = Cookies.get("sortClient");

    $.post(
      "inc/reparations/getFichesReparation4client.inc.php",
      {
        idClient: idClient,
        numeroBon: numeroBon,
        mode: "reparation",
        sortClient: sortClient,
      },
      function (resultat) {
        $("#corpsPage").html(resultat);
        $('.nav-link[data-numerobon="' + numeroBon + '"]').trigger("click");
        if ($("table.listeClients tr.choosen") != null) {
          $("table.listeClients tr.choosen")[0].scrollIntoView({
            behavior: "smooth",
            block: "center",
          });
        }
      }
    );
  });

  // ---------------------------------------------------------------
  // sélection d'un client dans le cadre "listeClients" à gauche
  // pour la page "réparations par client"
  // ---------------------------------------------------------------
  $("body").on(
    "click",
    ".table.listeClients[data-mode='reparation'] tr",
    function (event) {
      testSession(event);

      $(this)
        .closest(".tableClients")
        .find(".listeClients tr")
        .removeClass("choosen");
      // on indique que le client $idClient est sélectionné
      $(this).addClass("choosen");

      var idClient = $(this).data("idclient");
      var numeroBon = Cookies.get("bonEnCours");

      Cookies.set("clientEnCours", idClient, { sameSite: "strict" });

      $.post(
        "inc/reparations/getFichesTravail.inc.php",
        {
          idClient: idClient,
          numeroBon: numeroBon,
        },
        function (resultat) {
          $("#fichesReparation").html(resultat);
          $('#tabBons .nav-link[data-numerobon="' + numeroBon + '"]').trigger(
            "click"
          );
        }
      );
    }
  );

  // Accès aux fiches de réparation par numéro du bon
  // clic dans une ligne de la liste des bons de réparation
  // pour voir la fiche correspondante
  // ---------------------------------------------------------------
  $("body").on("click", "#listeReparations td", function (event) {
    testSession(event);
    var numeroBon = $(this).closest("tr").data("numerobon");
    $("#listeReparations tr").removeClass("choosen");
    $(this).closest("tr").addClass("choosen");
    Cookies.set("bonEnCours", numeroBon, { sameSite: "strict" });
    $.post(
      "inc/reparations/getFiche4numeroBon.inc.php",
      {
        numeroBon: numeroBon,
      },
      function (resultat) {
        $("#ficheTechnique").html(resultat);
      }
    );
  });

  function formatNumber(number) {
    // Convertir le nombre en chaîne de caractères
    numberString = number.toString();
    // Ajouter des zéros au début de la chaîne pour atteindre une longueur de 6 caractères
    formattedNumber = numberString.padStart(6, "0");
    return formattedNumber;
  }

  // clôture d'un bon de réparation actuellement en cours
  $("body").on("click", ".btn-closeBon", function (event) {
    testSession(event);
    var numeroBon = formatNumber($(this).closest("tr").data("numerobon"));
    var nomClient = $(this).closest("tr").data("nom");
    var idUser = $(this).data("iduser");
    bootbox.confirm({
      title: "Veuillez confirmer",
      message: "Clôture de la fiche de travail <strong>" + numeroBon + "</strong><br>de <strong>" + nomClient + "</strong>",
      callback: function (result) {
        if (result == true) {
          $.post(
            "inc/reparations/closeBon.inc.php",
            {
              numeroBon: numeroBon,
              idUser: idUser,
            },
            function (resultat) {
              if (resultat == 1) {
                var prevBon = $("#listeReparations tr.choosen")
                  .prev()
                  .data("numerobon");
                var nextBon = $("#listeReparations tr.choosen")
                  .next()
                  .data("numerobon");
                // sélection du bon de réparation précédent ou, à défaut, du suivant
                var current = prevBon != undefined ? prevBon : nextBon;

                $("#listeReparations .choosen").remove();
                $('#listeReparations tr[data-numerobon="' + current + '"] td')
                  .eq(0)
                  .trigger("click");
              }
            }
          );
        }
      },
    });
  });

  // ------------------------------------------------------------------
  // Mise en vue de la réparation en cours actuellement sélectionnée
  // ------------------------------------------------------------------
  $("body").on("click", ".scrollReparations", function () {
    $("#listeReparations tr.choosen")[0].scrollIntoView({
      behavior: "smooth",
      block: "center",
    });
  });

  // sélection d'une fiche de travail dans les onglets -----------------
  // permet d'ajuster le Cookie pour le numéro du bon de réparation
  $("body").on("click", "#ficheTravail .nav-link", function (event) {
    testSession(event);
    var numeroBon = $(this).data("numerobon");
    Cookies.set("bonEnCours", numeroBon, { sameSite: "strict" });
  });

  // Enregistrement d'une nouvelle fiche de travail pour le client sélectionné
  $("body").on("click", "#btn-addBon", function (event) {
    testSession(event);

    var idClient = $(".listeClients tr.choosen").data("idclient");

    $.post(
      "inc/reparations/editBon.inc.php",
      {
        idClient: idClient,
        // pas de numero de bon
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditBon").modal("show");
      }
    );
  });

  // Edition: raccourci par clic dans un champ de la fiche de travail
  $("body").on("click", ".openModalTravail", function (event) {
    testSession(event);
    if (isDoubleClicked($(this))) return;
    var idClient = $(this).closest("form").find('input[name="idClient"]').val();
    var numeroBon = $(this)
      .closest("form")
      .find('input[name="numeroBon"]')
      .val();

    $.post(
      "inc/reparations/editBon.inc.php",
      {
        numeroBon: numeroBon,
        idClient: idClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditBon").modal("show");
      }
    );
  });

  // enregistrement du bon de réparation en cours d'édition
  // ------------------------------------------------------------
  $("body").on("click", "#btn-saveBon", function (event) {
    testSession(event);
    if ($("#modalFormBon").valid()) {
      // L'identifiant du client se trouve dans le formulaire modal
      var idClient = $("#modalFormBon input#idClient").val();

      var formulaire = $("#modalFormBon").serialize();
      // quel est l'état du travail: terminé ou en cours?
      var termine = $("#modalFormBon input[name='termine']:checked").val();

      $.post(
        "inc/reparations/saveBon.inc.php",
        {
          formulaire: formulaire,
          idClient: idClient,
        },
        function (resultat) {
          var numeroBon = resultat;
          // au cas où il s'agit d'une nouvelle fiche de travail
          Cookies.set("bonEnCours", numeroBon, { sameSite: "strict" });

          $("#modalEditBon").modal("hide");

          bootbox.alert({
            title: "Enregistrement",
            message: "Fiche de réparation n° " + numeroBon + " enregistrée",
            callback: function () {
              // rafraîchir l'écran par "fiches clients" ou "par fiches de travail"

              // s'il y a un tableau des clients à l'écran en zone gauche
              if ($("table.listeClients").length != 0) {
                // la liste des clients est affichée
                var sortClient = Cookies.get("sortClient");

                $.post(
                  "inc/reparations/getFichesReparation4client.inc.php",
                  {
                    idClient: idClient,
                    numeroBon: numeroBon,
                    mode: "reparation",
                    sortClient: sortClient,
                  },
                  function (resultat) {
                    $("#corpsPage").html(resultat);
                    // sélection de l'onglet de la fiche de travail
                    $('.nav-link[data-numerobon="' + numeroBon + '"]').trigger(
                      "click"
                    );

                    // y a-t-il une ligne correspondant à idClient dans la liste de gauche?
                    var obj = $('tr[data-idclient="' + idClient + '"]');
                    // ramener doucement cette ligne en vue
                    if (obj.length != 0) {
                      obj[0].scrollIntoView({
                        behavior: "smooth",
                        block: "center",
                      });
                    }
                  }
                );
              } else {
                // c'est la liste des fiches de réparations disponible à gauche
                $.post(
                  "inc/reparations/getListeBons.inc.php",
                  {
                    termine: termine,
                    bonEnCours: numeroBon,
                  },
                  function (resultat) {
                    $("#corpsPage").html(resultat);
                    var obj = $(
                      '#listeReparations tr[data-numerobon="' + numeroBon + '"]'
                    );
                    if (obj.length != 0) {
                      obj[0].scrollIntoView({
                        behavior: "smooth",
                        block: "center",
                      });
                    }
                  }
                );
              }
            },
          });
        }
      );
    }
  });

  // Suppression d'un bon de réparation (le numéro du bon figure sur le bouton .deleteBon)
  $("body").on("click", ".deleteBon", function () {
    var numeroBon = $(this).data("numerobon");
    var idClient = $(this).data("idclient");
    // est-on dans l'écran de la liste des bons ou de la liste des clients?
    var choice = $(this).data("choice");
    bootbox.confirm({
      title: '<i class="fa fa-warning fa-2x"></i> Veuillez confirmer',
      message: "Suppression de la fiche de travail #" + numeroBon,
      callback: function (result) {
        if (result == true) {
          $.post(
            "inc/reparations/deleteBon.inc.php",
            {
              numeroBon: numeroBon,
              idClient: idClient,
            },
            function (resultat) {
              if (resultat == 1) {
                Cookies.set("bonEnCours", null, { sameSite: "strict" });
                // selon que l'on est parti de la liste des clients ou de la liste des bons
                if (choice == "listeBons")
                  $("#reparations4bons").trigger("click");
                else $("#ficheReparation").trigger("click");
                bootbox.alert({
                  title: "Effacement",
                  message: "Bon de réparation n° " + numeroBon + "supprimé",
                });
              }
            }
          );
        }
      },
    });
  });

  // présentation dans l'écran des réparations par client
  $("body").on("click", ".btn-searchClient", function (event) {
    testSession(event);
    var numeroBon = $(this).data("numerobon");
    var idClient = $(this).data("iduser");
    var sortClient = Cookies.get("sortClient");
    Cookies.set("clientEnCours", idClient, { sameSite: "strict" });
    $.post(
      "inc/reparations/getFichesReparation4client.inc.php",
      {
        idClient: idClient,
        numeroBon: numeroBon,
        mode: "reparation",
        sortClient: sortClient,
      },
      function (resultat) {
        $("#corpsPage").html(resultat);
      }
    );
  });

  // montrer la liste des clients n'ayant pas de travail en cours
  // afin de leur attribuer une nouvelle fiche de travail
  $("body").on("click", "#btn-findClient4travail", function (event) {
    testSession(event);
    // quel est le client actuellement sélectionné dans la liste gauche?
    var idClient = $(".listeClients tr.choosen").data("idclient");
    var sortClient = Cookies.get("sortClient");
    $.post(
      "inc/clients/selectClient4Travail.inc.php",
      {
        idClient: idClient,
        sortClient: sortClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalSelectClient").modal("show");
        var obj = $(
          "#modal .table.listeClients tr[data-idclient='" + idClient + "'"
        );
        if (obj.length != 0) {
          obj[0].scrollIntoView({
            behavior: "smooth",
            block: "center",
          });
        }
      }
    );
  });

  // un client est sélectionné dans la boîte modale
  $("body").on("click", "#btn-modalChooseClient", function (event) {
    testSession(event);

    var idClient = $("#modalSelectClient table.listeClients tr.choosen").data(
      "idclient"
    );
    if (idClient != undefined) {
      // le client $idClient a été sélectionné dans la boîte modale de recherche
      // de clients sans travail en cours (#modalSelectClient)
      // on peut donc cacher cette boîte modale
      $("#modalSelectClient").modal("hide");
      // et présenter le formulaire d'établissement d'une fiche de travail
      // pour l'utilisateur $idClient
      $.post(
        "inc/reparations/editBon.inc.php",
        {
          idClient: idClient,
        },
        function (resultat) {
          $("#modal").html(resultat);
          $("#modalEditBon").modal("show");
        }
      );
    }
  });

  // sélection par click d'un onglet de la liste des réparations
  $("body").on("click", "#tabBons .nav-link", function (event) {
    testSession(event);
    $(".btn-print").attr("href", "javascript:void(0)").addClass("isDisabled");
    var numeroBon = $(this).data("numerobon");
    $('.btn-print[data-numerobon="' + numeroBon + '"]').removeClass(
      "isDisabled"
    );
  });

  // ouverture de la liste des réparations en cours
  $("body").on("click", "#reparations4bons", function (event) {
    testSession(event);
    var bonEnCours = Cookies.get("bonEnCours");
    $.post(
      "inc/reparations/getListeBons.inc.php",
      {
        termine: 0,
        bonEnCours: bonEnCours,
      },
      function (resultat) {
        $("#corpsPage").html(resultat);
        // si un bon de réparation a été sélectionné
        if ($("#listeReparations tr.choosen").length != 0) {
          $("#listeReparations tr.choosen")[0].scrollIntoView({
            behavior: "smooth",
            block: "center",
          });
        }
      }
    );
  });

  // ouverture de la liste des réparations terminées
  $("body").on("click", "#reparationsArchives", function (event) {
    testSession(event);
    var bonEnCours = Cookies.get("bonEnCours");
    $.post(
      "inc/reparations/getListeBons.inc.php",
      {
        termine: 1,
        bonEnCours: bonEnCours,
      },
      function (resultat) {
        $("#corpsPage").html(resultat);
        // si un bon de réparation a été sélectionné
        if ($("#listeReparations tr.choosen").length != 0) {
          $("#listeReparations tr.choosen")[0].scrollIntoView({
            behavior: "smooth",
            block: "center",
          });
        }
      }
    );
  });
  // Avancement du travail
  // ------------------------------------------------

  $("body").on("click", ".btn-avancement", function (event) {
    testSession(event);
    var numeroBon = $(this).data("numerobon");
    var idClient = $("table.listeClients tr.choosen").data("idclient");

    $.post(
      "inc/reparations/getModalAvancement.inc.php",
      {
        numeroBon: numeroBon,
        idClient: idClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalAvancement").modal("show");
        event.stopPropagation();
      }
    );
  });

  $("body").on("click", "#btn-saveAvancement", function (event) {
    testSession(event);
    if ($("#form-avancement").valid()) {
      var formulaire = $("#form-avancement").serialize();
      var numeroBon = $(this).data("numerobon");
      $.post(
        "inc/reparations/saveAvancement.inc.php",
        {
          formulaire: formulaire,
        },
        function (resultat) {
          $("#tableauAvancement").html(resultat);
          $("#texte").val("");
          // rétablir le nombre d'étapes d'avancement dans le bouton de la fiche de travail
          var nAv = $("#tableauAvancement table tr").length;
          $('.btn-avancement[data-numerobon="' + numeroBon + '"] .idAv').text(
            nAv
          );
          // actualiser la liste des clients par ordre de dates
          $("button.clientParDate").trigger("click");
        }
      );
    }
  });

  $("body").on("click", ".btn-delAvancement", function (event) {
    testSession(event);
    var ceci = $(this);
    var idAvancement = $(this).data("idavancement");
    var numeroBon = $(this).data("numerobon");
    var idClient = $(this).data("idclient");

    bootbox.confirm({
      title: "Effacer cette mention",
      message: "Veuillez confirmer l'effacement définitif de cette mention",
      callback: function (result) {
        if (result == true) {
          $.post(
            "inc/reparations/delAvancement.inc.php",
            {
              idAvancement: idAvancement,
              idClient: idClient,
            },
            function (resultat) {
              if (resultat == 1) {
                ceci.closest("tr").remove();
                // rétablir le nombre d'interactions dans le bouton de la fiche de réparation
                var nAv = $("#tableauAvancement table tr").length;
                $(
                  '.btn-avancement[data-numerobon="' + numeroBon + '"] .idAv'
                ).text(nAv);
                // actualiser la liste des clients par ordre de dates
                $("button.clientParDate").trigger("click");
              }
            }
          );
        }
      },
    });
  });

  $("body").on("click", ".btn-strikeAvancement", function (event) {
    testSession(event);
    var ceci = $(this);
    var idAvancement = $(this).data("idavancement");
    var numeroBon = $(this).data("numerobon");
    $.post(
      "inc/reparations/strikeAvancement.inc.php",
      {
        idAvancement: idAvancement,
        numeroBon: numeroBon,
      },
      function (resultat) {
        ceci.closest("tr").toggleClass("barre");
      }
    );
  });

  // Gestion des types de matériel

  $("body").on("click", "#btn-moreMatos", function (event) {
    testSession(event);
    bootbox.prompt({
      title: "Nouveau type de matériel",
      callback: function (texte) {
        if (texte != "" && texte != null) {
          $.post(
            "inc/saveNewMatos.inc.php",
            {
              matos: texte,
            },
            function (resultat) {
              $("#selectMateriel").html(resultat);
            }
          );
        }
      },
    });
  });

  $("body").on("click", "#btn-editMatos", function (event) {
    testSession(event);
    if ($("select#typeMateriel").val() > 0) {
      var texte = $("select#typeMateriel option:selected").text();
      var idMatos = $("select#typeMateriel option:selected").val();
      bootbox.prompt({
        title: "Edition d'un matériel",
        value: texte,
        callback: function (texte) {
          if (texte != "" && texte != null)
            $.post(
              "inc/saveNewMatos.inc.php",
              {
                idMatos: idMatos,
                matos: texte,
              },
              function (resultat) {
                $("#selectMateriel").html(resultat);
              }
            );
        },
      });
    }
  });

  // Gestion des accessoires supplémentaires déposés

  $("body").on("click", "#btn-newAccessoire", function (event) {
    testSession(event);
    var numeroBon = $(this).data("numerobon");
    bootbox.prompt({
      title: "Ajout d'accessoires",
      callback: function (texte) {
        if (texte != "" && texte != null)
          $.post(
            "inc/saveNewAccessoire.inc.php",
            {
              accessoire: texte,
              numeroBon: numeroBon,
            },
            function (resultat) {
              $("#accessoires").html(resultat);
            }
          );
      },
    });
  });

  // Gestion des mentions automatiques ------------------------------------

  $("body").on("click", ".btn-pasteMention", function (event) {
    testSession(event);
    var ceci = $(this);
    var idMention = $(this)
      .closest(".input-group")
      .find("select option:selected")
      .val();
    if (idMention != "") {
      var texte = $(this)
        .closest(".input-group")
        .find("select option:selected")
        .text();
      var originalText = $(this)
        .closest(".autoMentions")
        .find("textarea")
        .val();
      var finalText = texte + "\n" + originalText;
      $(this).closest(".autoMentions").find("textarea").val(finalText);
    }
  });

  $("body").on("click", ".btn-mentions", function (event) {
    testSession(event);
    var type = $(this).data("type");
    if ($('.modalMentions[data-type="' + type + '"]').is(":hidden")) {
      $.post(
        "inc/getMentions.inc.php",
        {
          type: type,
        },
        function (resultat) {
          $('.modalMentions[data-type="' + type + '"]').html(resultat);
        }
      );
    }
    $('.modalMentions[data-type="' + type + '"]').toggle("slow");
  });

  $("body").on("click", ".btn-moreMentions", function (event) {
    testSession(event);
    var type = $(this).data("type");
    bootbox.prompt({
      title: "Nouvelle mention",
      callback: function (texte) {
        if (texte != "" && texte != null)
          $.post(
            "inc/saveMentionsBon.inc.php",
            {
              mention: texte,
              type: type,
            },
            function (resultat) {
              $.post(
                "inc/getMentions.inc.php",
                {
                  type: type,
                },
                function (resultat) {
                  $('.modalMentions[data-type="' + type + '"]').html(resultat);
                  if (
                    $('.modalMentions[data-type="' + type + '"]').is(":hidden")
                  ) {
                    $('.modalMentions[data-type="' + type + '"]').toggle(
                      "slow"
                    );
                  }
                }
              );
            }
          );
      },
    });
  });

  $("body").on("click", ".btn-editMention", function (event) {
    testSession(event);
    var type = $(this).data("type");
    if ($("#mentions option:selected").val() > 0) {
      var texte = $("#mentions option:selected").text();
      var idMention = $("#mentions option:selected").val();
      bootbox.prompt({
        title: "Edition d'une mention",
        message: "Laisser vide pour effacer",
        value: texte,
        callback: function (texte) {
          if (texte != null)
            $.post(
              "inc/reparations/saveMentionsBon.inc.php",
              {
                mention: texte,
                type: type,
                idMention: idMention,
              },
              function (resultat) {
                $.post(
                  "inc/getMentions.inc.php",
                  {
                    type: type,
                  },
                  function (resultat) {
                    $('.modalMentions[data-type="' + type + '"]').html(
                      resultat
                    );
                    $('#mentions option[value="' + idMention + '"]').prop(
                      "selected",
                      true
                    );
                    if (
                      $('.modalMentions[data-type="' + type + '"]').is(
                        ":hidden"
                      )
                    ) {
                      $('.modalMentions[data-type="' + type + '"]').toggle(
                        "slow"
                      );
                    }
                  }
                );
              }
            );
        },
      });
    }
  });

  // -------------------------------------------------------------------
  // Suppression d'un item de la liste des accessoires disponibles
  // --------------------------------------------------------------------
  $("body").on("click", ".btn-delAccessoire", function () {
    var ceci = $(this);
    var idAccessoire = ceci.closest("tr").data("idaccessoire");
    var accessoire = ceci.closest("tr").find("td").eq(1).text().trim();
    var message =
      "Veuillez confirmer la suppression définitive de l'accessoire \"" +
      accessoire +
      '"';
    bootbox.confirm({
      title: "Suppression",
      message: message,
      callback: function (result) {
        if (result == true) {
          $.post(
            "inc/reparations/delAccessoire.inc.php",
            {
              idAccessoire: idAccessoire,
            },
            function (resultat) {
              if (resultat == 1) ceci.closest("tr").remove();
            }
          );
        }
      },
    });
  });

  // ---------------------------------------------------------------------
  // Ajout d'un nouvel item à la liste des accessoires disponibles
  // ---------------------------------------------------------------------
  $("body").on("click", "#btn-addAccessoire", function () {
    bootbox.prompt({
      title: "Nouvel accessoire",
      message: "Dénomination de cet accessoire",
      maxlength: "31",
      callback: function (accessoire) {
        if (accessoire != null) {
          $.post(
            "inc/reparations/addAccessoire.inc.php",
            {
              accessoire: accessoire,
            },
            function (resultat) {
              $("#gestionAccessoires").trigger("click");
            }
          );
        }
      },
    });
  });

  // ------------------------------------------------------------------
  // Edition d'un item parmi les accessoires
  // ------------------------------------------------------------------
  $("body").on("click", ".btn-editAccessoire", function () {
    var ceci = $(this);
    var idAccessoire = ceci.closest("tr").data("idaccessoire");
    var accessoire = ceci.closest("tr").find("td").eq(1).text().trim();
    var message = "Nouvelle dénomination de cet accessoire";
    var nb = ceci.data("nb");
    if (nb != 0)
      message +=
        "<br><strong>Attention! Vous allez modifier cette dénomination sur des fiches de réparation existantes.</strong>";
    bootbox.prompt({
      title: "Edition d'un accessoire",
      message: message,
      value: accessoire,
      callback: function (accessoire) {
        if (accessoire != null) {
          $.post(
            "inc/reparations/editAccessoire.inc.php",
            {
              idAccessoire: idAccessoire,
              accessoire: accessoire,
              maxlength: "30",
            },
            function (resultat) {
              if (resultat != 0) {
                ceci.closest("tr").find("td").eq(1).text(accessoire);
              }
            }
          );
        }
      },
    });
  });
});
