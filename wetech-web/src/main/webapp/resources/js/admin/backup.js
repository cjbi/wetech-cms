$(function() {
    var url = contextPath + '/admin/backup/listBackups.do';
    $.ajax({
	type : 'post',
	url : url,
	dataType : 'json',
	success : function(data) {
	    for (var i in data) {
		$('tbody').append('<tr>');
		/*for(var key in data[i]) {
		    $('tr:last').append('<td>'+ data[i][key]+'</td>');
		    console.log(key +":"+ data[i][key]);
		}*/
		 $('tr:last').append('<td>'+ data[i]['name'] +'</td>');
		 $('tr:last').append('<td>'+ data[i]['size']+'K </td>');
		 $('tr:last').append('<td>'+ dateFormat(data[i]['time'])+' </td>');
		 $('tr:last').append('<td>'+ data[i]['filetype'] +' </td>');
		 
		$('tbody').children().append('</tr>');
		$('tr:last').append().append('<td><div class="am-btn-group am-btn-group-xs"><button onclick="resume(this)" value="'+data[i]['name']+'"  class="am-btn am-btn-default am-btn-xs am-text-secondary"><span class="am-icon-undo"></span> 恢复数据库</button><button onclick="del(this)" value="'+data[i]['name']+'" class="am-btn am-btn-default am-btn-xs am-text-danger am-hide-sm-only"><span class="am-icon-trash-o"></span> 删除</button> </div></td>');
	    }

	},
	error : function(data) {
	    layer.msg('操作失败', {
		time : 2000,
		icon : 5
	    });
	}
    });
    
    del = function(obj) {
	console.log($(obj).val());
    };
    
    resume = function(obj) {
	console.log($(obj).val());
    }
    
});
