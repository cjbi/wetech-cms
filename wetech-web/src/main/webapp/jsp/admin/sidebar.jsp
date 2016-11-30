<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
div>ul>li>ul>li>a:hover, div>ul>li>a:hover {
	-webkit-transition: background-color .3s ease;
	-moz-transition: background-color .3s ease;
	-ms-transition: background-color .3s ease;
	-o-transition: background-color .3s ease;
	transition: background-color .3s ease;
	background: #E4E4E4;
}
</style>
<div class="admin-sidebar am-offcanvas admin-sidebar-list" id="admin-offcanvas">
	<div class="am-offcanvas-bar admin-offcanvas-bar">
		<ul class="am-list admin-sidebar-list" id="collapase-nav-1">
			<li><a href="#" class="am-cf"><span class="am-icon-dashboard"></span> 仪表盘</a></li>
			<c:if test="${isAdmin }">
			<li class="am-panel"><a class="am-cf" data-am-collapse="{parent:'#collapase-nav-1', target: '#collapse-nav'}"><span class="am-icon-user"></span>
					用户管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a> <!-- ul class add am-in to open sidebar item. -->
				<ul class="am-list am-collapse admin-sidebar-sub" id="collapse-nav">
					<li><a href="<%=request.getContextPath()%>/admin/user" class="am-cf"><span class="am-icon-info"></span> 用户信息管理<span
							class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
					<li><a href="<%=request.getContextPath()%>/admin/group" class="am-cf"><span class="am-icon-group"></span> 用户组管理<span
							class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
					<li><a href="<%=request.getContextPath()%>/admin/role" class="am-cf"><span class="am-icon-child"></span> 用户角色管理<span
							class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
				</ul></li>
			</c:if>
			<li class="am-panel"><a class="am-cf" data-am-collapse="{parent:'#collapase-nav-1', target: '#collapse-nav1'}"><span
					class="am-icon-file-text"></span> 文章管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
				<ul class="am-list am-collapse admin-sidebar-sub" id="collapse-nav1">
				<c:if test="${isAdmin }">
					<li><a href="<%=request.getContextPath()%>/admin/channel" class="am-cf"><span class="am-icon-navicon"></span> 栏目信息管理<span
							class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
				</c:if>			
					<li><a href="<%=request.getContextPath()%>/admin/topic" class="am-cf"><span class="am-icon-file-text-o"></span> 文章信息管理<span
							class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
				</ul></li>
			<c:if test="${isAdmin }">
				<li class="am-panel"><a class="am-cf" data-am-collapse="{parent:'#collapase-nav-1', target: '#collapse-nav2'}"><span class="am-icon-cogs"></span>
						系统配置 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
					<ul class="am-list am-collapse admin-sidebar-sub" id="collapse-nav2">
						<li><a href="<%=request.getContextPath()%>/admin/cmsLink" class="am-cf"><span class="am-icon-link"></span> 超级链接管理<span
								class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
						<li><a href="<%=request.getContextPath()%>/admin/system/baseInfo" class="am-cf"><span class="am-icon-sitemap"></span> 网站信息管理<span
								class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
						<li><a href="<%=request.getContextPath()%>/admin/pic/indexPic" class="am-cf"><span class="am-icon-picture-o"></span> 轮播图片管理<span
								class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
						<li><a href="<%=request.getContextPath()%>/admin/backup" class="am-cf"><span class="am-icon-database"></span> 网站数据备份<span
								class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
						<li><a href="<%=request.getContextPath()%>/admin/system/clean" class="am-cf"><span class="am-icon-wrench"></span> 系统清理管理<span
								class="am-fr am-margin-right admin-icon-yellow"></span></a></li>
					</ul></li>
			</c:if>
			<li><a href="<%=request.getContextPath()%>/admin/logout"><span class="am-icon-sign-out"></span> 注销</a></li>
		</ul>
	</div>
</div>
<!-- 自适应菜单按钮 -->
<a href="#" class="am-icon-btn am-icon-th-list am-show-sm-only admin-menu" data-am-offcanvas="{target: '#admin-offcanvas'}"></a>