<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎使用附中网站后台管理程序</title>
</head>
<frameset cols="*,1035,*"  border="0" frameborder="0" frameSpacing="0" scrolling="false">
	<frame src="<%=request.getContextPath() %>/resources/admin/background.html" frameSpacing="0">
	<frameset rows="110,*" frameborder="0" noresize frameSpacing="0">
		<frame name="top" src="<%=request.getContextPath() %>/jsp/admin/top.jsp" frameborder="0" frameSpacing="0"/>
		<frameset cols="164,*" frameborder="0" frameSpacing="0">
			<frame name="nav" src="<%=request.getContextPath() %>/jsp/admin/nav.jsp" frameborder="0"/>
			<frame name="content" src="<%=request.getContextPath() %>/resources/admin/01.html" frameborder="0"/>
		</frameset>
	</frameset>
	<frame src="<%=request.getContextPath() %>/resources/admin/background.html" frameSpacing="0">
</frameset>
</html>