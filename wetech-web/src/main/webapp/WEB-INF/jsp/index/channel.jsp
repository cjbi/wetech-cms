<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>Channel Page | ${baseInfo.name}</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="alternate icon" type="image/png" href="<%=request.getContextPath()%>/resources/amazeui/assets/i/favicon.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/cms.css" />
</head>
<body class="am-with-topbar-fixed-top">
	<jsp:include page="/jsp/template/header.jsp" />
	<%-- channel start --%>
	<div class="am-g am-g-fixed">
		<div>
			<ol class="am-breadcrumb am-breadcrumb am-margin-vertical-0 br_bt">
				<li><a href="<%=request.getContextPath()%>/index" class="am-icon-home">首页</a></li>
				<%-- <li><a href="<%=request.getContextPath()%>/channel/${pc.id}">${pc.name }</a></li> --%>
				<li class="am-active">${channel.name }</li>
			</ol>
		</div>
	</div>
	<div class="am-g am-g-fixed admin-content-body">
		<div class="am-u-md-3">
			<div class="am-panel-group">
				<section class="am-panel am-panel-default">
					<div data-am-widget="" class="am-titlebar-default">
						<h2 class="am-titlebar-title">${pc.name}</h2>
						<nav class="am-titlebar-nav">
							<a href="#more" class="">more &raquo;</a>
						</nav>
					</div>
					<ul class="am-nav">
						<c:forEach var="c" items="${cs}">
							<c:if test="${c.name eq channel.name}">
								<li class="am-active"><a href="${c.id }">${c.name }</a></li>
							</c:if>
							<c:if test="${c.name ne channel.name}">
								<li><a href="${c.id }">${c.name }</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</section>
			</div>
		</div>
		<div class="am-u-md-9">
			<div data-am-widget="list_news" class="am-list-news am-list-news-default">
				<%--列表标题--%>
				<div class="am-list-news-hd am-cf">
					<%--带更多链接--%>
					<h2>
						<span class="am-icon-list-ul"></span> ${channel.name}
					</h2>
				</div>
				<div class="am-list-news-bd">
					<c:if test="${datas.total le 0 }">
						该栏目还没有任何文章....
					</c:if>
					<c:if test="${datas.total gt 0 }">
						<ul class="am-list">
							<c:forEach items="${datas.datas}" var="topic">
								<li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-bottom-left"><a href="<%=request.getContextPath() %>/topic/${topic.id}"
									class="am-list-item-hd"><h2>${topic.title }</h2></a>
									<c:if test="${not empty topic.thumb}">
										<div class="am-u-sm-2 am-list-thumb">
											<a href="<%=request.getContextPath() %>/topic/${topic.id}"><img src="${topic.thumb }" width="140" height="140" class="am-img-thumbnail"></a>
										</div>
										<div class=" am-u-sm-10  am-list-main">
											<div class="am-list-item-text">${topic.summary }</div>
										</div>
									</c:if>
									<c:if test="${empty topic.thumb}">
										<div class=" am-u-sm-12  am-list-main">
											<div class="am-list-item-text">${topic.summary }</div>
										</div>
									</c:if>
									<p class="am-article-meta am-text-right">
										<span class="am-icon-user"></span>&nbsp;<a href="#">${topic.author }</a>&nbsp;&nbsp;<span class="am-icon-clock-o"></span>&nbsp;
										<fmt:formatDate value="${topic.publishDate }" pattern="yyyy-MM-dd" />
										&nbsp;&nbsp;
									</p></li>
							</c:forEach>
						</ul>
					</c:if>
					<%-- pager start --%>
					<jsp:include page="/jsp/index_pager.jsp">
						<jsp:param value="${datas.total }" name="totalRecord" />
						<jsp:param value="channel/${channel.id}" name="url" />
					</jsp:include>
					<%-- pager end --%>
				</div>
			</div>
		</div>
	</div>
	<%-- channel end--%>
	<jsp:include page="/jsp/template/footer.jsp" />
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/cms.js"></script>
</body>
</html>