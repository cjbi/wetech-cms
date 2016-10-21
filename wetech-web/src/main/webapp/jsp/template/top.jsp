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
				<li><a class="main_nav_link" href="mailto:11@111.com">联系我们</a></li>
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
				<li>
					<span href="<%=request.getContextPath()%>/channel/1">学校简介</span>
				</li>
				<li>
					<span href="<%=request.getContextPath()%>/channel/2">校园之窗</span>
				</li>
				<li>
					<span href="<%=request.getContextPath()%>/channel/3">教育科研</span>
				</li>
				<li>
					<span href="<%=request.getContextPath()%>/channel/4">德育园地</span>
				</li>
				<li>
					<span href="<%=request.getContextPath()%>/channel/8">师生风采</span>
				</li>
				<li>
					<span href="<%=request.getContextPath()%>/channel/22">学生工作</span>
				</li>
				<li>
					<span href="<%=request.getContextPath()%>/channel/18">学科资源</span>
				</li>
				<li>
					<span href="<%=request.getContextPath()%>/channel/28">校园文化</span>
				</li>
				<li>
					<span href="<%=request.getContextPath()%>/channel/13">党团工作</span>
				</li>
		</ul>
	</div>
</div>