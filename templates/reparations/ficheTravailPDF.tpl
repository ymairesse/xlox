<page backimg="../../css/oxfambg.jpg"  backtop="35mm" backbottom="30mm" backleft="10mm" backright="10mm">
  <page_header>

    <table style="width:100%">
        <tr>
            <td style="width: 40%"><img src="../../images/oxfamcs.jpg" alt="Oxfam" /></td>
            <td style="width: 40%">
                <p style="font-size: 10pt; line-height: 14pt">
                    252, Chaussée d'Ixelles<br />
                    1050 Bruxelles<br />
                    tel: 02 647 48 51<br />
                    mail: computershop.ixelles@oxfam.org
                  </p>
            </td>
            <td style="width: 20%; text-align: center; font-size: xx-large; font-weight: bold;">
                {$dataBon.numeroBon|string_format:"%05d"}
            </td>
        </tr>
    </table>

      <page_footer>Document généré le: {$dateGeneration} </page_footer>

    </page_header>

  <h2>Client</h2>

    <table style="width: 100%">
    <tr>
      <td style="width: 33%"><strong style="font-size: 14pt">{$client.civilite}</strong></td>
      <td style="width: 34%">Nom: <strong style="font-size: 14pt">{$client.nom}</strong></td>
      <td style="width: 33%">Prenom: <strong style="font-size: 14pt">{$client.prenom}</strong></td>
    </tr>

    <tr>
      <td style="width: 33%">
        GSM: <strong style="font-size: 14pt">{$client.gsm|default:'---'}</strong>
      </td>
      <td style="width: 34%">
        Téléphone: <strong style="font-size: 14pt">{$client.telephone|default:'---'}</strong>
      </td>
      <td style="width: 33%">
        email: <strong style="font-size: 14pt">{$client.mail|default:'---'}</strong>
      </td>
    </tr>
  </table>

    <table style="width: 100%">
    <tr>
      <td style="width: 50%">
        Adresse: <br /><strong>{$client.adresse|default:'---'}</strong>
      </td>
      <td style="width: 20%">
        Code Postal: <br /><strong>{$client.cpost|default:'---'}</strong>
      </td>
      <td style="width: 30%">
        Commune: <br /><strong>{$client.commune|default:'---'}</strong>
      </td>
    </tr>
  </table>

    {if $client.rgpd == 1}
  <p style="font-size: small">
    J'accepte que mes données personnelles soient conservées pour usage
    ultérieur interne au magasin et/ou aux services techniques de Oxfam asbl
  </p>
  {/if}

  <h2>Travail</h2>

  <table style="width: 100%">
    <tr>
      <td style="width: 33%">
        <h3>Matériel:</h3>
        {$allMateriel[$dataBon.typeMateriel]|default:'non défini'}
      </td>
      <td style="width: 34%">
        <h3>Marque:</h3>
        {$dataBon.marque|default:'--'}
      </td>
      <td style="width: 33%">
        <h3>Modèle:</h3>
        {$dataBon.modele|default:'--'}
      </td>
    </tr>

    <tr>
      <td style="width: 25%">
        <h3>Numero OX:</h3>
        {$dataBon.ox|default:'--'}
      </td>
      <td style="width: 25%">
        <h3>Mot de passe:</h3>
        {if $dataBon.mdp != ''}[[ fourni ]]{else}'--'{/if}
      </td>
      <td style="width: 25%">
        <h3>Date d'entrée:</h3>
        {$dataBon.dateEntree}
      </td>
    </tr>
  </table>
  <table style="width: 100%">
    <tr>
      <td style="width: 33%;" {if $dataBon.data == 1}class="inverse"{/if}>
        <h3>DATA:</h3>
        {if $dataBon.data == 1}<span class="veryImportant">À conserver</span>{else}--{/if}
      </td>
      <td style="width: 34%">
        <h3>Réception par:</h3>
        {$dataBon.benevole}
      </td>
      <td style="width: 33%">
        <h3>Garantie:</h3>
        {if $dataBon.garantie == 1}OUI{else}NON{/if}
      </td>
    </tr>
  </table>

  <table style="width: 100%">
    <tr>
      <td style="width: 100%">
        <h3>Accessoires</h3>

        <ol>
          {foreach from=$accessoiresBon key=wtf item=accessoire}
          <li>{$accessoire}</li>
          {/foreach}
        </ol>
      </td>
    </tr>
  </table>

  <table style="width: 100%">
    <tr>
      <td style="width: 60%; border: solid 1px #888; padding: 2mm">
        <h3>Description</h3>
        <p>{$dataBon.probleme|regex_replace:"/[\r\n]/" : "<br />"}</p>
      </td>
      <td style="width: 40%; border: solid 1px #888; padding: 2mm">
        <h3>Proposition</h3>
        <p>{$dataBon.devis|regex_replace:"/[\r\n]/" : "<br />"}</p>
      </td>
    </tr>
  </table>

  <table style="width: 100%">
    <tr>
      <td style="width: 40%">
        <h3>État à la réception</h3>
        <p>{$dataBon.etat|regex_replace:"/[\r\n]/" : "<br />"}</p>
      </td>
      <td style="width: 60%">
        <h3>Remarques technicien</h3>
        <p>{$dataBon.remarque|regex_replace:"/[\r\n]/" : "<br />" }</p>
      </td>
    </tr>
  </table>

  <table style="width: 100%">
    <tr>
      <td style="width: 40%">
        <h3>Travail terminé</h3>
        <p>{if $dataBon.termine == 1}OUI{else}NON{/if}</p>
      </td>
      <td style="width: 40%">
        <h3>Date de sortie</h3>
        <p>{$dataBon.dateSortie|default:'--'}</p>
      </td>
      <td style="text-align: right; width: 20%">
        <h3>A payer</h3>
        <span class="veryImportant">{if ($dataBon.apayer == 0)}
          &nbsp;
          {else} 
          {$dataBon.apayer} €
        {/if}</span>
      </td>
    </tr>
  </table>

    <table style="width:100%">
    <tr>
      <td style="width:15%">
        <strong>Client prévenu</strong>
      </td>
      <td style="width:20%">
        Téléphone: <div class="square"></div> 
      </td>
      <td style="width:20%">
        Répondeur: <div class="square"></div>
      </td>
      <td style="width:20%">
        Mail: <div class="square"></div>
      </td>
      <td style="width:25%">
        Date: 
      </td>
    </tr>

  </table>

  <p>Le matériel non retiré par le client dans un délai de trois mois au-delà de la date de réparation sera considéré comme abandonné par son propriétaire.</p>
  
</page>

<style type="text/css">
  p {
    font-size: 10pt;
    line-height: 8pt;
  }
  .titre {
    font-weight: bold;
  }
  h1,
  h2,
  h3 {
    margin: 0;
  }
  h3 {
    font-size: 12pt;
  }
  .veryImportant {
    font-size: xx-large;
    font-weight: bold;
  }

  table {
    margin-top: 3em;
    border-collapse: collapse;
  }
  table td {
    border: solid 1px #888;
    padding: 2mm;
  }

  .inverse {
    background-color: #555;
    color: #fff;
  }

  .square {
  height: 15px;
  width: 15px;
  border: 2px solid black;
  display: inline;
  margin-left: 20px;
}
</style>
