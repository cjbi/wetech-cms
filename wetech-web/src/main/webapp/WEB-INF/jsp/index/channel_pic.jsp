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
			<div id="breadcrumb">
				<span>你的位置&nbsp; <a href="<%=request.getContextPath()%>/index">首页</a>|
				<a href="<%=request.getContextPath()%>/channel/${pc.id}">${pc.name }</a>|${channel.name }</span>
			</div>
			<div id="channel_content">
				<div id="channel_left">
					<dl>
						<dt><span>${pc.name}</span></dt>
						<c:forEach var="c" items="${cs}">
							<dd><a href="${c.id }" class="channel_left_href">${c.name }</a></dd>
						</c:forEach>
					</dl>
				</div>
				<div id="channel_right">
					<div id="channel_title">
						<span>${channel.name}</span>
					</div>
					<div id="channel_img_container">
						<c:if test="${datas.total le 0 }">
							该栏目还没有文章...
						</c:if>
						<c:if test="${datas.total gt 0 }">
							<c:forEach var="att" items="${datas.datas }">
									<div class="channel_img">
										<div class="channel_img_img">
											<a href="<%=request.getContextPath()%>/topic/${att.topic.id}" title="${att.topic.title }">
											<img src="<%=request.getContextPath()%>/resources/upload/thumbnail/${att.newName}" width="150" height="110"/>
											</a>
										</div>
										<div class="channel_img_title"><span>${att.topic.title }</span></div>
										<div class="channel_img_intro">
											<span><fmt:formatDate value="${att.topic.publishDate }" pattern="yyyy/MM/dd"/>
											&nbsp;&nbsp;&nbsp;${att.topic.author }</span>
										</div>
									</div>
								</c:forEach>
							<div id="channel_img_pager">
								<span>
								<jsp:include page="/jsp/index_pager.jsp">
									<jsp:param value="${datas.total }" name="totalRecord"/>
									<jsp:param value="channel/${channel.id}" name="url"/>
								</jsp:include>
								</span>
							</div>
						</c:if>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/jsp/template/bottom.jsp"/>
</body>
</html>