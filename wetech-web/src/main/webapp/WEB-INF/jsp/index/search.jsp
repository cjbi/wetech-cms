<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎访问${baseInfo.name }</title>
<meta http-equiv="keywords" content="昭通师专,昭通学院,昭通学院附中,昭通师专附中">   
<meta http-equiv="description" content="昭通学院附中网站,昭通师专附中网站">   
<!-- Date: 2013-09-04 -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/index/web.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery.cycle2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/index/main.js"></script>
<script type="text/javascript">
$(function(){
	$("#search_btn1").click(function() {
		var k = $("#search_con1").val();
		if(k=="") {
			alert("请输入要检索的关键字");
		} else {
			window.location.href=$("#ctx").val()+"/search/"+k;
		}
	})
})
</script>
</head>
<body>
<jsp:include page="/jsp/template/top.jsp"/>	
<div id="content">
	<div id="content_con">
		<div id="breadcrumb">
			<span>
			你的位置&nbsp; <a href="<%=request.getContextPath()%>/index">首页</a>|检索:${con }
			</span>
		</div>
		<div id="channel_content">
			<div id="channel_left">
				<dl>
					<dt><span>导航栏目</span></dt>
					<c:forEach var="c" items="${cs}">
						<dd><a href="${c.id }" class="channel_left_href">${c.name }</a></dd>
					</c:forEach>
				</dl>
			</div>
			<div id="channel_right">
				<div id="channel_title">
					<span>检索内容:[${con }]</span>
					<span><input type="text" id="search_con1" value="${con }" size="50"/><input type="button" id="search_btn1" value="进行检索"/></span>
				</div>
				<table>
					<c:if test="${datas.total le 0 }">
						<tr><td>没有检索到任何相关文章</td></tr>
					</c:if>
					<c:if test="${datas.total gt 0 }">
					<c:forEach items="${datas.datas}" var="topic">
					<tr>
						<td>
							<a href="<%=request.getContextPath() %>/topic/${topic.id}" class="channel_right_href">
							${topic.title }</a>
						</td>
						<td>[<fmt:formatDate value="${topic.publishDate }" pattern="yyyy-MM-dd"/>]</td>
					</tr>
					</c:forEach>
					<tfoot>
					<tr>
					<td colspan="2">
						<jsp:include page="/jsp/index_pager.jsp">
							<jsp:param value="${datas.total }" name="totalRecord"/>
							<jsp:param value="search/${con }" name="url"/>
						</jsp:include>
					</td>
					</tr>
					</tfoot>
					</c:if>
				</table>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/jsp/template/bottom.jsp"/>
</body>
</html>