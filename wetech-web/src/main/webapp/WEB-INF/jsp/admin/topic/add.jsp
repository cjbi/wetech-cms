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
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/js/base/jquery.ui.all.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/uploadify/uploadify.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/zTree/zTreeStyle.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/app.css">
<script>
    var contextPath = "${pageContext.request.contextPath}";
</script>
</head>
<input type="hidden" id="sid" value="<%=session.getId()%>" />
<div id="menuContent" class="menuContent" style="display: none; position: absolute; background: #fff; z-index: 999; border: 1px solid #999">
	<ul id="mytree" class="ztree" style="margin-top: 0;"></ul>
</div>
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
							<div class="am-u-sm-12 am-padding-0">
								<div class="am-u-sm-6">
									<input type="text" name="cname" id="cname" placeholder="指定你的文章所属栏目(必填)" required readonly>
								</div>
								<div class="am-u-sm-6">
									<input type="text" name="cid" id="cid" required readonly>
								</div>
							</div>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章状态</label>
						<div class="am-u-sm-8">
							<label class="am-checkbox-line"> <input type="radio" name="status" value="0" />未发布
							</label> <br> <label class="am-checkbox-line"> <input type="radio" name="status" value="1" checked />已发布
							</label>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">是否推荐该文章</label>
						<div class="am-u-sm-8">
							<label class="am-checkbox-line"> <input type="radio" name="recommend" value="0" checked />不推荐
							</label> <br> <label class="am-checkbox-line"> <input type="radio" name="recommend" value="1" />推荐
							</label>
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
							<input type="text" id="keyword" name="keyword" placeholder="请输入关键字，通过逗号或者回车确认(最多五个关键字，不能重复)">
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章附件</label>
						<div class="am-u-sm-4">
							<div id="attachs"></div>
							<input type="file" id="attach" name="attach" />
							<button type="button" class="am-btn am-btn-secondary am-btn-xs am-round" id="uploadFile">
								<span class="am-icon-cloud-upload"></span>&nbsp;上传文件
							</button>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">已传附件</label>
						<div class="am-u-sm-8">
							<table id="ok_attach" class="am-table am-table-bordered  am-table-striped am-table-hover" width="890px" cellpadding="0" cellspacing="0">
								<thead>
									<tr>
										<Td>文件名缩略图</Td>
										<td width="180">文件名</td>
										<td>文件大小</td>
										<td>主页图片</td>
										<td>栏目图片</td>
										<td>附件信息</td>
										<td width="160">操作</td>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章内容</label>
						<div class="am-u-sm-8">
							<textarea id="content" name="content" rows="10" required></textarea>
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
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/xheditor/jquery/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/ui/jquery-ui-1.10.0.custom.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/assets/js/amazeui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/layer/layer.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/xheditor/xheditor-1.1.14-zh-cn.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/tree/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/assets/js/app.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.keywordinput.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/uploadify/jquery.uploadify.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/js/dateFormat.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/admin/topic/add.js"></script>
</body>
</html>
