$(function() {

	/*------------  Amaze UI Upload  ------------*/
	var upload = $('#event').AmazeuiUpload({
		url : contextPath + '/admin/topic/upload',
		downloadUrl : '',
		maxFiles : 10, // 单次上传的数量
		maxFileSize : 30, // 单个文件允许的大小 (M)
		multiThreading : false, // true为同时上传false为队列上传
		useDefTemplate : true, // 是否使用表格模式
		dropType : false, // 是否允许拖拽
		pasteType : false
	// 是否允许粘贴
	});

	var uploadPath = contextPath + "/resources/upload/";

	$("#ok_attach").on("click", ".indexPic", function() {
		// alert($(this).val());
		dwrService.updateIndexPic($(this).val());
	});
	$("#ok_attach").on("click", ".insertAttach", function() {
		var node = "";
		var isImg = $(this).attr("isimg");
		if (isImg == 1) {
			node = "<img height='400' src='" + uploadPath + $(this).attr("name") + "' id='attach_" + $(this).attr("title") + "'/>"
		} else {
			// alert("abc");
			node = "<a href='" + uploadPath + $(this).attr("name") + "' id='attach_" + $(this).attr("title") + "'>" + $(this).attr("oldName") + "</a>"
		}
		// 追加内容
		editor.$txt.append(node);
	});
	$("#ok_attach").on("click", ".isAttach", function() {
		dwrService.updateAttachInfo($(this).val());
	});
	$("#ok_attach").on("click", ".deleteAttach", function() {
		var ad = this;
		var id = $(this).attr("title");
		dwrService.deleteAttach(id, function(data) {
			$(ad).parent("td").parent("tr").remove();
			// alert($("#xhe0_iframe").contents().find("#attach_"+id).html());
			$("#xhe0_iframe").contents().find("#attach_" + id).remove();
		});
	});

	$("#uploadFile").click(function() {
		$("#attach").uploadify("upload", "*");
	});

	/*------------  搜索关键字  ------------*/
	$('#dropdown-search').keywordinput({
		url : contextPath + "/admin/topic/searchKeyword",
	});

	/*------------  初始化wangEditor  ------------*/
	// 获取元素
	var textarea = document.getElementById('content');
	// 生成编辑器
	var editor = new wangEditor(textarea);
	// 表情显示项
	// 阻止输出log
	wangEditor.config.printLog = false;
	editor.config.emotionsShow = 'icon';
	editor.config.emotions = {
		'default' : {
			title : '默认',
			data : contextPath + '/resources/wangEditor/emotions.data'
		}
	};
	editor.create();

	/*------------  获取当前日期  ------------*/
	$('#publishDate').attr('value', dateFormat(new Date()));

	/*------------  提交文章  ------------*/
	$('#submit').click(function() {
		var index = parent.layer.getFrameIndex(window.name); // 获取窗口索引
		if (index != undefined) {
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
						if (dataValue[$(this).attr('name')] != null) {
							dataValue[$(this).attr('name')] += "," + $(this).val()
						} else {
							dataValue[$(this).attr('name')] = $(this).val();
						}
					}
				});
				console.log(dataValue);
				url = contextPath + '/admin/topic/add.do';
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
						// 如果成功了，就刷新父页面的表格
						parent.loadContent(contextPath + '/admin/topic');
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

	// 生成tree
	var t = $("#mytree").mytree({
		mine : {
			listChild : 0
		},
		callback : {
			onAsyncSuccess : function() {
				// 如果成功，就展开所有节点
				t.expandAll(true);
			},
			beforeClick : beforeChoice,
			onClick : choice
		},
		url : contextPath + "/admin/topic/treeAll.do"
	});
	$("#cname").click(showMenu);
});

/*------------ 对树的一系列操作 ------------*/
function choice(event, treeId, treeNode) {
	$("#cname").val(treeNode.name);
	$("#cid").val(treeNode.id);
	hideMenu();
}
function beforeChoice(treeId, treeNode) {
	var check = (treeNode && !treeNode.isParent);
	if (!check)
		return check;
}
function showMenu() {
	$("#mytree").width($(this).width() + 15);
	var cObj = $("#cname");
	var cOffset = $("#cname").offset();
	$("#menuContent").css({
		left : cOffset.left + "px",
		top : cOffset.top + cObj.outerHeight() + "px"
	}).slideDown("fast");

	$("body").bind("mousedown", onBodyDown);
}
function onBodyDown(event) {
	if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
		hideMenu();
	}
}
function hideMenu() {
	$("#menuContent").fadeOut("fast");
	$("body").unbind("mousedown", onBodyDown);
}
