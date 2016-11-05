/*------------ 多列查询 ------------*/
jQuery.fn.dataTableExt.oApi.fnMultiFilter = function(oSettings, oData) {
    for ( var key in oData) {
	if (oData.hasOwnProperty(key)) {
	    for (var i = 0, iLen = oSettings.aoColumns.length; i < iLen; i++) {
		if (oSettings.aoColumns[i].sName == key) {
		    /* Add single column filter */
		    oSettings.aoPreSearchCols[i].sSearch = oData[key];
		    break;
		}
	    }
	}
    }
    this.oApi._fnReDraw(oSettings);
};

/*------------ 对象级别的插件开发 ------------*/
(function($) {
    $.fn.layerOpen = function(opts) {
	// Our plugin implementation code goes here.
	var __modalDom = $(this);
	console.log('---------------------->');
	
	var __title = $.extend({}, opts ? (opts.title || {}) : {});
	
	var __yes = $.extend(function(index, layero) {
	    layer.msg('请定义参数yes');
	}, opts ? (opts.yes || {}) : {});

	var __defaultOpts = $.extend({
	    title : __title,
	    type : 1,
	    shift : 2,
	    moveType : 1,
	    // 此参数开启最大化最小化
	    // maxmin: true,
	    area : [ '600px', 'auto' ],
	    content : $(this),
	    btn : [ '确定', '关闭' ],
	    // 按钮一【确定】的回调
	    // index 当前层索引 layero 当前层DOM对象
	    yes : __yes,
	    cancel : function(index) {
		// 按钮二【关闭】和右上角关闭的回调
	    },
	    end : function() {
		// 无论是确认还是取消，只要层被销毁了，end都会执行
		__modalDom.children('form').find('[name]').each(function(e) {
		    // 如果类型是checkbox，就取消选中
		    if ($(this).attr('type') == 'checkbox') {
			$(this).attr('checked', false);
		    }
		    // 否则如果不等于空，就清空
		    else if ($(this).val() != '') {
			$(this).val('');
		    }
		});
		// 销毁表格验证
		__modalDom.children("form").validator('destroy');
	    },
	    success : function(layero, index) {
		// 层弹出后的成功回调方法
		console.log(layero, index);
	    }
	}, opts || {});

	layer.open(__defaultOpts);
    };
})(jQuery);

var tableName = 'example';

/*------------ 初始化table ------------*/
initTable = function(url, gridTable, initComplete, ServerParams, tableNames) {
    tableName = tableNames == undefined ? 'example' : tableNames;
    var table = $('#' + tableName).dataTable({
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
	'ajax' : url,
	"dom" : '<"am-g am-g-collapse"<"am-g am-datatable-hd"<"am-u-sm-8"<"#topPlugin">><"am-u-sm-4"f>>rt<<"am-datatable-hd am-u-sm-4"l><"am-u-sm-4"i><"am-u-sm-4"p>><"clear">>',
	'responsive' : true,
	'columns' : gridTable,
	"fnServerData" : ServerParams,
	'oLanguage' : { // 国际化配置
	    'sProcessing' : '正在获取数据，请稍后...',
	    // 'sLengthMenu' : ' 显示 _MENU_ 项结果',
	    'sZeroRecords' : '没有找到数据',
	    // 'sInfo' : '从 _START_ 到 _END_ 条记录 总记录数为 _TOTAL_ 条',
	    'sInfo' : ' _START_ -  _END_  _TOTAL_ ',
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

}
/*------------ checkbox全选,必须用prop方法设置 ------------*/
checkAll = function() {
    if ($('input[id="checkAll"]').is(':checked')) {
	$('input[name="checkList"]').parent().parent().addClass('selected');
	$('input[name="checkList"]').prop('checked', true);
    } else {
	$('input[name="checkList"]').parent().parent().removeClass('selected');
	$('input[name="checkList"]').prop('checked', false);
    }
};

rowActive = function() {
    $('input[name="checkList"]').each(function() {
	if ($(this).is(':checked')) {
	    $(this).parent().parent().addClass('selected');
	} else {
	    $(this).parent().parent().removeClass('selected');
	}
    });
};

/*------------ 销毁表单 ------------*/
destoryForm = function(formName) {
    // 无论是确认还是取消，只要层被销毁了，end都会执行
    $('#' + formName + ' [name]').each(function(e) {
	if ($(this).val() != '' && $.contains($(this), 'checkbox') == false) {
	    $(this).val('');
	}
	if ($(this).attr('checked')) {
	    $(this).attr('checked', false);
	}
    });
    $('#' + formName).validator('destroy');
}

/*------------ 删除数据，url：请求地址，pk：主键 ------------*/
deleteBatch = function(url, pk) {
    var table = $('#' + tableName).DataTable();
    var rowData = {};
    var array = [];
    var dictType = table.rows('.selected').data();
    var str = $('#' + tableName + ' tbody tr[class="even selected"]').length + $('#' + tableName + ' tbody tr[class="odd selected"]').length;
    if (dictType[0] == undefined) {
	layer.msg('请选择一条记录！', {
	    time : '2000',
	    icon : 0
	});
    }
    $.each(dictType[0], function(key, value) {
	key = new obj(key, []);
	array.push(key);
    });
    for (var i = 0; i < dictType.length; i++) {
	$.each(dictType[i], function(key, value) {
	    for (var j = 0; j < array.length; j++) {
		$.each(array[j], function(key2, value2) {
		    if (key == key2) {
			value2.push(value);
		    }
		});
	    }
	});
    }
    $.each(array, function(key, value) {
	$.each(value, function(key2, value2) {
	    rowData[key2] = value2;
	});
    });
    if (str == 0) {
	layer.msg('请选择一条记录！', {
	    time : '2000',
	    icon : 0
	});
    } else {
	layer.confirm('确定要删除这' + str + '条数据吗？', {
	    icon : 3,
	    title : '系统提示',
	    moveType : 1,
	    yes : function(index, layero) {
		// 从rowData中获得主键id数组
		console.log(rowData);
		$.ajax({
		    type : 'post',
		    url : url,
		    dataType : 'json',
		    data : 'ids=' + rowData[pk].join(),
		    success : function(data) {
			layer.msg(data.message, {
			    time : '2000',
			    icon : 6
			});
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
	    }
	});
    }
};

/*------------ 将值填充到表单中 ------------*/
editData = function() {// 将值填充到表单中
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
    var data = table.rows('.selected').data()[0];
    $.each(data, function(key, value) {
	$("#edit-modal [name='" + key + "']").val(value);
    });
};

function obj(tkey, tval) { // 动态生成类变量方法
    this[tkey] = tval;
}
