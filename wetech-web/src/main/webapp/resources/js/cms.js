$(function () {
    $.AMUI.progress.start();
    /*------------ search ------------*/
    var $dropdownSearch = $('#dropdown-search');
    var $dropdownInput = $("#dropdown-search-input");
    var $dropdownUl = $('#dropdown-search-ul');
    var $dropdownForm = $('#search-form');
    $dropdownInput.keyup(function () {
        if ($(this).val().trim() !== '') {
            $dropdownSearch.dropdown('open');
            var url = contextPath + '/search.do';
            var con = $dropdownInput.val().trim();
            $.ajax({
                type: "post",
                url: url,
                data: {
                    con: con
                },
                dataType: "json",
                success: function (data) {
                    $dropdownUl.children().remove();
                    if (data == '') {
                        $dropdownUl.append('<li class="am-disabled"><a href="#">没有找到相关的搜索结果</a></li>');
                        return;
                    }
                    $dropdownUl.append('<li class="am-dropdown-header">主题</li>');
                    for (var i in data) {
                        $dropdownUl.append('<li><a href="' + contextPath + '/topic/' + data[i].id + '">' + data[i].title + '</a></li>');
                    }
                    var url = contextPath + '/search/' + con;
                    $dropdownForm.attr('action', url);
                    $dropdownUl.append(' <li class="am-divider"></li><li><a href="' + url + '" class="am-text-center">查看全部搜索结果</a></li>');
                },
                error: function (data) {
                    console.log(data);
                }
            });
        } else {
            $dropdownSearch.dropdown('close');
        }
    });

    $.AMUI.progress.done();
});
