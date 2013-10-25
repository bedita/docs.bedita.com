<div style="float: right; margin: 80px 190px 0 0;">
<form action="{$html->url('/search')}" method="post">
	<input type="text" name="searchstring" value="{$stringSearched|default:''}" style="width: 110px;"/>
	<input type="submit" value="{t}search{/t}"/>
</form>
</div>