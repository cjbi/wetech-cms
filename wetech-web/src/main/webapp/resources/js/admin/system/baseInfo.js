$(function() {
	$('#setBaseInfo').click(function() {
		var opts = {
			title : '编辑基本信息',
			yes : function(index, layero) {
				// 处理异步验证结果
				var isFormValid = layero.find('#edit-form').validator('isFormValid');
				if (isFormValid) {
					$('#edit-modal').submit(contextPath + '/admin/system/baseInfo/edit.do');
					layer.close(index);
					$('#admin-content').load(contextPath + "/admin/system/baseInfo");
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