$(document).ready(function() {
    /*------------ 初始化 ------------*/

});

$(function() {
    /*------------ 填充dataTables ------------*/
    var table = $('#example').DataTable({
	'aLengthMenu' : [ 10, 15, 20, 40, 60 ],
	'searching' : false,// 开启搜索框
	'lengthChange' : true,
	'paging' : true,// 开启表格分页
	'bProcessing' : true,
	'bServerSide' : true,
	'bAutoWidth' : true,
	'sort' : 'position',
	'deferRender' : true,// 延迟渲染
	'bStateSave' : false, // 刷新时保存表格状态
	'iDisplayLength' : 15,
	'iDisplayStart' : 0,
	'ordering' : false,// 全局禁用排序
	// 'scrollX' : true,
	'ajax' : {
	    'type' : 'POST',
	    'url' : '../../admin/user/list.do',
	},
	"dom" : '<"am-g am-g-collapse"<"am-g am-datatable-hd"<"am-u-sm-8"<"#topPlugin">><"am-u-sm-4"f>>rt<<"am-u-sm-4"l><"am-u-sm-4"i><"am-u-sm-4"p>><"clear">>',
	'responsive' : true,
	'columns' : [ {
	    'data' : 'id',
	    "sWidth" : "2%",
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
		    return '<font color="green">启用</font>';
		} else if (data == '0') {
		    return '<font color="red">停用</font>';
		} else {
		    return "未知";
		}
	    }
	}, {
	    'data' : 'email'
	}, {
	    'data' : 'email'
	} ],
	'oLanguage' : { // 国际化配置
	    'sProcessing' : '正在获取数据，请稍后...',
	    // 'sLengthMenu' : ' 显示 _MENU_ 项结果',
	    'sZeroRecords' : '没有找到数据',
	    'sInfo' : '从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条',
	    'sInfoEmpty' : '记录数为0',
	    'sInfoFiltered' : '(全部记录数 _MAX_ 条)',
	    'sInfoPostFix' : '',
	    'sSearch' : '搜索:',
	    'sUrl' : '',
	    'oPaginate' : {
		'sFirst' : '第一页',
		'sPrevious' : '«',
		'sNext' : '»',
		'sLast' : '最后一页'
	    }
	},
	initComplete : initComplete
    });

    /*------------ 上方topPlugin DIV中追加HTML ------------*/
    function initComplete(data) {
	var topPlugin = '<div class="am-btn-group am-btn-group-xs"><button type="button" class="am-btn am-btn-default" onclick="add()"> <span class="am-icon-plus"></span> 新增 </button> <button type="button" class="am-btn am-btn-default" onclick="edit()"> <span class="am-icon-edit"></span> 修改 </button> <button type="button" class="am-btn am-btn-default" onclick="del()"> <span class="am-icon-trash-o"></span> 删除 </button></div>';
	// <button class="am-btn am-btn-default" id="expCsv">导 出全部</button>
	$("#topPlugin").append(topPlugin);// 在表格上方topPlugin DIV中追加HTML

    }

    /*------------ 选中行触发事件 ------------*/
    $('#example tbody').on('click', 'tr', function() {
	rowActive();
    });

    /*------------ checkbox全选 ------------*/
    $('input[id="checkAll"]').bind('click', function() {
	checkAll();
    });

    /*------------ 通过id加载用户 ------------*/
    load = function(id) {
	var data = [];
	$.ajax({
	    type : "GET",
	    url : '../../admin/user/load/' + id,
	    async : false,
	    success : function(d) {
		data = d;
	    }
	});
	return data;
    }

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

	// 将数据填充到模态框
	editData();
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

	layer.open({
	    title : '添加用户',
	    type : 1,
	    shift : 2,
	    moveType : 1,
	    // 此参数开启最大化最小化
	    // maxmin: true,
	    area : [ '600px', 'auto' ],
	    content : $('#edit-modal'),
	    btn : [ '确定', '关闭' ],
	    // 按钮一【确定】的回调
	    // index 当前层索引 layero 当前层DOM对象
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
			url : '../../admin/user/edit.do',
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

	    },
	    cancel : function(index) {
		// 按钮二【关闭】和右上角关闭的回调
	    },
	    end : function() {
		destoryForm('edit-form');
	    },
	    success : function(layero, index) {
		// 层弹出后的成功回调方法
		console.log(layero, index);
	    }
	});
    }

    /*------------ 删除 ------------*/
    del = function() {
	var url = '../../admin/user/delete.do';
	deleteBatch(url, 'id');
    }

    /*------------ 新增 ------------*/
    add = function() {
	$('#add-form').validator();
	layer.open({
	    title : '添加用户',
	    type : 1,
	    shift : 2,
	    moveType : 1,
	    // 此参数开启最大化最小化
	    // maxmin: true,
	    area : [ '600px', 'auto' ],
	    content : $('#add-modal'),
	    btn : [ '确定', '关闭' ],
	    // 按钮一【确定】的回调
	    // index 当前层索引 layero 当前层DOM对象
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
			url : '../../admin/user/add.do',
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

	    },
	    cancel : function(index) {
		// 按钮二【关闭】和右上角关闭的回调
	    },
	    end : function() {
		// 无论是确认还是取消，只要层被销毁了，end都会执行
		destoryForm('add-form');
	    },
	    success : function(layero, index) {
		// 层弹出后的成功回调方法
		console.log(layero, index);
	    }
	});
    };

});
