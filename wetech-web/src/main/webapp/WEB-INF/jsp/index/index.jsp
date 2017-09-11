<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
	<title>${baseInfo.name} <c:if test="${not empty baseInfo.name2}">|</c:if> ${baseInfo.name2}</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="alternate icon" type="image/png" href="<%=request.getContextPath()%>/resources/amazeui/assets/i/favicon.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/index/cms.css" />
<style type="text/css">
.am-list-item-text {
    line-height: 1.4;
    font-size: 1.4rem;
    color: #999;
    margin: 0;
}
</style>
</head>
<body class="am-with-topbar-fixed-top">
	<%-- top start --%>
	<jsp:include page="/jsp/template/header.jsp" />
	<%-- top end --%>
	<%-- content start --%>
	<jsp:include page="/jsp/template/body.jsp" />
	<%-- content end --%>
	<%-- Link start--%>
	<jsp:include page="/jsp/template/cmsLink.jsp" />
	<%-- Link end--%>
	<%-- Footer start --%>
	<jsp:include page="/jsp/template/footer.jsp" />
	<%-- Footer end --%>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/cms.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/index.js"></script>
</body>
</html>
