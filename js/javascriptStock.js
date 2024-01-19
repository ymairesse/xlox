$(function () {
  $("body").on("click", "#gestionStock", function (event) {
    testSession(event);
    var idMateriel = Cookies.get("idMateriel");
    $.post(
      "inc/stock/getStock.inc.php",
      {
        idMateriel: idMateriel,
      },
      function (resultat) {
        $("#unique").html(resultat);
      }
    );
  });

  // sélection d'une ligne du tableau des matériels
  $("body").on("click", "#selecteurStock td", function (event) {
    testSession(event);
    var idMateriel = $(this).closest("tr").data("idmateriel");
    Cookies.set("idMateriel", idMateriel, { sameSite: "strict" });
    $("#selecteurStock tr").removeClass("choosen");
    $(this).closest("tr").addClass("choosen");
  });

  // édition d'une pièce de matériel
  $("body").on("click", ".btn-editItemStock", function (event) {
    testSession(event);
    var idMateriel = $(this).closest("tr").data("idmateriel");
    Cookies.set("idMateriel", idMateriel, { sameSite: "strict" });
    $.post(
      "inc/stock/editItemStock.inc.php",
      {
        idMateriel: idMateriel,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditItemStock").modal("show");
      }
    );
  });

  // Ajout d'un item au matériel en stock
  $("body").on("click", "#btn-addItemStock", function (event) {
    testSession(event);
    var idMateriel = null;
    $.post(
      "inc/stock/editItemStock.inc.php",
      {
        idMateriel: idMateriel,
      },
      function (resultat) {
        $("#modal").html(resultat);
        $("#modalEditItemStock").modal("show");
      }
    );
  });

  // suppression d'un matériel de l'inventaire
  $("body").on("click", ".btn-delItemStock", function (event) {
    testSession(event);
    var idMateriel = $(this).closest("tr").data("idmateriel");
    Cookies.set("idMateriel", idMateriel, { sameSite: "strict" });
    bootbox.confirm({
      title: "Effacement d'un item",
      message: "Veuille confirmer la suppression de ce matériel",
      callback: function (result) {
        if (result == true)
          $.post(
            "inc/stock/delItemStock.inc.php",
            {
              idMateriel: idMateriel,
            },
            function (nb) {
                if (nb == 1)
                    $('table#selecteurStock tr[data-idmateriel="' + idMateriel +'"]').remove();
            }
          );
      },
    });
  });

  // enregistrement (édition ou nouveau) d'un matériel depuis la boîte modale
  $("body").on("click", "#btn-saveItemStock", function (event) {
    testSession(event);
    if ($("#modalFormItemStock").valid()) {
      var formulaire = $("#modalFormItemStock").serialize();
      $.post(
        "inc/stock/saveItemStock.inc.php",
        {
          formulaire: formulaire,
        },
        function (resultatJSON) {
          var resultat = JSON.parse(resultatJSON);
          var idMateriel = resultat["idMateriel"];
          var nb = resultat["nb"];
          $("#modalEditItemStock").modal("hide");
          $.post(
            "inc/stock/getStock.inc.php",
            {
              idMateriel: idMateriel,
            },
            function (resultat) {
              $("#unique").html(resultat);
            }
          );
          bootbox.alert({
            title: "Enregistrement d'un article",
            message: nb + " enregistrement effectué",
          });
        }
      );
    }
  });
});
