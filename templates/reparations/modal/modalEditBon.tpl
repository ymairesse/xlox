<!-- Modal -->
<div
  class="modal fade"
  id="modalEditBon"
  data-bs-backdrop="static"
  data-bs-keyboard="false"
  tabindex="-1"
  aria-labelledby="modalEditBonLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="modalEditBonLabel">
          Fiche de réparation acceptée par
          [{$dataBon.benevole|default:$benevole.prenom}]
        </h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <form id="modalFormBon" autocomplete="off">
          <input 
            type="hidden" 
            id="idClient" 
            name="idClient" 
            value="{$idClient}"
          />
          <input
            type="hidden"
            name="numeroBon"
            id="numeroBon"
            value="{$dataBon.numeroBon|default:''}"
          />
          <input
            type="hidden"
            name="benevole"
            value="{$dataBon.benevole|default:$benevole.prenom}"
          />

          <div class="row">
            <div class="form-group pb-3 col-md-3 col-4">
              <label for="typeMateriel" class="w-100"
                >Type matériel
              </label>
              <div id="selectMateriel">
                <select name="typeMateriel" 
                  id="typeMateriel" 
                  class="form-control"
                  required
                  >
                  <option value="">Sélectionner</option>
                  {foreach from=$allMateriel key=id item=materiel} 
                  <option value="{$id}"{if isset($dataBon) && ($id == $dataBon.typeMateriel)} selected{/if}>{$materiel}</option>
                  {/foreach}
              </select>
              </div>
            </div>

            <div class="form-group pb-3 col-md-3 col-4">
              <label for="marque">Marque</label>
              <input
                type="text"
                class="form-control"
                name="marque"
                id="marque"
                value="{$dataBon.marque|default:''}"
              />
            </div>

            <div class="form-group pb-3 col-md-3 col-4">
              <label for="marque">Modèle</label>
              <input
                type="text"
                class="form-control"
                name="modele"
                id="modele"
                value="{$dataBon.modele|default:''}"
              />
            </div>

            <div class="col-md-3 form-group pb-3 col-6">
              <label for="dateEntree">Date de réception</label>
              <input 
                type="date" 
                class="form-control" 
                name="dateEntree"
                id="dateEntree" 
                value="{if isset($dataBon.dateEntree)}{$dataBon.dateEntree}{else}{$smarty.now|date_format:"%Y-%m-%d"}{/if}"
                required
              />
            </div>

            <div class="col-md-3 col-6 form-group pb-3">
              <label for="ox">Numero OX</label>
              <div class="input-group mb-3">
                <span class="input-group-text">OX</span>
                <input
                  type="text"
                  class="form-control"
                  name="ox"
                  id="ox"
                  value="{$dataBon.ox|default:'          '}"
                  maxlength="6"
                  placeholder="Num OX"
                  autocomplete="off"
                />
              </div>
            </div>

            <div class="col-md-3 col-6 form-group pb-3">
              <label for="mdp">Mot de passe</label>
              <div class="input-group mb-3">
                <span class="input-group-text addonMdp"
                  ><i class="fa fa-eye"></i
                ></span>
                <input
                  type="password"
                  class="form-control"
                  name="mdp"
                  id="mdp"
                  data-mdp="{$dataBon.mdp|default:''}"
                  autocomplete="off"
                  value="{$dataBon.mdp|default:''}"
                  placeholder="Mot de passe"
                  aria-describedby="addonMdp"
                />
              </div>
            </div>

            <div class="col-6 col-md-6 pb-3">
              <label for="data">Données</label>
              <div class="btn-group w-100" role="group" aria-label="Data">
                <input type="radio" class="btn-check" name="data" id="noData"
                autocomplete="off" value="0" {if !isset($dataBon.data) ||
                ($dataBon.data == 0)} checked{/if}>
                <label class="btn btn-outline-primary" for="noData">No</label>

                <input type="radio" class="btn-check" name="data" id="data"
                autocomplete="off" value="1" {if isset($dataBon.data) &&
                ($dataBon.data == 1)} checked{/if} >
                <label class="btn btn-outline-danger" for="data">Data</label>
              </div>
            </div>

            <div class="col-12 form-group pb-3">
              <label for="accessoires" class="w-100">Accessoires déposés
              </label>
              <div id="accessoires">
                {foreach from=$allAccessoires key=idAccessoire item=data name=acc}
                  <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox"
                    name="accessoires[]"
                    id="accessoires_{$smarty.foreach.acc.index}"
                    value="{$idAccessoire}" {if isset($accessoiresBon) &&
                    in_array($idAccessoire, array_keys($accessoiresBon))} checked
                    {/if} />
                    <label for="accessoires_{$smarty.foreach.acc.index}">
                      {$data}
                    </label>
                  </div>
                {/foreach}
            </div>

            <div id="modalAccessoires"></div>


            </div>
          </div>

          <div class="row">
            <div class="col-md-8 pb-3 autoMentions">
              <label class="w-100" for="probleme"
                >Problème technique
                <div class="btn-group float-end">
                  <button
                    type="button"
                    class="btn btn-sm btn-warning py-0 btn-editMention"
                    data-type="probleme"
                  >
                    <i class="fa fa-edit"></i>
                  </button>
                  <button
                    type="button"
                    class="btn btn-sm btn-info py-0 btn-moreMentions"
                    data-type="probleme"
                  >
                    <i class="fa fa-plus"></i>
                  </button>
                  <button
                    type="button"
                    class="btn btn-primary btn-sm py-0 btn-mentions"
                    data-type="probleme"
                  >
                    <i class="fa fa-question"></i>
                  </button>
                </div>
              </label>
              <div
                class="modalMentions"
                data-type="probleme"
                style="display: none"
              >
                // ici la collection de mentions possibles
              </div>
              <textarea
                name="probleme"
                id="probleme"
                rows="2"
                class="form-control"
              >
{$dataBon.probleme|default:''}</textarea
              >
            </div>

            <div class="col-md-4 pb-3">
              <label for="etat">État à la réception</label>
              <textarea class="form-control" name="etat" id="etat" rows="2">
{$dataBon.etat|default:''}</textarea
              >
            </div>
          </div>

          <div class="row">
            <div class="col-6 pb-3 autoMentions">
              <label class="w-100" for="devis"
                >Solution et devis
                <div class="btn-group float-end">
                  <button
                    type="button"
                    class="btn btn-sm btn-warning py-0 btn-editMention"
                    data-type="solution"
                  >
                    <i class="fa fa-edit"></i>
                  </button>
                  <button
                    type="button"
                    class="btn btn-sm btn-info py-0 btn-moreMentions"
                    data-type="solution"
                  >
                    <i class="fa fa-plus"></i>
                  </button>
                  <button
                    type="button"
                    class="btn btn-primary btn-sm py-0 btn-mentions"
                    data-type="solution"
                  >
                    <i class="fa fa-question"></i>
                  </button>
                </div>
              </label>
              <div
                class="modalMentions"
                data-type="solution"
                style="display: none"
              >
                // ici la collection de mentions possibles
              </div>
              <textarea class="form-control" name="devis" id="devis" rows="2">
{$dataBon.devis|default:''}</textarea
              >
            </div>

            <div class="col-6 pb-3">
              <label for="remarque">Remarque technicien</label>
              <textarea
                name="remarque"
                id="remarque"
                rows="2"
                class="form-control"
              >
{$dataBon.remarque|default:''}</textarea
              >
            </div>
          </div>

          <div class="row">

            <div class="col-md-3 col-sm-6 col-6 form-group pb-3">
              <label for="dateSortie">Sortie</label>
              <input
                type="date"
                class="form-control"
                name="dateSortie"
                id="dateSortie"
                value="{$dataBon.dateSortie|default:''}"
              />
            </div>

            <div class="col-md-3 col-sm-6 col-6 form-group pb-3">
              <label for="garantie">Garantie</label>
              <div class="btn-group w-100" role="group" aria-label="Garantie">
                <input type="radio" class="btn-check" name="garantie"
                id="noGarantie" autocomplete="off" value="0" {if
                !isset($dataBon.garantie) || ($dataBon.garantie == 0)}
                checked{/if}>
                <label class="btn btn-outline-primary" for="noGarantie"
                  >NON</label
                >

                <input type="radio" class="btn-check" name="garantie"
                id="garantie" autocomplete="off" value="1" {if
                isset($dataBon.garantie) && ($dataBon.garantie == 1)}
                checked{/if} >
                <label class="btn btn-outline-warning" for="garantie"
                  >OUI</label
                >
              </div>
            </div>

            <div class="col-md-3 col-sm-6 col-6 form-group pb-3">
              <label for="apayer">À payer</label>

              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text">€</span>
                </div>
                <input
                  type="text"
                  class="form-control"
                  id="apayer"
                  name="apayer"
                  value="{$dataBon.apayer|default:''}"
                />
              </div>
            </div>

            <div class="col-md-3 col-sm-6 col-6 pb-3">
              <label for="enCours">Terminé</label>
              <div
                class="btn-group w-100"
                role="group"
                aria-label="Terminé"
              >
                <input type="radio" class="btn-check" name="termine"
                id="enCours" autocomplete="off" value="0" {if
                !isset($dataBon.termine) || ($dataBon.termine == 0)}
                checked{/if}>
                <label class="btn btn-outline-primary" for="enCours"
                  >NON</label
                >

                <input type="radio" class="btn-check" name="termine"
                id="termine" autocomplete="off" value="1" {if
                isset($dataBon.termine) && ($dataBon.termine == 1)} checked{/if}
                >
                <label class="btn btn-outline-danger" for="termine"
                  >OUI</label
                >
              </div>
            </div>
            
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Annuler
        </button>
        <button
          type="button"
          class="btn btn-primary"
          id="btn-saveBon"
          data-numerobon="{$dataBon.numeroBon|default:''}"
          data-idClient="{$idClient}"
        >
          Enregistrer
        </button>
      </div>
    </div>
  </div>
</div>

<style>
  #modal h5 {
    font-size: 13pt;
    font-weight: bold;
  }

  .invalide {
    color: red;
  }
</style>

<script>
  $(document).ready(function () {
    $("#modalFormBon").validate({
      errorClass: "invalide",
    });
  });
</script>
