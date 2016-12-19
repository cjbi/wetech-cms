$(function() {
	/*------------ 填充dataTables ------------*/
	var url = contextPath + '/admin/topic/list.do';
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
		'sWidth' : '30%',
		"mRender" : function(data, type, full) {
			return '<a href="http://localhost:8888/topic/' + full.id + '" target="_blank">' + data + '</a>';
		}
	}, {
		'data' : 'author'
	}, {
		'data' : 'recommend',
		"mRender" : function(data, type, full) {
			if (data == '1') {
				return '<span class="am-badge am-badge-primary">推荐</span>';
			} else if (data == '0') {
				return '<span class="am-badge">不推荐</span>';
			} else {
				return "未知";
			}
		}
	}, {
		'data' : 'cname'
	}, {
		'data' : 'status',
		"mRender" : function(data, type, full) {
			if (data == '1') {
				return '<span class="am-badge am-badge-success">已发布</span>';
			} else if (data == '0') {
				return '<span class="am-badge  am-badge-success">未发布</span>';
			} else {
				return "未知";
			}
		}
	}, {
		'data' : 'publishDate',
		"mRender" : function(data) {
			return dateFormat(data);
		}
	} ];
	// 页面数据加载
	var table = initTable(url, gridTable);

	/*------------ 修改 ------------*/
	$('#edit').on('click', function() {
		//只能选择一条数据
		var rowLength = table.rows('.selected').data().length;
		if (rowLength == 0) {
			layer.msg('请选择一条记录！', {
				time : '2000',
				icon : 0
			});
			return;
		} else if (rowLength > 1) {
			layer.msg('最多可选一条记录！', {
				time : '2000',
				icon : 0
			});
			return;
		}
		var data = table.rows('.selected').data()[0];
		var index = layer.open({
			type : 2,
			title : '发表文章',
			maxmin : true, // 开启最大化最小化按钮
			area : [ '100%', '100%' ],
			/* btn : [ '发表', '关闭' ], */
			content : contextPath + '/admin/topic/edit/'+data.id
		});
		layer.full(index);
	});

	/*------------ 删除 ------------*/
	del = function() {
		var url = contextPath + '/admin/topic/delete.do';
		deleteBatch(url, 'id');
	}

	/*------------ 新增 ------------*/
	$('#add').on('click', function() {
		var index = layer.open({
			type : 2,
			title : '发表文章',
			maxmin : true, // 开启最大化最小化按钮
			area : [ '100%', '100%' ],
			/* btn : [ '发表', '关闭' ], */
			content : contextPath + '/admin/topic/add.do'
		});
		layer.full(index);
	});
});
