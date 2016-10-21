<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/validate/main.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/core/jquery.cms.validate.js"></script>
<script type="text/javascript">
$(function(){
	$("#beginBackup").click(function(){
		var v = $("#backupFilename").val();
		if(v=="") {
			var c = confirm("备份文件名没有输入，默认会使用“未命名”作为文件名，确定吗？");
			if(!c) return; 
			else {
				$("#backupFilename").val("未命名");	
			}
		}
		$("#backupCon").html("正在备份中,请稍等...");
		$("#addForm").submit();
	});
});
</script>
</head>
<body>
<div id="content">
	<h3 class="admin_link_bar">
		<jsp:include page="inc.jsp"></jsp:include>
	</h3>
	<sf:form method="post" modelAttribute="userDto" id="addForm">
	<table width="800" cellspacing="0" cellPadding="0">
		<thead><tr><td colspan="2">备份数据功能</td></tr></thead>
		<tr>
			<td class="rightTd" width="200px">输入备份的文件名:</td>
			<td class="leftTd"><input type="text" name="backupFilename" id="backupFilename"/></td>
		</tr>
		<tr>
			<td colspan="2" class="centerTd"><span id="backupCon"><input type="button" value="进行备份" id="beginBackup"/><input type="reset"/></span></td>
		</tr>
	</table>
	</sf:form>
</div>
</body>
</html>