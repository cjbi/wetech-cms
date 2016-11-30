$(function() {
    /*------------ search ------------*/
    $("#dropdown-search-input").keyup(function() {
	if ($('#dropdown-search-input').val().trim() !== '') {
	    $('#dropdown-search').dropdown('open');
	    var url = contextPath + '/search/' + $('#dropdown-search-input').val().trim();
	    $.ajax({
		type : "get",
		url : url,
		dataType : "json",
		success : function(data) {
		    $('#dropdown-search-ul').children().remove();
		    if(data=='') {
			 $('#dropdown-search-ul').append('<li class="am-disabled"><a href="#">没有找到相关的搜索结果</a></li>');
			return;
		    }
		    $('#dropdown-search-ul').append('<li class="am-dropdown-header">内容</li>');
		    for ( var i in data) {
			$('#dropdown-search-ul').append('<li><a href="'+contextPath+'/topic/' + data[i].id + '">' + data[i].title + '</a></li>');
		    }
		    $('#dropdown-search-ul').append(' <li class="am-divider"></li><li><a href="#" class="am-text-center">查看全部搜索结果</a></li>');
		},
		error : function(data) {
		    console.log(data);
		}
	    });
	} else {
	    $('#dropdown-search').dropdown('close');
	}
    });
});