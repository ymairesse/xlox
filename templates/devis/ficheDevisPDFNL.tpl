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

          <h3 class="texteGras" style="text-align: center">IT Prijsopgave</h3>
        </td>
        <td style="width: 50%; padding: 0 20px">
          <p class="inverse texteGras" style="margin: 0">Klantgegevens</p>
          <p>
            Offert nr: <strong>{$dataDevis.ref}</strong> du
            <strong>{$dataDevis.date|date_format:"%d/%m/%Y"}</strong><br />
            {if $dataClient != Null} {$dataClient.civilite|default:'M./Mme '}
            {$dataClient.nom|default:''} {$dataClient.prenom|default:''}<br />
            {$dataClient.adresse|default:''}<br />
            {$dataClient.cpost|default:''} {$dataClient.commune|default:''}<br />
            {if ($dataClient.mail != '')}Mail: {$dataClient.mail|default:''}<br />{/if}
            {if ($dataClient.gsm != '')}GSM {$dataClient.gsm|default:''}<br />{/if}
            {if (($dataClient.telephone != ''))}Tel:
            {$dataClient.telephone|default:''}<br />{/if} {if $dataClient.tva !=
            ''}BTW BE {$dataClient.tva}{/if} {/if}
          </p>
        </td>
      </tr>
    </table>
  </page_header>

  <p style="margin: 10; font-size: 9pt">
    Het volgende aanbod is <strong>drie maanden</strong> geldig vanaf
    <strong> {$dataDevis.date|date_format:"%d/%m/%Y"}</strong>. Als een of meer
    van de genoemde artikelen tijdelijk of definitief niet beschikbaar zijn,
    bieden we een gelijkwaardig artikel aan voor de aangegeven prijs.
  </p>

  {include file="devis/tableauItemsPDF.tpl"}

  <div id="cgv" style="font-size: 8pt; width: 98%">
    <p style="font-weight: bold">
      Dank u voor uw vertrouwen in Oxfam-Solidariteit. Met uw keuze voor
      IT-apparatuur kunt u geld besparen, milieuvriendelijker zijn en
      Oxfam-projecten in ontwikkelingslanden helpen financieren. De aangeschafte
      apparatuur is grondig gecontroleerd in onze computerwerkplaatsen.
    </p>

    <h3 style="text-align: center; margin-top: 2rem; font-weight: bold">
      ALGEMENE VERKOOPSVOORWAARDEN
    </h3>

    <p>
      De koper aanvaardt dit product in de staat waarin het zich bevindt op het
      moment van aankoop en volgt de onderstaande voorwaarden:
    </p>

    <ul style="list-style-type: circle">
      <li>
        Oxfam-Solidarité a.s.b.l. geeft één jaar garantie vanaf de datum van
        aankoop. Printerinktpatronen, batterijen en andere consumptiegoederen
        zijn uitgesloten van de garantie.
      </li>
      <li>
        Oxfam Solidarité a.s.b.l. is niet verantwoordelijk voor de werking van
        geïnstalleerde randapparatuur, met uitzondering van randapparatuur die
        bij de aankoop is geleverd.
      </li>
      <li>
        Technisch defecte apparaten worden binnen de garantieperiode gerepareerd
        of omgeruild in de winkel waar ze gekocht zijn, op vertoon van het
        originele aankoopbewijs.
      </li>
      <li>
        In het geval van een defect in het besturingssysteem dat niet te wijten
        is aan misbruik door de koper, zal Oxfam de software opnieuw installeren
        zoals deze was op het moment van aankoop.
      </li>
      <li>
        Oxfam-Solidarité a.s.b.l is nooit verantwoordelijk voor verlies of
        beschadiging van gegevens.
      </li>
    </ul>
    <p>Garantie is niet van toepassing:</p>
    <ul style="list-style-type: circle">
      <li>indien het apparaat werd geopend of</li>
      <li>
        in geval van oneigenlijk gebruik van de computer, slecht onderhoud of
        revisie, verbouwing, reparatie (zelfs gedeeltelijk) of demontage door
        andere personen dan Oxfam-Solidarité nv. De garantie is ook niet van
        toepassing als de schade het gevolg is van het aansluiten van het
        apparaat in een omgeving die niet voldoet aan de technische
        specificaties (temperatuur, vochtigheid, corrosieve of stoffige
        omgeving, variatie in elektrische spanningen).
      </li>
    </ul>
    <p>
      De koper wordt hierbij geïnformeerd dat elk niet-functionerend
      computerproduct een "gevaarlijk" product is dat moet worden afgevoerd
      volgens de geldende regels in de regio. Als deze computerapparatuur buiten
      gebruik is, moet deze worden ingeleverd bij het plaatselijke
      afvalverzamelpunt.
    </p>
    <p>
      Toepasselijk recht en bevoegde rechtbanken - Het Belgisch recht is van
      toepassing. In geval van een geschil zijn enkel de rechtbanken van het
      gerechtelijk arrondissement Brussel bevoegd om kennis te nemen van het
      geschil.
    </p>
    <p>
      <strong>GDPR</strong><br />
      De inwerkingtreding op 25 mei 2018 van de nieuwe richtlijn over
      persoonsgegevens, verplicht ons om uw toestemming te vragen voor het
      opslaan van uw gegevens in onze IT-systemen. Zonder jouw toestemming wordt
      er geen informatie opgeslagen.
    </p>
  </div>

  <page_footer>
    <table style="width: 100%">
      <tr>
        <td style="width: 40%">
          <h5 style="margin: 0"><strong>ComputerShop Ixelles</strong></h5>
          <p style="font-size: 10pt; line-height: 14pt">
            252, Steenweg op Elsene<br />
            1050 Brussel<br />
            Tel: 02 647 48 51<br />
            computershop.ixelles@oxfam.org
          </p>

          Document opgesteld op {$dateGeneration}
        </td>
        <td style="width: 20%">
          <img src="../../images/oxfamBelg.png" width="130" alt="Oxfam" />
        </td>
        <td style="width: 40%; text-align: right">
          <h5><strong>Oxfam-Solidarité asbl</strong></h5>
          <p style="font-size: 10pt">
            Vierwindensstraat 60 1080<br />
            1080 Brussel<br />
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

  p {
    margin: 5px;
  }

  ul {
    margin: 5px;
  }
</style>
