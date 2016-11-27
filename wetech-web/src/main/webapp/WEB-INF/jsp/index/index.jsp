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
<style>
.cms-footer {
	padding: 3rem 0 2rem 0;
	margin-top: 5rem;
	background-color: #2d3e50;
	color: #fff !important;
}

.cms-icon {
	width: 3.4rem;
	border: 1px solid #e5e5e5;
	padding: 0.5rem;
	color: #fff;
}

.cms-footer a {
	color: #fff;
}

.cms-text-center {
	color: #7f8c8d;
	text-align: center;
}

.am-container {
	max-width: 1200px;
}

.am-g-fixed {
	max-width: 1200px;
}

.am-article {
	padding: 30px 0;
}

.am-panel-group {
	padding-top: 20px;
}
</style>
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
