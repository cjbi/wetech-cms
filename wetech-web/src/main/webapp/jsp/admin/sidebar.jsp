<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="admin-sidebar am-offcanvas admin-sidebar-list" id="admin-offcanvas">
	<div class="am-offcanvas-bar admin-offcanvas-bar">
		<ul class="am-list admin-sidebar-list" id="collapase-nav-1">
			<li><a href="<%=request.getContextPath()%>/admin"><span class="am-icon-dashboard"></span> 仪表盘</a></li>
			<li class="am-panel"><a class="am-cf" data-am-collapse="{parent:'#collapase-nav-1', target: '#collapse-nav'}"><span class="am-icon-user"></span> 用户管理 <span
					class="am-icon-angle-right am-fr am-margin-right"></span></a>
				<ul class="am-list am-collapse admin-sidebar-sub am-in" id="collapse-nav">
					<li><a href="<%=request.getContextPath()%>/admin/user/user" class="am-cf"><span class="am-icon-info"></span> 用户信息管理<span class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
					<li><a href="#" class="am-cf"><span class="am-icon-group"></span> 用户组管理<span class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
					<li><a href="#" class="am-cf"><span class="am-icon-child"></span> 用户角色管理<span class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
				</ul></li>
			<li class="am-panel"><a class="am-cf" data-am-collapse="{parent:'#collapase-nav-1', target: '#collapse-nav1'}"><span class="am-icon-file-text"></span> 文章管理 <span
					class="am-icon-angle-right am-fr am-margin-right"></span></a>
				<ul class="am-list am-collapse admin-sidebar-sub" id="collapse-nav1">
					<li><a href="<%=request.getContextPath()%>/admin/user/users" class="am-cf"><span class="am-icon-navicon"></span> 栏目信息管理<span class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
					<li><a href="<%=request.getContextPath()%>/admin/user/users" class="am-cf"><span class="am-icon-file-text-o"></span> 文章信息管理<span class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
				</ul></li>
			<li class="am-panel"><a class="am-cf" data-am-collapse="{parent:'#collapase-nav-1', target: '#collapse-nav2'}"><span class="am-icon-cogs"></span> 系统配置 <span
					class="am-icon-angle-right am-fr am-margin-right"></span></a>
				<ul class="am-list am-collapse admin-sidebar-sub" id="collapse-nav2">
					<li><a href="#" class="am-cf"><span class="am-icon-link"></span> 超级链接管理<span class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
					<li><a href="#" class="am-cf"><span class="am-icon-sitemap"></span> 网站信息管理<span class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
					<li><a href="#" class="am-cf"><span class="am-icon-picture-o"></span> 首页图片管理<span class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
					<li><a href="#" class="am-cf"><span class="am-icon-database"></span> 网站数据备份<span class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
					<li><a href="#" class="am-cf"><span class="am-icon-cog"></span> 系统清理管理<span class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
				</ul></li>
			<li><a href="<%=request.getContextPath()%>/admin/logout"><span class="am-icon-sign-out"></span> 注销</a></li>
		</ul>
	</div>
</div>

<!-- 自适应菜单按钮 -->
<a href="#" class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu" data-am-offcanvas="{target: '#admin-offcanvas'}"></a>