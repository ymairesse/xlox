{if $listeMentions != Null}
<div class="input-group">
  <button class="btn btn-warning btn-pasteMention" type="button"><i class="fa fa-angle-down"></i></button>
  <select name="mentions" id="mentions" class="form-control">
    <option value="">Selectionner une mention</option>
    {foreach from=$listeMentions key=idMention item=mention}
    <option value="{$idMention}">{$mention.texte}</option>
    {/foreach}
  </select>
</div>
{/if}

<style>
  #mentions {
    height: 24px;
    font-size: 14px;
    padding: 0 10px;
  }

  .btn-pasteMention {
    height: 24px;
    font-size: 14px;
    padding: 0 10px;
  }
</style>

