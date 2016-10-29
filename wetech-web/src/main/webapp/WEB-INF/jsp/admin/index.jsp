<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js fixed-layout">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>后台管理</title>
<meta name="description" content="后台管理">
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/resources/assets/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/admin.css">
</head>
<body>

	<!-- header start -->
	<jsp:include page="/jsp/admin/header.jsp"/>
	<!-- header end -->

	<div class="am-cf admin-main">
		<!-- sidebar start -->
		<jsp:include page="/jsp/admin/sidebar.jsp" />
		<!-- sidebar end -->

		<!-- content start -->

		<div class="admin-content">
			<div class="admin-content-body">
				<div class="am-cf am-padding">
					<div class="am-fl am-cf">
						<strong class="am-text-primary am-text-lg">仪表盘</strong> / <small>没有内容</small>
					</div>
				</div>
			</div>
			<!-- footer start -->
			<jsp:include page="/jsp/admin/footer.jsp" />
			<!-- footer end -->
		</div>
		<!-- content end -->

	</div>

	<script src="<%=request.getContextPath()%>/resources/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/js/app.js"></script>
</body>
</html>

