<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="bootstrap-5.3.0-dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/screen.css" />

    <script src="bootstrap-5.3.0-dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/jquery-3.7.0.min.js"></script>
    <script src="js/jsCookie/src/js.cookie.js"></script>

    <script src="js/javascript.js"></script>

    <script src="js/bootbox.min.js"></script>


    <link
      rel="stylesheet"
      href="fa/css/font-awesome.css"
      type="text/css"
      media="screen, print"
    />
    <script>
      bootbox.setDefaults({
        locale: "fr",
        backdrop: false,
      });
    </script>

    <script>
      $(document).ready(function () {});
    </script>
  </head>
  <body>

    <div id="modal"></div>

    


    {include file="footer.tpl"}

    <script>
    
        $(document).ready(function(){
            $('#login').modal('show');
        })
    
    </script>
  </body>
</html>
