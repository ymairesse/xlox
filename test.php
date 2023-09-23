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


    <div class="container-fluid" id="corpsPage">
    <img src="inc/captcha.php?nbchar=6&amp;rand=<?php echo rand(); ?>" id="captcha_image" class="img-responsive">
    </div>

    <style>

      .tableMentions {
        font-size: 0.8em;
      }

      button {
        font-size: 0.3em;
        height: 15px;
        width: 15px;
      }

      .tronc {
        overflow: hidden;
        max-height: 1.2em;
        padding: 0;
        text-overflow: '-';
      }

    </style>


  </body>
</html>
