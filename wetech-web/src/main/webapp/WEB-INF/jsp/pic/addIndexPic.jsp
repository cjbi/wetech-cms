<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/jcrop/css/jquery.Jcrop.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/js/base/jquery.ui.all.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/article.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/validate/main.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/core/jquery.cms.validate.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/core/jquery.cms.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/admin/main.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/uploadify/uploadify.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/jcrop/js/jquery.Jcrop.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/admin/indexPic.js"></script>
</head>
<body>
<input type="hidden" id="sid" value="<%=session.getId()%>"/>
<div id="container">
<jsp:include page="/jsp/admin/top_inc.jsp"></jsp:include>
<div id="contents">
<input type="hidden" id="ctx" value="<%=request.getContextPath() %>"/>
	<h3 class="admin_link_bar" style="text-align:center">
	<span>添加首页图片功能</span>
	</h3>
	<sf:form method="post" modelAttribute="indexPic" id="addForm">
	<table width="980" cellspacing="0" cellPadding="0" id="addTable">
		<tr>
			<td colspan="2">
				<input type="file" id="indexPic" name="indexPic"/>
				<input id="newName" name="newName" readonly/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div id="indexPicView"></div>
			</td>
		</tr>
		<tr>
			<td class="rightTd" width="120px">首页图片标题:</td>
			<td class="leftTd">
			<sf:input path="title" size="80"/></td>
		</tr>
		<tr>
			<td class="rightTd" width="120px">首页图片子标题:</td>
			<td class="leftTd">
			<sf:input path="subTitle" size="80"/></td>
		</tr>
		<tr>
			<td class="rightTd">状态:</td>
			<td class="leftTd">
				<sf:radiobutton path="status" value="0"/>未发布
				<sf:radiobutton path="status" value="1"/>已发布
			</td>
		</tr>
		<tr>
			<td class="rightTd">链接类型:</td>
			<td class="leftTd">
				<sf:radiobutton path="linkType" value="0"/>站内链接
				<sf:radiobutton path="linkType" value="1"/>站外链接
			</td>
		</tr>
		<tr>
			<td class="rightTd">链接地址:</td>
			<td class="leftTd">
				<sf:input path="linkUrl" size="80"/>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="centerTd"><input type="submit" id="addBtn" value="添加首页图片"/><input type="reset"/></td>
		</tr>
	</table>
	</sf:form>
</div>
</div>
</body>
</html>