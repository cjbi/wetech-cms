$(function() {
    /*------------ 填充dataTables ------------*/
    var url = contextPath + '/admin/system/clean/listNoUseAttachment.do';
    var attaCount = 0;
    var indexPicCount = 0;
    var gridTable = [ {
	'data' : 'id',
	'sWidth' : '5%'
    }, {
	'data' : 'oldName',
    }, {
	'data' : 'newName',
    }, {
	'data' : 'size'
    }, {
	'data' : 'type',
	"mRender" : function(data, type, full) {
	    var table = $('#example').DataTable();
	    // 将总数量赋值给attaCount
	    if (attaCount == 0) {
		attaCount = table.context[0]['_iRecordsTotal'];
		$('#attaCount').text(attaCount);
	    }
	    return data;
	}
    } ];

    listNoUseIndexPic = function() {
	var url = contextPath + '/admin/system/clean/listNoUseIndexPic';
	$.ajax({
	    type : 'post',
	    url : url,
	    dataType : 'json',
	    success : function(data) {
		// 将总数量赋值给indexPicCount
		indexPicCount = data.length;
		$('#indexPicCount').text(indexPicCount);
		for ( var i in data) {
		    var img = '<a href="'+contextPath+'/resources/indexPic/' + data[i] + '" target="_blank"><img class="am-thumbnail am-thumbnail am-animation-scale-up" src="'+contextPath+'/resources/indexPic/thumbnail/' + data[i] + '" title="点击查看大图"></a>';
		    $('tbody').append('<tr>');
		    $('tr:last').append('<td>' + img + '</td>');
		    $('tr:last').append('<td>' + data[i] + ' </td>');

		    $('tbody').children().append('</tr>');
		}
	    },
	    error : function(data) {
		layer.msg('操作失败', {
		    time : 2000,
		    icon : 5
		});
	    }
	});
    }

    // 未引用的垃圾附件数据加载
    initTable(url, gridTable);
    // 未引用的首页图片数据加载
    listNoUseIndexPic();

    $('#cleanIndexPic').click(function() {
	layer.confirm('确定要清理这'+indexPicCount+'条未引用的首页图片数据吗？', {
	    icon : 3,
	    title : '系统提示',
	    yes : function(index, layero) {
		var url = contextPath + '/admin/system/clean/cleanIndexPic';
		$.ajax({
		    type : 'post',
		    url : url,
		    dataType : 'json',
		    data : {},
		    success : function(data) {
			layer.msg(data.message, {
			    time : '2000',
			    icon : 6
			});
			layer.close(index);
			loadContent('#system/clean',function() {
                // callback重新注册组件
                $('[data-am-selected]').selected();
            });
			
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
    $('#cleanAtta').click(function() {
	layer.confirm('确定要清理这' + attaCount + '条未引用的垃圾附件数据吗？', {
	    icon : 3,
	    title : '系统提示',
	    yes : function(index, layero) {
		var url = contextPath + '/admin/system/clean/cleanAtta';
		$.ajax({
		    type : 'post',
		    url : url,
		    dataType : 'json',
		    data : {},
		    success : function(data) {
			layer.msg(data.message, {
			    time : '2000',
			    icon : 6
			});
			layer.close(index);
			loadContent('#system/clean',function() {
                // callback重新注册组件
                $('[data-am-selected]').selected();
            });
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
			if ($(this).prop('checked')) {
			    roleIds.push($(this).val());
			}
		    });
		    $('#add-modal [name=groupIds]').each(function(e) {
			if ($(this).prop('checked')) {
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
