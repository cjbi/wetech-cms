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
</head>
<body>
<div id="content">
	<h3 class="admin_link_bar">
		<jsp:include page="inc.jsp"></jsp:include>
	</h3>
	<table width="550px" cellspacing="0" cellPadding="0">
		<thead><tr><td colspan="2">显示超链接</td></tr></thead>
		<tr>
			<td class="rightTd" width="96px">超链接标题:</td><td class="leftTd">${cmsLink.title }</td>
		</tr>
		<tr>
			<td class="rightTd" width="96px">超链接地址:</td><td class="leftTd"><a href="${cmsLink.url }" class="list_link" target="_blank">${cmsLink.url }</a></td>
		</tr>
		<tr>
			<td class="rightTd">超链接类别：</td>
			<td class="leftTd">
				${cmsLink.type }
			</td>
		</tr>
		<tr>
			<td class="rightTd">打开方式:</td>
			<td><c:if test="${cmsLink.newWin eq 0}">本窗口</c:if>
				<c:if test="${cmsLink.newWin eq 1}">新窗口</c:if></td>
		</tr>
		<tr>
			<td class="rightTd">链接标签ID:</td>
			<td>${cmsLink.urlId }</td>
		</tr>
		<tr>
			<td class="rightTd">链接标签类别:</td>
			<td>${cmsLink.urlClass}</td>
		</tr>
	</table>
</div>
</body>
</html>