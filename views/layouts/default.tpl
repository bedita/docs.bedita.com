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

	{$javascript->link('libs/modernizr-2.0.6.min')}
	{$javascript->link('libs/jquery-1.7.min')}
	{$javascript->link('libs/jquery.colorbox-min')}
	{$javascript->link("libs/ui/ui.core.min")}
	{$javascript->link("libs/ui/ui.draggable.min")}
	{if $conf->staging}
		{$javascript->link('libs/jquery.cookie')}
	{/if}

	{* SyntaxHighlighter *}
	{$html->css('/syntaxhighlighter/css/shCore')}
	{$html->css('/syntaxhighlighter/css/shThemeDefault')}
	{$javascript->link('/syntaxhighlighter/js/shCore')}
	{$javascript->link('/syntaxhighlighter/js/shBrushAS3')}
	{$javascript->link('/syntaxhighlighter/js/shBrushBash')}
	{$javascript->link('/syntaxhighlighter/js/shBrushCss')}
	{$javascript->link('/syntaxhighlighter/js/shBrushJava')}
	{$javascript->link('/syntaxhighlighter/js/shBrushJScript')}
	{$javascript->link('/syntaxhighlighter/js/shBrushPhp')}
	{$javascript->link('/syntaxhighlighter/js/shBrushPlain')}
	{$javascript->link('/syntaxhighlighter/js/shBrushPython')}
	{$javascript->link('/syntaxhighlighter/js/shBrushRuby')}
	{$javascript->link('/syntaxhighlighter/js/shBrushSql')}
	{$javascript->link('/syntaxhighlighter/js/shBrushXml')}

	{* DISABLED
		$javascript->link('/syntaxhighlighter/js/shBrushAppleScript')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushColdfusion')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushCpp')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushCSharp')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushDelphi')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushDiff')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushErlang')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushGroovy')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushJavaFX')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushPerl')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushPowerShell')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushSass')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushScala')*}
	{*$javascript->link('/syntaxhighlighter/js/shBrushVb')
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
	
	{$javascript->link('common')}
	
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