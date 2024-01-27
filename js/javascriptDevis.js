$(function () {
  // clic dans la navbar pour un devis
  $("body").on("click", "#devis", function (event) {
    testSession(event);
    // le client en cours est pris par défaut
    var idClient = Cookies.get("clientEnCours");

    // mode de tri dans la liste des clients
    var sortClient = Cookies.get("sortClient");
    $.post(
      // rechercher la liste des clients et les devis pour le client $idClient
      "inc/devis/getAllDevis.inc.php",
      {
        idClient: idClient,
        sortClient: sortClient,
      },
      function (resultat) {
        $("#unique").html(resultat);
        var obj = $('tr[data-idclient="' + idClient + '"]');
        // y a-t-il une ligne correspondant à idClient dans la liste de gauche?
        if (obj.length != 0)
          $("table.listeClients tr.choosen")[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
        var idDevis = Cookies.get("idDevis");
        $('button.nav-link[data-iddevis="' + idDevis + '"]').trigger("click");
      }
    );
  });

  // Ajouter un devis au client actuellement actif (sélecteur des clients)
  $("body").on("click", "#btn-addDevis", function (event) {
    testSession(event);
    var idClient = $(this).data('idclient');
    $.post(
      "inc/devis/editDevis.inc.php",
      {
        idClient: idClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditDevis").modal("show");
      }
    );
  });

  // Edition d'un devis (modification de la date seulement)
  $("body").on("click", ".btn-editDevis", function (event) {
    testSession(event);
    var idDevis = $(this).data("iddevis");
    var idClient = $(this).data("idclient");
    $.post(
      "inc/devis/editDevis.inc.php",
      {
        idClient: idClient,
        idDevis: idDevis,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditDevis").modal("show");
      }
    );
  });

  // enregistre un devis édité
  $("body").on("click", "#btn-saveDevis", function (event) {
    testSession(event);
    if ($("#modalFormDevis").valid()) {
      var idClient = $("#modalFormDevis input#idClient").val();
      var formulaire = $("#modalFormDevis").serialize();
      $.post(
        "inc/devis/saveDevis.inc.php",
        {
          formulaire: formulaire,
          idClient: idClient
        },
        function (resultat) {
          $("#modalEditDevis").modal("hide");
          $('.listeClients tr[data-idclient="' + idClient + '"]').trigger(
            "click"
          );
          // actualiser la date d'accès à la fiche client
          $('button.clientParDate').trigger('click');
        }
      );
    }
  });

  // Effacer le devis $idDevis
  $("body").on("click", ".btn-delDevis", function (event) {
    testSession(event);
    var idDevis = $(this).data("iddevis");
    var idClient = $(this).data("idclient");
    var ref = $(this).data("ref");
    bootbox.confirm({
      title: "Effacement d'un devis",
      message: "Veuille confirmer l'effacement du devis " + ref,
      callback: function (result) {
        if (result == true) {
          $.post(
            "inc/devis/delDevis.inc.php",
            {
              idDevis: idDevis,
            },
            function (resultat) {
              $('.listeClients tr[data-idclient="' + idClient + '"]').trigger(
                "click"
              );
            }
          );
        }
      },
    });
  });

  // Ajouter un item à au devis $idDevis pour le client $idClient
  $("body").on("click", ".btn-addItemDevis", function (event) {
    testSession(event);
    var idDevis = $(this).data("iddevis");
    var idClient = $(this).data("idclient");
    $.post(
      "inc/devis/editItem.inc.php",
      {
        idDevis: idDevis,
        idClient: idClient,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditItemDevis").modal("show");
      }
    );
  });

  // Modification d'un item $idItem pour le devis $idDevis
  $("body").on("click", ".btn-editItemDevis", function (event) {
    testSession(event);
    var idItem = $(this).closest("tr").data("iditem");
    var idDevis = $(this).closest("tr").data("iddevis");
    var idClient = $(this).closest("tr").data("idclient");

    $.post(
      "inc/devis/editItem.inc.php",
      {
        idDevis: idDevis,
        idClient: idClient,
        idItem: idItem,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditItemDevis").modal("show");
      }
    );
  });

  // enregistrement d'un item depuis la boîte modale
  $("body").on("click", "#btn-saveItemDevis", function (event) {
    testSession(event);
    if ($("#formModalEditItemDevis").valid()) {
      var idClient = $('.listeClients[data-mode="devis"] tr.choosen').data(
        "idclient"
      );
      var formulaire = $("#formModalEditItemDevis").serialize();
      $.post(
        "inc/devis/saveItemDevis.inc.php",
        {
          formulaire: formulaire,
        },
        function (resultat) {
          $("#modalEditItemDevis").modal("hide");
          // renvoie le idItem de l'article ajouté
          $('.listeClients tr[data-idclient="' + idClient + '"]').trigger(
            "click"
          );
        }
      );
    }
  });

  // suppression de l'item  $idItem d'un devis
  $("body").on("click", ".delItemDevis", function (event) {
    testSession(event);
    var idItem = $(this).closest("tr").data("iditem");
    var idClient = $(this).closest("tr").data("idclient");
    var denomination = $(this).closest("tr").find(".materiel").text();

    bootbox.confirm({
      title: "Suppression d'un item",
      message:
        "Voulez-vous vraiment supprimer l'article <br><strong style='text-align:center'>" +
        denomination +
        "</strong><br>de ce devis?",
      callback: function (result) {
        if (result == true) {
          $.post(
            "inc/devis/delItemDevis.inc.php",
            {
              idItem: idItem,
            },
            function (resultat) {
              // forcer la re-génération de l'ensemble des devis (à améliorer?)
              $(
                'table.listeClients tr[data-idclient="' + idClient + '"]'
              ).trigger("click");
            }
          );
        }
      },
    });
  });

  // sélection d'un client dans la liste de gauche
  $("body").on(
    "click",
    '.listeClients[data-mode="devis"] tr',
    function (event) {
      testSession(event);
      var idClient = $(this).data("idclient");
      $.post(
        "inc/devis/getDevis4client.inc.php",
        {
          idClient: idClient,
        },
        function (resultat) {
          $("#conteneurDevis").html(resultat);
          var idDevis = Cookies.get("idDevis");
          $('button.nav-link[data-iddevis="' + idDevis + '"]').trigger("click");
        }
      );
    }
  );

  // sélection d'un devis pas son onglet (si plusieurs devis pour le même client)
  $("body").on("click", "button.nav-link", function (event) {
    testSession(event);
    var idDevis = $(this).data("iddevis");
    Cookies.set("idDevis", idDevis, { sameSite: "strict" });
  });
});
