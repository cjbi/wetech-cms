<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/amazeui.datatables.css" />
<%-- content start --%>
<div class="admin-content">
	<div class="admin-content-body">
		<div class="am-cf am-padding am-padding-bottom-0">
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">用户管理</strong> / <small>用户组管理</small>
			</div>
		</div>
		<hr>
		<div class="am-u-sm-12">
			<div class="am-panel am-panel-default">
				<div class="am-panel-hd">
					<span class="am-icon-recycle am-animation-scale-up"></span> 系统清理管理
				</div>
				<div class="am-tabs" data-am-tabs>
					<ul class="am-tabs-nav am-nav am-nav-tabs">
						<li class="am-active"><a href="#tab1">未引用的垃圾附件</a></li>
						<li><a href="#tab2">未引用的首页图片</a></li>
					</ul>
					<div class="am-tabs-bd">
						<div class="am-tab-panel am-fade am-in am-active" id="tab1">
							<div class="am-g am-g-fixed">
								<div class="am-u-sm-6">
									当前未引用的垃圾附件共<span id="attaCount" class="am-badge am-badge-warning am-round am-animation-slide-top">0</span>条
								</div>
								<div class="am-u-sm-6">
									<button id="cleanAtta" class="am-btn-xs am-btn-danger am-round am-animation-fade">
										<i class="am-icon-trash-o"></i> 清理
									</button>
								</div>
							</div>
							<hr>
							<table class="am-table am-table-striped  am-table-hover table-main am-table-bordered am-table-compact am-text-nowrap" width="100%" id="example">
								<thead>
									<tr>
										<th>文件 ID</th>
										<th>原文件名</th>
										<th>新文件名</th>
										<th>大小</th>
										<th>类型</th>
									</tr>
								</thead>
							</table>
						</div>
						<div class="am-tab-panel am-fade" id="tab2">
							<div class="am-g am-g-fixed">
								<div class="am-u-sm-6">当前未引用的首页图片共<span id="indexPicCount" class="am-badge am-badge-warning am-round am-animation-slide-top">0</span>条</div>
								<div class="am-u-sm-6">
									<button id="cleanIndexPic" class="am-btn-xs am-btn-danger am-round am-animation-fade">
										<i class="am-icon-trash-o"></i> 清理
									</button>
								</div>
							</div>
							<hr>
							<table class="am-table am-table-striped am-table-hover table-main am-table-bordered am-table-compact am-text-nowrap dataTable no-footer">
								<thead>
									<tr>
										<th>缩略图</th>
										<th>名称</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%-- footer start --%>
	<jsp:include page="/jsp/admin/footer.jsp" />
	<%-- footer end --%>
</div>
<%-- content end --%>
<script type="text/javascript">
	$.getScript("<%=request.getContextPath()%>/resources/js/admin/system/clean.js");
</script>