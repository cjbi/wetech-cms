<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- content start --%>
<div class="admin-content">
	<div class="admin-content-body">
		<div class="am-cf am-padding am-padding-bottom-0">
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">系统配置</strong> / <small>网站数据备份</small>
			</div>
		</div>
		<hr>
		<div class="am-g">
			<div class="am-u-sm-12 am-u-md-6">
				<div class="am-btn-toolbar">
					<div class="am-btn-group am-btn-group-xs">
						<button type="button" class="am-btn am-btn-default" onclick="add()">
							<span class="am-icon-plus-square am-animation-fade"></span> 备份数据库
						</button>
					</div>
				</div>
			</div>
		</div>
		<div class="am-u-sm-12 am-cf am-padding am-padding-bottom-0">
			<div class="am-panel am-panel-default">
				<div class="am-panel-hd">
					<span class="am-icon-refresh am-animation-spin"></span> 网站数据备份
				</div>
				<table class="am-table am-table-striped am-table-hover table-main am-table-bordered am-table-compact am-text-nowrap dataTable no-footer">
					<thead>
						<tr>
							<th>备份文件名称</th>
							<th>文件大小</th>
							<th>备份时间</th>
							<th>文件类型</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
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
			<label class="am-u-sm-2 am-form-label" for="doc-ipt-email-1">输入备份的文件名</label>
			<div class="am-u-sm-10">
				<input type="text" id="doc-ipt-email-1" name="name" placeholder="请输入备份的文件名称(必填)" minlength="3" required>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript">
	$.getScript("<%=request.getContextPath()%>/resources/js/admin/backup.js");
</script>