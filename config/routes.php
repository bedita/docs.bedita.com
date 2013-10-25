<?php
	// specific publication routing rules
	// first active section on the publication's tree is used as home page
	Router::connect('/', array('controller' => 'pages', 'action' => 'route', 'homePage'));
	
	Router::connect('/glossary/*', array('controller' => 'pages', 'action' => 'glossary'));
	
	// DO NOT EDIT OR CHANGE BELOW!!
	Router::connect('/lang/*', array('controller' => 'pages', 'action' => 'changeLang'));
	Router::connect('/section/*', array('controller' => 'pages', 'action' => 'section'));
	Router::connect('/content/*', array('controller' => 'pages', 'action' => 'content'));
    Router::connect('/(?!pages)(.*)', array('controller' => 'pages', "action" => "route"));
?>