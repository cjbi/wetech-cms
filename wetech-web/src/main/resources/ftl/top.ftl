<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<input type="hidden" id="ctx" value="<%=request.getContextPath()%>" />
<header class="am-topbar am-topbar-fixed-top am-topbar-inverse">
	<div class="am-container">
		<h1 class="am-topbar-brand">
			<a href="#">WETECH CMS</a>
		</h1>
		<button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-secondary am-show-sm-only" data-am-collapse="{target: '#collapse-head'}">
			<span class="am-sr-only">导航切换</span><span class="am-icon-bars"></span>
		</button>
		<div class="am-collapse am-topbar-collapse" id="collapse-head">
			<ul class="am-nav am-nav-pills am-topbar-nav">
				<li class="am-active"><a href="<%=request.getContextPath()%>/index">首页</a></li>
				<#list navs as nav>
				<#if nav.customLink==0>
				<li><a href="<%=request.getContextPath()%>/channel/${nav.id}">${nav.name}</a></li>
				<#else>
				<li><a href="${nav.customLinkUrl}">${nav.name}</a></li>
				</#if>
				</#list>
				<li class="am-dropdown" data-am-dropdown><a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;"> 下拉菜单 <span
						class="am-icon-caret-down"></span>
				</a>
					<ul class="am-dropdown-content">
						<li><a href="#">1. 默认样式</a></li>
						<li><a href="#">2. 基础设置</a></li>
						<li><a href="#">3. 文字排版</a></li>
						<li><a href="#">4. 网格系统</a></li>
					</ul></li>
			</ul>
			<form class="am-topbar-form am-topbar-left  am-form-inline" role="search">
				<div class="am-form-group am-form-icon">
					<i class="am-icon-search"></i> <input type="text" class="am-form-field am-input-sm" placeholder=" 搜索你感兴趣的内容...">
				</div>
			</form>
			<div class="am-topbar-right">
				<button class="am-btn am-btn-primary am-topbar-btn am-btn-sm">
					<span class="am-icon-user"></span> <a href="<%=request.getContextPath()%>/login">登录</a>
				</button>
			</div>
		</div>
	</div>
</header>