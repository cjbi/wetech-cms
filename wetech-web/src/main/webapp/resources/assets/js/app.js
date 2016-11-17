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

    $.ajaxCheck = function(data) {
	if (data.result)
	    return true;
	else {
	    alert(data.msg);
	    return false;
	}
    };
    
    /*------------ ztree  ------------*/
    $.fn.mytree = function(opts) {
	var setting = $.extend({
	    data : {
		simpleData : {
		    enable : true,
		    idKey : "id",
		    pIdKey : "pid",
		    rootPId : -1
		}
	    },
	    view : {
		dblClickExpand : false,
		selectedMulti : false
	    },
	    async : {
		enable : true,
		url : opts ? (opts.url || "channel/treeAll") : "channel/treeAll"

	    },
	    mine : {
		listChild : 1,
		srcElement : "#cc"
	    },
	    callback : {
		onAsyncSuccess : function() {
		    if (opts.mine.expandAll)
			t.expandAll(true);
		}
	    }
	}, opts || {});
	var _mine = setting.mine;
	var t = $.fn.zTree.init($(this), setting);
	t.getCheckParentNodes = getCheckParentNodes;
	t.getCheckChildNodes = getCheckChildNodes;
	if (_mine.listChild) {
	    t.setting.callback.onClick = listChild;
	}

	function listChild(event, treeId, treeNode) {
	    $(_mine.srcElement).attr("src", "channels/" + treeNode.id);
	}

	function getCheckParentNodes(treeNode, checked) {
	    var ps = new Array();
	    var pn;
	    while ((pn = treeNode.getParentNode())) {
		if (pn.checked == checked)
		    ps.push(pn);
		treeNode = pn;
	    }
	    return ps;
	}
	// 第三个参数存储所有子节点
	function getCheckChildNodes(treeNode, checked, cs) {
	    var ccs;
	    if ((ccs = treeNode.children)) {
		for (var i = 0; i < ccs.length; i++) {
		    var c = ccs[i];
		    if (c.checked == checked) {
			cs.push(c);
		    }
		    getCheckChildNodes(c, checked, cs);
		}
	    }
	}
	return t;
    };

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
	// cookie.unset('collapase-nav', '/');
    });
});
