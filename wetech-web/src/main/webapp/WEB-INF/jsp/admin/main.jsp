<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js fixed-layout">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>后台管理 | ${baseInfo.name}</title>
<meta name="description" content="后台管理">
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/amazeui/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/resources/amazeui/assets/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/amazeui.datatables.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/admin.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/layer/skin/default/layer.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/zTree/zTreeStyle.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/main.css">
</head>
<body>
	<%-- header start --%>
	<jsp:include page="/jsp/admin/header.jsp" />
	<%-- header end --%>
	<div class="am-cf admin-main">
		<%-- sidebar start --%>
		<jsp:include page="/jsp/admin/sidebar.jsp" />
		<%-- sidebar end --%>
		<%-- content start --%>
		<content id="admin-content">
		<div class="admin-content">
			<div class="admin-content-body">
				<div class="am-cf am-padding am-padding-bottom-0">
					<div class="am-fl am-cf">
						<strong class="am-text-primary am-text-lg">仪表盘</strong> / <small>没有内容</small>
					</div>
				</div>
			</div>
			<%-- footer start --%>
			<jsp:include page="/jsp/admin/footer.jsp" />
			<%-- footer end --%>
			<%-- content end --%>
		</div>
		</content>
	</div>
	
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.datatables.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.datatables.plugin.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
	<script src="<%=request.getContextPath()%>/resources/layer/layer.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/zTree/jquery.ztree.core-3.5.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/common/wetech.common.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/main.js"></script>
</body>
</html>
