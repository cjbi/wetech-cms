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

var tableName = 'example';

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
    $('#'+formName+' [name]').each(function(e) {
	if ($(this).val() != '' && $.contains($(this), 'checkbox') == false) {
	    $(this).val('');
	}
	if ($(this).attr('checked')) {
	    $(this).attr('checked', false);
	}
    });
    $('#'+formName).validator('destroy');
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
