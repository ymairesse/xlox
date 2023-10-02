<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Oxfam Computershop</title>
    
    <script src="js/jquery-3.7.0.min.js"></script>
    
  </head>
  <body>


    <select name="selectClients" id="selectClients">
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>


    </select>


  </body>
</html>


<script>

  $(document).ready(function(){

    $('#selectClients').on('change', function(){
      var x = $('#selectClients option:selected').val();
      alert(x);
    })

    



  })


</script>