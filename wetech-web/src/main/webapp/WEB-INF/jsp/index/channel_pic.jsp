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
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/index/cms.css" />
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
	<div class="am-g am-g-fixed">
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
					<%--channel pic start--%>
					<c:if test="${datas.total gt 0 }">
						<ul data-am-widget="gallery" class="am-gallery am-avg-sm-2 am-avg-md-3 am-avg-lg-4 am-gallery-imgbordered" data-am-gallery="{ pureview: true }">
							<c:forEach var="att" items="${datas.datas }">
								<li>
									<div class="am-gallery-item">
										<a href="<%=request.getContextPath()%>/resources/upload/thumbnail/${att.newName}"> <img src="<%=request.getContextPath()%>/resources/upload/${att.newName}"
											alt="${att.topic.title }" />
										</a>
										<h3 class="am-gallery-title">
											<a href="<%=request.getContextPath()%>/topic/${att.topic.id}">
											${att.topic.title }
											</a>
										</h3>
										<div class="am-gallery-desc">
											<div class="am-cf">
												<div class="am-fl">
													<span class="am-icon-user"></span>  ${att.topic.author }
												</div>
												<div class="am-fr">
													<span class="am-icon-clock-o"></span>  <fmt:formatDate value="${att.topic.publishDate }" pattern="yyyy/MM/dd" />
												</div>
											</div>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</c:if>
					<%--channel pic end--%>
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