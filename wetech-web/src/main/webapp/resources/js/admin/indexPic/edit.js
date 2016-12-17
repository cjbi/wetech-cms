
/*------------ 初始化图片裁剪 ------------*/
$(function() {
	var $clip = $("#clip");
	var $file = $("#file");
	$("#toggle-file").click(function() {
		$file.trigger("click");
	});

	$clip.photoClip({
		width : 900,
		height : 350,
		fileMinSize : 20,
		file : $file,
		defaultImg : "",
		ok : "#clipBtn",
		loadStart : function() {
			console.log("照片读取中");
		},
		loadProgress : function(progress) {
			console.log(progress);
		},
		loadError : function() {
			console.log("图片加载失败");
		},
		loadComplete : function() {
			console.log("照片读取完成");
		},
		imgSizeMin : function(kbs) {
			console.log(kbs, "上传图片过小");
		},
		clipFinish : function(dataURL) {
			document.getElementById("img-view").src = dataURL;
		}
	});
})

/*------------  提交  ------------*/
$('#submit').click(function() {
	var index = parent.layer.getFrameIndex(window.name); // 获取窗口索引
	if (index != undefined) {
		var isFormValid = $('form').validator('isFormValid');
		// 如果前台校验通过
		if (isFormValid) {
			var dataUrl = $('#img-view').attr('src');
			// 如果img src == ""，就结束
			if (dataUrl == "") {
				parent.layer.msg('请先上传图片', {
					time : 2000,
					icon : 5
				});
				return;
			}
			if(dataUrl.indexOf('.jpg')>-1){
				var dataValue = $('#edit-form').serialize();
				var url = '/admin/pic/indexPic/edit.do';
				$.ajax({
					type : "post",
					url : url,
					dataType : "json",
					data : dataValue,
					success : function(data) {
						layer.msg(data.message, {
							time : '2000',
							icon : 6
						});
						//如果成功了，就刷新父页面的表格
						parent.loadContent(contextPath+'/admin/pic/indexPic');
						parent.layer.close(index);
					},
					error : function(data) {
						layer.msg('操作失败', {
							time : 2000,
							icon : 5
						});
					}
				});
				return;
			}
			var blob = dataURLtoBlob(dataUrl);
			// 使用ajax发送
			var formData = new FormData($('#edit-form')[0]);
			formData.append("image", blob, "image.jpg");
			url = contextPath + '/admin/pic/indexPic/edit.do';
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
					//如果成功了，就刷新父页面的表格
					parent.loadContent(contextPath+'/admin/pic/indexPic');
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

function dataURLtoBlob(dataurl) {
	var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1], bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
	while (n--) {
		u8arr[n] = bstr.charCodeAt(n);
	}
	return new Blob([ u8arr ], {
		type : mime
	});
}
