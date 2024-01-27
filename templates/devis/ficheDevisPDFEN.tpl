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
    The following offer is valid for <strong>three months</strong> from
    <strong>{$dataDevis.date|date_format:"%d/%m/%Y"}</strong>.<br />
    Should one or more of the items mentioned become temporarily or permanently
    unavailable, we undertake to offer an equivalent item for the price
    indicated.
  </p>

  {include file="devis/tableauItemsPDF.tpl"}

  <div id="cgv" style="font-size: 8pt; width: 98%">
    <p style="font-weight: bold">
      Thank you for your confidence in Oxfam-Solidarité. Your choice of IT
      equipment will allow you to save money, be more environmentally friendly
      and help fund Oxfam projects in developing countries. The equipment
      purchased has been thoroughly checked in our computer workshops.
    </p>

    <h3 style="text-align: center; margin-top: 2rem; font-weight: bold">
      GENERAL TERMS AND CONDITIONS OF SALE
    </h3>

    <p>
      The purchaser accepts this product in the condition it is in at the time
      of purchase and follows the conditions below:
    </p>

    <ul style="list-style-type: circle">
      <li>
        Oxfam-Solidarité a.s.b.l. gives a one-year guarantee from the date of
        purchase. Printer ink cartridges, batteries and other consumer goods are
        excluded from the guarantee.
      </li>
      <li>
        Oxfam Solidarité a.s.b.l. is not responsible for the operation of any
        peripherals installed, with the exception of peripherals supplied at the
        time of purchase.
      </li>
      <li>
        Technically defective appliances will be repaired or exchanged within
        the warranty period in the shop where they were purchased, on
        presentation of the original proof of purchase.
      </li>
      <li>
        In the event of a defect in the operating system that is not
        attributable to misuse by the purchaser, Oxfam will reinstall the
        software as it was at the time of purchase.
      </li>
      <li>
        Oxfam-Solidarité a.s.b.l is never responsible for the loss or damage of
        data
      </li>
    </ul>
    <p>The guarantee does not apply:</p>
    <ul style="list-style-type: circle">
      <li>if the appliance has been opened or</li>
      <li>
        in the event of improper use of the computer, poor maintenance or
        overhaul, remodelling, repair (even partial) or dismantling by persons
        other than Oxfam-Solidanté a.s.b.l. The guarantee also does not apply if
        the damage is the result of connecting the device in an environment that
        does not meet the technical specifications (temperature, humidity,
        corrosive or dusty environment, variation in electrical voltages)
      </li>
    </ul>
    <p>
      The purchaser is hereby informed that any non-functioning computer product
      is a "hazardous" product that must be disposed of in accordance with the
      rules in force in the region. Once out of use, this computer equipment
      must be disposed of at the local waste collection centre.
    </p>
    <p>
      Applicable law and competent courts - Belgian law applies. In the event of
      a dispute, only the courts of the judicial district of Brussels are
      authorised to take cognisance of the dispute.
    </p>
    <p>
      <strong>GDPR</strong><br />
      The entry into force on 25 May 2018 of the new directive relating to
      personal data requires us to obtain your consent for the recording of your
      details in our IT system. Without your consent, no information will be
      saved.
    </p>
  </div>

  <page_footer>
    <table style="width: 100%">
      <tr>
        <td style="width: 40%">
          <h5 style="margin: 0"><strong>ComputerShop Ixelles</strong></h5>
          <p style="font-size: 10pt; line-height: 14pt">
            252, Chaussée d'Ixelles<br />
            1050 Brussels<br />
            Tel: 02 647 48 51<br />
            computershop.ixelles@oxfam.org
          </p>

          Document generated on {$dateGeneration}
        </td>
        <td style="width: 20%">
          <img src="../../images/oxfamBelg.png" width="130" alt="Oxfam" />
        </td>
        <td style="width: 40%; text-align: right">
          <h5><strong>Oxfam-Solidarité asbl</strong></h5>
          <p style="font-size: 10pt">
            Rue des Quatre Vents, 60 1080<br />
            1080 Brussels<br />
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
