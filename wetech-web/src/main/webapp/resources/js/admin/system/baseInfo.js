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
					    type : 'post',
					    url : url,
					    dataType : 'json',
					    success : function(data) {
						layer.msg(data.message, {
						    time : '2000',
						    icon : 6
						});
						layer.close(index);
						loadContent(contextPath + '/admin/system/baseInfo');
					    },
					    error : function(data) {
						layer.msg('操作失败', {
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