var cookie = $.AMUI.utils.cookie;
(function($) {
    'use strict';
    $(function() {
	var $fullText = $('.admin-fullText');
	$('#admin-fullscreen').on('click', function() {
	    $.AMUI.fullscreen.toggle();
	});

	$(document).on($.AMUI.fullscreen.raw.fullscreenchange, function() {
	    $fullText.text($.AMUI.fullscreen.isFullscreen ? '退出全屏' : '开启全屏');
	});
    });
})(jQuery);
/*------------ 初始化 ------------*/
$(document).ready(function() {
    var tagNav = cookie.get('collapase-nav');
    if (tagNav != null) {
	$('#' + tagNav).addClass('am-in');
    }
});
/*------------ 折叠面板绑定事件 ------------*/
$(function() {
    $('#collapase-nav-1').on('open.collapse.amui', '.am-panel', function(event) {
	console.log('折叠菜单打开了！');
	// cookie 7天之后失效
	var expires = new Date(new Date().valueOf() + 7 * 24 * 60 * 60 * 1000);
	var tagId = $(this).find('ul').attr('id');
	cookie.set('collapase-nav', tagId, expires, '/');
    }).on('close.collapse.amui', function() {
	console.log('折叠菜单关闭了！');
//	cookie.unset('collapase-nav', '/');
    });
});
