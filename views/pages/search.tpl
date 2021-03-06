
<header class="column-header">
	<hgroup>
		<h1>Search</h1>
		<h2>Articles matching:
			<span style="display: block; font-style: italic; font-size: 1.6em; line-height: 1em; margin-top: 5px;">{$stringSearched}</span>
		</h2>
	</hgroup>
</header>

<article class="columns column-large">
	<section>
		{if !empty($searchResult.items)}
		{assign var="continueImage" value=$html->image('sbisciulo.png')}
		{foreach from=$searchResult.items item="article"}
			{if !empty($article.Category)}
				{assign var="categories" value=$article.Category}
			{/if}
			<div class="article-preview {if !empty($categories)}{foreach from=$categories item="category"} {$category.name}{/foreach}{/if}">
				<a href="{$html->url($article.canonicalPath)}">
					<hgroup>
						<h1>{$article.title}</h1>
					</hgroup>
					<div>{$article.abstract|default:$article.body|html_substr:90:$continueImage}</div>
				</a>
				{if !empty($article.Category)}
					<p class="applies-to">› This article applies to {foreach from=$categories item="category"} <a href="javascript: void(0);" class="{$category.name}">{$category.label}</a>{/foreach}</p>
				{/if}
			</div>
		{/foreach}
		{/if}
	</section>
</article>

{if !empty($pageCategories)}
<nav class="page-categories">
	<h1>Filter by category</h1>
	<ul>
		<li class="applies-to selected-category"><a href="javascript: void(0)" class="all-categories">All categories</a></li>
	{foreach from=$pageCategories item="pageCategory"}
		<li class="applies-to"><a href="javascript: void(0);" class="{$pageCategory.name}">{$pageCategory.label}</a></li>
	{/foreach}
	</ul>
</nav>
{/if}


<div class="clear"></div>

{$view->element('tag_cloud')}
