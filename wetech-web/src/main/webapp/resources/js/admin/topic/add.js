$(function() {
    
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
        
        
        //获取当前日期
        $('#publishDate').val(dateFormat(new Date()));        
        
        // 生成tree
        var t = $("#mytree").mytree({mine:{listChild:0},
	callback:{
	onAsyncSuccess:function(){
	    // 如果成功，就展开所有节点
	    	t.expandAll(true);
	},
		beforeClick:beforeChoice,
		onClick:choice
	},
	url:contextPath + "/admin/topic/treeAll.do"
    });
    $("#cname").click(showMenu);
    
    var editor = $('#content').xheditor({
	tools : 'full',
	width : '100%',
	height: '600',
	skin :'nostyle'
    });

    $("#keyword").keywordinput({
	autocomplete : {
	    enable : true,
	    url : contextPath + "/admin/topic/searchKeyword",
	    minLength : 2
	}
    });

	$("#attach").uploadify({
		swf: contextPath + "/resources/uploadify/uploadify.swf",
		uploader: contextPath + "/admin/topic/upload",
		fileObjName:"attach",
		auto:false,
		formData:{"sid":$("#sid").val()},
		fileTypeExts:"*.jpg;*.gif;*.png;*.doc;*.docx;*.txt;*.xls;*.xlsx;*.rar;*.zip;*.pdf;*.flv;*.swf",
		onUploadSuccess:function(file, data, response) {
			var ao = $.parseJSON(data);
			var suc = $.ajaxCheck(ao);
			if(suc) {
				var node = createAttachNode(ao.obj);
				$("#ok_attach").find("tbody").append(node);
			}
		}
	});

	var uploadPath = contextPath + "/resources/upload/";
	function createAttachNode(attach) {
		var node = "<tr>";
		if(attach.isImg) {
			node+="<td><img src='"+uploadPath+"thumbnail/"+attach.newName+"'/></td>";
		} else {
			node+="<td>普通类型附件</td>";
		}
		node+="<td>"+attach.oldName+"</td>";
		node+="<td>"+Math.round(attach.size/1024)+"K</td>";
		if(attach.isImg) {
			node+="<td><input type='checkbox' value='"+attach.id+"' name='indexPic' class='indexPic'></td>";
			node+="<td><input type='radio' value='"+attach.id+"' name='channelPicId'></td>";
		} else {
			node+="<td>&nbsp;</td><td>&nbsp;</td>";
		}
		node+="<td><input type='checkbox' value='"+attach.id+"' name='isAttach' class='isAttach'><input type='hidden' name='aids' value='"+attach.id+"'/></td>";
		node+="<td><a href='#' class='list_op insertAttach' title='"+attach.id+"' isImg='"+attach.isImg+"' name='"+attach.newName+"' oldName='"+attach.oldName+"'>插入附件</a>&nbsp;<a href='#' title='"+attach.id+"' class='list_op deleteAttach delete'>删除附件</a></td>";
		node+="</tr>";
		return node;
	}
	$("#ok_attach").on("click",".indexPic",function(){
		// alert($(this).val());
		dwrService.updateIndexPic($(this).val());
	});
	$("#ok_attach").on("click",".insertAttach",function(){
		var node = "";
		var isImg = $(this).attr("isimg");
		if(isImg==1) {
			node = "<img height='400' src='"+uploadPath+$(this).attr("name")+"' id='attach_"+$(this).attr("title")+"'/>"
		} else {
			// alert("abc");
			node = "<a href='"+uploadPath+$(this).attr("name")+"' id='attach_"+$(this).attr("title")+"'>"+$(this).attr("oldName")+"</a>"
		}
		editor.pasteHTML(node);
	});
	$("#ok_attach").on("click",".isAttach",function(){
		dwrService.updateAttachInfo($(this).val());
	});
	$("#ok_attach").on("click",".deleteAttach",function(){
		var conf = confirm("确定删除附件信息吗？");
		if(conf) {
			var ad = this;
			var id = $(this).attr("title");
			dwrService.deleteAttach(id,function(data) {
				$(ad).parent("td").parent("tr").remove();
				// alert($("#xhe0_iframe").contents().find("#attach_"+id).html());
				$("#xhe0_iframe").contents().find("#attach_"+id).remove();
			});
		}
	});

	$("#uploadFile").click(function() {
		$("#attach").uploadify("upload","*");
	});
});

/*------------ 对树的一系列操作 ------------*/
function choice(event,treeId,treeNode) {
	$("#cname").val(treeNode.name);
	$("#cid").val(treeNode.id);
	hideMenu();
}
function beforeChoice(treeId,treeNode) {
	var check = (treeNode && !treeNode.isParent);
	if (!check) return check;
}
function showMenu() {
	$("#mytree").width($(this).width()+15);
	var cObj = $("#cname");
	var cOffset = $("#cname").offset();
	$("#menuContent").css({left:cOffset.left + "px", top:cOffset.top + cObj.outerHeight() + "px"}).slideDown("fast");

	$("body").bind("mousedown", onBodyDown);
}
function onBodyDown(event) {
	if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
		hideMenu();
	}
}
function hideMenu() {
	$("#menuContent").fadeOut("fast");
	$("body").unbind("mousedown", onBodyDown);
}



