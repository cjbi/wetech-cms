$(document).ready(function() {
    // 初始化

});

$(function() {
    // 填充dataTables
    var url = contextPath + '/admin/cmsLink/list.do';
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
	'data' : 'title',
	'sWidth' : '20%'
    }, {
	'data' : 'url'
    }, {
	'data' : 'type'
    }, {
	'data' : 'newWin',
	"mRender" : function(data, type, full) {
	    if (data == '1') {
		return '<span class="am-badge am-badge-success">新窗口</span>';
	    } else if (data == '0') {
		return '<span class="am-badge am-badge-success">本窗口</span>';
	    } else {
		return "未知";
	    }
	}
    }, {
	'data' : 'pos'
    } ];
    // 页面数据加载
    var table = initTable(url, gridTable);
    
    //填充选择框方法
    fillTypes = function() {
	var url = contextPath + '/admin/cmsLink/listAllType.do';
	$.ajax({
	    type : "post",
	    url : url,
	    dataType : "json",
	    data : {},
	    success : function(data) {
		$('select[id="add-type"],select[id="edit-type"]').children().remove();
		$('select[id="add-type"],select[id="edit-type"]').append('<option value="0">请选择类型</option>');
		for ( var i in data) {
		    $('select[id="add-type"],select[id="edit-type"]').append('<option value="' + data[i] + '">' + data[i] + '</option>');
		}
		$('select[id="add-type"],select[id="edit-type"]').append('<option value="-1">选择其他</option>');
	    },
	    error : function(data) {
		layer.msg('操作失败', {
		    time : 2000,
		    icon : 5
		});
	    }
	});
    }
    
    //类型点击事件
    $('select').on('click',['select[id="add-type"]','select[id="edit-type"]'],function() {
	if($(this).val()!=0 && $(this).val()!=-1) {
	    $(this).parent().parent().find('[name="type"]').val( $(this).val());
	}
	if($(this).val()!=-1) {
	    $(this).parent().parent().find('[name="type"]').prop('readonly',true);
	} else {
	    $(this).parent().parent().find('[name="type"]').prop('readonly',false);
	}
    });
    
    // 修改
    edit = function() {
	// 填充选择框
	fillTypes();
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
		    $('#edit-modal').submit(contextPath + '/admin/cmsLink/edit.do');
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

    // 删除
    del = function() {
	var url = contextPath + '/admin/cmsLink/delete.do';
	deleteBatch(url, 'id');
    }

    // 新增
    add = function() {
	// 填充选择框
	fillTypes();
	var opts = {
	    title : '添加用户',
	    yes : function(index, layero) {
		// 处理异步验证结果
		var isFormValid = layero.find('#add-form').validator('isFormValid');
		if (isFormValid) {
		    $('#add-modal').submit(contextPath + '/admin/cmsLink/add.do');
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
    }

    /**
     * 重置
     */
    reset = function () {
        loadContent('#cmsLink', function () {
            reloadComponent();
        })
    }

});
