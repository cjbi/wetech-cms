$(function() {
	// 填充dataTables
	var url = contextPath + '/admin/role/list.do';
	var gridTable = [
			{
				'data' : 'id',
				"sWidth" : "2%",
				'bSortable' : true,
				'fnCreatedCell' : function(nTd, sData, oData, iRow, iCol) {
					$(nTd).html('<input type="checkbox" name="checkList" title="' + sData + '" value="' + sData + '">');
				}
			},
			{
				'data' : 'id',
				'sWidth' : '5%'
			},
			{
				'data' : 'name',
				'sWidth' : '20%'
			},
			{
				'data' : 'roleType'
			},{
            'data' : 'userCount',
            'sWidth' : "5%",
            "sClass" : "dt-column-center",
            'mRender' : function(data,type,full) {
                return '<span style="color: green;">'+data +'人</span>';
            }
       		 },
			{
				'data' : 'id',
				'mRender' : function(data, type, full) {
					return '<div class="am-btn-group am-btn-group-xs"><button class="am-btn am-btn-default am-btn-xs am-text-secondary" name="qryUser" value="'
							+ data
							+ '"><span class="am-icon-search"></span> 查询用户</button><button class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only" name="clearUser" value="'
							+ data + '"><span class="am-icon-trash-o"></span> 清空用户</button> </div>';
				}
			} ];
	// 页面数据加载
	var table = initTable(url, gridTable);

	// 修改
    edit = function() {
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
					$('#edit-modal').submit(contextPath + '/admin/role/edit.do');
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

    /**
	 * 删除
     */
	 del = function() {
		var url = contextPath + '/admin/role/delete.do';
		deleteBatch(url, 'id');
	}

    /**
	 * 新增
     */
	add = function() {
		var opts = {
			title : '添加用户',
			yes : function(index, layero) {
				// 处理异步验证结果
				var isFormValid = layero.find('#add-form').validator('isFormValid');
				if (isFormValid) {
					$('#add-modal').submit(contextPath + '/admin/role/add.do');
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
	};

    /**
     * 重置
     */
    reset = function () {
        loadContent('#role', function () {
            reloadComponent();
        })
    }
	
	// 查询用户
	$("#example").on("click", '.am-btn[name=qryUser]', function(event) {
		var rId = $(this).val();
		loadContent('#user',function() {
            $('[data-am-selected][name="rId"]').find('option[value="' + rId + '"]').attr('selected', true);
            // callback重新注册组件
            $('[data-am-selected]').selected();
		});
	});

	// 清空用户
	$("#example").on("click", '.am-btn[name=clearUser]', function(event) {
		var rId = $(this).val();
		layer.confirm('确定要清空角色 ['+rId+'] 下所有用户吗？', {
			icon : 3,
			title : '系统提示',
			yes : function(index, layero) {
				var url = contextPath + "/admin/role/clearUsers.do";
				$.ajax({
					type : 'post',
					url : url,
					dataType : 'json',
					data : {
						id : rId
					},
					success : function(data) {
						layer.msg(data.message, {
							time : '2000',
							icon : 6
						});
						layer.close(index);
						loadContent("#role",function() {
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

});
