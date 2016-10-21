<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/js/base/jquery.ui.all.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/article.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/validate/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/zTree/zTreeStyle.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/js/core/jquery.cms.keywordinput.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/core/jquery.cms.keywordinput.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/tree/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/core/jquery.cms.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/ui/jquery-ui-1.10.0.custom.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/i18n/jquery.ui.datepicker-zh-CN.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/admin/main.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/xheditor/xheditor-1.1.14-zh-cn.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/uploadify/uploadify.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/core/jquery.cms.validate.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/admin/topicAdd.js"></script>
</head>
<body>
<input type="hidden" id="sid" value="<%=session.getId()%>"/>
<div id="menuContent" class="menuContent" style="display:none; position: absolute;background:#eee;z-index: 999;border:1px solid #999">
	<ul id="mytree" class="ztree" style="margin-top:0;"></ul>
</div>
<div id="container">
<jsp:include page="/jsp/admin/top_inc.jsp"></jsp:include>
<div id="contents">
<input type="hidden" id="ctx" value="<%=request.getContextPath() %>"/>
	<h3 class="admin_link_bar" style="text-align:center">
	<span>添加文章功能</span>
	</h3>
	<sf:form method="post" modelAttribute="topicDto" id="addForm">
	<table width="980" cellspacing="0" cellPadding="0" id="addTable">
		<tr>
			<td class="rightTd" width="120px">文章标题:</td>
			<td class="leftTd">
			<sf:input path="title" size="80"/><sf:errors cssClass="errorContainer" path="title"/></td>
		</tr>
		<tr>
			<td class="rightTd">文章栏目:</td>
			<td class="leftTd">
				<input type="text" readonly="readonly" name="cname" id="cname"/>
				<input type="text" readonly="readonly" id="cid" name="cid" value="0"/><sf:errors cssClass="errorContainer" path="cid"/>
			</td>
		</tr>
		<c:choose>
			<c:when test="${isAudit||isAdmin }">
			<tr>
				<td class="rightTd">文章状态:</td>
				<td class="leftTd">
					<sf:radiobutton path="status" value="0"/>未发布
					<sf:radiobutton path="status" value="1"/>已发布
				</td>
			</tr>
			</c:when>
			<c:otherwise>
			<sf:hidden path="status"/>
			</c:otherwise>
		</c:choose>
		<tr>
			<td class="rightTd">是否推荐该文章:</td>
			<td class="leftTd">
				<sf:radiobutton path="recommend" value="0"/>不推荐
				<sf:radiobutton path="recommend" value="1"/>推荐
			</td>
		</tr>
		<tr>
			<td class="rightTd">发布时间:</td>
			<td class="leftTd">
				<sf:input path="publishDate"/>
			</td>
		</tr>
		<tr>
			<td class="rightTd">文章关键字:</td>
			<td class="leftTd">
				<sf:input path="keyword"/>
			</td>
		</tr>
		<tr>
			<td class="rightTd">文章附件</td>
			<td class="leftTd">
				<div id="attachs"></div>
				<input type="file" id="attach" name="attach"/>
				<input type="button" id="uploadFile" value="上传文件"/>
			</td>
		</tr>
		<tr>
		<td colspan="2">已传附件</td>
		</tr>
		<tr>
		<td colspan="2">
		<table id="ok_attach" width="890px" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
				<Td>文件名缩略图</Td>
				<td width="180">文件名</td>
				<td>文件大小</td>
				<td>主页图片</td>
				<td>栏目图片</td>
				<td>附件信息</td>
				<td width="160">操作</td>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		</td>
		</tr>
		<tr>
			<td colspan="2">文章内容</td>
		</tr>
		<tr>
			<td colspan="2">
			<sf:textarea path="content" rows="25" cols="110"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">文章摘要</td>
		</tr>
		<tr>
			<td colspan="2">
			<sf:textarea path="summary" rows="5" cols="110"/>
			
			</td>
		</tr>
		<tr>
			<td colspan="2" class="centerTd"><input type="button" id="addBtn" value="添加文章"/><input type="reset"/></td>
		</tr>
	</table>
	</sf:form>
</div>
</div>
</body>
</html>