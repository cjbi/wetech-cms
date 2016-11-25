<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <input type="hidden" id="ctx" value="<%=request.getContextPath()%>"/>
<div id="header">
	<div id="header_con">
		<div id="logo"></div>
		<div id="main_nav">
			<ul>
				<li><a class="main_nav_link" href="http://www.baidu.com">百度首页</a></li>
				<li><a class="main_nav_link" href="<%=request.getContextPath()%>/channel/5">勤耕园</a></li>
				<li><a class="main_nav_link" href="<%=request.getContextPath()%>/admin">后台管理</a></li>
				<li><a class="main_nav_link" href="mailto:cjbi@outlook.com">联系我们</a></li>
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
			<li><span href="<%=request.getContextPath()%>/index">首页</span></li>
				<li>
					<span href="<%=request.getContextPath()%>/channel/7">网站介绍</span>
				</li>
				<li>
					<span href="">军事</span>
				</li>
				<li>
					<span href="<%=request.getContextPath()%>/channel/2">财经</span>
				</li>
				<li>
					<span href="<%=request.getContextPath()%>/channel/3">新闻</span>
				</li>
				<li>
					<span href="http://163.com">网易</span>
				</li>
				<li>
					<span href="<%=request.getContextPath()%>/channel/30">测试</span>
				</li>
		</ul>
	</div>
</div>