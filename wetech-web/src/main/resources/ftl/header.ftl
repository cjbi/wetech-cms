<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<header class="am-topbar am-topbar-fixed-top am-topbar-inverse">
	<div class="am-container">
		<h1 class="am-topbar-brand">
			<a href="<%=request.getContextPath()%>/index">${baseInfo.name}</a>
		</h1>
		<button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-secondary am-show-sm-only" data-am-collapse="{target: '#collapse-head'}">
			<span class="am-sr-only">导航切换</span><span class="am-icon-bars"></span>
		</button>
		<div class="am-collapse am-topbar-collapse" id="collapse-head">
			<ul class="am-nav am-nav-pills am-topbar-nav">
				<li class=""><a href="<%=request.getContextPath()%>/index">首页</a></li>
				<#list navs as nav>
				<#if nav.channel.customLink==0>
				<#if nav.child?size != 0>
				<li class="am-dropdown" data-am-dropdown><a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;"> ${nav.name} <span class="am-icon-caret-down"></span></a>
					<ul class="am-dropdown-content">
				<#list nav.child as child>
						<li><a href="<%=request.getContextPath()%>/channel/${child.id}">${child.name}</a></li>
				</#list>
					</ul>
				</li>
				<#else>
				<li><a href="<%=request.getContextPath()%>/channel/${nav.id}">${nav.name}</a></li>
				</#if>
				<#else>
				<li><a href="${nav.channel.customLinkUrl}">${nav.name}</a></li>
				</#if>
				</#list>
			</ul>
			<form class="am-topbar-form am-topbar-left  am-form-inline" action="<%=request.getContextPath()%>/search/" role="search">
				<div class="am-form-group am-form-icon">
					<div class="am-dropdown" id='dropdown-search'>
						<i class="am-icon-search"></i> <input type="text" id="dropdown-search-input" class="am-form-field am-input-sm" placeholder=" 搜索你感兴趣的内容...">
						<ul class="am-dropdown-content am-dropdown-search" id="dropdown-search-ul"></ul>
					</div>
				</div>
			</form>
			<div class="am-topbar-right">
				<c:if test="${r"${loginUser!=null}"}">
					<a href="<%=request.getContextPath()%>/admin"><button class="am-btn am-btn-primary am-topbar-btn am-btn-sm"><span class="am-icon-user"></span> ${r"${loginUser.nickname }"}</button></a>
				</c:if>
				<c:if test="${r"${loginUser==null}"}">
					<a href="<%=request.getContextPath()%>/login"><button class="am-btn am-btn-primary am-topbar-btn am-btn-sm"><span class="am-icon-user"></span> 登录</button></a>
				</c:if>
			</div>
		</div>
	</div>
	<script>
		var contextPath = "${r"${pageContext.request.contextPath}"}";
    </script>
</header>