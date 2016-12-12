<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>latests Page | ${baseInfo.name}</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="alternate icon" type="image/png"
	href="<%=request.getContextPath()%>/resources/assets/i/favicon.png">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/amazeui.min.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/cms.css" />
</head>
<body class="am-with-topbar-fixed-top">
	<jsp:include page="/jsp/template/top.jsp" />
	<%-- topics start --%>
	<div class="am-g am-g-fixed">
		<div>
			<ol class="am-breadcrumb am-breadcrumb am-margin-vertical-0 br_bt">
				<li><a href="<%=request.getContextPath()%>/index"
					class="am-icon-home">首页</a></li>
				<li class="am-active">最新文章</li>
			</ol>
		</div>
	</div>
	<div class="am-g am-g-fixed">
		<div class="am-u-md-8">
			<div data-am-widget="list_news"
				class="am-list-news am-list-news-default">
				<%--列表标题--%>
				<div class="am-list-news-hd am-cf">
					<%--带更多链接--%>
					<h2>
						<span class="am-icon-list-ul"></span> 最新文章
					</h2>
				</div>
				<div class="am-list-news-bd">
					<c:if test="${datas.total le 0 }">
						该栏目还没有任何文章....
					</c:if>
					<c:if test="${datas.total gt 0 }">
						<ul class="am-list">
							<c:forEach items="${datas.datas}" var="topic">
								<li class="am-g am-list-item-desced"><a
									href="<%=request.getContextPath() %>/topic/${topic.id}"
									class="am-list-item-hd"><h2>${topic.title }</h2></a>
									<div class="am-list-item-text">${topic.summary }</div>
									<p class="am-article-meta am-text-right">
										<span class="am-icon-navicon"></span>&nbsp;${topic.cname }&nbsp;&nbsp;<span
											class="am-icon-user"></span>&nbsp;<a href="#">${topic.author }</a>&nbsp;&nbsp;<span
											class="am-icon-clock-o"></span>&nbsp;
										<fmt:formatDate value="${topic.publishDate }"
											pattern="yyyy-MM-dd" />
										&nbsp;&nbsp;
									</p></li>
							</c:forEach>
						</ul>
					</c:if>
					<%-- pager start --%>
					<jsp:include page="/jsp/index_pager.jsp">
						<jsp:param value="${datas.total }" name="totalRecord" />
						<jsp:param value="topics" name="url" />
					</jsp:include>
					<%-- pager end --%>
				</div>
			</div>
		</div>
		<div class="am-u-md-4">
			<div class="am-panel-group">
				<section class="am-panel am-panel-default">
					<div class="am-panel-hd">推荐阅读</div>
					<ul class="am-list blog-list">
						<c:forEach items="${recommendTopics }" var="rt">
							<li><a href="<%=request.getContextPath()%>/topic/${rt.id }">${rt.title }</a></li>
						</c:forEach>
					</ul>
				</section>
				<section class="am-panel am-panel-default">
					<div class="am-panel-hd">文章标签</div>
					<div class="am-panel-bd">
						<a href="" class="am-badge am-badge-primary am-radius">amaze</a> <a
							href="" class="am-badge am-badge am-radius">妹纸 UI</a> <a href=""
							class="am-badge am-badge-warning am-radius">HTML5</a> <a href=""
							class="am-badge am-badge am-radius">这是标签</a>
					</div>
				</section>
			</div>
		</div>
	</div>
	<%-- topics end--%>
	<jsp:include page="/jsp/template/bottom.jsp" />
	<script
		src="<%=request.getContextPath()%>/resources/assets/js/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/resources/assets/js/amazeui.min.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/cms.js"></script>
</body>
</html>