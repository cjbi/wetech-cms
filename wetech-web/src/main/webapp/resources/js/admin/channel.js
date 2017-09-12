$(function() {

    // 初始化ztree
    var rMenu = $("#rMenu");
    var setting = {
	data : {
	    simpleData : {
		enable : true,
		idKey : 'id',
		pIdKey : 'pId',
		rootPId : 0
	    }
	},
	view : {
	    expandSpeed : 300,
	// 设置树展开的动画速度，IE6下面没效果
	},
	async : {
	    enable : true,
	    url : getAsyncUrl
	},
	callback : {
	    asyncError : zTreeOnAsyncError, // 加载错误的fun
	    beforeClick : beforeClick, // 捕获单击节点之前的事件回调函数
	    onRightClick : OnRightClick
	}
    };

    // 获取异步连接
    function getAsyncUrl(treeId, treeNode) {
	return treeNode == undefined ? contextPath + '/admin/channel/getChannelTree.do' : contextPath + '/admin/channel/getChannelTree?pId=' + treeNode.id;
    }

    // 加载错误的fun
    function zTreeOnAsyncError(event, treeId, treeNode) {
	alert('数据加载失败!');
    }

    // 点击之后的动作
    function beforeClick(treeId, treeNode) {
	// 销毁表单验证
	$('#edit-form').validator('destroy');
	// 取消被选中状态
	$('#edit-form [type="radio"]').removeAttr('checked');

	// 将值赋给编辑表单
	$.each(treeNode.obj, function(key, value) {
	    if ($('#edit-form [name="' + key + '"]').attr('type') == 'radio') {
		$('#edit-form [name="' + key + '"][value="' + value + '"]').prop('checked', true);
	    } else {
		$('#edit-form [name="' + key + '"]').val(value);
	    }
	});
	$('#edit-form [name="pId"]').val(treeNode.pId);
    }

    var zNodes = [];
    $.fn.zTree.init($("#tree"), setting, zNodes);

    //  右键触发事件
    // 在ztree上的右击事件
    function OnRightClick(event, treeId, treeNode) {
	// 是否叶子节点
	try {
	    // 在这里运行代码
	    if (treeNode.obj.isLeaf == '1') {
		showRMenu("leaf", event.clientX, event.clientY, treeNode.id, treeNode.name, treeNode.pId);
	    } else {
		showRMenu("", event.clientX, event.clientY, treeNode.id, treeNode.name, treeNode.pId);
	    }
	} catch (err) {
	    // 在这里处理错误
	    console.log(err);
	}
    }
    // 显示右键菜单
    function showRMenu(type, x, y, id, pName, pId) {
	$('#add-form [name="pId"]').val(id);
	$('#add-form [name="pName"]').val(pName);
	$('#rMenu ul').show();
	// 是否叶子节点
	if (type == 'leaf') {
	    $('#rAdd-curr').hide();
	    $('#rAdd-chi').hide();
	} else {
	    $('#rAdd-curr').show();
	    $('#rAdd-chi').show();
	}
	console.log(pId);
	// 是否父id为0
	if (pId == 0) {
	    $('#rAdd-curr').show();
	} else {
	    $('#rAdd-curr').hide();
	}

	rMenu.css({
	    "top" : y + "px",
	    "left" : x + "px",
	    "visibility" : "visible"
	}); // 设置右键菜单的位置、可见
	$("body").bind("mousedown", onBodyMouseDown);
    }
    // 隐藏右键菜单
    function hideRMenu() {
	if (rMenu)
	    rMenu.css({
		"visibility" : "hidden"
	    }); // 设置右键菜单不可见
	$("body").unbind("mousedown", onBodyMouseDown);
    }
    // 鼠标按下事件
    function onBodyMouseDown(event) {
	if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length > 0)) {
	    rMenu.css({
		"visibility" : "hidden"
	    });
	}
    }

    //  rDel删除节点
    $('#rDel').click(function() {

	layer.confirm('确定要删除 [' + $('#add-form [name="pName"]').val() + '] 吗？', {
	    icon : 3,
	    title : '系统提示',
	    yes : function(index, layero) {
		// 发送异步请求
		$.ajax({
		    type : 'post',
		    url : contextPath + '/admin/channel/delete.do',
		    dataType : 'json',
		    data : {
			id : $('#add-form [name="pId"]').val()
		    },
		    success : function(data) {
			if (data.status == false) {
			    layer.msg(data.message, {
				time : '2000',
				icon : 0
			    });
			    return;
			}
			layer.msg(data.message, {
			    time : '2000',
			    icon : 6
			});
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			var nodes = treeObj.getSelectedNodes();
			treeObj.reAsyncChildNodes(null, "refresh");
		    },
		    error : function(data) {
			layer.msg('操作失败', {
			    time : 2000,
			    icon : 5
			});
		    }
		});
	    }
	});
    });

    //  新增节点的模态框表单提交
    $('#rAdd-chi,#rAdd-curr').click(function() {
	var opts = {
	    title : '新增节点',
	    area : [ '800px', 'auto' ],
	    yes : function(index, layero) {
		// 处理异步验证结果
		var isFormValid = layero.find('#add-form').validator('isFormValid');
		if (isFormValid) {
		    $.ajax({
			type : 'post',
			url : contextPath + '/admin/channel/add.do',
			dataType : 'json',
			data : {
			    pId : $('#add-form [name="pId"]').val(),
			    name : $('#add-form [name="name"]').val(),
			    isLeaf : $('#add-form [name="isLeaf"]:checked').val(),
			    type : $('#add-form [name="type"]').val(),
			    customLink : $('#add-form [name="customLink"]:checked').val(),
			    customLinkUrl : $('#add-form [name="customLinkUrl"]').val(),
			    isIndex : $('#add-form [name="isIndex"]:checked').val(),
			    isTopNav : $('#add-form [name="isTopNav"]:checked').val(),
			    recommend : $('#add-form [name="recommend"]:checked').val(),
			    status : $('#add-form [name="status"]:checked').val(),
			    navOrder : $('#add-form [name="navOrder"]').val(),
			    descn : $('#add-form [name="descn"]').val()
			},
			success : function(data) {
			    layer.msg(data.message, {
				time : '2000',
				icon : 6
			    });
			    var treeObj = $.fn.zTree.getZTreeObj("tree");
			    var nodes = treeObj.getSelectedNodes();
			    treeObj.reAsyncChildNodes(null, "refresh");
			    console.log(data.message);
			    layer.close(index);
			},
			error : function(data) {

			    layer.msg('操作失败', {
				time : 2000,
				icon : 5
			    });
			}
		    });
		} else {
		    layer.msg('数据验证失败', {
			time : 2000,
			icon : 5
		    });
		}
	    }
	};
	$('#rAdd-modal').layerOpen(opts);
    });

    // 此方法只有父id为null的才有效
    $('#rAdd-curr').click(function() {
	try {
	    $('#add-form [name="pId"]').val("0");
	    $('#add-form [name="pName"]').val("根目录");
	    return true;
	} catch (e) {
	    return false;
	}
    });

    //  右边编辑表单提交
    $('#edit-form [type="submit"]').on('click', function() {
	var isFormValid = $('#edit-form').validator('isFormValid');
	if (isFormValid) {
		var dataValue = $('#edit-form').serialize();
	    console.log(dataValue);
	    // 发送异步请求
	    $.ajax({
		type : 'post',
		url : contextPath + '/admin/channel/edit.do',
		dataType : 'json',
		data : dataValue,
		success : function(data) {
		    layer.msg(data.message, {
			time : '2000',
			icon : 6
		    });
		    var treeObj = $.fn.zTree.getZTreeObj("tree");
		    var nodes = treeObj.getSelectedNodes();
		    treeObj.reAsyncChildNodes(null, "refresh");
		},
		error : function(data) {
		    layer.msg('操作失败', {
			time : 2000,
			icon : 5
		    });
		}
	    });
	} else {
	    layer.msg('操作失败', {
		time : 2000,
		icon : 5
	    });
	}
    });

});
