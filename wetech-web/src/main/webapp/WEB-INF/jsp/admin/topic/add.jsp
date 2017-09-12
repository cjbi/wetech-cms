<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html class="no-js fixed-layout">
<head>
<meta charset="utf-8">
<title>新增文章</title>
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/amazeui/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/resources/amazeui/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/amazeui.upload.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/admin.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/layer/skin/default/layer.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/zTree/zTreeStyle.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/wangEditor/css/wangEditor.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/main.css">
<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>
</head>
<input type="hidden" id="sid" value="<%=session.getId()%>" />
<div id="menuContent" class="menuContent" style="display: none; position: absolute; background: #fff; z-index: 999; border: 1px solid #999">
	<ul id="mytree" class="ztree" style="margin-top: 0;"></ul>
</div>
<body>
	<div class="admin-content">
		<div class="admin-content-body">
			<div class="am-cf am-padding am-padding-bottom-0">
				<div class="am-fl am-cf">
					<strong class="am-text-primary am-text-lg">文章信息管理</strong> / <small>新增文章</small>
				</div>
			</div>
			<div class="am-u-sm-12">
				<form class="am-form am-form-horizontal">
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章标题</label>
						<div class="am-u-sm-8">
							<input name="title" type="text" placeholder="输入你的文章标题(必填)" required>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章栏目</label>
						<div class="am-u-sm-8 am-padding-0">
							<div class="am-u-sm-12">
								<input type="text" name="cname" id="cname" placeholder="指定你的文章所属栏目(必填)" required readonly><input type="hidden" name="cid" id="cid">
							</div>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章状态</label>
						<div class="am-u-sm-8">
							<label class="am-radio-inline"><input type="radio" name="status" value="0" />未发布</label>
							<label class="am-radio-inline"><input type="radio" name="status" value="1" checked />已发布</label>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">是否推荐该文章</label>
						<div class="am-u-sm-8">
							<label class="am-radio-inline"><input type="radio" name="recommend" value="0" checked />不推荐</label>
							<label class="am-radio-inline"><input type="radio" name="recommend" value="1" />推荐</label>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">发布时间</label>
						<div class="am-u-sm-8">
							<input type="text" class="am-form-field" value="" id="publishDate" name="publishDate" placeholder="日历组件" data-am-datepicker readonly required />
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章关键字</label>
						<div class="am-u-sm-8">
							<div class="am-u-sm-12 am-padding-0 am-dropdown" id="dropdown-search">
								<input type="text" id="dropdown-search-input" placeholder="请输入关键字进行检索，通过回车确认(最多五个关键字，不能重复)">
								<ul class="am-dropdown-content am-dropdown-search" id="dropdown-search-ul"></ul>
							</div>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章附件</label>
						<div class="am-u-sm-8" id="ok_attach">
							<div id="event"></div>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章内容</label>
						<div class="am-u-sm-8">
							<textarea id="content" rows="30" name="content"></textarea>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章摘要</label>
						<div class="am-u-sm-8">
							<textarea name="summary" required></textarea>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label"></label>
						<div class="am-u-sm-8 am-cf">
							<button type="button" id="submit" class="am-btn am-btn-primary am-radius am-fr">发表文章</button>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.upload.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.upload.template.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.upload.event.js"></script>
	<script src="<%=request.getContextPath()%>/resources/layer/layer.js"></script>
	<script src="<%=request.getContextPath()%>/resources/zTree/jquery.ztree.core-3.5.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/main.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/common/jquery.cms.keywordinput.js"></script>
	<script src="<%=request.getContextPath()%>/resources/wangEditor/js/wangEditor.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/common/wetech.common.js"></script>
	<script src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/topic/add.js"></script>
</body>
</html>
