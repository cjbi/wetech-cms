$(document).ready(function() {
    /*------------ 初始化 ------------*/

});

$(function() {
    /*------------ 填充dataTables ------------*/
    var table = $('#example').DataTable({
	"aLengthMenu" : [ 10, 15, 20, 40, 60 ],
	"searching" : true,// 禁用搜索
	"lengthChange" : true,
	"paging" : true,// 开启表格分页
	"bProcessing" : true,
	"bServerSide" : true,
	"bAutoWidth" : true,
	"sort" : "position",
	"deferRender" : true,// 延迟渲染
	"bStateSave" : true, // 在第三页刷新页面，会自动到第一页
	"iDisplayLength" : 15,
	"iDisplayStart" : 0,
	"ordering" : false,// 全局禁用排序
	"scrollX" : true,
	"ajax" : {
	    "type" : "POST",
	    "url" : "../../admin/user/list.do",
	// "data" : function(d) {
	// d.state = $("#state").val();
	// d.deptname = $("#deptname").val().trim();
	// d.startTime = $("#startTime").val();
	// d.endTime = $("#endTime").val();
	// }
	},
	// "dom": 'rt<"am-g
	// am-datatable-footer"<"am-u-sm-5"<"am-form-group"i><"am-form-group"l>><"am-u-sm-7"p>><"clear">',
	"responsive" : true,
	"columns" : [ {
	    "data" : "id",
	    "bSortable" : false,
	    "fnCreatedCell" : function(nTd, sData, oData, iRow, iCol) {
		$(nTd).html("<label class='am-checkbox'><input type='checkbox' title='" + sData + "' value='" + sData + "'></label>");
	    }
	}, {
	    "data" : "id"
	}, {
	    "data" : "username"
	}, {
	    "data" : "nickname"
	}, {
	    "data" : "status"
	}, {
	    "data" : "email"
	}, {
	    "data" : "email"
	} ],
	"oLanguage" : { // 国际化配置
	    "sProcessing" : "正在获取数据，请稍后...",
	    // "sLengthMenu" : " 显示 _MENU_ 项结果",
	    "sZeroRecords" : "没有找到数据",
	    "sInfo" : "从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条",
	    "sInfoEmpty" : "记录数为0",
	    "sInfoFiltered" : "(全部记录数 _MAX_ 条)",
	    "sInfoPostFix" : "",
	    "sSearch" : "搜索",
	    "sUrl" : "",
	    "oPaginate" : {
		"sFirst" : "第一页",
		"sPrevious" : "«",
		"sNext" : "»",
		"sLast" : "最后一页"
	    }
	},
    });

    /*------------ 新增 ------------*/
    add = function() {
	$("#add-form").validator();
	layer.open({
	    title : '添加用户',
	    type : 1,
	    shift : 2,
	    moveType : 1,
	    // 此参数开启最大化最小化
	    // maxmin: true,
	    area : [ "600px", "auto" ],
	    content : $('#add'),
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
		    $("#add [name]").each(function(e) {
			data.push($(this).val());
		    });
		    $("#add [name=roleIds]").each(function(e) {
			if ($(this).attr("checked")) {
			    roleIds.push($(this).val());
			}
		    });
		    $("#add [name=groupIds]").each(function(e) {
			if ($(this).attr("checked")) {
			    groupIds.push($(this).val());
			}
		    });
		    $.ajax({
			type : "post",
			url : "../../admin/user/add.do",
			dataType : "json",
			data : {
			    "username" : data[0],
			    "nickname" : data[1],
			    "password" : data[2],
			    "confirmPwd" : data[3],
			    "phone" : data[4],
			    "email" : data[5],
			    "status" : data[6],
			    "roleIds" : roleIds.join(),
			    "groupIds" : groupIds.join()
			},
			success : function(data) {
			    layer.msg(data.message, {
				time : "2000",
				icon : 6
			    });
			    layer.close(index);
			    table.ajax.reload();
			},
			error : function(data) {

			    layer.msg("操作失败", {
				time : 2000,
				icon : 5
			    });
			}
		    });
		} else {
		    layer.msg("数据验证失败", {
			time : 2000,
			icon : 5
		    });
		}

	    },
	    cancel : function(index) {
		// 按钮二【关闭】和右上角关闭的回调
	    },
	    end : function() {
		console.log('layer end');
		// 无论是确认还是取消，只要层被销毁了，end都会执行
		$("#add [name]").each(function(e) {
		    if ($(this).val() != '') {
			$(this).val('');
		    }
		    if ($(this).attr("checked")) {
			$(this).attr("checked", false);
		    }
		});
		$('#add-form').validator('destroy');
	    },
	    success : function(layero, index) {
		// 层弹出后的成功回调方法
		console.log(layero, index);
	    }
	});
    };
});
