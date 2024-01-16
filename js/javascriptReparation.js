$(document).ready(function () {
  //
  // idClient = identifiant du client en cours
  // sortClient = type de tri ('parDate', 'AlphaAsc', 'AlphaDesc')
  // mode = utilisation dans la liste des réparations ou dans la liste des clients
  // travailEnCours = les utilisateurs ont un travail en cours (true) ou sans importance (false)
  //
  function restoreSelecteurClients(idClient, sortClient, mode, travailEnCours) {
    $.post(
      "inc/refreshSelecteurClients.inc.php",
      {
        idClient: idClient,
        sortClient: sortClient,
        mode: mode,
        travailEnCours: travailEnCours,
      },
      function (resultat) {
        $("#selectClients").html(resultat);
        clearForm($("#formClient"));
        // cas où le client idClient a été supprimé
        $("listeClients tr.choosen").trigger("click");
      }
    );
  }

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
        $("#unique").html(resultat);
        $('.nav-link[data-numerobon="' + numeroBon + '"]').trigger("click");
        if ($("table.listeClients tr.choosen") != null) {
          $("table.listeClients tr.choosen")[0].scrollIntoView();
        }
      }
    );
  });

  // ---------------------------------------------------------------
  // sélection d'un client dans le cadre "listeClients" à gauche
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
  //clic dans une ligne de la liste des bons de réparation
  // pour voir la fiche correspondante
  // ---------------------------------------------------------------
  $("body").on("click", "#listeReparations tr", function (event) {
    testSession(event);
    var numeroBon = $(this).data("numerobon");
    $("#listeReparations tr").removeClass("choosen");
    $(this).addClass("choosen");
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

  // ------------------------------------------------------------------
  // Mise en vue de la réparation en cours actuellement sélectionnée
  // ------------------------------------------------------------------
  $('body').on('click', '.scrollReparations', function(){
    $('#listeReparations tr.choosen')[0].scrollIntoView();
  })

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
      var numeroBon = $("#modalFormBon input#numeroBon").val();
      var idClient = $("#modalFormBon input#idClient").val();
      // faut-il raffraîchir la liste des clients?

      var formulaire = $("#modalFormBon").serialize();

      $.post(
        "inc/reparations/saveBon.inc.php",
        {
          formulaire: formulaire,
        },
        function (resultat) {
          var numeroBon = resultat;
          // au cas où il s'agit d'une nouvelle fiche de travail
          Cookies.set("bonEnCours", numeroBon, { sameSite: "strict" });

          $("#modalEditBon").modal("hide");

          bootbox.alert({
            title: "Enregistrement",
            message: "Fiche de réparation n° " + numeroBon + " enregistrée",
            callback: function (numeroBon) {
              // rafraîchir l'écran par "fiches clients" ou "par fiches de travail"

              // s'il y a un tableau des clients à l'écran
              if ($("table.listeClients").length != 0) {
                // la liste des clients est affichée
                var sortClient = Cookies.get("sortClient");
                var numeroBon = Cookies.get("bonEnCours");

                $.post(
                  "inc/reparations/getFichesReparation4client.inc.php",
                  {
                    idClient: idClient,
                    numeroBon: numeroBon,
                    mode: "reparation",
                    sortClient: sortClient,
                  },
                  function (resultat) {
                    $("#unique").html(resultat);

                    $('.nav-link[data-numerobon="' + numeroBon + '"]').trigger(
                      "click"
                    );
                    $(
                      '.listeClients tr[data-idclient="' + numeroBon + '"]'
                    )[0].scrollIntoView();
                  }
                );
              } else {
                // c'est la liste la liste des fiches de réparations disponible
                // à gauche
                var bonEnCours = numeroBon;
                $.post(
                  "inc/reparations/getListeBons.inc.php",
                  {
                    termine: false,
                    bonEnCours: bonEnCours,
                  },
                  function (resultat) {
                    $("#unique").html(resultat);
                  }
                );
              }
            },
          });
        }
      );
    }
  });

  $("body").on("click", ".deleteBon", function (event) {
    testSession(event);
    var idClient = $(this).data("idclient");
    var numeroBon = $(this).data("numerobon");
    $.post(
      "inc/deleteBon.inc.php",
      {
        idClient: idClient,
        numeroBon: numeroBon,
      },
      function (resultat) {
        bootbox.confirm({
          title: '<i class="fa fa-warning fa-2x"></i> Veuillez confirmer',
          message: resultat,
          callback: function (result) {
            if (result == true)
              $.post(
                "inc/deleteBon.inc.php",
                {
                  idClient: idClient,
                  numeroBon: numeroBon,
                  confirm: true,
                },
                function () {
                  var sortClient = Cookies.get("sortClient");
                  var numeroBon = null;
                  Cookies.set("bonEnCours", numeroBon, { sameSite: "strict" });
                  $("#ficheReparation").trigger("click");
                }
              );
          },
        });
      }
    );
  });

  $("body").on("click", ".btn-searchClient", function (event) {
    testSession(event);
    var numeroBon = $(this).data("numerobon");
    var idClient = $(this).data("iduser");
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
        $("#unique").html(resultat);
      }
    );
  });

  // montrer la liste des clients n'ayant pas de travail en cours
  // afin de leur attribuer une nouvelle fiche de travail
  $("body").on("click", "#btn-findClient4travail", function (event) {
    testSession(event);
    $.post("inc/selectClient4Travail.inc.php", {}, function (resultat) {
      $("#modal").html(resultat);
      $("#modalSelectClient").modal("show");
      if ($("#modal .table.listeClients tr.choosen") != null) {
        $("#modal .table.listeClients tr.choosen")[0].scrollIntoView();
      }
    });
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
        termine: false,
        bonEnCours: bonEnCours,
      },
      function (resultat) {
        $("#unique").html(resultat);
        $('#listeReparations tr.choosen')[0].scrollIntoView();
      }
    );
  });

  // Avancement du travail
  // ------------------------------------------------

  $("body").on("click", ".btn-avancement", function (event) {
    testSession(event);
    var numeroBon = $(this).data("numerobon");
    $.post(
      "inc/reparations/getModalAvancement.inc.php",
      {
        numeroBon: numeroBon,
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
        }
      );
    }
  });

  $("body").on("click", ".btn-delAvancement", function (event) {
    testSession(event);
    var ceci = $(this);
    var idAvancement = $(this).data("idavancement");
    var numeroBon = $(this).data("numerobon");
    bootbox.confirm({
      title: "Effacer cette mention",
      message: "Veuillez confirmer l'effacement définitif de cette mention",
      callback: function (result) {
        if (result == true) {
          $.post(
            "inc/delAvancement.inc.php",
            {
              idAvancement: idAvancement,
            },
            function (resultat) {
              if (resultat == 1) {
                ceci.closest("tr").remove();
                // rétablir le nombre d'interactions dans le bouton de la fiche de réparation
                var nAv = $("#tableauAvancement table tr").length;
                $(
                  '.btn-avancement[data-numerobon="' + numeroBon + '"] .idAv'
                ).text(nAv);
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
});
