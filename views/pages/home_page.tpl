    {foreach from=$menu item="menuItem" name="menuItem"}
    <article class="columns column-{$smarty.foreach.menuItem.iteration}">
    	<a href="{$html->url($menuItem.canonicalPath)}">
    	<header class="column-header" style="background-color: {$menuItem.ObjectProperty.color.value.property_value}">
    		<hgroup>
	    		<h1>{$menuItem.title}</h1>
	    		<h2>{$menuItem.description}</h2>
    		</hgroup>
    	</header>
    	</a>

		<div class="clear"></div>
		
    	<section>
			{assign var="continueImage" value=$html->image('sbisciulo.png')}
    		{if !empty($menuItem.childContents)}
    		{foreach from=$menuItem.childContents item="article"}
	    		<a href="{$html->url($article.canonicalPath)}">
	    		<div class="article-preview">
	    			<hgroup>
	    				<h1>{$article.title}</h1>
	    			</hgroup>
	    			{if $article.object_type_id == $conf->objectTypes.short_news.id}
	    				{assign var="abstract" value=$article.description}
	    			{else}
	    				{assign var="abstract" value=$article.abstract}
	    			{/if}
					<div>{$abstract|default:$article.body|html_substr:90:$continueImage}</div>
	    		</div>
	    		</a>
    		{/foreach}
    		{/if}
			
			{if !empty($menuItem.mostRead)}
			<hgroup class="separator" style="background-color: {$menuItem.ObjectProperty.color.value.property_value}">
				<h2>Most read</h2>
			</hgroup>
    		{foreach from=$menuItem.mostRead item="article"}
	    		<a href="{$html->url($article.canonicalPath)}">
	    		<div class="article-preview">
	    			<hgroup>
	    				<h1>{$article.title}</h1>
	    			</hgroup>
	    			{if $article.object_type_id == $conf->objectTypes.short_news.id}
	    				{assign var="abstract" value=$article.description}
	    			{else}
	    				{assign var="abstract" value=$article.abstract}
	    			{/if}
					<div>{$abstract|default:$article.body|html_substr:90:$continueImage}</div>
	    		</div>
	    		</a>
    		{/foreach}
    		{/if}
    	</section>
    </article>
    {/foreach}


	<div class="clear"></div>

	{$view->element('tag_cloud')}

