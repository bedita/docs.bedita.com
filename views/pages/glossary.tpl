{if !empty($isAjax)}
	{if !empty($definitionTerm)}
		<h1>{$definitionTerm.title}</h1>

		{if !empty($definitionTerm.description)}

			<div id="glossarydescription">{$definitionTerm.description}</div>

		{/if}
	{else}
		<h1>oops :(</h1>
		<div id="glossarydescription">definition term not found</div>
	{/if}
	
{else}
	
	{if !empty($definitionTerm)}
		
		
		<a href="{$html->url("/glossary")}" title="back to glossary list">
		<header class="column-header">
			<hgroup>
				<h1>Glossary</h1>
				<h2>Definition</h2>
			</hgroup>
		</header>
		</a>
				
		<article class="columns column-large">
			<section>
				<div class="article js-glossary">
					<hgroup>
						<h1>{$definitionTerm.title}</h1>
					</hgroup>
					<div class="article-body">{$definitionTerm.description}</div>
			
					<div class="article-share">
						{assign_concat var="url" 1=$publication.public_url 2="/glossary/" 3=$definitionTerm.nickname}
						<p>PermaLink <a id="permalink" title="permanent link to this article">{$url}</a></p>
						<p style="float: right;">Comments and support on Google Groups
						<a href="https://groups.google.com/forum/?fromgroups#!forum/bedita" target="_blank" class="facebook" title="Post on Google Groups">{$html->image('share-googlegroups.png')}</a>
						</p>
						<p style="float:left;">Share
						<a href="http://api.addthis.com/oexchange/0.8/forward/facebook/offer?url={$url}" target="_blank" class="facebook" title="Post on facebook">{$html->image('share-facebook.png')}</a>
						<a href="http://api.addthis.com/oexchange/0.8/forward/twitter/offer?url={$url}" target="_blank" class="twitter" title="Share on twitter">{$html->image('share-twitter.png')}</a>
						<a href="http://api.addthis.com/oexchange/0.8/forward/google/offer?url={$url}" target="_blank" class="googleplus" title="Share on Google+">{$html->image('share-googleplus.png')}</a>
						<a href="mailto:?subject={$definitionTerm.title}&body=From%20docs.bedita.com:%20{$url}" target="_blank" class="mail" title="Send by email">{$html->image('share-mail.png')}</a>
						</p>
					</div>					
				</div>
			</section>
		</article>
		
	
	{else}
	
		<header class="column-header">
			<hgroup>
				<h1>Glossary</h1>
			</hgroup>
		</header>

		<article class="columns column-large">
			<section>
				{if !empty($glossary)}
				{assign var="continueImage" value=$html->image('sbisciulo.png')}
				{foreach from=$glossary item="term"}
					<div class="article-preview js-glossary">
						<a href="javascript: void(0);" class="js-toggle-definition">
							<hgroup>
								<h1>{$term.title}</h1>
							</hgroup>
						</a>
					
						<p class="applies-to">
							<a href="{$html->url("/glossary/")}{$term.nickname}">PermaLink</a>
						</p>
						
						<div class="definition-text" style="display: none; margin-top:8px;">{$term.description}</div>
					</div>
				{/foreach}
				{/if}
			</section>
		</article>
		
	{/if}

	
	<div class="clear"></div>

	{$view->element('tag_cloud')}
	
{/if}
