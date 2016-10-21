(function($){
	$.ajaxCheck = function(data) {
		if(data.result) return true;
		else {
			alert(data.msg);
			return false;
		}
	}
	$.fn.mysorttable = function(opts) {
		var _isSort = false;
		var sortEle = $(this).find("tbody");
		var _that = this;
		var setting = $.extend({
			begin:"beginOrder",
			save:"saveOrder"
		},opts||{});
		sortEle.sortable({
			axis:"y",
			helper:function(e,ele) {
				//原始元素的td对象
				var _original = ele.children();
				var _helper = ele.clone();
				_helper.children().each(function(index){
					$(this).width(_original.eq(index).width());
				});
				_helper.css("background","#aaf");
				return _helper;
			},
			update:function(e,ui) {
				setOrders();
			}
		});
		
		sortEle.sortable("disable");
		
		$("#"+setting.begin).click(beginOrders);
		
		$("#"+setting.save).click(saveOrders);
		
		function beginOrders() {
			if(!_isSort) {
				$(_that).find("thead tr").append("<td>序号</td>");
				setOrders();
				$(_that).find("tfoot tr").append("<td>拖动排序</td>");
				sortEle.sortable("enable");
				_isSort = true;
			} else {
				alert("已经处于排序状态");
			}
		}
		
		function saveOrders() {
			if(_isSort) {
				var idArg = sortEle.sortable("serialize",{key:"ids"});
				$.post("updateSort?"+idArg,function(data){
					if($.ajaxCheck(data)) {
						$(_that).find("tr").each(function(){
							$(this).children().last().remove();
						});
						sortEle.sortable("disable");
						_isSort = false;
					}
				});
			} else {
				alert("还不是排序状态");
			}
		}
		
		function setOrders() {
			$(_that).find("tbody tr").each(function(index){
				if(_isSort) {
					$(this).find("td:last").html((index+1));
				} else
					$(this).append("<td>"+(index+1)+"</td>");
			});
		}
		return sortEle;
	}
	$.fn.mytree = function(opts) {
		var setting = $.extend({
			data:{
				simpleData:{
					enable: true,
					idKey: "id",
					pIdKey: "pid",
					rootPId: -1
				}
			},
			view: {
				dblClickExpand: false,
				selectedMulti: false
			},
			async: {
				enable: true,
				url: opts?(opts.url||"treeAll"):"treeAll"
				
			},
			mine: {
				listChild:1,
				srcElement:"#cc"
			},
			callback:{
				onAsyncSuccess:function(){
					if(opts.mine.expandAll)
						t.expandAll(true);
				}
			}
		},opts||{});
		var _mine = setting.mine;
		var t = $.fn.zTree.init($(this), setting);
		t.getCheckParentNodes = getCheckParentNodes;
		t.getCheckChildNodes = getCheckChildNodes;
		if(_mine.listChild) {
			t.setting.callback.onClick = listChild;
		}
		
		function listChild(event,treeId,treeNode) {
			$(_mine.srcElement).attr("src","channels/"+treeNode.id);
		}
		
		function getCheckParentNodes(treeNode,checked) {
			var ps = new Array();
			var pn;
			while((pn=treeNode.getParentNode())) {
				if(pn.checked==checked) ps.push(pn);
				treeNode = pn;
			}
			return ps;
		}
		//第三个参数存储所有子节点
		function getCheckChildNodes(treeNode,checked,cs) {
			var ccs;
			if((ccs=treeNode.children)) {
				for(var i=0;i<ccs.length;i++) {
					var c = ccs[i];
					if(c.checked==checked) {
						cs.push(c);
					}
					getCheckChildNodes(c,checked,cs);
				}
			}
		}
		return t;
	}
	
	$.fn.myaccordion = function(opts) {
		var settings = $.extend({
			selectedClz:"navSelected",
			titleTagName:"h3"
		},opts||{});
		var titleNode = $(this).find("ul>"+settings.titleTagName);
		var selectedNode = $(this).find("ul."+settings.selectedClz+">"+settings.titleTagName);
		titleNode.css("cursor","pointer");
		titleNode.nextAll().css("display","none");
		selectedNode.nextAll().css("display","block");
		titleNode.click(function(){
			var checked = $(this).parent().hasClass(settings.selectedClz);
			if(checked) {
				$(this).parent().removeClass(settings.selectedClz);
				$(this).nextAll().slideUp();
			} else {
				$(this).parent().addClass(settings.selectedClz);
				$(this).nextAll().slideDown();
			}
		});
	};
	
	$.fn.trColorChange = function(opts) {
		var settings = $.extend({
			overClz:"trMouseover",
			evenClz:"trEvenColor"
		},opts||{});
		$(this).find("tbody tr:even").addClass(settings.evenClz);
		$(this).find("tbody tr").on("mouseenter mouseleave",function(){
			$(this).toggleClass(settings.overClz);
		});
	};
	
	$.fn.confirmOperator = function(opts) {
		var settings = $.extend({
			msg:"该操作不可逆，确定进行该操作吗？",
			eventName:"click"
		},opts||{});
		$(this).on(settings.eventName,function(event){
			if(!confirm(settings.msg)) {
				event.preventDefault();
			}
		});
	}
})(jQuery)