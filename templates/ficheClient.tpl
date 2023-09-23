<div id="refClients">
<h1>Références client</h1>

<!-- choix de client --------------------------------------- -->
    <div class="row">
        <div class="col-7">
            <!-- sélecteur de client -->
            <label for="listeClients" class="w-100">Liste des clients
              <div class="btn-group float-end">
                <button class="btn btn-sm btn-sort py-0 {if $sortClient == 'parDate'}btn-primary{else}btn-default{/if}" id="clientParDate" data-bs-toggle="tooltip" data-bs-title="Par date"><i class="fa fa-calendar" aria-hidden="true"></i></button>
                <button class="btn btn-sm btn-sort py-0 {if $sortClient == 'alphaAsc'}btn-primary{else}btn-default{/if}" id="clientAlphaAsc" data-bs-toggle="tooltip" data-bs-title="Par ordre alphabétique ASC"><i class="fa fa-sort-alpha-asc" aria-hidden="true"></i></button>
                <button class="btn btn-sm btn-sort py-0 {if $sortClient == 'alphaDesc'}btn-primary{else}btn-default{/if}" id="clientAlphaDesc" data-bs-toggle="tooltip" data-bs-title="Par ordre alphabétique DESC"><i class="fa fa-sort-alpha-desc" aria-hidden="true"></i></button>
              </div>
            </label>
            
            <div id="selecteurClients">

              {include file='inc/selecteurClients.tpl'}

            </div>
        </div>

        <div class="col-md-3 col-3">
          <label for="">Actions</label>
          <div class="btn-group w-100">
          <button type="button" id="btn-newClient" class="btn btn-warning btn-sm text-truncate" title="Nouveau Client">Nouveau Client</button>
          <button type="button" id="delClient" class="btn btn-danger btn-sm text-truncate" title="Supprimer cette fiche client">
            <i class="fa fa-warning"></i> Supprimer ce client
            <i class="fa fa-warning"></i>
          </button>
        </div>
        </div>

        <div class="col-md-2 col-2">
          <label for=""></label>
          <div class="form-group">
            <button type="button" class="btn btn-secondary btn-sm btn-extended  w-100" data-zone="formClient"><i class="fa {if $formClient == 'hidden'}fa-plus{else}fa-minus{/if}"></i></button>
          </div>

        </div>
    </div>

<!-- Formulaire d'inscription ou d'édition ---------------------- -->

