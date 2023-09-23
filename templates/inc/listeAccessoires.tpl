{foreach from=$allAccessoires key=id item=data  name=acc}
<div class="form-check form-check-inline">
  <input class="form-check-input" 
        type="checkbox" 
        name="accessoires[]" 
        id="accessoires_{$smarty.foreach.acc.index}"
        value="{$id}" 
        {if in_array($id,  array_keys($accessoires4bon))} checked {/if} 
    />
  <label for="accessoires_{$smarty.foreach.acc.index}"> {$data} </label>
</div>
{/foreach}
