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
						<button type="button" class="am-btn am-btn am-btn-primary am-radius">修改网站基本信息</button>
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
<div id="rAdd-modal">
	<form class="am-form am-form-horizontal" id="add-form">
		<br> <input type="hidden" name="pId">
		<div class="am-form-group">
			<label class="am-u-sm-3 am-form-label">上级节点</label>
			<div class="am-u-sm-9">
				<input type="text" name="pName" placeholder="上级节点不存在" readonly>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-3 am-form-label">栏目名称</label>
			<div class="am-u-sm-9">
				<input type="text" name="name" placeholder="栏目的名称(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-3 am-form-label">是否叶子节点</label>
			<div class="am-u-sm-9">
				<label class="am-radio-inline"><input type="radio" name="isLeaf" value="1"> 是</label> <label class="am-radio-inline"><input
					type="radio" name="isLeaf" value="0" checked> 否</label>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-3 am-form-label">栏目类型</label>
			<div class="am-u-sm-9">
				<select name="type" required>
					<c:forEach var="type" items="${types}">
						<option value='${type.key}'>${type.value}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-3 am-form-label">是否指定链接</label>
			<div class="am-u-sm-9">
				<label class="am-radio-inline"><input type="radio" name="customLink" value="1"> 是</label> <label class="am-radio-inline"><input
					type="radio" name="customLink" value="0" checked> 否</label>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-3 am-form-label">链接地址</label>
			<div class="am-u-sm-9">
				<input type="text" name="customLinkUrl" placeholder="链接的地址">
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-3 am-form-label">是否主页显示</label>
			<div class="am-u-sm-9">
				<label class="am-radio-inline"><input type="radio" name="isIndex" value="1"> 是</label> <label class="am-radio-inline"><input
					type="radio" name="isIndex" value="0" checked> 否</label>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-3 am-form-label">是否为导航顶部栏目</label>
			<div class="am-u-sm-9">
				<label class="am-radio-inline"><input type="radio" name="isTopNav" value="1"> 是</label> <label class="am-radio-inline"><input
					type="radio" name="isTopNav" value="0" checked> 否</label>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-3 am-form-label">是否为推荐栏目</label>
			<div class="am-u-sm-9">
				<label class="am-radio-inline"><input type="radio" name="recommend" value="1"> 是</label> <label class="am-radio-inline"><input
					type="radio" name="recommend" value="0" checked> 否</label>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-3 am-form-label">是否启用</label>
			<div class="am-u-sm-9">
				<label class="am-radio-inline"><input type="radio" name="status" value="1"> 是</label> <label class="am-radio-inline"><input
					type="radio" name="status" value="0" checked> 否</label>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-3 am-form-label">导航序号</label>
			<div class="am-u-sm-9">
				<input type="text" name="navOrder" placeholder="前台导航显示的顺序(必填)" required>
			</div>
		</div>
		<div class="am-form-group">
			<label class="am-u-sm-3 am-form-label">栏目描述</label>
			<div class="am-u-sm-9">
				<textarea name="descn" placeholder="栏目的描述信息" maxlength="100"></textarea>
			</div>
		</div>
	</form>
</div>
<!-- 隐藏的右键菜单 -->
<div id="rMenu">
	<ul class="am-dropdown-content">
		<li><a href="#" id="rAdd-curr">新增同级节点</a></li>
		<li><a href="#" id="rAdd-chi">新增子节点</a></li>
		<li><a href="#" id="rDel">删除节点</a></li>
	</ul>
</div>
<script src="<%=request.getContextPath()%>/resources/js/channel/channel.js"></script>
