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

    $.ajaxCheck = function(data) {
	if (data.result)
	    return true;
	else {
	    alert(data.msg);
	    return false;
	}
    };
})(jQuery);

$(function() {
    // 初始化CollapaseNav状态
    initCollapaseNavStatus = function() {
	var cookie = $.AMUI.utils.cookie;
	// 从缓存中取出折叠状态
	var tagNav = cookie.get('collapase-nav');
	if (tagNav != null) {
	    $('#' + tagNav).addClass('am-in');
	}
	// 保存折叠状态到缓存
	// 折叠面板绑定事件
	$('#collapase-nav-1').on('open.collapse.amui', '.am-panel', function(event) {
	    // cookie 7天之后失效
	    var expires = new Date(new Date().valueOf() + 7 * 24 * 60 * 60 * 1000);
	    var tagId = $(this).find('ul').attr('id');
	    cookie.set('collapase-nav', tagId, expires, '/');
	}).on('close.collapse.amui', function() {
	    // cookie.unset('collapase-nav', '/');
	});
    }

    // 设置面板绑定事件
    $('#collapase-nav-1 a[class="am-cf"]').on('click', function(e) {
	var href = $(this).attr('href');
	if (href != undefined && href != "" && href != "#") {
	    $('#admin-content').load(href);
	    e.preventDefault();
	}
    });

    // 初始化CollapaseNav状态
    initCollapaseNavStatus();
});

// ajax全局事件 modified on 2016/11/22
$(function() {
    $(document).ajaxError(function(event, request, settings) {
	console.log('error log start:-------------------------------------->：');
	console.log(request);
	console.log(settings);
	console.log('error log end:-------------------------------------->：');
	layer.alert(request.status +'  ('+request.statusText+')', {
	    title : '出错',
	    icon : 5,
	    closeBtn : 0, // 关闭滚动条
	    scrollbar : false
	// 屏蔽浏览器滚动条
	// 动画类型
	});
    });

    // 加载进度条动画
    $(document).ajaxStart(function() {
	$.AMUI.progress.start();
    });
    $(document).ajaxStop(function() {
	$.AMUI.progress.done();
    });

});
