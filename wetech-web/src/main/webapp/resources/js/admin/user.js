$(function() {
	/*------------ 填充dataTables ------------*/
	var url = {
		'url' : contextPath + '/admin/user/list.do',
		'data' : function(d) {
			if ($('#searchValue').val() != '') {
				d.searchCode = $('#searchCode').val();
				d.searchValue = $('#searchValue').val();
			}
			if ($('#gId').val() != '')
				d.gId = $('#gId').val();
			if ($('#rId').val() != '')
				d.rId = $('#rId').val();
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
	}, {
		'data' : 'phone'
	}, {
		'data' : 'createDate',
		"mRender" : function(data) {
			return dateFormat(data);
		}
	} ];

	// 页面数据加载
	var table = initTable(url, gridTable);

	/*------------ 通过id加载用户 ------------*/
	load = function(id) {
		var data = [];
		$.ajax({
			type : "GET",
			url : contextPath + '/admin/user/load/' + id,
			async : false,
			success : function(d) {
				data = d;
			}
		});
		return data;
	}

	// draw event 事件
	$('#example').on('draw.dt', function() {
		/* console.log( 'Redraw occurred at: '+new Date().getTime() ); */
	});

	/*------------ 修改 ------------*/
	edit = function() {
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

		// 将数据填充到模态框 开始
		initData();
		var data = table.rows('.selected').data()[0];
		$.ajax({
			url : contextPath + '/admin/user/load/' + data.id,
			success : function(d) {
				var groupIds = d.groupIds.join();
				var roleIds = d.roleIds.join();

				$('#edit-modal [name=groupIds]').each(function() {
					// alert($(this).val());
					if (groupIds.indexOf($(this).val()) != -1) {
						$(this).prop('checked', true);
					} else {
						$(this).prop('checked', false);
					}
				});
				$('#edit-modal [name=roleIds]').each(function() {
					// alert($(this).val());
					if (roleIds.indexOf($(this).val()) != -1) {
						$(this).prop('checked', true);
					} else {
						$(this).prop('checked', false);
					}
				});
			}
		});
		// 将数据填充到模态框 结束

		var opts = {
			title : '修改用户',
			yes : function(index, layero) {
				// 处理异步验证结果
				var isFormValid = layero.find('#edit-form').validator('isFormValid');
				if (isFormValid) {
					var dataValue = $('#edit-form').serialize();
					console.log(dataValue);
					$.ajax({
						type : 'post',
						url : contextPath + '/admin/user/edit.do',
						dataType : 'json',
						data : dataValue,
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
		var url = contextPath + '/admin/user/delete.do';
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
					var dataValue = $('#add-form').serialize();
					console.log(dataValue);
					$.ajax({
						type : 'post',
						url : contextPath + '/admin/user/add.do',
						dataType : 'json',
						data : dataValue,
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
