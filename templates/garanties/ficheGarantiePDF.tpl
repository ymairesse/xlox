<page
  backimg="../../css/oxfambg.jpg"
  backtop="35mm"
  backbottom="30mm"
  backleft="10mm"
  backright="10mm"
>
  <page_header>
    <table style="width: 100%">
      <tr>
        <td style="width: 50%; padding: 0 20px">
          <p style="font-weight: bold">XL Oxfam Computershop 5496</p>
          <p class="texteGras">
            Valable pour les articles ci-dessous pendant 12 mois. À conserver
            avec preuve d'achat.
          </p>
        </td>
        <td style="width: 50%; padding: 0 20px">
          <p class="inverse texteGras" style="margin: 0">Références</p>
          <p>
            Ticket de caisse: <strong>{$ticketCaisse|number_format:0:'.':' '}</strong><br />
            {if $dataClient != Null}
            {$dataClient.civilite|default:'M./Mme '} {$dataClient.nom|default:''}
            {$dataClient.prenom|default:''}<br />
            {$dataClient.adresse|default:''}<br />
            {$dataClient.cpost|default:''} {$dataClient.commune|default:''}<br />
            {if ($dataClient.mail != '')}Mail: {$dataClient.mail|default:''}<br />{/if}
            {if ($dataClient.gsm != '')}GSM {$dataClient.gsm|default:''}<br />{/if}
            {if (($dataClient.telephone != ''))}Tel:
            {$dataClient.telephone|default:''}<br />{/if} {if $dataClient.tva !=
            ''}TVA BE {$dataClient.tva}{/if}
            {/if}
          </p>
        </td>
      </tr>
    </table>
  </page_header>

  <h3 class="texteGras" style="text-align: center">Certificat de garantie</h3>

  {include file="garanties/tableauItemsPDF.tpl"}

  <div style="font-size: 8pt">
  {$condPart|default:''|nl2br}
  </div>

  <div id="cgv" style="font-size: 7pt; width: 98%">
    <p style="padding: 0 2cm; font-weight: bold">
      Nous vous remercions pour votre confiance envers Oxfam-Solidarité. Votre
      choix informatique vous permettra d'économiser votre porte-monnaie; de
      mieux respecter l'environnement, mais aussi de contribuer au financement
      des projets Oxfam dans les pays du Sud. Le matériel acheté a été
      complètement vérifié dans nos ateliers informatiques.
    </p>

    <h3 style="text-align: center; margin-top: 2rem; font-weight: bold">
      CONDITIONS GENERALES DE VENTE
    </h3>

    <p>
      L'acquéreur accepte ce produit dans l'état où il se trouve au moment de
      l'achat et suit les conditions ci-dessous:
    </p>

    <ul style="list-style-type: circle;">
      <li>
        Oxfam-Solidarité a.s.b.l. donne une garantie d'un an à partir de la date
        d'achat. Les cartouches d'encre des imprimantes, les batteries et autres
        biens de consommation sont exclus de la garantie.
      </li>
      <li>
        Oxfam Solidarité a.s.b.l. n'est pas responsable du fonctionnement des
        périphériques éventuellement installés, à l'exception des périphériques
        fournis au moment de l'achat.
      </li>
      <li>
        Les appareils techniquement défectueux sont réparés ou échangés pendant
        la période de garantie dans le magasin d'achat après présentation de la
        preuve d'achat originale.
      </li>
      <li>
        En cas de défectuosité du système d'exploitation non imputable à une
        mauvaise utilisation par l'acheteur, Oxfam reinstallera les logiciels
        comme présents à l'achat.
      </li>
      <li>
        Oxfam-Solidarité a.s.b.l n'est jamais responsable de la perte ou de
        l'endommagement des données.
      </li>
    </ul>
    <p>La garantie ne s'applique pas:</p>
    <ul style="list-style-type:circle">
      <li>si l'appareil a été ouvert ou</li>
      <li>
        dans le cas d'une utilisation non conforme de l'ordinateur, un mauvais
        entretien ou une révision, un remodelage, une réparation (méme
        partielle) ou un demontage par des personnes étrangères à
        Oxfam-Solidanté a.s.b.l. La garantie ne joue pas non plus lorsque les
        dommages sont la conséquence du raccordement de l'appareil dans un
        environnement qui ne répond pas aux spécifications techniques
        (température, humidité, milieu corrosif ou poussiéreux, variation des
        tensions electriques)
      </li>
    </ul>
    <p>
      L'acquéreur est informé du fait que tout produit informatique non
      fonctionnel est un produit «&nbsp;dangereux&nbsp;» qui devra être éliminé
      selon les règles en vigueur dans la région. Une fois hors d'usage, ce
      matériel informatique devra donc être déposé dans la déchetterie
      communale.
    </p>
    <p>
      Le droit applicable et les tribunaux compétents -le droit belge est
      d'application. En cas de litige, les tribunaux judiciaires de
      l'arrondissement judiciaire de Bruxelles sont seuls habilités à prendre
      acte de ce litige.
    </p>
    <p>
      <strong>RGPD</strong><br />
      L'entrée en vigueur le 25 mai 2018 de la nouvelle directive relative aux
      données personnelles, nous oblige à obtenir votre consentement pour
      l'enregistrement de vos coordonnées dans nos systéme informatique. Sans
      accord de votre part, aucune information ne sera sauvegardée.
    </p>
  </div>

  <page_footer>
    <table style="width: 100%">
      <tr>
        <td style="width: 40%">
          <h5 style="margin: 0"><strong>ComputerShop Ixelles</strong></h5>
          <p style="font-size: 10pt; line-height: 14pt">
            252, Chaussée d'Ixelles<br />
            1050 Bruxelles<br />
            Tel: 02 647 48 51<br />
            computershop.ixelles@oxfam.org
          </p>

          Document généré le {$dateGeneration}
        </td>
        <td style="width: 20%">
          <img src="../../images/oxfamBelg.png" width="130" alt="Oxfam" />
        </td>
        <td style="width: 40%; text-align: right">
          <h5><strong>Oxfam-Solidarité asbl</strong></h5>
          <p style="font-size: 10pt">
            Rue des Quatres Vents 60 1080<br />
            1080 Bruxelles<br />
            TVA: BE 408.643.875<br />
            https://oxfambelgique.be/
          </p>
        </td>
      </tr>
    </table>
  </page_footer>
</page>

<style type="text/css">
  .texteGras {
    font-weight: bold;
    font-size: 120%;
  }

  .inverse {
    color: white;
    background-color: black;
    font-weight: bold;
    padding: 0;
  }
</style>
