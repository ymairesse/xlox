{if $interactions != Null}
<table class="table table-condensed">
    {foreach from=$interactions key=idInteraction item=data}
    <tr>
      <td>{$data.date|substr:0:5}  {$data.heure}</td>
      <td>{$data.benevole}</td>
      <td>
        {if $data.typeInteraction == 'telephone'}
        <button
          type="button"
          class="btn btn-primary btn-sm"
          title="Téléphone"
        >
          <i class="fa fa-phone" aria-hidden="true"></i>
          
        </button>
        {elseif $data.typeInteraction == 'mail'}
        <button
          type="button"
          class="btn btn-primary btn-sm"
          title="Mail"
        >
          <i class="fa fa-send" aria-hidden="true"></i>
        </button>
        {elseif $data.typeInteraction == 'magasin'}
        <button
          type="button"
          class="btn btn-primary btn-sm"
          title="Au magasin"
        >
          <i class="fa fa-user" aria-hidden="true"></i>
        </button>
        {else}
        <button
          type="button"
          class="btn btn-primary btn-sm"
          title="Répondeur"
        >
          <i class="fa fa-hashtag" aria-hidden="true"></i>
        </button>
        {/if}
        
      </td>
      <td>{$data.note}</td>
      <td>
        <button
          type="button"
          class="btn btn-danger btn-sm btn-delInteraction"
          data-idinteraction="{$idInteraction}"
          data-numerobon="{$numeroBon}"
        >
          <i class="fa fa-times"></i>
        </button>
      </td>
    </tr>
    {/foreach}
  </table>
{else} 
<h1 class="void">Rien encore</h1>
{/if}
