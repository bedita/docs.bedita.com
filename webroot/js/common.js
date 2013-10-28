// category filter
var pageCategories = new Array();
var baseUrl = $("meta[name='BEdita.base']").attr("content");

jQuery(document).ready(function($){
	// homepage.init();
	
	// Overlay on video thumb
	$('a.video img').each(function(i){
		var tthis = $(this);
		
		$('<div class="overlay"></div>')
			.insertBefore(tthis)
			.css({
				'opacity': 0.75,
				'position':'absolute',
				'height': tthis.parent().height(),
				'width': tthis.parent().width()
			})
			.hover(
				function(){$(this).css('opacity',1);},
				function(){$(this).css('opacity',0.75);}
			);
	});
	
	
	// get page categories
	var catTmp = new Array();
	$('li.applies-to a').each(function() {
		catTmp = $(this).attr('class').split(/\s+/);
		for (i = 0; i < catTmp.length; i++) {
			if ($.inArray(catTmp[i] , pageCategories)) {
				pageCategories.push( catTmp[i] );
			}
		}
	});


	// category filter events
	$("li.applies-to a").click(function(e) {
		e.preventDefault();
		
		var tthis = $(this);
		var category = tthis.attr("class");
		
		var liAllClass = tthis.parent().siblings().first(); // All Catgory li element
		var aAllClass = $('a:first',liAllClass); // All Catgory a element
		
		if (category == "all-categories"){ // click on "All categories"
			tthis.parent().addClass('selected-category').siblings().removeClass('selected-category');
			$('p.applies-to a').removeClass('selected-category');
			$('.article-preview').slideDown();
		}else{ // click su category button
			liAllClass.removeClass('selected-category');
			tthis.parent().toggleClass('selected-category');
			$('p.applies-to a.'+tthis.attr('class')).toggleClass('selected-category');
			
			var categories = tthis.parent().parent().children('.selected-category');
			if (!categories.length){
				aAllClass.click();
				return;
			}
			
			// selected categories
			var query ='';
			categories.each(function(i){
				if (i!=0) query += '&';
				query += '[class*='+$(this).children(0).attr('class')+']';
			});
			
			$('.article-preview:not('+query+')').slideUp();
			$('.article-preview'+query).slideDown();
		}
	});
	// Manage inline category button
	$('p.applies-to a').click(function(){
		var tthis = $(this);
		var c = tthis.attr('class').replace(/selected\-category/gi, '');
		$('li.applies-to a.'+c).click();
	});
	
	
	
	// colorbox
	$("div.article a.colorbox").colorbox();
	
	// remove empty paragraphs at start of articles
	$("div.article-preview p").each(function(){
		if ($.trim($(this).text()) === ""){
			$(this).remove();
		}
	});
	$("div.article-body p:first").each(function(){
		if ($.trim($(this).text()) === ""){
			$(this).remove();
		}
	});
	
	// glossary
	glossary.init($("div.js-glossary"), false);
	
	$(".js-toggle-definition").click(function() {
		var divToToggle = $(this).siblings("div.definition-text");
		if ($(this).siblings("div.definition-text:visible").length > 0) {
			divToToggle.slideUp();
		} else {
			divToToggle.slideDown();
		}
	});
	
	
});


var glossary = {
	init: function(parent, cleanup) {
		if (parent == undefined) {
			parent = $("body");
		}
		parent.find("dfn.glossario").css("cursor","help").attr("title", "see definition").click(function(){
			var appendTo = ($("div.article-body p:first").length > 0)? $("div.article-body p:first") : $("div.article-preview p:first");
			var options = {
				"url": baseUrl + 'glossary',
				"data": {
					"title": $(this).text()
				},
				"id": "glossary_" + $(this).text().replace(" ", "-"),
				"cleanup": cleanup,
				"appendAfter": appendTo,
				"afterShow": function(context) {
					glossary.init(context, false);
				}
			};
			$(this).minimodal(options);
		});
	},
	
	getFocus: function(modal, zIndex) {
		zIndex = parseInt(zIndex);
		$(".minimodal").each(function() {
			var minimodalZindex = parseInt($(this).css("z-index"));
			if (minimodalZindex > zIndex) {
				zIndex = minimodalZindex;
			}
		});
		zIndex++;
		modal.css("z-index", zIndex);
	}
}

/* Home page */
var homepage = {
  init: function(){
    if (!$.isFunction($.fn.cycle))
      return;
  }
}


jQuery.fn.minimodal = function(options) {
	if (options.url == undefined) {
		return false;
	}
	var now = new Date();
	var defaultOptions = {
		"data": {},
		"cleanup": false,
		"id": "minimodal_" + now.getTime(),
		"appendAfter": $(this),
		"afterShow": function() {}
	};
	options = $.extend(defaultOptions, options);
	var position = $(this).offset();
	var modclass = "";
	if (options.modalClass != undefined) {
		modclass = options.modalClass;
	}
	var isOpened = ($("div#" + options.id).length == 0)? false : true;
	
	var htmlModal = "<div class='minimodal' id='" + options.id + "'><a class='xclose' /><div class='modalcontent " + modclass + "'></div>";
	
	if (options.cleanup) {
		$('.minimodal').remove();
		options.appendAfter.after(htmlModal);
	} else if (!isOpened) {
		options.appendAfter.after(htmlModal);
	} else {
		$("div#" + options.id).find(".modalcontent").html("");
	}
	
	var $_currentModal = $("div#" + options.id);
	
	glossary.getFocus($_currentModal, $_currentModal.css("z-index"));
	
	$_currentModal.css({
		"left": "" + (position.left - 40) + "px",
		"top": "" + (position.top - 80) + "px"
	});

	$_currentModal.find(".modalcontent").css({
		background: "#FFF url('" + baseUrl + "img/loadingAnimation.gif') center no-repeat"
	}).load(options.url, options.data).ajaxComplete(function(){
		$(this).css("background-image", "none");
		options.afterShow($_currentModal);
	});

	$_currentModal.draggable({
		handle: "H1"
	});

	$_currentModal.find(".xclose").click(function(){
		$(this).closest('.minimodal').remove();
	});
	
	if (!isOpened) {
		$_currentModal.click(function(event) {
			if (!$(event.target).is("dfn")) {
				glossary.getFocus($_currentModal, $_currentModal.css("z-index"))
			}
		});
	}
	
//	if (!$('.minimodal').is(":visible")) {
//		$(this).after(htmlModal);
//	} else {
//		$(".minimodal .modalcontent").html("");
//	}

//	$(".minimodal").css({
//		"left": "" + (position.left - 40) + "px",
//		"top": "" + (position.top - 80) + "px"
//	});
//
//	$(".minimodal .modalcontent").css({
//		background: "#FFF url('" + baseUrl + "img/loadingAnimation.gif') center no-repeat"
//	}).load(options.url, options.data).ajaxComplete(function(){
//		$(this).css("background-image", "none");
//		options.afterShow($(".minimodal"));
//	});
//
//	$(".minimodal").draggable({
//		handle: "H1"
//	});
//
//	$(".minimodal .xclose").click(function(){
//		$(this).closest('.minimodal').remove();
//	});
	
	return true;
	
};
