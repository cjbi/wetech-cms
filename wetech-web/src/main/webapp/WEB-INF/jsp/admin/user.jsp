<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- content start --%>
<div class="admin-content">
	<div class="admin-content-body">
		<div class="am-cf am-padding am-padding-bottom-0">
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">用户管理</strong> / <small>用户信息管理</small>
			</div>
		</div>
		<hr>
		<div class="am-g">
			<div class="am-u-sm-12 am-u-md-5">
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
			<div class="am-u-sm-12 am-u-md-2">
				<div class="am-form-group">
					<label>组</label>
					<select name=gId id="gId" data-am-selected="{btnSize: 'sm'}">
						<option></option>
					<c:forEach var="group" items="${groups }">
						<option value="${group.id }">${group.name }</option>
					</c:forEach>
					</select>
				</div>
			</div>
			<div class="am-u-sm-12 am-u-md-2">
				<div class="am-form-group">
					<label>角色</label>
					<select name="rId" id="rId" data-am-selected="{btnSize: 'sm'}">
						<option></option>
					<c:forEach var="role" items="${roles }">
						<option value="${role.id }">${role.name }</option>
					</c:forEach>
					</select>
				</div>
			</div>
			<div class="am-u-sm-12 am-u-md-3">
				<div class="am-input-group am-input-group-sm am-input-group-default">
					<span class="am-input-group-btn">
						<select name="searchCode" id="searchCode" data-am-selected="{btnWidth: '100%',btnSize: 'sm',btnStyle:'default'}">
								<option value="id">用户 ID</option>
								<option value="username">用户名称</option>
								<option value="nickname">用户昵称</option>
						</select>
					</span>
						<input type="text" name="searchValue" id="searchValue" class="am-form-field">
					<span class="am-input-group-btn">
						<button class="am-btn am-btn-default" onclick="reloadTable();" type="button"><span class="am-icon-search"></span></button>
					</span>
				</div>
			</div>
		</div>
		<div class="am-u-sm-12">
			<table class="am-table am-table-striped  am-table-hover table-main am-table-bordered am-table-compact am-text-nowrap" width="100%" id="example">
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
	<%-- footer start --%>
	<jsp:include page="/jsp/admin/footer.jsp" />
	<%-- footer end --%>
</div>
<%-- content end --%>
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
	<form class="am-form am-form-horizontal" id="edit-form">
		<br> <input type="hidden" name="id"> <input type="hidden" name="password">
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
					<label class="am-checkbox-line"> <input type="checkbox" name="roleIds" value="${role.id }" readonly />${role.name }
					</label>
				</c:forEach>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">用户组</label>
			<div class="am-u-sm-10">
				<c:forEach var="group" items="${groups }">
					<label class="am-checkbox-line"> <input type="checkbox" name="groupIds" value="${group.id }" readonly />${group.name }
					</label>
				</c:forEach>
			</div>
		</div>
	</form>
</div>
<%-- 直接在标签内加载js资源会阻塞浏览器主线程，最终影响用户体验，不推荐这么用 --%>
<%-- 主线程中同步的 XMLHttpRequest 已不推荐使用，因其对终端用户的用户体验存在负面影响。更多帮助请见 http://xhr.spec.whatwg.org/ --%>
<%-- Synchronous XMLHttpRequest on the main thread is deprecated because of its detrimental effects to the end user's experience. For more help, check https://xhr.spec.whatwg.org/.  --%>
<script type="text/javascript">
	$.getScript("<%=request.getContextPath()%>/resources/js/admin/user.js");
</script>