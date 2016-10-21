<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	$("#addForm").cmsvalidate();
});
</script>
</head>
<body>
<div id="content">
	<h3 class="admin_link_bar">
		<jsp:include page="inc.jsp"></jsp:include>
	</h3>
	<form method="post" id="addForm">
	<table width="800" cellspacing="0" cellPadding="0">
	<input type="hidden" name="id" value="${user.id }"/>
		<thead><tr><td colspan="2">修改用户-->${user.username}</td></tr></thead>
		<tr>
			<td class="rightTd">原始密码:</td><td class="leftTd"><input type="password" name="oldPwd" size="30"/></td>
		</tr>
		<tr>
			<td class="rightTd">新密码:</td><td><input type="password" name="password" size="30" id="password"/></td>
		</tr>
		<tr>
			<td class="rightTd">确认密码:</td><td><input type="password" name="confirmPwd" size="30"/></td>
		</tr>
		<tr>
			<td colspan="2" class="centerTd"><input type="submit" value="修改密码"/><input type="reset"/></td>
		</tr>
	</table>
	</form>
</div>
</body>
</html>