$(function(){
	$("#addForm").cmsvalidate();
	var indexPicWidth=0,indexPicHeight=0,imgWidth=0,imgHeight=0;
	var x,y,w,h;
	var newName,oldName;
	var ctx = $("#ctx").val();
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
				$("#indexPicView").append("<img src='"+ctx+"/resources/indexPic/temp/"+newName+"'/><br/><input type='button' value='确定选择' id='confirmSelect'/>");
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
		//var tn = newName.replace("\.","#");
		//alert(tn);
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