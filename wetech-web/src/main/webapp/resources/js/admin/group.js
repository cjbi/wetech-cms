$(function() {
    /*------------ 填充dataTables ------------*/
    var url = contextPath + '/admin/group/list.do';
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
	'data' : 'name',
	'sWidth' : '20%'
    }, {
	'data' : 'descr'
    } ];
    // 页面数据加载
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
	// 将数据填充到模态框 开始
	initData();
	// 将数据填充到模态框 结束

	var opts = {
	    title : '修改用户',
	    yes : function(index, layero) {
		// 处理异步验证结果
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
    add = function() {
	var opts = {
	    title : '添加用户',
	    yes : function(index, layero) {
		// 处理异步验证结果
		var isFormValid = layero.find('#add-form').validator('isFormValid');
		if (isFormValid) {
		    $('#add-modal').submit(contextPath + '/admin/group/add.do');
		    layer.close(index);
		} else {
		    layer.msg('数据验证失败', {
			time : 2000,
			icon : 5
		    });
		}
	    }
	};
	$('#add-modal').layerOpen(opts);
    };

});
