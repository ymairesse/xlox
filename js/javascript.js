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

function clearForm($form) {
  $form
    .find(":input")
    .not(":button, :submit, :reset, :hidden, :checkbox, :radio")
    .val("");
  $form.find(":checkbox, :radio").prop("checked", false);
}

function clearLeftRight() {
  $("#left").html("");
  $("#right").html("");
}

function clearUnique() {
  $("#unique").html("");
}

function clearAllDivs() {
  $("#left").html("");
  $("#right").html("");
  $("#unique").html("");
}

$(document).ready(function () {
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
          if (loggedUser != "") message = "Bienvenue " + loggedUser;
          else message = "Adresse mail, pseudo et/ou mot de passe incorrect";

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

  // clic dans la navbar pour la fiche de réparation
  //
  $("body").on("click", "#ficheReparation", function (event) {
    testSession(event);
    clearUnique();
    // le client en cours est pris par défaut
    var idClient = Cookies.get("clientEnCours");

    $.post(
      "inc/getSelecteurClients.inc.php",
      {
        idClient: idClient,
        mode: "reparation",
      },
      function (resultat) {
        $("#left").html(resultat);
      }
    );
    // le dernier bon en cours est pris par défaut
    var numeroBon = Cookies.get("bonEnCours");
    $.post(
      "inc/getFichesTravail.inc.php",
      {
        idClient: idClient,
        numeroBon: numeroBon,
      },
      function (resultat) {
        $("#right").html(resultat);
        $('#formTravail .nav-link[data-numerobon="' + numeroBon + '"]').trigger(
          "click"
        );
      }
    );
  });

  $("body").on("change", "#selectClients", function (event) {
    testSession(event);
    var idClient = $(this).val();
    Cookies.set("clientEnCours", idClient, { sameSite: "strict" });
    //
    // sommes-nous dans la gestion des clients? -------------------------
    if ($(this).hasClass("gestion")) {
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
    //
    // sommes-nous dans un bon de réparation? ------------------------
    if ($(this).hasClass("reparation")) {
      // le dernier bon en cours est pris par défaut
      var numeroBon = Cookies.get("bonEnCours");
      $.post(
        "inc/getFichesTravail.inc.php",
        {
          idClient: idClient,
          numeroBon: numeroBon,
        },
        function (resultat) {
          $("#right").html(resultat);
          $(
            '#formTravail .nav-link[data-numerobon="' + numeroBon + '"]'
          ).trigger("click");
        }
      );
    }

    // //
    // // sommes-nous dans un bon de réparation? ------------------------
    // if ($(this).hasClass('reparation')) {
    //   $.post(
    //     "inc/getFichesTravail.inc.php",
    //     {
    //       idClient: idClient,
    //     },
    //     function (resultat) {
    //       $("#right").html(resultat);
    //     }
    //   );
    // }
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

  $("body").on("click", "#btn-saveClient", function (event) {
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

          $("#modalEditClient").modal("hide");

          $.post(
            "inc/getClientsProfiles.inc.php",
            {
              idClient: idClient,
              droits: "client",
            },
            function (resultat) {
              clearLeftRight();
              $("#unique").html(resultat);
              $('#selectClients option[value="' + idClient + "']").prop(
                "selected",
                true
              );
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

  //
  // sélection d'une fiche de travail dans les onglets -----------------
  $("body").on("click", "#ficheTravail .nav-link", function () {
    var numeroBon = $(this).data("numerobon");
    Cookies.set("bonEnCours", numeroBon, { sameSite: "strict" });
  });

  //
  // Enregistrement d'une nouvelle fiche de travail pour le client sélectionné
  $("body").on("click", "#btn-addBon", function (event) {
    testSession(event);
    var idClient = $("#selectClients option:selected").val();
    $.post(
      "inc/editBon.inc.php",
      {
        idClient: idClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditBon").modal("show");
      }
    );
  });

  // Edition: raccourci par clic dans un champ de la fiche de travail
  $("body").on(
    "click",
    ".formTravail input, .formTravail textarea, .formTravail .form-check-input, .editBon",
    function (event) {
      testSession(event);
      var idClient = $(this)
        .closest("form")
        .find('input[name="idClient"]')
        .val();
      var numeroBon = $(this)
        .closest("form")
        .find('input[name="numeroBon"]')
        .val();

      $.post(
        "inc/editBon.inc.php",
        {
          numeroBon: numeroBon,
          idClient: idClient,
        },
        function (resultat) {
          $("#modal").html(resultat);
          $("#modalEditBon").modal("show");
        }
      );
    }
  );

  $("body").on("click", "#btn-saveBon", function (event) {
    testSession(event);
    if ($("#modalFormBon").valid()) {
      var numeroBon = $("#modalFormBon input#numeroBon").val();
      var idClient = $("#modalFormBon input#idClient").val();

      var formulaire = $("#modalFormBon").serialize();
      $.post(
        "inc/saveBon.inc.php",
        {
          formulaire: formulaire,
        },
        function (resultat) {
          var numeroBon = resultat;
          bootbox.alert({
            title: "Enregistrement",
            message: 'Fiche de réparation n° ' + numeroBon + ' enregistrée',
          });

          Cookies.set('bonEnCours', numeroBon);

          $("#modalEditBon").modal("hide");

          $.post(
            "inc/getFichesTravail.inc.php",
            {
              idClient: idClient,
              numeroBon: numeroBon,
            },
            function (resultat) {
              $("#right").html(resultat);
              $(
                '#formTravail .nav-link[data-numerobon="' + numeroBon + '"]'
              ).trigger("click");
            }
          );
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
                  $.post(
                    "inc/getFichesTravail.inc.php",
                    {
                      idClient: idClient,
                      numeroBon: numeroBon,
                    },
                    function (resultat) {
                      $("#right").html(resultat);
                      $(
                        '#formTravail .nav-link[data-numerobon="' + numeroBon + '"]'
                      ).trigger("click");
                    }
                  );
                }
              );
          },
        });
      }
    );
  });

  // sélection par click d'un onglet de la liste des réparations
  $("body").on("click", ".nav-link", function () {
    $(".btn-print").attr("href", "javascript:void(0)").addClass("isDisabled");
    var numeroBon = $(this).data("numerobon");
    $('.btn-print[data-numerobon="' + numeroBon + '"]')
      .attr("href", "inc/getFicheTravailPDF.php?numeroBon=" + numeroBon)
      .removeClass("isDisabled");
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

  $("body").on("click", "#btn-newAccessoire", function () {
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
              "inc/saveMentionsBon.inc.php",
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

  // --------------------------------------------------------------------
  // Gestion de la fiche client ---------------------------------------

  $("body").on("click", "#delClient", function (event) {
    testSession(event);
    var title = "Suppression d'un client";
    var idClient = $("#selectClients").val();
    var nomClient = $("#selectClients option:selected").text();

    $.post(
      "inc/getDependances.inc.php",
      {
        idClient: idClient,
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
              if (result == true)
                $.post(
                  "inc/deleteClient.inc.php",
                  {
                    idClient: idClient,
                  },
                  function () {
                    $("#selectClients option:selected").remove();
                    clearForm($("#formClient"));
                    Cookies.set("clientEnCours", "", { sameSite: "strict" });
                  }
                );
            },
          });
      }
    );
  });

  $("body").on(
    "click",
    "#formClient input, #formClient select",
    function (event) {
      testSession(event);
      var idClient = $("#selectClients").val();
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
    }
  );

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

  // Avancement du travail
  // ------------------------------------------------

  $("body").on("click", ".btn-avancement", function (event) {
    testSession(event);
    var numeroBon = $(this).data("numerobon");
    $.post(
      "inc/getModalAvancement.inc.php",
      {
        numeroBon: numeroBon,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalAvancement").modal("show");
      }
    );
  });

  $("body").on("click", "#btn-saveAvancement", function (event) {
    testSession(event);
    if ($("#form-avancement").valid()) {
      var formulaire = $("#form-avancement").serialize();
      var numeroBon = $(this).data("numerobon");
      $.post(
        "inc/saveAvancement.inc.php",
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
      "inc/strikeAvancement.inc.php",
      {
        idAvancement: idAvancement,
        numeroBon: numeroBon,
      },
      function (resultat) {
        ceci.closest("tr").toggleClass("barre");
      }
    );
  });

  // profil et gestion de l'utilisateur actif

  $("body").on("click", "#profil", function (event) {
    testSession(event);
    $.post("inc/getOwnUserProfile.inc.php", {}, function (resultat) {
      clearLeftRight();
      $("#unique").html(resultat);
    });
  });

  // profil utilisateur

  $("body").on("click", "#btn-saveProfil", function (event) {
    testSession(event);
    if ($("#formUser").valid()) {
      var formulaire = $("#formUser").serialize();
      var idUser = $("#listeUsers option:selected").val();
      $.post(
        "inc/saveUserOxfam.inc.php",
        {
          formulaire: formulaire,
        },
        function (resultatJSON) {
          var resultat = JSON.parse(resultatJSON);
          var nb = resultat["nb"] > 0 ? 1 : 0;
          bootbox.alert({
            title: "Enregistrement",
            message:
              nb > 0
                ? "Modification enregistrée"
                : "Aucune modification effectuée",
            callback: function () {
              $.post("inc/refreshSelectUsers.inc.php", {}, function (resultat) {
                $("#selectUsers").html(resultat);
                $('#selectUsers option[value="' + idUser + '"]').prop(
                  "selected",
                  true
                );
              });
            },
          });
        }
      );
    }
  });

  // gestion des clients
  $("body").on("click", "#gestionClients", function (event) {
    testSession(event);
    var idClient = Cookies.get("clientEnCours");
    $.post(
      "inc/getClientsProfiles.inc.php",
      {
        idClient: idClient,
        droits: "client",
        mode: "gestion",
      },
      function (resultat) {
        clearLeftRight();
        $("#unique").html(resultat);
      }
    );
  });

  // gestion des utilisateurs
  $("body").on("click", "#gestUsers", function (event) {
    testSession(event);
    var idUser = Cookies.get("UserEnCours");
    $.post(
      "inc/getUsersProfiles.inc.php",
      {
        idUser: idUser,
      },
      function (resultat) {
        clearLeftRight();
        $("#unique").html(resultat);
      }
    );
  });

  $("body").on("change", "#listeUsers", function () {
    testSession();
    var idUser = $(this).val();
    Cookies.set("UserEnCours", idUser, { sameSite: "strict" });
    $.post(
      "inc/getRandomUserProfile.inc.php",
      {
        idUser: idUser,
      },
      function (resultat) {
        $("#ficheProfil").html(resultat);
      }
    );
  });

  // visualisation du mot de passe dans un champ "password"
  $("body").on("click", ".addonMdp", function () {
    if ($(this).next().prop("type") == "password")
      $(this).next().prop("type", "text");
    else $(this).next().prop("type", "password");
  });

  $("body").on("click", "#clientParDate", function () {
    Cookies.set("sortClient", "parDate", { sameSite: "strict" });
    $(".btn-sort").addClass("btn-default").removeClass("btn-primary");
    $("#clientParDate").addClass("btn-primary");
    var selectHeight = $(this).data('height');
    $.post("inc/getSelecteurClients.inc.php", {
      sortClient: 'parDate',
      selectHeight: selectHeight
    }, function (resultat) {
      $("#selecteurClients").html(resultat);
    });
  });

  $("body").on("click", "#clientAlphaAsc", function () {
    Cookies.set("sortClient", "alphaAsc", { sameSite: "strict" });
    $(".btn-sort").addClass("btn-default").removeClass("btn-primary");
    $("#clientAlphaAsc").addClass("btn-primary");
    var selectHeight = $(this).data('height');
    $.post("inc/getSelecteurClients.inc.php", {
      sortClient: 'alphaAsc',
      selectHeight: selectHeight
    }, function (resultat) {
      $("#selecteurClients").html(resultat);
    });
  });

  $("body").on("click", "#clientAlphaDesc", function () {
    Cookies.set("sortClient", "alphaDesc", { sameSite: "strict" });
    $(".btn-sort").addClass("btn-default").removeClass("btn-primary");
    $("#clientAlphaDesc").addClass("btn-primary");
    var selectHeight = $(this).data('height');
    $.post("inc/getSelecteurClients.inc.php", {
      sortClient: 'alphaDesc',
      selectHeight: selectHeight
    }, function (resultat) {
      $("#selecteurClients").html(resultat);
    });
  });
});
