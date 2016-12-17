$(function() {
	var url = contextPath + '/admin/backup/listBackups.do';
	$
			.ajax({
				type : 'post',
				url : url,
				dataType : 'json',
				success : function(data) {
					for ( var i in data) {
						$('tbody').append('<tr>');
						/*
						 * for(var key in data[i]) { $('tr:last').append('<td>'+
						 * data[i][key]+'</td>'); console.log(key +":"+
						 * data[i][key]); }
						 */
						$('tr:last').append('<td>' + data[i]['name'] + '</td>');
						$('tr:last').append(
								'<td>' + data[i]['size'] + 'K </td>');
						$('tr:last')
								.append(
										'<td>' + dateFormat(data[i]['time'])
												+ ' </td>');
						$('tr:last').append(
								'<td>' + data[i]['filetype'] + ' </td>');

						$('tbody').children().append('</tr>');
						$('tr:last')
								.append()
								.append(
										'<td><div class="am-btn-group am-btn-group-xs"><button onclick="resume(this)" value="'
												+ data[i]['name']
												+ '"  class="am-btn am-btn-default am-btn-xs am-text-secondary"><span class="am-icon-undo"></span> 恢复数据库</button><button onclick="del(this)" value="'
												+ data[i]['name']
												+ '" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button> </div></td>');
					}

				},
				error : function(data) {
					layer.msg('操作失败', {
						time : 2000,
						icon : 5
					});
				}
			});

	add = function() {
		var opts = {
			title : '添加备份数据',
			yes : function(index, layero) {
				// 处理异步验证结果
				var isFormValid = layero.find('#add-form').validator(
						'isFormValid');
				if (isFormValid) {
					var url = contextPath + '/admin/backup/add.do';
					var name = $('#add-form input[name="name"]').val();
					$.ajax({
						type : "post",
						url : url,
						dataType : "json",
						data : {
							name : name
						},
						success : function(data) {
							layer.msg(data.message, {
								time : '2000',
								icon : 6
							});
							loadContent(
									contextPath + "/admin/backup");
						},
						error : function(data) {
							layer.msg('操作失败', {
								time : 2000,
								icon : 5
							});
						}
					});
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

	del = function(obj) {
		var name = $(obj).val();
		layer.confirm('确定要删除' + name + '吗？', {
			icon : 3,
			title : '系统提示',
			yes : function(index, layero) {
				var url = contextPath + "/admin/backup/delete.do";
				$
						.ajax({
							type : 'post',
							url : url,
							dataType : 'json',
							data : {
								name : name
							},
							success : function(data) {
								layer.msg(data.message, {
									time : '2000',
									icon : 6
								});
								layer.close(index);
								loadContent(
										contextPath + "/admin/backup");
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
	};

	resume = function(obj) {
		var name = $(obj).val();
		layer.confirm('确定要恢复' + name + '吗？', {
			icon : 3,
			title : '系统提示',
			yes : function(index, layero) {
				var url = contextPath + "/admin/backup/resume.do";
				$
						.ajax({
							type : 'post',
							url : url,
							dataType : 'json',
							data : {
								name : name
							},
							success : function(data) {
								layer.msg(data.message, {
									time : '2000',
									icon : 6
								});
								layer.close(index);
								loadContent(
										contextPath + "/admin/backup");
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

});
