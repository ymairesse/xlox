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

function clearLeftRight(){
  $('#left').html('');
  $('#right').html('');
}

function clearUnique(){
  $('#unique').html('');
}

function clearAllDivs(){
  $('#left').html('');
  $('#right').html('');
  $('#unique').html('');
}

$(document).ready(function () {

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
    var idUser = Cookies.get("clientEnCours");
    var numeroBon = Cookies.get("bonEnCours");

    $.post(
      "inc/getFicheClient.inc.php",
      {
        idUser: idUser,
      },
      function (resultat) {
        $("#left").html(resultat);
      }
    );
    $.post(
      "inc/getFichesTravail.inc.php",
      {
        idUser: idUser,
      },
      function (resultat) {
        $("#right").html(resultat);
        $('#formTravail .nav-link[data-numerobon="' + numeroBon + '"]').trigger(
          "click"
        );
      }
    );
  });

  $("body").on("change", "#listeClients", function (event) {
    testSession(event);
    var idUser = $(this).val();
    Cookies.set("clientEnCours", idUser, { sameSite: "strict" });
    clearForm($("#formClient"));

    $.post(
      "inc/getFicheClient.inc.php",
      {
        idUser: idUser,
      },
      function (resultat) {
        $("#left").html(resultat);
      }
    );
    $.post(
      "inc/getFichesTravail.inc.php",
      {
        idUser: idUser,
      },
      function (resultat) {
        $("#right").html(resultat);
      }
    );
  });

  $("body").on("click", "#btn-editClient", function (event) {
    testSession(event);
    idUser = $("#listeClients").val();
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

    $('body').on('click', '.info-rgpd', function(){
    bootbox.alert({
      title: 'Information RGPD',
      message: '<strong>Oxfam Informatique</strong> s\'engage à n\'utiliser vos informations que pour des raisons d\'usages internes au magasin ou, si nécessaire, aux services techniques de Oxfam. En aucune cas, vos informations ne seront transmises à des tiers.'
    })
  })


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
          var idUser = resultat["idUser"];
          var nbModif = resultat["nb"];
          $("#modalEditClient").modal("hide");

          $.post(
            "inc/getFicheClient.inc.php",
            {
              idUser: idUser,
            },
            function (resultat) {
              $("#left").html(resultat);
            }
          );
          $('#listeClients option[value="' + idUser + "']").prop(
            "selected",
            true
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

  $("body").on("click", "#nosex", function (event) {
    testSession(event);
    $(".civilite").prop("checked", false);
  });

  $("body").on("click", "#btn-resetClient", function (event) {
    testSession(event);
    clearForm($("#formClient"));
  });

  $("body").on("click", ".editBon", function (event) {
    testSession(event);
    var idUser = $("#listeClients :selected").val();
    var numeroBon = $(this).data("numerobon");
    $.post(
      "inc/editBon.inc.php",
      {
        numeroBon: numeroBon,
        idUser: idUser,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditBon").modal("show");
      }
    );
  });

  $("body").on("click", "#formTravail .nav-link", function () {
    var numeroBon = $(this).data("numerobon");
    Cookies.set("bonEnCours", numeroBon, { sameSite: "strict" });
  });

  $("body").on("click", "#btn-addBon", function (event) {
    testSession(event);
    var idUser = $("#listeClients :selected").val();
    $.post(
      "inc/editBon.inc.php",
      {
        idUser: idUser,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditBon").modal("show");
      }
    );
  });

  $("body").on("click", "#btn-saveBon", function (event) {
    testSession(event);
    if ($("#modalFormBon").valid()) {
      var numeroBon = $(this).data("numerobon");
      var idUser = $(this).data("iduser");
      var formulaire = $("#modalFormBon").serialize();
      $.post(
        "inc/saveBon.inc.php",
        {
          formulaire: formulaire,
        },
        function (resultat1) {
          var message = resultat1 == 1 ? '1 enregistrement effectué' : 'Aucune modification effectuée';
          bootbox.alert({
            title: 'Enregistrement',
            message: message
          })
          $.post(
            "inc/getFichesTravail.inc.php",
            {
              idUser: idUser,
            },
            function (resultat) {
              $("#right").html(resultat);
              $("#modalEditBon").modal("hide");
              $(
                '#formTravail .nav-link[data-numerobon="' + numeroBon + '"]'
              ).trigger("click");
            }
          );
        }
      );
    }
  });

  $("body").on("click", ".deleteBon", function () {
    testSession(event);
    var idUser = $(this).data("iduser");
    var numeroBon = $(this).data("numerobon");
    $.post(
      "inc/deleteBon.inc.php",
      {
        idUser: idUser,
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
                  idUser: idUser,
                  numeroBon: numeroBon,
                  confirm: true,
                },
                function () {
                  $.post(
                    "inc/getFichesTravail.inc.php",
                    {
                      idUser: idUser,
                    },
                    function (resultat) {
                      $("#right").html(resultat);
                    }
                  );
                }
              );
          },
        });
      }
    );
  });

  $('body').on('click', '.btn-print', function(){
    var numeroBon = $(this).data('numerobon');
    console.log(numeroBon);
  })

  $('body').on('click', '.formTravail input, .formTravail textarea', function(event){
    testSession(event);
    var idUser = $("#listeClients :selected").val();
    var numeroBon = $(this).closest('.tab-pane').data('numerobon');
    $.post(
      "inc/editBon.inc.php",
      {
        numeroBon: numeroBon,
        idUser: idUser,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditBon").modal("show");
      }
    );
})


  // fiche client

  $("body").on("click", "#delClient", function (event) {
    testSession(event);
    var title = "Suppression d'un client";
    var idUser = $("#listeClients").val();
    $.post(
      "inc/getDependances.inc.php",
      {
        idUser: idUser,
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
              "Veuillez confirmer la suppression définitive de ce client",
            callback: function (result) {
              if (result == true)
                $.post(
                  "inc/deleteClient.inc.php",
                  {
                    idUser: idUser,
                  },
                  function () {
                    $("#listeClients option:selected").remove();
                    clearForm($("#formClient"));
                    Cookies.set("clientEnCours", "", { sameSite: "strict" });
                  }
                );
            },
          });
      }
    );
  });

  $('body').on('click', '#formClient input', function(event){
    testSession(event);
    idUser = $("#listeClients").val();
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
  })

  

  // Avancement du travail
  // ------------------------------------------------

  $('body').on('click', '.btn-avancement', function(event){
    testSession(event);
    var numeroBon = $(this).data('numerobon');
    var idUser = $(this).data('iduser');
    $.post('inc/getModalAvancement.inc.php', {
      numeroBon: numeroBon,
      idUser: idUser
    }, function(resultat){
      $('#modal').html(resultat);
      $('#modalAvancement').modal('show');
    })
  })

  $('body').on('click', '#btn-saveAvancement', function(event){
    testSession(event);
    if ($('#form-avancement').valid()){
      var formulaire = $('#form-avancement').serialize();
      var numeroBon = $(this).data('numerobon');
      $.post('inc/saveAvancement.inc.php', {
        formulaire: formulaire
      }, function(resultat){
        $('#tableauAvancement').html(resultat);
        // rétablir le nombre d'étapes d'avancement dans le bouton de la fiche de travail
        var nAv = $('#tableauAvancement table tr').length;
        $('.btn-avancement[data-numerobon="' + numeroBon + '"] .idAv').text(nAv);

      })
    }
  })

  $('body').on('click', '.btn-delAvancement', function(event){
    testSession(event);
    var ceci = $(this);
    var idAvancement = $(this).data('idavancement');
    var numeroBon = $(this).data('numerobon');
    bootbox.confirm({
      title: 'Effacer cette mention',
      message: 'Veuillez confirmer l\'effacement définitif de cette mention',
      callback: function(result){
        if (result == true) {
          $.post('inc/delAvancement.inc.php', {
            idAvancement: idAvancement,
          }, function(resultat){
            if (resultat == 1) {
              ceci.closest('tr').remove();
              // rétablir le nombre d'interactions dans le bouton de la fiche de réparation
              var nAv = $('#tableauAvancement table tr').length;
              $('.btn-avancement[data-numerobon="' + numeroBon + '"] .idAv').text(nAv);
            }
          })
        }
      }
    })
  })


  // profil et gestion de l'utilisateur actif

  $('body').on('click', '#profil', function(){
    testSession();
    $.post('inc/getOwnUserProfile.inc.php', {}, 
    function(resultat){
      clearLeftRight();
      $('#unique').html(resultat);
    })
  })

