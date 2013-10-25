	{if $media.object_type_id == $conf->objectTypes.video.id}
		<div class="media_embed">
			{assign_associative var="flashParams" htmlEmbed=true}
			{assign_associative var="params" params=$flashParams}
			{assign_associative var="htmlparams" width=$mediaWidth|default:720}
			{if $media.provider|default:"" == "youtube"}
				{array_add var="htmlparams" height=540}
			{/if}
			{$beEmbedMedia->object($media,$params,$htmlparams)}
		</div>
	{*
	{else}
		{assign_associative var="params" width=$mediaWidth|default:720 mode=fill URLonly=true}
		{assign var="imageUrl" value=$beEmbedMedia->object($media,$params)}
		{image_info var="imageInfo" file=$imageUrl}
		
		<div class="media_embed" style="height:{$imageInfo.h}px;">
			<img src="{$imageUrl}" title="{$media.title}" alt="{$media.title}"/>
		</div>
	*}
	{/if}