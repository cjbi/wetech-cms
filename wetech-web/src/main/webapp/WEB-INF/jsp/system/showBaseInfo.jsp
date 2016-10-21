<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/validate/main.css"/>
</head>
<body>
<div id="content">
	<h3 class="admin_link_bar">
		<jsp:include page="incBaseInfo.jsp"></jsp:include>
	</h3>
	<table width="800" cellspacing="0" cellPadding="0">
		<thead><tr><td colspan="2">修改网站信息功能</td></tr></thead>
		<tr>
			<td class="rightTd" width="200px">网站名称:</td>
			<td class="leftTd">${baseInfo.name }</td>
		</tr>
		<tr>
			<td class="rightTd">网站所在地址:</td>
			<td class="leftTd">${baseInfo.address }</td>
		</tr>
		<tr>
			<td class="rightTd">邮政编码:</td>
			<td class="leftTd">${baseInfo.zipCode }</td>
		</tr>
		<tr>
			<td class="rightTd">联系电话:</td>
			<td class="leftTd">${baseInfo.phone }</td>
		</tr>
		<tr>
			<td class="rightTd">网站联系邮箱:</td>
			<td class="leftTd">${baseInfo.email }</td>
		</tr>
		<tr>
			<td class="rightTd">网站访问域名:</td>
			<td class="leftTd">${baseInfo.domainName }</td>
		</tr>
		<tr>
			<td class="rightTd">网站备案号:</td>
			<td class="leftTd">${baseInfo.recordCode }</td>
		</tr>
		<tr>
			<td class="rightTd">首页图片宽度:</td>
			<td class="leftTd">${baseInfo.indexPicWidth }</td>
		</tr>
		<tr>
			<td class="rightTd">首页图片高度:</td>
			<td class="leftTd">${baseInfo.indexPicHeight }</td>
		</tr>
		<tr>
			<td colspan="2" class="centerTd"><a href="<%=request.getContextPath() %>/admin/system/baseinfo/update" class="list_op">修改网站基本信息</a></td>
		</tr>
	</table>
</div>
</body>
</html>