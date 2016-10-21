<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/main.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/core/jquery.cms.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/admin/main.js"></script>
</head>
<body>
<div id="content">
	<h3 class="admin_link_bar">
		<jsp:include page="inc.jsp"></jsp:include>
	</h3>
	<table width="800" cellspacing="0" cellPadding="0" id="listTable">
		<thead>
		<tr>
			<td>角色标识</td>
			<td>角色名称</td>
			<td>角色类型</td>
			<td>角色操作</td>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${roles}" var="role">
			<tr>
				<td>${role.id }&nbsp;</td>
				<td><a href="${role.id }" class="list_link">${role.name }</a></td>
				<td>${role.roleType }&nbsp;</td>
				<td>
					<a href="delete/${role.id }" class="list_op delete">删除</a>
					<a href="update/${role.id }" class="list_op">更新</a>
					<a href="clearUsers/${role.id }" class="list_op delete">清空用户</a>
				&nbsp;
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>