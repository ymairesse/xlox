$("document").ready(function () {
  // profil et gestion de l'utilisateur actif

  $("body").on("click", "#profil", function (event) {
    testSession(event);
    $.post("inc/getOwnUserProfile.inc.php", {}, function (resultat) {
      $("#unique").html(resultat);
    });
  });

  // profil utilisateur

  $("body").on("click", "#btn-saveProfil", function (event) {
    testSession(event);
    if ($("#formUser").valid()) {
      var formulaire = $("#formUser").serialize();
      var idUser = $("table#listeUsers tr.choosen").data("iduser");
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
              if (nb > 0)
                $.post(
                  "inc/refreshUsersOxfam.inc.php",
                  {
                    idUser: idUser,
                  },
                  function (resultat) {
                    $("#selectUsers").html(resultat);
                  }
                );
            },
          });
        }
      );
    }
  });

  //----------------------------------------------------------------
  // gestion des utilisateurs OXFAM
  //----------------------------------------------------------------

  // gestion des utilisateurs OXFAM: visualisation de la liste
  $("body").on("click", "#gestUsers", function (event) {
    testSession(event);
    var idUser = Cookies.get("UserEnCours");

    $.post(
      "inc/getUsersProfiles.inc.php",
      {
        idUser: idUser,
      },
      function (resultat) {
        $("#unique").html(resultat);
      }
    );
  });

  // --------------------------------------------------------
  // création d'un nouvel utilisateur
  //
  $("body").on("click", "#btn-newUser", function (event) {
    testSession();
    $.post(
      "inc/editUser.inc.php",
      {
        idUser: null,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditUser").modal("show");
      }
    );
  });

  // Édition d'un profil utilisateur par un clic dans le formulaire
  //
  $("body").on("click", "#formUser input", function (event) {
    testSession(event);
    var idUser = $("#idUser").val();
    // la liste de sélection est présente à gauche?
    var selfEdit = $("table#listeUsers").length == 0;
    $.post(
      "inc/editUser.inc.php",
      {
        idUser: idUser,
        selfEdit: selfEdit,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditUser").modal("show");
      }
    );
  });

  // Enregistrement d'un utilisateur OXFAM
  //
  $("body").on("click", "#btn-modalSaveUser", function (event) {
    testSession(event);
    if ($("#modalFormUser").valid()) {
      var formulaire = $("#modalFormUser").serialize();
      $.post(
        "inc/saveUserOxfam.inc.php",
        {
          formulaire: formulaire,
        },
        function (resultatJSON) {
          var resultat = JSON.parse(resultatJSON);
          var nbModif = resultat["nb"];
          if (nbModif > 0)
            var message =
              nbModif > 0 ? "Modification enregistrée" : "Aucun changement";
          var idUser = resultat["idUser"];
          $.post(
            "inc/getRandomUserProfile.inc.php",
            {
              idUser: idUser,
            },
            function (resultat) {
              $("#ficheProfil").html(resultat);
              $.post(
                "inc/refreshUsersOxfam.inc.php",
                {
                  idUser: idUser,
                },
                function (resultat) {
                  $("#selectUsers").html(resultat);
                }
              );
            }
          );
          bootbox.alert({
            title: "Enregistrement",
            message: message,
          });
          $("#modalEditUser").modal("hide");
        }
      );
    }
  });

  // gestion des utilisateurs OXFAM: sélection d'un utilisateur dans la liste
  //
  $("body").on("click", "table#listeUsers tr", function (event) {
    testSession(event);
    var idUser = $(this).data("iduser");
    Cookies.set("UserEnCours", idUser, { sameSite: "strict" });
    $("#listeUsers tr.choosen").removeClass("choosen");
    $(this).addClass("choosen");
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

  // Suppression d'un utilisateur
  //
  $("body").on("click", "#btn-delUser", function (event) {
    testSession(event);
    var idUser = $("table#listeUsers tr.choosen").data("iduser");
    var nom = $('#listeUsers tr[data-iduser="' + idUser + '"] td').html();
    console.log(nom);
    bootbox.confirm({
      title: "Suppression d'un utilisateur",
      message:
        "Veuillez confirmer la suppression définitive de<br><b>" + nom + "</b>",
      callback: function (result) {
        if (result == true) {
          $.post(
            "inc/deleteUser.inc.php",
            {
              idUser: idUser,
            },
            function (resultat) {
              $.post(
                "inc/refreshUsersOxfam.inc.php",
                {
                  idUser: null,
                },
                function (resultat) {
                  $("#selectUsers").html(resultat);
                  $("#formUser").find("input").val("");
                }
              );
            }
          );
        }
      },
    });
  });

  
});
