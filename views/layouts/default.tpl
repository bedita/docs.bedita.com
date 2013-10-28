<!doctype html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>{$beFront->title()}</title>
	{$beFront->metaAll()}
	{$beFront->metaDc()}
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<meta name="BEdita.base"  content="{$html->url('/')}" />

	<link rel="icon" href="{$html->webroot}favicon.png" type="image/png" />

	<!-- CSS -->
	{$html->css('reset')}
	{$html->css('common')}
	{$html->css('colorbox')}
	<!-- /CSS -->

	{$html->script('libs/modernizr-2.0.6.min')}
	{$html->script('libs/jquery-1.7.min')}
	{$html->script('libs/jquery.colorbox-min')}
	{$html->script("libs/ui/ui.core.min")}
	{$html->script("libs/ui/ui.draggable.min")}
	{if $conf->staging}
		{$html->script('libs/jquery.cookie')}
	{/if}

	{* SyntaxHighlighter *}
	{$html->css('/syntaxhighlighter/css/shCore')}
	{$html->css('/syntaxhighlighter/css/shThemeDefault')}
	{$html->script('/syntaxhighlighter/js/shCore')}
	{$html->script('/syntaxhighlighter/js/shBrushAS3')}
	{$html->script('/syntaxhighlighter/js/shBrushBash')}
	{$html->script('/syntaxhighlighter/js/shBrushCss')}
	{$html->script('/syntaxhighlighter/js/shBrushJava')}
	{$html->script('/syntaxhighlighter/js/shBrushJScript')}
	{$html->script('/syntaxhighlighter/js/shBrushPhp')}
	{$html->script('/syntaxhighlighter/js/shBrushPlain')}
	{$html->script('/syntaxhighlighter/js/shBrushPython')}
	{$html->script('/syntaxhighlighter/js/shBrushRuby')}
	{$html->script('/syntaxhighlighter/js/shBrushSql')}
	{$html->script('/syntaxhighlighter/js/shBrushXml')}

	{* DISABLED
		$html->script('/syntaxhighlighter/js/shBrushAppleScript')*}
	{*$html->script('/syntaxhighlighter/js/shBrushColdfusion')*}
	{*$html->script('/syntaxhighlighter/js/shBrushCpp')*}
	{*$html->script('/syntaxhighlighter/js/shBrushCSharp')*}
	{*$html->script('/syntaxhighlighter/js/shBrushDelphi')*}
	{*$html->script('/syntaxhighlighter/js/shBrushDiff')*}
	{*$html->script('/syntaxhighlighter/js/shBrushErlang')*}
	{*$html->script('/syntaxhighlighter/js/shBrushGroovy')*}
	{*$html->script('/syntaxhighlighter/js/shBrushJavaFX')*}
	{*$html->script('/syntaxhighlighter/js/shBrushPerl')*}
	{*$html->script('/syntaxhighlighter/js/shBrushPowerShell')*}
	{*$html->script('/syntaxhighlighter/js/shBrushSass')*}
	{*$html->script('/syntaxhighlighter/js/shBrushScala')*}
	{*$html->script('/syntaxhighlighter/js/shBrushVb')
	*}
	{literal}
	<style type="text/css" media="all">
		body .syntaxhighlighter .line {
			white-space: pre-wrap !important; /* make code wrap */
		}
		.syntaxhighlighter a, .syntaxhighlighter div, .syntaxhighlighter code,
		.syntaxhighlighter table, .syntaxhighlighter table td, .syntaxhighlighter table tr,
		.syntaxhighlighter table tbody, .syntaxhighlighter table thead, .syntaxhighlighter table caption,
		.syntaxhighlighter textarea{
			overflow-y: hidden !important;
		}
	</style>
	<script type="text/javascript">$(function() {
		SyntaxHighlighter.defaults['gutter'] = false;
		SyntaxHighlighter.defaults['class-name'] = 'sh';
		SyntaxHighlighter.all();
	})</script>
	{/literal}
	{* /SyntaxHighlighter *}
	
	{$html->script('common')}
	
	{$beFront->feeds()}

	{$scripts_for_layout}
	{$beFront->stats()}
</head>

<body>
{if $conf->staging}{$view->element("staging_toolbar")}{/if}
<div id="wrapper">
<div id="container">

{$view->element('header')}

{$content_for_layout}

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