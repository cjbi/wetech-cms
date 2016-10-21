<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/main.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/core/jquery.cms.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/admin/main.js"></script>
<script type="text/javascript">
$(function(){
	$("a.resumeDatabase").click(function() {
		if(!confirm("覆盖之后不可恢复，确定要覆盖吗？建议先进行备份")) {
			event.preventDefault();
		} else {
			$("a.resumeDatabase").parent("td").html("恢复中,请稍等...");
		}
	})
})
</script>
</head>
<body>
<div id="content">
	<h3 class="admin_link_bar">
		<jsp:include page="inc.jsp"></jsp:include>
	</h3>
	<table width="800" cellspacing="0" cellPadding="0" id="listTable">
		<thead>
		<tr>
			<td>备份文件名称</td>
			<td>文件大小</td>
			<td>备份时间</td>
			<td>文件类型</td>
			<td>用户操作</td>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${backups }" var="b">
			<tr>
				<td>${b.name }</td>
				<td>${b.size }K</td>
				<td><fmt:formatDate value="${b.time }" pattern="yyyy-MM-dd HH:mm"/></td>
				<td>
					${b.filetype }
				</td>
				<td>
					<a href="delete/${b.name }?type=${b.filetype}"  class="list_op delete">删除</a>
					<a href="resume/${b.name}?type=${b.filetype}" class="list_op resumeDatabase">恢复数据库</a>
				&nbsp;
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>