<form id="formClient" class="extended {if $formClient == 'hidden'}d-none{/if}" data-zone="formClient">

    <div class="container-fluid">

      <div class="row">
        
        <div class="form-group pb-3 col-2">
          <label for="genre">F/M/X</label>
          <input
            type="text"
            class="form-control"
            name="civilite"
            id="civilite"
            readonly
            value="{$dataClient.civilite|default:''}"
            placeholder="Civ."
          />
        </div>
  
        <div class="form-group pb-3 col-6">
          <label for="nom">Nom</label>
          <input
            type="text"
            class="form-control"
            name="nom"
            id="nom"
            readonly
            value="{$dataClient.nom|default:''}"
            placeholder="Nom"
            required
          />
        </div>
  
        <div class="form-group pb-3 col-4">
          <label for="prenom">Prénom</label>
          <input
            type="text"
            class="form-control"
            name="prenom"
            id="prenom"
            readonly
            value="{$dataClient.prenom|default:''}"
            placeholder="Prénom"
          />
        </div>
  
        <div class="form-group pb-3 col-6 col-md-4">
          <label for="gsm">
            <i class="fa fa-mobile" aria-hidden="true"></i> GSM
          </label>
          <input
            type="text"
            class="form-control"
            name="gsm"
            id="gsm"
            readonly
            value="{$dataClient.gsm|default:''}"
            placeholder="GSM"
          />
        </div>
  
        <div class="form-group pb-3 col-6 col-md-4">
          <label for="telephone"
            ><i class="fa fa-phone" aria-hidden="true"></i> Téléphone</label
          >
          <input
            type="text"
            class="form-control"
            name="telephone"
            id="telephone"
            readonly
            value="{$dataClient.telephone|default:''}"
            placeholder="Téléphone"
          />
        </div>
  
        <div class="form-group pb-3 col-12 col-md-4">
          <label for="mail"
            ><i class="fa fa-send" aria-hidden="true" readonly></i> Adresse
            mail</label
          >
          <input
            type="mail"
            class="form-control"
            name="mail"
            id="mail"
            readonly
            value="{$dataClient.mail|default:''}"
            placeholder="Adresse mail"
          />
        </div>

        <div class="form-group pb-3 col-8">
          <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox" role="switch" name="rgpd" onclick="return false"  {if isset($dataClient) && $dataClient.rgpd == 1}checked{/if}>
            <label class="form-check-label" for="rgpd">J'accepte que mes données personnelles soient conservées pour usage ultérieur 
              <button type="button" 
                class="btn btn-primary btn-sm info-rgpd" 
                style="height:14pt; font-size: 60%; padding:0 5px"
                data-bs-toggle="tooltip"
                data-bs-title="<strong>Oxfam Informatique</strong> s'engage à n'utiliser vos informations que pour des raisons d'usages internes au magasin ou, si nécessaire, aux services techniques de Oxfam. En aucune cas, vos informations ne seront transmises à des tiers."
                data-bs-html="true">
                <i class="fa fa-info-circle" aria-hidden="true"></i>
              </button> 
            </label>
          </div>
        </div>
        <div class="form-group col-2">
          <label for="dateAcces">Dernière modification</label>
          <input type="text" readonly id="dateAcces" name="dateAcces" class="form-control"
            data-bs-toggle="tooltip"
            data-bs-title="{$dataClient.dateAcces|default:''}"
          value="{$dataClient.dateAcces|default:''}">
        </div>

        <div class="form-group col-2">
          <button type="button" class="btn btn-secondary btn-sm btn-extended w-100" data-zone="extraForm"><i class="fa {if $extraForm == 'hidden'}fa-plus{else}fa-minus{/if}"></i></button>
        </div>
  
      </div>
      
      <div class="row extended {if $extraForm=='hidden'}d-none{/if}" data-zone="extraForm">
  
      <div class="form-group pb-3 col-12">
        <label for="adresse">Adresse</label>
        <input
          type="text"
          class="form-control"
          name="adresse"
          readonly
          id="adresse"
          value="{$dataClient.adresse|default:''}"
          placeholder="Adresse rue / numéro"
        />
      </div>
  
      <div class="form-group pb-3 col-7">
          <label for="commune">Commune</label>
          <input
            type="text"
            class="form-control"
            name="commune"
            readonly
            id="commune"
            value="{$dataClient.commune|default:''}"
            placeholder="Commune"
          />
      </div>
  
      <div class="form-group pb-3 col-5">
          <label for="cpost">Code Postal</label>
          <input
            type="text"
            class="form-control"
            name="cpost"
            readonly
            id="cpost"
            value="{$dataClient.cpost|default:''}"
            placeholder="Code Postal"
          />
      </div>
  
      <div class="form-group pb-3 col-12">
          <label for="tva">Numéro de TVA</label>
    
          <div class="input-group mb-3">
            <div class="input-group-prepend">
              <span class="input-group-text">BE</span>
            </div>
            <input
              type="text"
              class="form-control"
              id="tva"
              name="tva"
              value="{$dataClient.tva|default:''}"
            />
          </div>
      </div>
  
      </div>
    
    </div>
  </form>
  
    

<script>

  $(document).ready(function(){

    $('#clientParDate').click(function(){
      Cookies.set("sortClient", "parDate", { sameSite: "strict" });
      $('.btn-sort').addClass('btn-default').removeClass('btn-primary');
      $('#clientParDate').addClass('btn-primary');
      $.post('inc/getSelecteurClients.inc.php', {}, 
        function(resultat){
          $('#selecteurClients').html(resultat);
        })
    })
    $('#clientAlphaAsc').click(function(){
      Cookies.set("sortClient", "alphaAsc", { sameSite: "strict" });
      $('.btn-sort').addClass('btn-default').removeClass('btn-primary');
      $('#clientAlphaAsc').addClass('btn-primary');
      $.post('inc/getSelecteurClients.inc.php', {}, 
        function(resultat){
          $('#selecteurClients').html(resultat);
        })
    })
    $('#clientAlphaDesc').click(function(){
      Cookies.set("sortClient", "alphaDesc", { sameSite: "strict" });
      $('.btn-sort').addClass('btn-default').removeClass('btn-primary');
      $('#clientAlphaDesc').addClass('btn-primary');
      $.post('inc/getSelecteurClients.inc.php', {}, 
        function(resultat){
          $('#selecteurClients').html(resultat);
        })
    })


    var tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
    );
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
    });

  })

</script>