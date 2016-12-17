<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html class="no-js fixed-layout">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>修改首页图片</title>
<meta name="description" content="这是一个 index 页面">
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/main.css">
<style type="text/css">
#clip {
	width: 100%;
	height: 400px;
}
</style>
<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>
</head>
<body>
	<input type="hidden" id="sid" value="<%=session.getId()%>" />
	<div class="admin-content">
		<div class="admin-content-body">
			<div class="am-cf am-padding am-padding-bottom-0">
				<div class="am-fl am-cf">
					<strong class="am-text-primary am-text-lg">文章信息管理</strong> / <small>新增文章</small>
				</div>
			</div>
			<br>
			<div class="am-center">
				<div id="clip"></div>
				<div class="am-margin-sm">
					<button type="button" class="am-btn am-btn-primary" id="toggle-file">上传图片</button>
					<button type="button" class="am-btn am-btn-primary" id="clipBtn">裁剪</button>
				</div>
			</div>
			<div class="am-u-sm-12">
				<form class="am-form am-form-horizontal" id="edit-form">
					<input type="hidden" value="${indexPic.id}" name="id"></input>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">图片预览</label>
						<div class="am-u-sm-10">
							<input class="am-hide" type="file" id="file"> <img class="am-img-circle am-img-thumbnail" src="<%=request.getContextPath()%>/resources/indexPic/${indexPic.newName}"
								id="img-view" />
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">首页图片标题</label>
						<div class="am-u-sm-10">
							<input type="text" value="${indexPic.title}" name="title" placeholder="请输入图片标题(必填)" minlength="3" required>
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">首页图片子标题</label>
						<div class="am-u-sm-10">
							<input type="text" value="${indexPic.subTitle}" name="subTitle" placeholder="请输入图片子标题"></input>
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">状态</label>
						<div class="am-u-sm-10">
							<c:if test="${indexPic.status eq 1}">
								<input name="status" type="radio" value="0" /> 未发布 <input name="status" type="radio" value="1" checked /> 已发布
						</c:if>
							<c:if test="${indexPic.status eq 0}">
								<input name="status" type="radio" value="0" checked /> 未发布 <input name="status" type="radio" value="1" /> 已发布
						</c:if>
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">链接类型</label>
						<div class="am-u-sm-10">
							<c:if test="${indexPic.linkType eq 1}">
								<input name="linkType" type="radio" value="0" /> 站内链接 <input name="linkType" type="radio" value="1" checked /> 站外链接
						</c:if>
							<c:if test="${indexPic.linkType eq 0}">
								<input name="linkType" type="radio" value="0" checked /> 站内链接 <input name="linkType" type="radio" value="1" /> 站外链接
						</c:if>
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">链接地址</label>
						<div class="am-u-sm-10">
							<input type="text" value="${indexPic.linkUrl}" name="linkUrl" placeholder="请输入链接地址(必填)" required></input>
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label"></label>
						<div class="am-u-sm-10 am-cf">
							<button type="button" id="submit" class="am-btn am-btn-primary am-radius am-fr">提交</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/photoClip/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/layer/layer.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/photoClip/iscroll-zoom.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/photoClip/hammer.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/photoClip/photoClip.min.js"></script>
	<script src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/main.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/indexPic/edit.js"></script>
</body>
</html>