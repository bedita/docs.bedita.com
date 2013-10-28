<!doctype html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>{$this->publication.public_name|default:"BEdita docs"} |  Error 500 - Internal server error</title>
	
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<meta name="BEdita.base"  content="{$html->url('/')}" />

	<link rel="icon" href="{$html->webroot}favicon.png" type="image/png" />

	<!-- CSS -->
	{$html->css('reset')}
	{$html->css('common')}
	<!-- /CSS -->

	{$html->script('libs/modernizr-2.0.6.min')}
	{$html->script('libs/jquery-1.7.min')}
	{$html->script('libs/jquery.zclip.min')}
	{$html->script('libs/jquery.colorbox-min')}
	{$html->script("libs/ui/ui.core.min")}
	{$html->script("libs/ui/ui.draggable.min")}
	{if $conf->staging}
		{$html->script('libs/jquery.cookie')}
	{/if}
	{$html->script('common')}
	
	{$beFront->feeds()}

	{$beFront->stats()}
</head>

<body>
{if $conf->staging}{$view->element("staging_toolbar")}{/if}
<div id="wrapper">
<div id="container">

{$view->element('header')}

<div class="clear"></div>

<header class="column-header">
	<hgroup>
		<h1>Error 500</h1>
		<h2>Internal server error</h2>
	</hgroup>
</header>

<article class="columns column-large">
	<section>
		<div class="article-preview">
			<hgroup><h1>Whoops... something went wrong!</h1></hgroup>
			
			<p>
			You may want to:
			<ul style="margin-top: 10px;">
				<li><a href="{$html->url('/')}">go to home page</a></li>
				<li><a href="javascript:history-back(-1)">go back to previous page</a></li>
			</ul>
			</p>
		</div>
	</section>
</article>


<div class="clear"></div>


{$view->element('footer')}

</div> <!--! end of container -->
</div> <!--! end of wrapper -->

  <!-- scripts concatenated and minified via ant build script-->
  {*
  <script defer src="js/plugins.js"></script>
  <script defer src="js/script.js"></script>
  *}
  <!-- end scripts-->


  <!--[if lt IE 7 ]>
    <script src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.3/CFInstall.min.js"></script>
    {literal}
    <script>window.attachEvent('onload',function(){CFInstall.check({mode:'overlay'})})</script>
    {/literal}
  <![endif]-->

</body>
</html>