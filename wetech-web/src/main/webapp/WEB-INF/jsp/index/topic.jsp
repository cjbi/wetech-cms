<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>Topic Page | ${baseInfo.name}</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="alternate icon" type="image/png" href="<%=request.getContextPath()%>/resources/assets/i/favicon.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/cms.css" />
</head>
<body class="am-with-topbar-fixed-top">
	<jsp:include page="/jsp/template/top.jsp" />
	<!-- topic start -->
	<div class="am-g am-g-fixed blog-g-fixed">
		<div class="am-u-md-8">
			<article class="am-article">
				<div class="am-article-hd">
					<h1 class="am-article-title">${topic.title}</h1>
					<p class="am-article-meta">
						作者&nbsp;&nbsp;<a href="#">${topic.author }</a>&nbsp;&nbsp;发布于
						<fmt:formatDate value="${topic.publishDate }" pattern="yyyy-MM-dd HH:mm:ss" />
						| 发表在<a href="<%=request.getContextPath() %>/channel/${topic.channel.id}">${topic.channel.name}</a>栏目
					</p>
				</div>
				<div class="am-article-bd">
					<p class="am-article-lead">${topic.summary }</p>
					<p>${topic.content }</p>
				</div>
			</article>
			<hr class="am-article-divider blog-hr">
			<div class="am-cf">
				<div class="am-fl">
					<!-- <button type="button" class="am-btn am-btn-danger am-btn-xs am-radius">
						<i class="am-icon-heart"></i> 赞一下
					</button> -->
					<c:if test="${!hasAtts}">该文章没有附件</c:if>
					<c:if test="${hasAtts }">
						<c:forEach items="${atts }" var="att">
							<span><a href="<%=request.getContextPath()%>/resources/upload/${att.newName}" class="article_att_link">${att.oldName }</a></span>
						</c:forEach>
					</c:if>
				</div>
				<!-- baidu share start -->
				<div class="am-fr">
					<div class="bdsharebuttonbox">
						<a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#"
							class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#"
							class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
					</div>
					<script>
			window._bd_share_config = {
			    "common" : {
				"bdSnsKey" : {},
				"bdText" : "",
				"bdMini" : "2",
				"bdMiniList" : false,
				"bdPic" : "",
				"bdStyle" : "0",
				"bdSize" : "24"
			    },
			    "share" : {},
			    "image" : {
				"viewList" : [ "qzone", "tsina", "tqq", "renren", "weixin" ],
				"viewText" : "分享到：",
				"viewSize" : "16"
			    },
			    "selectShare" : {
				"bdContainerClass" : null,
				"bdSelectMiniList" : [ "qzone", "tsina", "tqq", "renren", "weixin" ]
			    }
			};
			with (document)
			    0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='
				    + ~(-new Date() / 36e5)];
		    </script>
				</div>
				<!-- baidu share end -->
			</div>
			<!-- duoshuo start -->
			<div data-am-widget="duoshuo" class="am-duoshuo am-duoshuo-default" data-ds-short-name="cjbi">
				<div class="ds-thread" data-thread-key="${topic.title}"></div>
			</div>
			<!-- duoshuo end -->
		</div>
		<div class="am-u-md-4 blog-sidebar">
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
					<div class="am-panel-hd">相关文章</div>
					<ul class="am-list blog-list">
						<c:forEach items="${channelTopics }" var="ct">
							<li><a href="<%=request.getContextPath()%>/topic/${ct.id }">${ct.title }</a></li>
						</c:forEach>
					</ul>
				</section>
				<section class="am-panel am-panel-default">
					<div class="am-panel-hd">文章标签</div>
					<div class="am-panel-bd">
						<c:if test="${hasKey }">
							<c:forEach items="${kws }" var="k">
								<a href="<%=request.getContextPath() %>/keyword/${k}" class="am-badge am-badge-primary am-radius">${k }</a>
							</c:forEach>
						</c:if>
					</div>
				</section>
				<section class="am-panel am-panel-default">
					<div class="am-panel-hd">最近访客</div>
					<div class="am-panel-bd">
						<ul class="am-avg-sm-4 blog-team">
							<li><img class="am-thumbnail" src="<%=request.getContextPath()%>/resources/img/visitor.jpeg" alt="" /></li>
							<li><img class="am-thumbnail" src="<%=request.getContextPath()%>/resources/img/visitor.jpeg" alt="" /></li>
							<li><img class="am-thumbnail" src="<%=request.getContextPath()%>/resources/img/visitor.jpeg" alt="" /></li>
							<li><img class="am-thumbnail" src="<%=request.getContextPath()%>/resources/img/visitor.jpeg" alt="" /></li>
							<li><img class="am-thumbnail" src="<%=request.getContextPath()%>/resources/img/visitor.jpeg" alt="" /></li>
							<li><img class="am-thumbnail" src="<%=request.getContextPath()%>/resources/img/visitor.jpeg" alt="" /></li>
							<li><img class="am-thumbnail" src="<%=request.getContextPath()%>/resources/img/visitor.jpeg" alt="" /></li>
							<li><img class="am-thumbnail" src="<%=request.getContextPath()%>/resources/img/visitor.jpeg" alt="" /></li>
						</ul>
					</div>
				</section>
			</div>
		</div>
	</div>
	<!-- topic end-->
	<jsp:include page="/jsp/template/bottom.jsp" />
	<script src="<%=request.getContextPath()%>/resources/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/js/amazeui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/cms.js"></script>
</body>
</html>