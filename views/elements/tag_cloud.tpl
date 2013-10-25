<article class="tag-cloud">
	<a href="{$html->url('/pages/loadTags')}">
	<header class="column-header">
		<hgroup>
			<h1>Tag Cloud</h1>
			<h2>Browse by keyword</h2>
		</hgroup>
	</header>
	</a>

	{if !empty($listTags)}
	<section>
		{foreach from=$listTags item="tag"}
			<a title="{$tag.weight} article{if $tag.weight > 1}s{/if} about '{$tag.label}'" class="tagCloud {$tag.class|default:''}" href="{$html->url('/tag/')}{$tag.name}">{$tag.label}</a>
		{/foreach}
	</section>
	{/if}
</article>

<div class="clear"></div>