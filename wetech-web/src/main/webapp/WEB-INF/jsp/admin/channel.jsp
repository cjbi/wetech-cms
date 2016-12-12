<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
div#rMenu {
	position: absolute;
	visibility: hidden;
	padding: 2px;
	font-size: 14px;
}

div#rMenu ul {
	min-width: 50px;
}

.ztree li {
	padding: 0;
	margin: 0;
	list-style: none;
	line-height: 20px;
	text-align: left;
	white-space: nowrap
}

.ztree li span {
	margin-right: 2px;
	font-weight: lighter;
	font-size: 14px;
	color: #000;
	font-family: inherit;
}
</style>
<%-- content start --%>
<div class="admin-content">
	<div class="admin-content-body">
		<div class="am-cf am-padding am-padding-bottom-0">
			<div class="am-fl am-cf">
				<strong class="am-text-primary am-text-lg">文章管理</strong> / <small>栏目信息管理</small>
			</div>
		</div>
		<hr>
		<div class="am-u-sm-3">
			<div class="am-panel am-panel-default am-animation-fade">
				<div class="am-panel-hd">栏目树</div>
				<div class="am-panel-bd">
					<ul id="tree" class="ztree context-menu-one btn btn-neutral" style="width: 150px; overflow: auto;"></ul>
				</div>
			</div>
			<div class="am-panel am-panel-default am-animation-scale-down">
				<div class="am-panel-bd">
					<p>
						<span class="am-icon-bookmark"></span> 提示
					</p>
					<p>鼠标单击右键操作树节点，拖动排序 : )</p>
				</div>
			</div>
		</div>
		<div class="am-u-sm-7 am-u-end">
			<div class="am-panel am-panel-default am-animation-fade am-animation-shake">
				<div class="am-panel-hd">栏目树管理</div>
				<div class="am-panel-bd">
					<form class="am-form am-form-horizontal" onsubmit="return false;" id="edit-form">
						<br> <input type="hidden" name="id"> <br> <input type="hidden" name="pId">
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
							<label class="am-u-sm-3 am-form-label">排序</label>
							<div class="am-u-sm-9">
								<input type="text" name="orders" placeholder="栏目后台显示的顺序(必填)" required>
							</div>
						</div>
						<div class="am-form-group">
							<label class="am-u-sm-3 am-form-label">栏目类型</label>
							<div class="am-u-sm-9">
								<select name='type' required>
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
							<label class="am-u-sm-3 am-form-label">状态</label>
							<div class="am-u-sm-9">
								<label class="am-radio-inline"><input type="radio" name="status" value="0"> 启用</label> <label class="am-radio-inline"><input
									type="radio" name="status" value="1" checked> 停用</label>
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
						<div class="am-form-group">
							<div class="am-u-sm-end am-text-right">
								<button type="submit" class="am-btn am-btn-primary am-radius">保存</button>
								<button type="reset" class="am-btn am-btn-warning am-radius">重置</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%-- footer start --%>
	<jsp:include page="/jsp/admin/footer.jsp" />
	<%-- footer end --%>
</div>
<%-- content end --%>

<%-- 隐藏的模态框 --%>
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
			<label class="am-u-sm-3 am-form-label">状态</label>
			<div class="am-u-sm-9">
				<label class="am-radio-inline"><input type="radio" name="status" value="0"> 启用</label> <label class="am-radio-inline"><input
					type="radio" name="status" value="1" checked> 停用</label>
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
<%-- 隐藏的右键菜单 --%>
<div id="rMenu">
	<ul class="am-dropdown-content">
		<li><a href="#" id="rAdd-curr">新增同级节点</a></li>
		<li><a href="#" id="rAdd-chi">新增子节点</a></li>
		<li><a href="#" id="rDel">删除节点</a></li>
	</ul>
</div>
<script type="text/javascript">
	$.getScript("<%=request.getContextPath()%>/resources/js/admin/channel.js");
</script>