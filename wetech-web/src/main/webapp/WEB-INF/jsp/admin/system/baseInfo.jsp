<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- content start -->
<div class="admin-content">
	<div class="admin-content-body">
		<div class="am-cf am-padding am-padding-bottom-0">
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">系统配置</strong> / <small>网站信息管理</small>
			</div>
		</div>
		<hr>
		<div class="am-u-sm-12">
			<div class="am-panel am-panel-default">
				<div class="am-panel-hd">
					<span class="am-icon-cog am-animation-spin"></span> 修改网站信息功能
				</div>
				<table class="am-table  am-table-bordered">
					<tbody>
						<tr>
							<td class="am-text-right">网站名称：</td>
							<td>${baseInfo.name }</td>
						</tr>
						<tr>
							<td class="am-text-right">网站所在地址：</td>
							<td>${baseInfo.address }</td>
						</tr>
						<tr>
							<td class="am-text-right">邮政编码：</td>
							<td>${baseInfo.zipCode }</td>
						</tr>
						<tr>
							<td class="am-text-right">联系电话：</td>
							<td>${baseInfo.phone }</td>
						</tr>
						<tr>
							<td class="am-text-right">网站联系邮箱：</td>
							<td>${baseInfo.email }</td>
						</tr>
						<tr>
							<td class="am-text-right">网站访问域名：</td>
							<td>${baseInfo.domainName }</td>
						</tr>
						<tr>
							<td class="am-text-right">网站备案号：</td>
							<td>${baseInfo.recordCode }</td>
						</tr>
						<tr>
							<td class="am-text-right">首页图片宽度：</td>
							<td>${baseInfo.indexPicWidth }</td>
						</tr>
						<tr>
							<td class="am-text-right">首页图片高度：</td>
							<td>${baseInfo.indexPicHeight }</td>
						</tr>
					</tbody>
				</table>
				<div class="am-panel-footer">
					<div class="am-u-sm-3 am-u-sm-centered ">
						<button type="button" id="setBaseInfo" class="am-btn am-btn am-btn-primary am-radius">修改网站基本信息</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer start -->
	<jsp:include page="/jsp/admin/footer.jsp" />
	<!-- footer end -->
</div>
<!-- content end -->

<!-- 隐藏的模态框 -->
<div id="edit-modal">
	<form class="am-form am-form-horizontal" id="edit-form">
		<br>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">网站名称</label>
			<div class="am-u-sm-10">
				<input type="text" name="name" value="${baseInfo.name }" placeholder="请输入网站名称(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">网站所在地址</label>
			<div class="am-u-sm-10">
				<input type="text" name="address" value="${baseInfo.address }" placeholder="请输入网站所在地址(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">邮政编码</label>
			<div class="am-u-sm-10">
				<input type="text" name="zipCode" value="${baseInfo.zipCode }" placeholder="请输入邮政编码(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">联系电话</label>
			<div class="am-u-sm-10">
				<input type="text" name="phone" value="${baseInfo.phone }" placeholder="请输入联系电话(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">网站联系邮箱</label>
			<div class="am-u-sm-10">
				<input type="text" name="email" value="${baseInfo.email }" placeholder="请输入网站联系邮箱(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">网站访问域名</label>
			<div class="am-u-sm-10">
				<input type="text" name="domainName" value="${baseInfo.domainName }" placeholder="请输入网站访问域名(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">网站备案号</label>
			<div class="am-u-sm-10">
				<input type="text" name="recordCode" value="${baseInfo.recordCode }" placeholder="请输入网站备案号(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">首页图片宽度</label>
			<div class="am-u-sm-10">
				<input type="text" name="indexPicWidth" value="${baseInfo.indexPicWidth }" placeholder="请输入首页图片宽度(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-2 am-form-label">首页图片高度</label>
			<div class="am-u-sm-10">
				<input type="text" name="indexPicHeight" value="${baseInfo.indexPicHeight }" placeholder="请输入首页图片高度(必填)" required>
			</div>
		</div>
	</form>
</div>
<script type="text/javascript">
	$.getScript("<%=request.getContextPath()%>/resources/js/admin/system/baseInfo.js");
</script>