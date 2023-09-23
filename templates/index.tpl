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

    
    <script src="bootstrap-5.3.0-dist/js/bootstrap.bundle.min.js"></script>

    <script src="js/jquery-3.7.0.min.js"></script>
    <script src="js/jsCookie/src/js.cookie.js"></script>

    <script src="js/javascript.js"></script>
    <script src="js/jqvalidate/dist/jquery.validate.min.js"></script>
    <script src="js/jqvalidate/dist/additional-methods.min.js"></script>
    <script src="js/jqvalidate/dist/localization/messages_fr.js"></script>
    <script src="js/bootbox.min.js"></script>
    <script>
      bootbox.setDefaults({
        locale: "fr",
        backdrop: false,
      });
    </script>
  </head>
  <body>
    <div class="container-fluid" id="menu">
      
      {include file="navbar.tpl"}
    
    </div>

    <div class="container-fluid" id="corpsPage">

      <div class="row">

        <div id="left">
          {include file="start.tpl"}
        </div>

        <div id="right">

        </div>

        <div class="col-12" id="unique">
          
        </div>
      </div>

    </div>

      <div id="modal"></div>

    {include file="footer.tpl"}

  </body>
</html>
