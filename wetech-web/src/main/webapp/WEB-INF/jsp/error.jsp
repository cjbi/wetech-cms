<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发生错误</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/error.css" />
</head>
<body>
<div id="container">
	<div id = "error">
		<span>出现错误</span>
		<div id="message"><span class="errorContainer">${exception.message }</span></div>
		<div id="upPage"><a href="javascript:history.go(-1)">返回上一页</a></div>
	</div>
</div>
</body>
</html>