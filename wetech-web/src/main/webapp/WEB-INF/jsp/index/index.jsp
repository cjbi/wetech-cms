<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>Landing Page | Amaze UI Example</title>
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
	<!-- top start -->
	<jsp:include page="/jsp/template/top.jsp" />
	<!-- top end -->
	<!-- content start -->
	<jsp:include page="/jsp/template/body.jsp" />
	<!-- content end -->
	<!-- Link start-->
	<jsp:include page="/jsp/template/cmsLink.jsp" />
	<!-- Link end-->
	<!-- Footer start -->
	<jsp:include page="/jsp/template/bottom.jsp" />
	<!-- Footer end -->
	<!--[if lt IE 9]>
		<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
		<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
		<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
		<![endif]-->
	<!--[if (gte IE 9)|!(IE)]><!-->
	<script src="<%=request.getContextPath()%>/resources/assets/js/jquery.min.js"></script>
	<!--<![endif]-->
	<script src="<%=request.getContextPath()%>/resources/assets/js/amazeui.min.js"></script>
</body>
</html>
