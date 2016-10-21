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
<script type="text/javascript">
$(function(){
	$("#updateForm").cmsvalidate();
});
</script>
</head>
<body>
<div id="content">
	<h3 class="admin_link_bar">
		<jsp:include page="incBaseInfo.jsp"></jsp:include>
	</h3>
	<sf:form method="post" modelAttribute="baseInfo" id="updateForm">
	<table width="800" cellspacing="0" cellPadding="0">
		<thead><tr><td colspan="2">修改网站信息功能</td></tr></thead>
		<tr>
			<td class="rightTd" width="200px">网站名称:</td>
			<td class="leftTd"><sf:input path="name" size="30"/></td>
		</tr>
		<tr>
			<td class="rightTd">网站所在地址:</td>
			<td class="leftTd"><sf:input path="address" size="30"/></td>
		</tr>
		<tr>
			<td class="rightTd">邮政编码:</td>
			<td class="leftTd"><sf:input path="zipCode" size="30"/></td>
		</tr>
		<tr>
			<td class="rightTd">联系电话:</td>
			<td class="leftTd"><sf:input path="phone" size="30"/></td>
		</tr>
		<tr>
			<td class="rightTd">网站联系邮箱:</td>
			<td class="leftTd"><sf:input path="email" size="30"/></td>
		</tr>
		<tr>
			<td class="rightTd">网站访问域名:</td>
			<td class="leftTd"><sf:input path="domainName" size="30"/></td>
		</tr>
		<tr>
			<td class="rightTd">网站备案号:</td>
			<td class="leftTd"><sf:input path="recordCode" size="30"/></td>
		</tr>
		<tr>
			<td class="rightTd">首页图片宽度:</td>
			<td class="leftTd"><sf:input path="indexPicWidth" size="30"/></td>
		</tr>
		<tr>
			<td class="rightTd">首页图片高度:</td>
			<td class="leftTd"><sf:input path="indexPicHeight" size="30"/></td>
		</tr>
		<tr>
			<td colspan="2" class="centerTd"><input type="submit" value="修改网站基本信息"/><input type="reset"/></td>
		</tr>
	</table>
	</sf:form>
</div>
</body>
</html>