<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/zTree/zTreeStyle.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/tree/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript">
var datas = [{id:"0",name:"根目录",pid:"-1",test:"abc"},
             {id:"1",name:"用户管理",pid:"0",test:"a1"},
             {id:"2",name:"用户管理1",pid:"1",test:"a11"},
             {id:"3",name:"用户管理2",pid:"1",test:"a12"},
             {id:"4",name:"系统管理",pid:"0",test:"b1"},
             {id:"5",name:"系统管理1",pid:"4",test:"b11"},
             {id:"6",name:"系统管理2",pid:"4",test:"b12"}];
$(function(){
	var setting = {
		data:{
			simpleData:{
				enable: true,
				idKey: "id",
				pIdKey: "pid",
				rootPId: -1,
			}
		},
		view: {
			dblClickExpand: false,
			selectedMulti: false
		},
		callback:{
			onClick:function(event,treeId,treeNode) {
				//alert(treeNode.name+","+treeNode.isParent+","+treeNode.test);
			}
		}
	};
	var n = {id:"7",name:"系统管理2",pid:"4"};
	var t = $.fn.zTree.init($("#tree"), setting, datas);
	t.addNodes(t.getNodeByParam("id",4,null),n);
});
</script>
</head>
<body>
<div id="content">
<div id="tree" class="ztree"></div>
</div>
</body>
</html>