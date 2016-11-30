$(function(){
	var indexPicWidth=0,indexPicHeight=0,imgWidth=0,imgHeight=0;
	var x,y,w,h;
	var newName,oldName;
	var ctx = contextPath;
	$("#indexPic").uploadify({
		swf:ctx+"/resources/uploadify/uploadify.swf",
		uploader:ctx+"/admin/pic/uploadIndexPic",
		fileObjName:"pic",
		multi:false,
		formData:{"sid":$("#sid").val()},
		fileTypeExts:"*.jpg;*.png;",
		onUploadSuccess:function(file, data, response) {
			var ao = $.parseJSON(data);
			if(ao.result) {
				newName = ao.obj.newName;
				oldName = ao.obj.oldName;
				$("#indexPicView").append("<img src='"+ctx+"/resources/indexPic/temp/"+newName+"'/><br/><button type=\"button\" class=\"am-btn am-btn-secondary am-btn-xs am-round\" id=\"confirmSelect\"> <span class=\"am-icon-cloud-upload\"></span>&nbsp;确定选择</button>");
				indexPicWidth = ao.obj.indexPicWidth;
				indexPicHeight = ao.obj.indexPicHeight;
				imgWidth = ao.obj.imgWidth;
				imgHeight = ao.obj.imgHeight;
				$("#indexPicView").before("<div id='pc' style='width:"+indexPicWidth+"px;height:"+indexPicHeight+"px;overflow:hidden;margin-bottom:5px;'><img id='preview' src='"+ctx+"/resources/indexPic/temp/"+newName+"'/></div>");
				$("#indexPicView img").Jcrop({
					aspectRatio:indexPicWidth/indexPicHeight,
					onChange: showPreview,
					onSelect: showPreview,
					setSelect: [0,0,indexPicWidth,indexPicHeight]
				});
				$("#confirmSelect").click(confirmSelect);
			} else {
				alert(ao.msg);
			}
		}
	});
	function showPreview(coords)
	{
		if (parseInt(coords.w) > 0)
		{
			var rx = indexPicWidth / coords.w;
			var ry = indexPicHeight / coords.h;
			x = coords.x;
			y = coords.y;
			h = coords.h;
			w = coords.w;
			jQuery('#preview').css({
				width: Math.round(rx * imgWidth) + 'px',
				height: Math.round(ry * imgHeight) + 'px',
				marginLeft: '-' + Math.round(rx * coords.x) + 'px',
				marginTop: '-' + Math.round(ry * coords.y) + 'px'
			});
		}
	}
	$("#uploadFile").click(function() {
		$("#indexPic").uploadify("upload","*");
	});
	function confirmSelect() {
		var path = ctx+"/admin/pic/confirmPic";
		$.post(path,{w:w,h:h,x:x,y:y,newName:newName},function(data) {
			if($.ajaxCheck(data)) {
				$("#indexPicView").prev("#pc").remove();
				$("#indexPicView").html("<img src='"+ctx+"/resources/indexPic/"+newName+"'/>");
				$("#newName").val(newName);
			}
		},"json")
	}
});

	/*------------  提交文章  ------------*/
$('#submit').click(function() {
    var index = parent.layer.getFrameIndex(window.name); // 获取窗口索引
    if(index != undefined) {
	var isFormValid = $('form').validator('isFormValid');
	// 如果前台校验通过
	if (isFormValid) {
	    var dataValue = {};
        	$('form').find('[name]').each(function() {
        	    // 如果是单选框
        	    if ($(this).attr('type') == 'radio') {
        		// 如果已经选中
        		if ($(this).is(':checked')) {
        		    dataValue[$(this).attr('name')] = $(this).val();
        		}
        	    } else {
        		// 如果datavalue[key]
			// 不等于null，说明已经赋过值，就split通过"，"分割。
        		if(dataValue[$(this).attr('name')]!= null) {
        		    dataValue[$(this).attr('name')] += ","+$(this).val()
        		} else {
        		    dataValue[$(this).attr('name')] = $(this).val();
        		}
        	    }
        	});
        	console.log(dataValue);
        	url = contextPath + '/admin/pic/indexPic/add.do';
        	$.ajax({
        	    type : "post",
        	    url : url,
        	    dataType : "json",
        	    data : dataValue,
        	    success : function(data) {
        		parent.layer.msg(data.message, {
        		    time : '2000',
        		    icon : 6
        		});
        		// TODO 如果成功了，就刷新父页面的表格
                	parent.layer.close(index);
        	    },
        	    error : function(data) {
        		parent.layer.msg('操作失败', {
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
});

