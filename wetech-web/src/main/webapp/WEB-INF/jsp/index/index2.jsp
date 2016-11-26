<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎访问${baseInfo.name }</title>
<meta http-equiv="keywords" content="昭通师专,昭通学院,昭通学院附中,昭通师专附中">   
<meta http-equiv="description" content="昭通学院附中网站,昭通师专附中网站">   
<!-- Date: 2013-09-04 -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/index/web.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery.cycle2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/index/main.js"></script>
<style type="text/css">
</style>
</head>
<body>
<jsp:include page="/jsp/template/top.jsp"/>	
<jsp:include page="/jsp/template/body.jsp"/>
<jsp:include page="/jsp/template/bottom.jsp"/>
</body>
</html>