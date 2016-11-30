$(function() {
    /*------------ 填充dataTables ------------*/
    var url = contextPath + '/admin/pic/listIndexPic.do';
    var gridTable = [ {
	'data' : 'id',
	"sWidth" : "2%",
	'bSortable' : true,
	'fnCreatedCell' : function(nTd, sData, oData, iRow, iCol) {
	    $(nTd).html('<input type="checkbox" name="checkList" title="' + sData + '" value="' + sData + '">');
	}
    }, {
	'data' : 'id',
	'sWidth' : '5%'
    }, {
	'data' : 'newName',
	'sWidth' : '5%',
	"mRender" : function(data, type, full) {
	    var originalSrc =  contextPath + '/resources/indexPic/' + data;
	    var thumbnailSrc = contextPath + '/resources/indexPic/thumbnail/' + data;
	    
	    var img = '<img class="am-thumbnail am-thumbnail am-animation-scale-up" src="' + thumbnailSrc + '" title="点击查看大图"/>';
	    return '<a href="'+originalSrc+'" target="_blank">' + img + '</a>';
	}
    }, {
	'data' : 'title',
	'sWidth' : '20%'
    }, {
	'data' : 'status',
	"mRender" : function(data, type, full) {
	    if (data == '1') {
		return '<span class="am-badge am-badge-success">已启用</span>';
	    } else if (data == '0') {
		return '<span class="am-badge am-badge-danger">已停用</span>';
	    } else {
		return "未知";
	    }
	}
    }, {
	'data' : 'linkType',
	'sWidth' : '20%',
	"mRender" : function(data, type, full) {
	    if (data == '1') {
		return '<span class="am-badge am-badge-success">站外链接</span>';
	    } else if (data == '0') {
		return '<span class="am-badge am-badge-success">站内链接</span>';
	    } else {
		return "未知";
	    }
	}
    }, {
	'data' : 'pos',
	'sWidth' : '20%'
    } ];
    // / / 页面数据加载
    var table = initTable(url, gridTable);

    /*------------ 修改 ------------*/
    edit = function() {
	var rowLength = table.rows('.selected').data().length;
	if (rowLength == 0) {
	    layer.msg('请选择一条记录！', {
		time : '2000',
		icon : 0
	    });
	    return false;
	} else if (rowLength > 1) {
	    layer.msg('最多可选一条记录！', {
		time : '2000',
		icon : 0
	    });
	    return false;
	}
	// / / 将数据填充到模态框 开始
	initData();
	// / / 将数据填充到模态框 结束

	var opts = {
	    title : '修改用户',
	    yes : function(index, layero) {
		// / / 处理异步验证结果
		var isFormValid = layero.find('#edit-form').validator('isFormValid');
		if (isFormValid) {
		    $('#edit-modal').submit(contextPath + '/admin/group/edit.do');
		    layer.close(index);
		} else {
		    layer.msg('数据验证失败', {
			time : 2000,
			icon : 5
		    });
		}
	    }
	};
	$('#edit-modal').layerOpen(opts);
    }

    /*------------ 删除 ------------*/
    del = function() {
	var url = contextPath + '/admin/group/delete.do';
	deleteBatch(url, 'id');
    }

    /*------------ 新增 ------------*/
    $('#add').on('click', function() {
	var index = layer.open({
	    type : 2,
	    title : '发表文章',
	    maxmin : true, // 开启最大化最小化按钮
	    area: ['100%', '100%'],
	    /*btn : [ '发表', '关闭' ],*/
	    content : contextPath + '/admin/pic/add.do'
	});
	layer.full(index);
    });

});
