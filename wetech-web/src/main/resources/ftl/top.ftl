<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <input type="hidden" id="ctx" value="<%=request.getContextPath()%>"/>
<div id="header">
	<div id="header_con">
		<div id="logo"></div>
		<div id="main_nav">
			<ul>
				<li><a class="main_nav_link" href="http://www.ztu.edu.cn">昭通学院首页</a></li>
				<li><a class="main_nav_link" href="<%=request.getContextPath()%>/channel/5">勤耕园</a></li>
				<li><a class="main_nav_link" href="<%=request.getContextPath()%>/admin">后台管理</a></li>
				<li><a class="main_nav_link" href="mailto:${baseInfo.email}">联系我们</a></li>
			</ul>
		</div>
		<div id="search">
			<input type="text" id="search_con" value="Search.." />
			<div id="search_btn"></div>
		</div>
	</div>
</div>
<div id="nav">
	<div id="nav_con">
		<ul>
			<li><span href="<%=request.getContextPath()%>/index">附中首页</span></li>
			<#list navs as nav>
				<li>
				<#if nav.customLink==0>
					<span href="<%=request.getContextPath()%>/channel/${nav.id}">${nav.name}</span>
				<#else>
					<span href="${nav.customLinkUrl}">${nav.name}</span>
				</#if>
				</li>
			</#list>
		</ul>
	</div>
</div>