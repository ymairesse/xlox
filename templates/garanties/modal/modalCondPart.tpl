<div
  class="modal fade"
  id="modalCondPart"
  data-bs-backdrop="static"
  data-bs-keyboard="false"
  tabindex="-1"
  aria-labelledby="modalCondPartLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 w-100" id="modalCondPartLabel">
          Conditions particulières # {$ticketCaisse|number_format:0:'.':' '}
        </h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>

      <div class="modal-body">
        
        <form id="formmodalCondPart">
            <input
              type="hidden"
              name="ticketCaisse"
              id="ticketCaisse"
              value="{$ticketCaisse}"
            />
            <div class="py-3">
            <label for="typeCondPart" class="form-label">
              Conditions particulières de vente
            </label>
            <select class="form-select" 
            aria-label="Condition particulière" 
            name="typeCondPart" 
            id="typeCondPart"
            data-ticketcaisse="{$ticketCaisse}"
            >
            <option value="" {if $typeCondPart != Null}disabled{/if}>Aucune condition particulière</option>
            <option value="CPAS"{if $typeCondPart == 'CPAS'} selected{/if} {if ($typeCondPart != Null) && ($typeCondPart != 'CPAS')} disabled{/if}>Bon CPAS</option>
            <option value="Facture"{if $typeCondPart == 'Facture'} selected{/if} {if ($typeCondPart != Null) && ($typeCondPart != 'Facture')} disabled{/if}>Facture</option>
          </select>
          </div>

          <div class="mb-3" id="formCondPart">

            {if $typeCondPart == 'CPAS'} 

              {include file="garanties/inc/formCpas.tpl"}

            {elseif $typeCondPart == 'Facture'}

              {include file="garanties/inc/formFacture.tpl"}

           {/if}
        
          </div>

        </form>

      </div>
      <div class="modal-footer">
        {if $typeCondPart != Null}
        <button type="button" class="btn btn-danger btn-sm me-auto" id="btn-delCondPart" data-ticketcaisse="{$ticketCaisse}">
          <i class="fa fa-times"></i>
          Supprimer condition particulière</button>
        {/if}
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Annuler
        </button>
        <button
          type="button"
          class="btn btn-primary"
          id="btn-savemodalCondPart"
        >
          Enregistrer
        </button>
    </div>

    </div>
  </div>
</div>

<style>
  div.error {
    color: red;
  }

  .visu {
    background-color: #ffef007a;
  }
</style>

<script>

  $(document).ready(function(){

    $('#typeCondPart').on('change', function(){
      var type = $(this).val();
      $.post('inc/garanties/getFormCondPart.inc.php', {
        type: type
      }, function(resultat) {
        $('#formCondPart').html(resultat)
      } 
      );
    })

  })

</script>