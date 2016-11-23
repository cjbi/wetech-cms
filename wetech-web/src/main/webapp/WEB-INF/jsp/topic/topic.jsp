<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- content start -->
<div class="admin-content">
	<div class="admin-content-body">
		<div class="am-cf am-padding am-padding-bottom-0">
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">文章管理</strong> / <small>文章信息管理</small>
			</div>
		</div>
		<hr>
		<div class="am-g">
			<div class="am-u-sm-12 am-u-md-6">
				<div class="am-btn-toolbar">
					<div class="am-btn-group am-btn-group-xs">
						<button type="button" class="am-btn am-btn-default" id="add">
							<span class="am-icon-plus"></span> 新增
						</button>
						<button type="button" class="am-btn am-btn-default" id="edit">
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
					<select data-am-selected="{searchBox: 1}">
						<c:forEach var="c" items="${cs }">
							<option value="${c.id}">${c.name}</option>
						</c:forEach>
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
						<th>文章 ID</th>
						<th>文章标题</th>
						<th>文章作者</th>
						<th>是否推荐</th>
						<th>所属频道</th>
						<th>文章状态</th>
						<th>发布日期</th>
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
<script type="text/javascript">
	$.getScript("<%=request.getContextPath()%>/resources/js/topic/topic.js");
</script>