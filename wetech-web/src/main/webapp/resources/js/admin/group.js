$(document).ready(function() {
    /*------------ 初始化 ------------*/

});

$(function() {
    /*------------ 填充dataTables ------------*/
    var url = contextPath+'/admin/group/list.do';
    var gridTable = [ {
	'data' : 'id',
	"sWidth" : "2%",
	'bSortable' : true,
	'fnCreatedCell' : function(nTd, sData, oData, iRow, iCol) {
	    $(nTd).html('<input type="checkbox" name="checkList" title="' + sData + '" value="' + sData + '">');}},
	    {'data' : 'id','sWidth' : '5%' },
	    {'data' : 'name','sWidth' : '20%' },
	    {'data' : 'descr'} ];
    // 上方topPlugin DIV中追加HTML
    function initComplete(data) {
	var topPlugin = '<div class="am-btn-group am-btn-group-xs"><button type="button" class="am-btn am-btn-default" id="btn-add" onclick="add()"> <span class="am-icon-plus"></span> 新增 </button> <button type="button" class="am-btn am-btn-default" onclick="edit()"> <span class="am-icon-edit"></span> 修改 </button> <button type="button" class="am-btn am-btn-default" onclick="del()"> <span class="am-icon-trash-o"></span> 删除 </button></div>';
	// <button class="am-btn am-btn-default" id="expCsv">导 出全部</button>
	$("#topPlugin").append(topPlugin);// 在表格上方topPlugin DIV中追加HTML

    }
    // 页面数据加载
    initTable(url, gridTable, initComplete);

    /*------------ 选中行触发事件 ------------*/
    $('#example tbody').on('click', 'tr', function() {
	rowActive();
    });
    
    /*------------ 修改 ------------*/
    edit = function() {
	var table = $('#' + tableName).DataTable();
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
			url : contextPath+'/admin/group/edit.do',
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
	var url = contextPath+'/admin/group/delete.do';
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
		    $.ajax({
			type : 'post',
			url : contextPath+'/admin/group/add.do',
			dataType : 'json',
			data : {
			    'name' : data[0],
			    'descr' : data[1],
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

    test = function() {
	var opts = {
	    title : '添加用户',
	    yes : function(index, layero) {
		// 处理异步验证结果
		var isFormValid = layero.find('#add-form').validator('isFormValid');
		if (isFormValid) {
		   
		    $.ajax({
			type : 'post',
			url : contextPath+'/admin/group/add.do',
			dataType : 'json',
			data : {
			    'name' : data[0],
			    'descr' : data[1]
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
    }

});
