	<aside class="article-meta">
		<a href="{$html->url($section.canonicalPath)}">
		<header class="column-header" style="{if !empty($section.ObjectProperty.color.value.property_value)} background-color: {$section.ObjectProperty.color.value.property_value};{/if}">
			<hgroup>
	    		<h1>{$section.title}</h1>
	    		<h2>{$section.description|default:''}</h2>
			</hgroup>
		</header>
		</a>

		{if !empty($section.currentContent.relations.download)}
		<div class="article-meta">
			<hgroup>
				<h1>Download</h1>
			</hgroup>
			<ul>
				{foreach from=$section.currentContent.relations.download item="download"}
				<li><a href="{$html->url('/download')}/{$download.nickname}" title="Download file">{$download.title}</a></li>
				{/foreach}
			</ul>
		</div>
		{/if}

		{if !empty($section.currentContent.relations.seealso)}
		<div class="article-meta">
			<hgroup>
				<h1>See also</h1>
			</hgroup>
			<ul>
				{foreach from=$section.currentContent.relations.seealso item="seealso"}
				<li><a href="{$html->url('/')}{$seealso.nickname}">{$seealso.title}</a></li>
				{/foreach}
			</ul>
		</div>
		{/if}
		
		{if !empty($section.currentContent.relations.link)}
		<div class="article-meta">
			<hgroup>
				<h1>Link</h1>
			</hgroup>
			<ul>
				{foreach from=$section.currentContent.relations.link item="link"}
				<li><a href="{$link.url}" target="{$link.target}">{$link.title}</a></li>
				{/foreach}
			</ul>
		</div>
		{/if}
	</aside>

	<article class="columns column-large">
		<section>
			{if !empty($section.currentContent)}
				<div class="article js-glossary">
					{if !empty($section.currentContent.Category)}
					<p class="applies-to" style="margin-bottom: 5px;{if !empty($section.ObjectProperty.color.value.property_value)} color: {$section.ObjectProperty.color.value.property_value};{/if}">
						› This article applies to <span>{foreach from=$section.currentContent.Category item="category"} “{$category.label}”{/foreach}</span>
					</p>
					{/if}

					<hgroup>
						<h1>{$section.currentContent.title}</h1>
						{if !empty($section.currentContent.abstract) }
							<h2>{$section.currentContent.abstract}</h2>
						{/if}
					</hgroup>


					{if !empty($section.currentContent.body) }
						<div class="article-body">{$section.currentContent.body}</div>
					{/if}
					
					<div class="article-attach clearfix">
					{if !empty($section.currentContent.relations.attach)}
						{assign_associative var="paramsThumb" width="140" height="140" mode="crop"}
						{assign_associative var="paramsLarge" URLonly="true" width="600" mode="fill"}
						{foreach from=$section.currentContent.relations.attach item="attach" name="attachForeach"}
							{if $attach.object_type_id != $conf->objectTypes.video.id}
							<div class="article-image{if $smarty.foreach.attachForeach.index % 3 == 2} even{/if}">
								<a href="{$beEmbedMedia->object($attach, $paramsLarge)}" class="colorbox" rel="gallery">{$beEmbedMedia->object($attach, $paramsThumb)}</a>
								<p>{$attach.description|default:""}</p>
							</div>
							{else}
							<div class="article-image{if $smarty.foreach.attachForeach.index % 3 == 2} even{/if}">
								{assign_associative var="params" presentation="thumb"}
								{assign_associative var="htmlAttr"}

								<a href="{$html->url('/pages/showMedia')}/{$attach.nickname}" title="{$attach.title}" class="colorbox video">{$beEmbedMedia->object($attach, $params, $htmlAttr)}</a>

								<p>{$attach.description|default:""}</p>
							</div>
							{/if}
							{if $smarty.foreach.attachForeach.index % 3 == 2}<div class="clear"></div>{/if}

						{/foreach}
					{/if}
					</div>

					<div class="clear"></div>

					<div class="article-share">
						{if !empty($section.currentContent.Tag)}
							<p class="article-tags">{foreach from=$section.currentContent.Tag item="tag"} <a href="{$html->url('/tag/')}{$tag.name}" class="">{$tag.label}</a>{/foreach}</p>
						{/if}
						{assign_concat var="url" 1=$publication.public_url 2=$html->url($section.currentContent.canonicalPath)}
						<p>PermaLink <a id="permalink" title="permanent link to this article">{$url}</a></p>
						<p style="float: right;">Comments and support on Google Groups
						<a href="https://groups.google.com/forum/?fromgroups#!forum/bedita" target="_blank" class="facebook" title="Post on Google Groups">{$html->image('share-googlegroups.png')}</a>
						</p>
						<p style="float:left;">Share
						<a href="http://api.addthis.com/oexchange/0.8/forward/facebook/offer?url={$url}" target="_blank" class="facebook" title="Post on facebook">{$html->image('share-facebook.png')}</a>
						<a href="http://api.addthis.com/oexchange/0.8/forward/twitter/offer?url={$url}" target="_blank" class="twitter" title="Share on twitter">{$html->image('share-twitter.png')}</a>
						<a href="http://api.addthis.com/oexchange/0.8/forward/google/offer?url={$url}" target="_blank" class="googleplus" title="Share on Google+">{$html->image('share-googleplus.png')}</a>
						<a href="mailto:?subject={$section.currentContent.title}&body=From%20docs.bedita.com:%20{$url}" target="_blank" class="mail" title="Send by email">{$html->image('share-mail.png')}</a>
						</p>
					</div>
				</div>
			{/if}
		</section>
	</article>

	<div class="clear"></div>
