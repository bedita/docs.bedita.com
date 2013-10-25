{if !empty($section.contentRequested) || ( !empty($section.childContents) && count($section.childContents) == 1 )}

	{$view->element('article')}

{else}
	<a href="{$html->url($section.canonicalPath)}">
	<header class="column-header" {if !empty($section.ObjectProperty.color.value.property_value)}style="background-color: {$section.ObjectProperty.color.value.property_value};"{/if}>
		<hgroup>
    		<h1>{$section.title}</h1>
    		{if $section.description}<h2>{$section.description}</h2>{/if}
		</hgroup>
	</header>
	</a>

    <article class="columns column-large">
    	<section>
    		{if !empty($section.childContents)}
				{assign var="continueImage" value=$html->image('sbisciulo.png')}
    		{foreach from=$section.childContents item="article"}
	    		{if !empty($article.Category)}
					{assign var="categories" value=$article.Category}
				{/if}
	    		<div class="article-preview {foreach from=$categories item="category"} {$category.name}{/foreach}">
		    		<a href="{$html->url($article.canonicalPath)}">
		    			<hgroup>
		    				<h1>{$article.title}</h1>
		    			</hgroup>
						<p>{$article.abstract|default:$article.body|html_substr:120:$continueImage}</p>
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
{/if}
