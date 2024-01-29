{if $avancements != Null}
<table class="table table-sm">
  {foreach from=$avancements key=idAvancement item=data}
  <tr 
    {if $data.barre == 1} class="barre" data-bs-toggle="tooltip" data-bs-title="Barré par {$data.barrePar}"{/if}>
    <td>
      {if $data.interactionClient != Null}
        {if $data.interactionClient == 'telephone'} 
          <i class="fa fa-phone" data-bs-title="Par téléphone" data-bs-toggle="tooltip"></i>
        {elseif $data.interactionClient == 'mail'} 
          <i class="fa fa-send" data-bs-title="Par mail" data-bs-toggle="tooltip"></i>
        {elseif $data.interactionClient == 'repondeur'} 
          <i class="fa fa-hashtag" data-bs-title="Message sur répondeur" data-bs-toggle="tooltip"></i>
        {elseif $data.interactionClient == 'magasin'} 
          <i class="fa fa-user" data-bs-title="Au magasin" data-bs-toggle="tooltip"></i>
        {/if}
        {else} 
        
      {/if}</td>
    <td>{$data.date|substr:0:5} {$data.heure}</td>
    <td>{$data.benevole}</td>

    <td>{$data.texte}</td>
    <td>
      {if ($data.benevole != $benevole.prenom) || ($data.barre == 1)}
      <button
        type="button"
        class="btn btn-warning btn-sm btn-strikeAvancement"
        data-idavancement="{$idAvancement}"
        data-numerobon="{$numeroBon}"
        {if ($data.barre == 1) && ($data.barrePar != $benevole.prenom)}disabled
        {/if}
      >
        <i class="fa fa-strikethrough" aria-hidden="true"></i>
      </button>
      {else}
      <button
        type="button"
        class="btn btn-danger btn-sm btn-delAvancement"
        data-idavancement="{$idAvancement}"
        data-numerobon="{$numeroBon}"
        data-idclient="{$idClient}"
      >
        <i class="fa fa-times"></i>
      </button>
      {/if}
    </td>
  </tr>
  {/foreach}
</table>
{else}
<h1 class="void">Rien encore</h1>
{/if}
