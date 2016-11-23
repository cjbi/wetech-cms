<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- content start -->
<div class="admin-content">
	<div class="admin-content-body">
		<div class="am-cf am-padding am-padding-bottom-0">
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">用户管理</strong> / <small>用户角色管理</small>
			</div>
		</div>
		<hr>
		<div class="am-g">
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
						<option value="id">角色 ID</option>
						<option value="name">角色名称</option>
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
		</div>
		<div class="am-u-sm-12">
			<table class="am-table am-table-striped  am-table-hover table-main am-table-bordered am-table-compact am-text-nowrap" width="100%" id="example">
				<thead>
					<tr>
						<th><input type="checkbox" id='checkAll'></th>
						<th>角色 ID</th>
						<th>角色名称</th>
						<th>角色类型</th>
						<th>角色操作</th>
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
<div id="add-modal">
	<form class="am-form am-form-horizontal" id="add-form">
		<br>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">角色名称</label>
			<div class="am-u-sm-10">
				<input type="text" id="" name="name" placeholder="角色名称(必填)" minlength="3" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">角色名称</label>
			<div class="am-u-sm-10">
				<select name="roleType">
					<label class="am-checkbox-line"> <c:forEach var="type" items="${types }">
							<option value="${type }">${type }</option>
						</c:forEach>
				</label>
				</select>
			</div>
		</div>
	</form>
</div>
<div id="edit-modal">
	<form class="am-form am-form-horizontal" id="edit-form">
		<br> <input type="hidden" name="id">
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">角色名称</label>
			<div class="am-u-sm-10">
				<input type="text" name="name" placeholder="角色名称(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">角色名称</label>
			<div class="am-u-sm-10">
				<select name="roleType">
					<label class="am-checkbox-line"> <c:forEach var="type" items="${types }">
							<option value="${type }">${type }</option>
						</c:forEach>
				</label>
				</select>
			</div>
		</div>
</div>
<script type="text/javascript">
	$.getScript("<%=request.getContextPath()%>/resources/js/admin/role.js");
</script>