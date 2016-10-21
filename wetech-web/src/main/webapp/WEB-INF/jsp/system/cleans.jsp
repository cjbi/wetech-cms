<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/main.css"/>
</head>
<body>
<div id="content">
	<table width="800" cellspacing="0" cellPadding="0" id="listTable">
		<thead>
		<tr>
			<td>名称</td>
			<td>数量</td>
			<td>操作</td>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td>未引用的垃圾附件</td><td>${attNums }</td><td><a href="cleanList/atts" class="list_op">查询</a>&nbsp;&nbsp;<a href="clean/atts" class="list_op delete">清理</a></td>
		</tr>
		<tr>
			<td>未引用的首页图片</td><td>${indexPics }</td><td><a href="cleanList/pics" class="list_op">查询</a>&nbsp;&nbsp;<a href="clean/pics" class="list_op delete">清理</a></td>
		</tr>
		</tbody>
	</table>
</div>
</body>
</html>