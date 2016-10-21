<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<input type="hidden" id="contextPath" value="<%=request.getContextPath()%>"/>
<div id="top">
	<div id="topIntro">
		<span id="logo"></span>
		<span id="user_operator">
			<a href="<%=request.getContextPath()%>/index"  target="_blank">网站首页</a>
			|<a href="<%=request.getContextPath()%>/admin/user/showSelf"  target="content">查询个人信息</a>
			| <a href="<%=request.getContextPath()%>/admin/user/updateSelf"  target="content">修改个人信息</a>
			| <a href="<%=request.getContextPath()%>/admin/user/updatePwd"  target="content">修改密码</a>
			| <a href="javascript:exitSystem()">退出系统</a>
		</span>
	</div>
	<div id="remind">
		<span id="showDate">欢迎[${loginUser.nickname }]光临${baseInfo.name }后台管理程序。
		</span>
	</div>
</div>
