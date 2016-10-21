<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<table width="800" cellspacing="0" cellPadding="0">
		<thead><tr><td colspan="2">查询用户功能：用户id[${user.id }]</td></tr></thead>
		<tr>
			<td class="rightTd" width="200px">用户名:</td><td class="leftTd">${user.username }&nbsp;</td>
		</tr>
		<tr>
			<td class="rightTd">显示名称:</td><td class="leftTd">${user.nickname }&nbsp;</td>
		</tr>
		<tr>
			<td class="rightTd">联系电话:</td><td>${user.phone}&nbsp;</td>
		</tr>
		<tr>
			<td class="rightTd">电子邮件:</td><td>${user.email }&nbsp;</td>
		</tr>
		<tr>
			<td class="rightTd">状态:</td>
			<td>
				<c:if test="${user.status eq 0 }">
					<span class="emp">停用</span>
				</c:if>
				<c:if test="${user.status eq 1 }">
					<span>启用</span>
				</c:if>
				&nbsp;
			</td>
		</tr>
		<tr>
			<td class="rightTd">创建时间:</td>
			<td>
				<fmt:formatDate value="${user.createDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
				&nbsp;
			</td>
		</tr>
		<tr>
			<td class="rightTd">拥有角色:</td>
			<td>
				<c:forEach items="${rs }" var="r">
				<c:if test="${isAdmin}">
					<a href="<%=request.getContextPath()%>/admin/role/${r.id}" class="list_op">
					[${r.name }]
					</a>&nbsp;
				</c:if>
				<c:if test="${not isAdmin}">
					[${r.name }]
				</c:if>	
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td class="rightTd">所在用户组:</td>
			<td>
				<c:forEach items="${gs }" var="g">
				<c:if test="${isAdmin}">
					<a href="<%=request.getContextPath()%>/admin/group/${g.id}" class="list_op">[${g.name }]</a>&nbsp;
				</c:if>
				<c:if test="${not isAdmin}">
					[${g.name }]
				</c:if>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="centerTd">
				<c:if test="${isAdmin}">
				<a href="update/${user.id }" class="list_op">修改用户</a>
				</c:if>
				<c:if test="${not isAdmin}">
				<a href="updateSelf" class="list_op">修改个人信息</a>
				</c:if>
			</td>
		</tr>
	</table>
</div>
</body>
</html>