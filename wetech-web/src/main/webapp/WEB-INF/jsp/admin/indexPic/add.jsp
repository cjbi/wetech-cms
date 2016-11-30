<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html class="no-js fixed-layout">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>新增文章</title>
<meta name="description" content="这是一个 index 页面">
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/resources/assets/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/amazeui.datatables.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/admin.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/layer/skin/default/layer.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/js/base/jquery.ui.all.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/jcrop/css/jquery.Jcrop.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/uploadify/uploadify.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/app.css">
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
			<div class="am-u-sm-12">
				<form class="am-form am-form-horizontal" id="add-form">
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">上传图片</label>
						<div class="am-u-sm-10">
							<input type="file" id="indexPic" name="indexPic" />
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">图片预览</label>
						<div class="am-u-sm-10">
							<div id="indexPicView"></div>
							<input id="newName" name="newName" readonly required /> <br>
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">首页图片标题</label>
						<div class="am-u-sm-10">
							<input type="text" id="" name="title" placeholder="请输入图片标题(必填)" minlength="3" required>
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">首页图片子标题</label>
						<div class="am-u-sm-10">
							<input type="text" id="" name="subTitle" placeholder="请输入图片子标题"></input>
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">状态</label>
						<div class="am-u-sm-10">
							<input name="status" type="radio" value="0" /> 未发布 <input name="status" type="radio" value="1" checked /> 已发布
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">状态</label>
						<div class="am-u-sm-10">
							<input name="linkType" type="radio" value="0" /> 站内链接 <input name="linkType" type="radio" value="1" checked /> 站外链接
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">链接地址</label>
						<div class="am-u-sm-10">
							<input type="text" id="" name="linkUrl" placeholder="请输入链接地址(必填)"></input>
						</div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label"></label>
						<div class="am-u-sm-10 am-cf">
							<button type="button" id="submit" class="am-btn am-btn-primary am-radius am-fr">发表文章</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/xheditor/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/assets/js/amazeui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/layer/layer.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/uploadify/jquery.uploadify.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/jcrop/js/jquery.Jcrop.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/assets/js/app.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/js/dateFormat.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/admin/indexPic/add.js"></script>
</body>
</html>