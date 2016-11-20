$(function() {
    /*------------ 填充dataTables ------------*/
    var url ={
            'url': contextPath+'/admin/user/list.do',
            'data': function ( d ) {
        	if($('#searchValue').val() != '') {
        	    d.searchCode = $('#searchCode').val();
        	    d.searchValue = $('#searchValue').val();
        	}
            }
        };
    
    var gridTable = [ {
	'data' : 'id',
	'sWidth' : '2%',
	'bSortable' : true,
	'fnCreatedCell' : function(nTd, sData, oData, iRow, iCol) {
	    $(nTd).html('<input type="checkbox" name="checkList" title="' + sData + '" value="' + sData + '">');
	}
    }, {
	'data' : 'id'
    }, {
	'data' : 'username'
    }, {
	'data' : 'nickname'
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
	'data' : 'email'
    },{'data' : 'phone'}, {
	'data' : 'createDate',
	"mRender" : function(data) {
	    return dateFormat(data);
	}
    } ];

/*
 * // 上方btnPlugin DIV中追加HTML function initComplete(data) { var btnPlugin = '<div
 * class="am-btn-group am-btn-group-xs"><button type="button" class="am-btn
 * am-btn-default" id="btn-add" onclick="add()"> <span class="am-icon-plus"></span>
 * 新增 </button> <button type="button" class="am-btn am-btn-default"
 * onclick="edit()"> <span class="am-icon-edit"></span> 修改 </button> <button
 * type="button" class="am-btn am-btn-default" onclick="del()"> <span
 * class="am-icon-trash-o"></span> 删除 </button> <button type="button"
 * class="am-btn am-btn-default" id="test" onclick="test()"> <span
 * class="am-icon-refresh"></span> 测试 </button></div>'; // <button
 * class="am-btn am-btn-default" id="expCsv">导 出全部</button>
 * $("#btnPlugin").append(btnPlugin);// 在表格上方btnPlugin DIV中追加HTML
 *  }
 */
    // 页面数据加载
    var table = initTable(url, gridTable);

    /*------------ 通过id加载用户 ------------*/
    load = function(id) {
	var data = [];
	$.ajax({
	    type : "GET",
	    url : contextPath+'/admin/user/load/' + id,
	    async : false,
	    success : function(d) {
		data = d;
	    }
	});
	return data;
    }
    
    // draw event 事件
    $('#example').on( 'draw.dt', function () {
	    console.log( 'Redraw occurred at: '+new Date().getTime() );
     } );

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
	var data = table.rows('.selected').data()[0];
	var userData = load(data.id);
	console.log(userData.groupIds.join());

	var groupIds = userData.groupIds.join();
	var roleIds = userData.roleIds.join();

	$('#edit-modal [name=groupIds]').each(function() {
	    // alert($(this).val());
	    if (groupIds.indexOf($(this).val()) != -1) {
		$(this).attr('checked', true);
	    } else {
		$(this).attr('checked', false);
	    }
	});

	$('#edit-modal [name=roleIds]').each(function() {
	    // alert($(this).val());
	    if (roleIds.indexOf($(this).val()) != -1) {
		$(this).attr('checked', true);
	    } else {
		$(this).attr('checked', false);
	    }
	});
	// 将数据填充到模态框 结束
	
	var opts = {
	    title : '修改用户',
	    yes : function(index, layero) {
		// 处理异步验证结果
		var isFormValid = layero.find('#edit-form').validator('isFormValid');
		if (isFormValid) {
		    var data = [];
		    var roleIds = [];
		    var groupIds = [];
		    $('#edit-modal [name]').each(function(e) {
			data.push($(this).val());
		    });
		    $('#edit-modal [name=roleIds]').each(function(e) {
			if ($(this).attr('checked')) {
			    roleIds.push($(this).val());
			}
		    });
		    $('#edit-modal [name=groupIds]').each(function(e) {
			if ($(this).attr('checked')) {
			    groupIds.push($(this).val());
			}
		    });
		    console.log(data);
		    $.ajax({
			type : 'post',
			url : contextPath+'/admin/user/edit.do',
			dataType : 'json',
			data : {
			    'id' : data[0],
			    'password' : data[1],
			    'username' : data[2],
			    'nickname' : data[3],
			    'phone' : data[4],
			    'email' : data[5],
			    'status' : data[6],
			    'roleIds' : roleIds.join(),
			    'groupIds' : groupIds.join()
			},
			success : function(data) {
			    layer.msg(data.message, {
				time : '2000',
				icon : 6
			    });
			    console.log(data.message);
			    layer.close(index);
			    table.ajax.reload();
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
	 $('#edit-modal').layerOpen(opts);
    }

    /*------------ 删除 ------------*/
    del = function() {
	var url = contextPath+'/admin/user/delete.do';
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
		    var data = [];
		    var roleIds = [];
		    var groupIds = [];
		    $('#add-modal [name]').each(function(e) {
			data.push($(this).val());
		    });
		    $('#add-modal [name=roleIds]').each(function(e) {
			if ($(this).attr('checked')) {
			    roleIds.push($(this).val());
			}
		    });
		    $('#add-modal [name=groupIds]').each(function(e) {
			if ($(this).attr('checked')) {
			    groupIds.push($(this).val());
			}
		    });
		    $.ajax({
			type : 'post',
			url : contextPath+'/admin/user/add.do',
			dataType : 'json',
			data : {
			    'username' : data[0],
			    'nickname' : data[1],
			    'password' : data[2],
			    'confirmPwd' : data[3],
			    'phone' : data[4],
			    'email' : data[5],
			    'status' : data[6],
			    'roleIds' : roleIds.join(),
			    'groupIds' : groupIds.join()
			},
			success : function(data) {
			    layer.msg(data.message, {
				time : '2000',
				icon : 6
			    });
			    console.log(data.message);
			    layer.close(index);
			    table.ajax.reload();
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
	$('#add-modal').layerOpen(opts);
    };

});
