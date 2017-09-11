$(function () {
    $('#reloadIndex').on('click', function () {
        layer.confirm('确定要重新静态化首页吗？', {
            icon: 3,
            title: '系统提示',
            yes: function (index, layero) {
                var url = contextPath + "/admin/system/index/reload.do";
                $.ajax({
                    url: url,
                    success: function (data) {
                        layer.msg(data.message, {
                            time: '2000',
                            icon: 6
                        });
                        layer.close(index);
                    },
                    error: function (data) {
                        layer.msg('操作失败', {
                            time: 2000,
                            icon: 5
                        });
                    }
                });
            }
        });
    });

    $('#setBaseInfo').click(function () {
        var opts = {
            title: '编辑基本信息',
            yes: function (index, layero) {
                // 处理异步验证结果
                var isFormValid = layero.find('#edit-form').validator('isFormValid');
                if (isFormValid) {
                    var url = contextPath + '/admin/system/baseInfo/edit.do'
                    $.ajax({
                        type: 'post',
                        url: url,
                        data: layero.find('#edit-form').serializeArray(),
                        dataType: 'json',
                        success: function (data) {
                            layer.msg(data.message, {
                                time: '2000',
                                icon: 6
                            });
                            layer.close(index);
                            loadContent('#system/baseInfo', function () {
                                // callback重新注册组件
                                $('[data-am-selected]').selected();
                            });
                        },
                        error: function (data) {
                            layer.msg('操作失败', {
                                time: 2000,
                                icon: 5
                            });
                        }
                    });
                } else {
                    layer.msg('数据验证失败', {
                        time: 2000,
                        icon: 5
                    });
                }
            },
            end: function (index, layero) {
            }
        };
        $('#edit-modal').layerOpen(opts);

    });
});