// profil utilisateur

  $('body').on('click', '#btn-saveProfil', function(){
    testSession();
    if ($('#formUser').valid()){
      var formulaire = $('#formUser').serialize();
      var idUser = $('#listeUsers option:selected').val();
      $.post('inc/saveUserOxfam.inc.php', {
        formulaire: formulaire
      }, function(resultatJSON){
        var resultat = JSON.parse(resultatJSON);
        var nb = resultat['nb'] > 0 ? 1 : 0;
        bootbox.alert({
          title: 'Enregistrement',
          message: nb > 0 ? 'Modification enregistrée' : 'Aucune modification effectuée',
          callback: function(){
            $.post('inc/refreshSelectUsers.inc.php', {}, 
            function(resultat){
              $('#selectUsers').html(resultat);
              $('#selectUsers option[value="' + idUser + '"]').prop('selected', true);
            })
          }
        });
      })
    }
  })

  // gestion des utilisateurs

  $('body').on('click', '#gestUsers', function(){
    testSession();
    var idUser = Cookies.get("UserEnCours");
    $.post('inc/getUsersProfiles.inc.php', {
      idUser: idUser 
    },
    function(resultat){
      clearLeftRight();
      $('#unique').html(resultat);
    })
  })

  $('body').on('change', '#listeUsers', function(){
    testSession();
    var idUser = $(this).val();
    Cookies.set("UserEnCours", idUser, { sameSite: "strict" });
    $.post('inc/getRandomUserProfile.inc.php', {
      idUser: idUser
    }, function(resultat){
      $('#ficheProfil').html(resultat);
    })
  })


  $('body').on('click', '.addonMdp', function(){
    if ($(this).next().prop('type') == 'password')
      $(this).next().prop('type', 'text');
    else $(this).next().prop('type', 'password');
  })

  $('body').on('click', '.btn-extended', function(){
    var zone = $(this).data('zone');
    $('.extended[data-zone="' + zone + '"]').toggleClass('d-none');
    $(this).find('i').toggleClass('fa-plus fa-minus');
  })


});

