<header class="column-header">
	<hgroup>
		<h1>Tags</h1>
	</hgroup>
</header>
		
<article class="columns column-large">
   	{if !empty($listTags)}
	<section style="padding: 10px; text-align: justify;">
		{foreach from=$listTags item="tag"}
			<a title="{$tag.weight} article{if $tag.weight > 1}s{/if} about '{$tag.label}'" class="tagCloud {$tag.class|default:''}" href="{$html->url('/tag/')}{$tag.name}">{$tag.label}</a>
		{/foreach}
	</section>
	{/if}
</article>

<div class="clear"></div>