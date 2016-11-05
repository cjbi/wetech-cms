<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><html class="no-js fixed-layout">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>用户信息管理</title>
<meta name="description" content="这是一个 index 页面">
<meta name="keywords" content="index">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/resources/assets/i/app-icon72x72@2x.png">
<meta name="apple-mobile-web-app-title" content="Amaze UI" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/app.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/amazeui.datatables.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/assets/css/admin.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/layer/skin/layer.css">
</head>
<body>
	<!-- header start -->
	<jsp:include page="/jsp/admin/header.jsp" />
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
						<strong class="am-text-primary am-text-lg">用户管理</strong> / <small>用户信息管理</small>
					</div>
				</div>
				<hr>
				<!-- <div class="am-g">
					<div class="am-u-sm-12 am-u-md-6">
						<div class="am-btn-toolbar">
							<div class="am-btn-group am-btn-group-xs">
								<button type="button" class="am-btn am-btn-default" onclick="add()">
									<span class="am-icon-plus"></span> 新增
								</button>
								<button type="button" class="am-btn am-btn-default" onclick="edit()">
									<span class="am-icon-edit"></span> 修改
								</button>
								<button type="button" class="am-btn am-btn-default" onclick="del()">
									<span class="am-icon-trash-o"></span> 删除
								</button>
							</div>
						</div>
					</div>
					<div class="am-u-sm-12 am-u-md-3">
						<div class="am-form-group">
							<select data-am-selected="{btnSize: 'sm'}">
								<option value="option1">用户标识</option>
								<option value="option1">用户名称</option>
								<option value="option1">用户昵称</option>
								<option value="option1">用户状态</option>
								<option value="option1">用户邮箱</option>
								<option value="option1">用户操作</option>
							</select>
						</div>
					</div>
					<div class="am-u-sm-12 am-u-md-3">
						<div class="am-input-group am-input-group-sm">
							<input type="text" class="am-form-field"> <span class="am-input-group-btn">
								<button class="am-btn am-btn-default" type="button">搜索</button>
							</span>
						</div>
					</div>
				</div> -->
				<div class="am-u-sm-12">
					<table class="am-table am-table-striped am-table-bordered am-table-compact am-text-nowrap" width="100%" id="example">
						<thead>
							<tr>
								<th><input type="checkbox" id='checkAll'></th>
								<th>用户 ID</th>
								<th>用户名称</th>
								<th>用户昵称</th>
								<th>用户状态</th>
								<th>用户邮箱</th>
								<th>用户电话</th>
								<th>创建时间</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<!-- footer start -->
			<jsp:include page="/jsp/admin/footer.jsp" />
			<!-- footer end -->
		</div>
		<!-- content end -->
	</div>
	<div id="add-modal">
		<form class="am-form am-form-horizontal" id="add-form">
			<br>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">用户名</label>
				<div class="am-u-sm-10">
					<input type="text" id="" name="username" placeholder="必须是英文(必填)" minlength="3" required>
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">显示名称</label>
				<div class="am-u-sm-10">
					<input type="text" id="" name="nickname" placeholder="可以是中文">
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">用户密码</label>
				<div class="am-u-sm-10">
					<input type="password" name="password" id="password" placeholder="设置一个密码(必填)" required>
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">确认密码</label>
				<div class="am-u-sm-10">
					<input type="password" name="confirmPwd" placeholder="确认你的密码(必填)" data-equal-to="#password" required>
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">联系电话</label>
				<div class="am-u-sm-10">
					<input type="tel" name="phone" placeholder="输入联系电话">
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">电子邮件</label>
				<div class="am-u-sm-10">
					<input type="email" name="email" id="email" placeholder="输入电子邮件(格式：xxx@xxx.com)">
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">状态</label>
				<div class="am-u-sm-3" style="float: left;">
					<select name="status">
						<option value="0" selected="selected">停用</option>
						<option value="1">启用</option>
					</select>
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">角色</label>
				<div class="am-u-sm-10">
					<c:forEach var="role" items="${roles }">
						<label class="am-checkbox-line"> <input type="checkbox" name="roleIds" value="${role.id }" />${role.name }
						</label>
					</c:forEach>
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">用户组</label>
				<div class="am-u-sm-10">
					<c:forEach var="group" items="${groups }">
						<label class="am-checkbox-line"> <input type="checkbox" name="groupIds" value="${group.id }" />${group.name }
						</label>
					</c:forEach>
				</div>
			</div>
		</form>
	</div>
	<div id="edit-modal">
		<form class="am-form am-form-horizontal" id="add-form">
			<br> 
			<input type="hidden" name="id">
			<input type="hidden" name="password">
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">用户名</label>
				<div class="am-u-sm-10">
					<input type="text" name="username" placeholder="必须是英文(必填)" disabled>
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">显示名称</label>
				<div class="am-u-sm-10">
					<input type="text" name="nickname" placeholder="可以是中文">
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">联系电话</label>
				<div class="am-u-sm-10">
					<input type="tel" name="phone" placeholder="输入联系电话">
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">电子邮件</label>
				<div class="am-u-sm-10">
					<input type="email" name="email" id="email" placeholder="输入电子邮件">
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">状态</label>
				<div class="am-u-sm-3" style="float: left;">
					<select name="status">
						<option value="0" selected="selected">停用</option>
						<option value="1">启用</option>
					</select>
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">角色</label>
				<div class="am-u-sm-10">
					<c:forEach var="role" items="${roles }">
						<label class="am-checkbox-line"> <input type="checkbox" name="roleIds" value="${role.id }" readonly/>${role.name }
						</label>
					</c:forEach>
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">用户组</label>
				<div class="am-u-sm-10">
					<c:forEach var="group" items="${groups }">
						<label class="am-checkbox-line"> <input type="checkbox" name="groupIds" value="${group.id }" readonly/>${group.name }
						</label>
					</c:forEach>
				</div>
			</div>
		</form>
	</div>
	<script src="<%=request.getContextPath()%>/resources/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/layer/layer.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/js/amazeui.datatables.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/js/amazeui.datatables.plugin.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/js/dateFormat.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
	<script src="<%=request.getContextPath()%>/resources/assets/js/app.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/user.js"></script>
</body>
</html>
