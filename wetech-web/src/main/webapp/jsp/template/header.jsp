<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<header class="am-topbar am-topbar-fixed-top am-topbar-inverse">
	<div class="am-container">
		<h1 class="am-topbar-brand">
			<a href="<%=request.getContextPath()%>/index">WETECH CMS</a>
		</h1>
		<button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-secondary am-show-sm-only" data-am-collapse="{target: '#collapse-head'}">
			<span class="am-sr-only">导航切换</span><span class="am-icon-bars"></span>
		</button>
		<div class="am-collapse am-topbar-collapse" id="collapse-head">
			<ul class="am-nav am-nav-pills am-topbar-nav">
				<li class=""><a href="<%=request.getContextPath()%>/index">首页</a></li>
				<li class="am-dropdown" data-am-dropdown><a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;"> 财经 <span class="am-icon-caret-down"></span></a>
					<ul class="am-dropdown-content">
						<li><a href="<%=request.getContextPath()%>/channel/15">股票</a></li>
						<li><a href="<%=request.getContextPath()%>/channel/13">基金</a></li>
						<li><a href="<%=request.getContextPath()%>/channel/14">商业</a></li>
					</ul>
				</li>
				<li class="am-dropdown" data-am-dropdown><a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;"> 新闻 <span class="am-icon-caret-down"></span></a>
					<ul class="am-dropdown-content">
						<li><a href="<%=request.getContextPath()%>/channel/18">军事</a></li>
						<li><a href="<%=request.getContextPath()%>/channel/16">评论</a></li>
						<li><a href="<%=request.getContextPath()%>/channel/17">图片</a></li>
					</ul>
				</li>
				<li><a href="http://163.com">网易</a></li>
				<li><a href="<%=request.getContextPath()%>/channel/56">文章内容</a></li>
				<li><a href="<%=request.getContextPath()%>/channel/17">图片</a></li>
				<li><a href="<%=request.getContextPath()%>/channel/14">商业</a></li>
			</ul>
			<form class="am-topbar-form am-topbar-left  am-form-inline" role="search">
				<div class="am-form-group am-form-icon">
					<div class="am-dropdown" id='dropdown-search'>
						<i class="am-icon-search"></i> <input type="text" id="dropdown-search-input" class="am-form-field am-input-sm" placeholder=" 搜索你感兴趣的内容...">
						<ul class="am-dropdown-content am-dropdown-search" id="dropdown-search-ul"></ul>
					</div>
				</div>
			</form>
			<div class="am-topbar-right">
				<c:if test="${loginUser!=null}">
					<a href="<%=request.getContextPath()%>/admin"><button class="am-btn am-btn-primary am-topbar-btn am-btn-sm"><span class="am-icon-user"></span> ${loginUser.nickname }</button></a>
				</c:if>
				<c:if test="${loginUser==null}">
					<a href="<%=request.getContextPath()%>/login"><button class="am-btn am-btn-primary am-topbar-btn am-btn-sm"><span class="am-icon-user"></span> 登录</button></a>
				</c:if>
			</div>
		</div>
	</div>
	<script>
		var contextPath = "${pageContext.request.contextPath}";
    </script>
</header>