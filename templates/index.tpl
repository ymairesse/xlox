<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Oxfam Computershop</title>
    <link rel="stylesheet" href="bootstrap-5.3.0-dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/screen.css" />
    <link
      rel="stylesheet"
      href="fa/css/font-awesome.min.css"
      type="text/css"
      media="screen, print"
    />
    <link rel="icon" type="image/x-icon" href="images/favicon.ico" />
    <script src="bootstrap-5.3.0-dist/js/bootstrap.bundle.min.js"></script>

    <script src="js/jquery-3.7.0.min.js"></script>
    <script src="js/jsCookie/src/js.cookie.js"></script>

    <script src="js/javascript.js"></script>
    <script src="js/javascriptClients.js"></script>
    <script src="js/javascriptReparation.js"></script>
    <script src="js/javascriptUsers.js"></script>
    <script src="js/javascriptDocuments.js"></script>
    <script src="js/javascriptStock.js"></script>
    <script src="js/javascriptDevis.js"></script>
    <script src="js/jqvalidate/dist/jquery.validate.min.js"></script>
    <script src="js/jqvalidate/dist/additional-methods.min.js"></script>
    <script src="js/jqvalidate/dist/localization/messages_fr.js"></script>
    <script src="js/bootbox.all.min.js"></script>
  </head>
  <body>
    <div class="container-fluid" id="menu">
      <div class="row">
        {include file="navbar.tpl"}
      </div>
    </div>

    <div class="container-fluid" id="corpsPage">
      {include file="start.tpl"}
    </div>

    <div id="modal"></div>

    {include file="footer.tpl"}

    <script>

      var tooltipTriggerList = [].slice.call(
        document.querySelectorAll('[data-bs-toggle="tooltip"]')
      );
      var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
      });
    </script>
  </body>
</html>
