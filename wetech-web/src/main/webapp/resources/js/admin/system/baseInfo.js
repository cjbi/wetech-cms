$(function() {
	$('#setBaseInfo').click(function() {
		var opts = {
			title : '编辑基本信息',
			yes : function(index, layero) {
				// 处理异步验证结果
				var isFormValid = layero.find('#edit-form').validator('isFormValid');
				if (isFormValid) {
					var url = contextPath + '/admin/system/baseInfo/edit.do'
					$.ajax({
						url : url,
						type : 'POST',
						data : formData,
						async : false,
						cache : false,
						contentType : false,
						processData : false,
						success : function(data) {
							parent.layer.msg(data.message, {
								time : '2000',
								icon : 6
							});
							// 如果成功了，就刷新表格
							loadContent(contextPath + '/admin/system/baseInfo');
							layer.close(index);
						},
						error : function(data) {
							parent.layer.msg('操作失败', {
								time : 2000,
								icon : 5
							});
						}
					});
					layer.close(index);
					loadContent(contextPath + "/admin/system/baseInfo");
				} else {
					layer.msg('数据验证失败', {
						time : 2000,
						icon : 5
					});
				}
			},
			end : function(index, layero) {
			}
		};
		$('#edit-modal').layerOpen(opts);

	});
});