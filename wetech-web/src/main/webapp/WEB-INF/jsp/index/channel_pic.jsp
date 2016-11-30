<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>Channel Page | ${baseInfo.name}</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="alternate icon" type="image/png" href="<%=request.getContextPath()%>/resources/assets/i/favicon.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/index/web.cms.css" />
</head>
<body class="am-with-topbar-fixed-top">
	<jsp:include page="/jsp/template/top.jsp" />
	<!-- channel_pic start -->
	建设中。。。
	<!-- channel_pic end-->
	<jsp:include page="/jsp/template/bottom.jsp" />
	<script src="<%=request.getContextPath()%>/resources/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/js/amazeui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
</body>
</html>