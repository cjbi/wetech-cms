<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/amazeui.datatables.css" />
<%-- content start --%>
<div class="admin-content">
	<div class="admin-content-body">
		<div class="am-cf am-padding am-padding-bottom-0">
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">系统配置</strong> / <small>超级链接管理</small>
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
						<option value="id">组 ID</option>
						<option value="name">组名称</option>
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
						<th>链接 ID</th>
						<th>标题</th>
						<th>超链接</th>
						<th>类型</th>
						<th>打开方式</th>
						<th>排序</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<%-- footer start --%>
	<jsp:include page="/jsp/admin/footer.jsp" />
	<%-- footer end --%>
</div>
<%-- content end --%>
<div id="add-modal">
	<form class="am-form am-form-horizontal" id="add-form">
		<br>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">超链接标题</label>
			<div class="am-u-sm-10">
				<input type="text" name="title" placeholder="请输入超链接标题(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">超链接地址</label>
			<div class="am-u-sm-10">
				<input type="text" name="url" placeholder="请输入超链接地址">
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">超链接类别</label>
			<div class="am-u-sm-10">
				<div class="am-padding-0  am-u-sm-3">
					<select id="add-type">
						<option value="0">请选择类型</option>
					</select>
					</div>
					<div class="am-padding-right-0  am-u-sm-9">
						<input type="text" id="" name="type" placeholder="输入超链接类别" required readonly>
					</div>
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">打开方式</label>
				<div class="am-u-sm-10">
					<label class="am-radio-inline"> <input type="radio" value="0" name="newWin" checked>本窗口
					</label> <label class="am-radio-inline"> <input type="radio" value="1" name="newWin">新窗口
					</label>
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">链接标签ID</label>
				<div class="am-u-sm-10">
					<input type="text" name="urlId" placeholder="请输入链接标签ID">
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">链接标签类别</label>
				<div class="am-u-sm-10">
					<input type="text" name="urlClass" placeholder="请输入链接标签类别">
				</div>
			</div>
	</form>
</div>
<div id="edit-modal">
	<form class="am-form am-form-horizontal" id="edit-form">
		<br> <input type="hidden" name="id"><input type="hidden" name="pos">
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">超链接标题</label>
			<div class="am-u-sm-10">
				<input type="text" name="title" placeholder="请输入超链接标题(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">超链接地址</label>
			<div class="am-u-sm-10">
				<input type="text" name="url" placeholder="请输入超链接地址">
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">超链接类别</label>
			<div class="am-u-sm-10">
				<div class="am-padding-0  am-u-sm-3">
					<select id="edit-type">
						<option value="0">请选择类型</option>
					</select>
					</div>
					<div class="am-padding-right-0  am-u-sm-9">
						<input type="text" name="type" placeholder="输入超链接类别" required readonly>
					</div>
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">打开方式</label>
				<div class="am-u-sm-10">
					<label class="am-radio-inline"> <input type="radio" value="0" name="newWin" checked>本窗口
					</label> <label class="am-radio-inline"> <input type="radio" value="1" name="newWin">新窗口
					</label>
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">链接标签ID</label>
				<div class="am-u-sm-10">
					<input type="text" name="urlId" placeholder="请输入链接标签ID">
				</div>
			</div>
			<div class="am-form-group">
				<label class="am-u-sm-2 am-form-label">链接标签类别</label>
				<div class="am-u-sm-10">
					<input type="text" name="urlClass" placeholder="请输入链接标签类别">
				</div>
			</div>
	</form>
</div>
<script type="text/javascript">
	$.getScript("<%=request.getContextPath()%>/resources/js/admin/cmsLink.js");
</script>