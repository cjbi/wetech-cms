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
<style type="text/css">
</style>
</head>
<body>
<jsp:include page="/jsp/template/top.jsp"/>	
<div id="content">
	<div id="content_con">
		<div id="article_title"><span>${topic.title}</span></div>
		<div id="article_info">
		<fmt:formatDate value="${topic.publishDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
		&nbsp;${topic.author }
		</div>
		<div id="article_keyword">
			<a href="<%=request.getContextPath() %>/channel/${topic.channel.id}" class="article_keyword_href">${topic.channel.name}</a>
			<c:if test="${hasKey }">
				<c:forEach items="${kws }" var="k">
					<a href="<%=request.getContextPath() %>/keyword/${k}" class="article_keyword_href">${k }</a>
				</c:forEach>
			</c:if>
		</div>
		<div id="article_content">
		${topic.content }
		</div>
		<div class="article_atts">
		相关附件:
		<c:if test="${!hasAtts}">该文章没有附件</c:if>
		<c:if test="${hasAtts }">
			<c:forEach items="${atts }" var="att">
				<span><a href="<%=request.getContextPath()%>/resources/upload/${att.newName}" class="article_att_link">${att.oldName }</a></span>
			</c:forEach>
		</c:if>
		</div>
	</div>
</div>
<jsp:include page="/jsp/template/bottom.jsp"/>
</body>
</html>