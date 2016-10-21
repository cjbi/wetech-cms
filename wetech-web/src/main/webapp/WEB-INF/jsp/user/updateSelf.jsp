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
	$("#addForm").cmsvalidate();
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
	<sf:hidden path="id"/><sf:hidden path="username"/>
	<sf:hidden path="password"/>
		<thead><tr><td colspan="2">修改用户-->${userDto.username}</td></tr></thead>
		<tr>
			<td class="rightTd">显示名称(可以是中文):</td><td class="leftTd"><sf:input path="nickname" size="30"/></td>
		</tr>
		<tr>
			<td class="rightTd">联系电话:</td><td><sf:input path="phone" size="30"/></td>
		</tr>
		<tr>
			<td class="rightTd">电子邮件:</td><td><sf:input path="email" size="30"/><sf:errors path="email"/></td>
		</tr>
		<tr>
			<td colspan="2" class="centerTd"><input type="submit" value="修改个人信息"/><input type="reset"/></td>
		</tr>
	</table>
	</sf:form>
</div>
</body>
</html>