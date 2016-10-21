$(function(){
	var _cs = new Array();
	var t = $("#tree").mytree({
		url:$("#treePath").val(),
		mine:{listChild:0},
		callback:{
			onAsyncSuccess:initTree,
			beforeCheck:function(treeId,treeNode) {
				if(!treeNode.checked) {
					//ps中的节点应该进行添加操作
					var ps = t.getCheckParentNodes(treeNode,false);
					ps.push(treeNode);
					addGroupChannel(ps);
				} else {
					var cs = new Array();
					t.getCheckChildNodes(treeNode,true,cs);
					cs.push(treeNode);
					//cs就是要删除的元素
					deleteGroupChannel(cs);
				}
			},
			onCheck:function(event,treeId,treeNode) {
				if(!treeNode.checked) {
					var ps = t.getCheckParentNodes(treeNode,false);
					//ps就表示要删除的元素
					deleteGroupChannel(ps);
				}
			}
		
		},
		check:{
			enable:true,
			chkboxType: { "Y": "p", "N": "ps" }
		}
	});
	
	function handler(msg,exc) {
		alert(msg);
	}
	
	dwr.engine.setErrorHandler(handler);
	
	function addGroupChannel(cs) {
		var gid = $("#gid").val();
		for(var i=0;i<cs.length;i++) {
			var c = cs[i];
			if(c.id>0) {
				dwrService.addGroupChannel(gid,c.id);
			}
		}
		
	}
	
	function deleteGroupChannel(cs) {
		var gid = $("#gid").val();
		for(var i=0;i<cs.length;i++) {
			var c = cs[i];
			if(c.id>0) {
				dwrService.deleteGroupChannel(gid,c.id);
			}
		}
		
	}

	function initTree() {
		t.expandAll(true);
		//var n = t.getNodeByTId("tree_10");
		var cids = $("input[name='cids']");
		for(var i=0;i<cids.length;i++) {
			var cid = cids[i].value;
			var n = t.getNodeByParam("id",cid,null);
			t.checkNode(n,true,true);
		}
	}
});