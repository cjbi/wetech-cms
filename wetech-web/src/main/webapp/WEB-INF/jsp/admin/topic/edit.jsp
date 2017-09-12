<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html class="no-js fixed-layout">
<head>
<meta charset="utf-8">
<title>编辑文章</title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/resources/amazeui/assets/i/favicon.png">
<link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/resources/amazeui/assets/i/app-icon72x72@2x.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/amazeui.upload.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/admin.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/layer/skin/default/layer.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/zTree/zTreeStyle.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/wangEditor/css/wangEditor.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/main.css">
<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>
</head>
<div id="menuContent" class="menuContent" style="display: none; position: absolute; background: #fff; z-index: 999; border: 1px solid #999">
	<ul id="mytree" class="ztree" style="margin-top: 0;"></ul>
</div>
<body>
	<input type="hidden" id="sid" value="<%=session.getId()%>" />
	<div class="admin-content">
		<div class="admin-content-body">
			<div class="am-cf am-padding am-padding-bottom-0">
				<div class="am-fl am-cf">
					<strong class="am-text-primary am-text-lg">文章信息管理</strong> / <small>新增文章</small>
				</div>
			</div>
			<div class="am-u-sm-12">
				<form class="am-form am-form-horizontal">
					<input type="hidden" name="id" value="${topicDto.id }" />
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章标题</label>
						<div class="am-u-sm-8">
							<input name="title" value="${topicDto.title}" type="text" placeholder="输入你的文章标题(必填)" required>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章栏目</label>
						<div class="am-u-sm-8 am-padding-0">
							<div class="am-u-sm-12">
								<input type="text" name="cname" value="${cname}" id="cname" placeholder="指定你的文章所属栏目(必填)" required readonly><input type="hidden" name="cid" value="${topicDto.cid }"
									id="cid">
							</div>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<c:choose>
						<c:when test="${isAudit||isAdmin }">
							<div class="am-form-group">
								<label class="am-u-sm-2 am-form-label">文章状态</label>
								<div class="am-u-sm-8">
									<c:if test="${topicDto.status eq 1}">
										<label class="am-radio-inline"><input type="radio" name="status" value="0" />未发布</label>
										<label class="am-radio-inline"><input type="radio" name="status" value="1" checked />已发布</label>
									</c:if>
									<c:if test="${topicDto.status eq 0}">
										<label class="am-radio-inline"><input type="radio" name="status" value="0" checked />未发布</label>
										<label class="am-radio-inline"><input type="radio" name="status" value="1" />已发布</label>
									</c:if>
								</div>
								<div class="am-u-sm-2"></div>
							</div>
						</c:when>
						<c:otherwise>
							<input type="hidden" name="status" value="${topicDto.status }" />
						</c:otherwise>
					</c:choose>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">是否推荐该文章</label>
						<div class="am-u-sm-8">
							<c:if test="${topicDto.recommend eq 0}">
								<label class="am-radio-inline"><input type="radio" name="recommend" value="0" checked />不推荐</label>
								<label class="am-radio-inline"><input type="radio" name="recommend" value="1" />推荐</label>
							</c:if>
							<c:if test="${topicDto.recommend eq 1}">
								<label class="am-radio-inline"><input type="radio" name="recommend" value="0" />不推荐</label>
								<label class="am-radio-inline"><input type="radio" name="recommend" value="1" checked />推荐</label>
							</c:if>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">发布时间</label>
						<div class="am-u-sm-8">
							<input type="text" class="am-form-field" value="${topicDto.publishDate }" id="publishDate" name="publishDate" value="" placeholder="日历组件" data-am-datepicker readonly
								required />
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章关键字</label>
						<div class="am-u-sm-8">
							<div class="am-u-sm-12 am-padding-0 am-dropdown" id="dropdown-search">
								<div id="keyword-exists" style="display: none;">
									<c:forEach items="${keywords }" var="k">
										<span>${k }</span>
									</c:forEach>
								</div>
								<input type="text" id="dropdown-search-input" placeholder="请输入关键字进行检索，通过回车确认(最多五个关键字，不能重复)">
								<ul class="am-dropdown-content am-dropdown-search" id="dropdown-search-ul"></ul>
							</div>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章附件</label>
						<div class="am-u-sm-8" id="ok_attach">
							<div id="event"></div>
							<c:if test="${!empty atts}">
							历史附件信息：
							<table class="am-table am-table-compact am-table-striped am-table-hover am-text-sm" id="_template">
									<thead>
										<tr>
											<th>缩略图</th>
											<th>文件信息</th>
											<th>上传情况</th>
											<th>上传状态</th>
											<th>主页图片</th>
											<th>栏目图片</th>
											<th>附件信息</th>
											<th>操作项</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${atts }" var="att">
											<tr>
												<td width="5%">
													<div class="image">
														<c:if test="${att.isImg eq 1 }">
															<img class="am-thumbnail" src="<%=request.getContextPath() %>/resources/upload/thumbnail/${att.newName}" alt="">
														</c:if>
													</div>
												</td>
												<td width="20%"><span style="display: none" class="fileID">608</span> <span class="fileName"><label class="am-text-xs"><text>${att.oldName }</text><label></label>
															<iframe id="tmp_downloadhelper_iframe" style="display: none;"></iframe></label></span><br> <span class="fileSize"><span class="am-badge">文件大小<text>${att.size/1024}
															KB</text></span></span></td>
												<td width="20%"><span class="speed"><span class="am-badge am-badge-primary">已完成上传</span></span><br> <span class="loaded"><span
														class="am-badge am-badge-secondary">详情<text>${att.size/1024}KB</text></span></span></td>
												<td width="20%">
													<div class="stage">
														<span class="am-badge am-badge-success">已上传成功</span>
													</div>
													<div class="am-progress am-progress-striped am-active" style="">
														<div class="am-progress-bar am-progress-bar-secondary" style="width: 100%;">100%</div>
													</div>
												</td>
												<c:if test="${att.isImg eq 1 }">
													<td><input type='checkbox' value="${att.id }" name='indexPic' class='indexPic' <c:if test="${att.isIndexPic eq 1 }">checked="checked"</c:if>></td>
													<td><input type='radio' value="${att.id }" name='channelPicId' <c:if test="${att.id eq topicDto.channelPicId }"> checked="checked"</c:if>></td>
												</c:if>
												<c:if test="${att.isImg ne 1 }">
													<td>&nbsp;</td>
													<td>&nbsp;</td>
												</c:if>
												<td><input type='checkbox' value="${att.id }" name='isAttach' class='isAttach' <c:if test="${att.isAttach eq 1 }">checked="checked"</c:if>></td>
												<td class="am-text-middle"><button type="button" title="${att.id }" class="am-btn am-btn-danger am-round am-btn-xs deleteAttach">
														<i class="am-icon-remove"></i>移除
													</button>
													<button type="button" title='${att.id}' isImg="${att.isImg }" name="${att.newName }" oldName="${att.oldName }"
														class="am-btn am-btn-primary am-round am-btn-xs insertAttach">
														<i class="am-icon-plus"></i> 插入
													</button></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章内容</label>
						<div class="am-u-sm-8">
							<textarea id="content" rows="30" name="content">${topicDto.content }</textarea>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label">文章摘要</label>
						<div class="am-u-sm-8">
							<textarea name="summary" required>${topicDto.summary }</textarea>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
					<div class="am-form-group">
						<label class="am-u-sm-2 am-form-label"></label>
						<div class="am-u-sm-8 am-cf">
							<button type="button" id="submit" class="am-btn am-btn-primary am-radius am-fr">修改文章</button>
						</div>
						<div class="am-u-sm-2"></div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.upload.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.upload.template.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.upload.event.js"></script>
	<script src="<%=request.getContextPath()%>/resources/layer/layer.js"></script>
	<script src="<%=request.getContextPath()%>/resources/zTree/jquery.ztree.core-3.5.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/main.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/common/jquery.cms.keywordinput.js"></script>
	<script src="<%=request.getContextPath()%>/resources/wangEditor/js/wangEditor.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/common/wetech.common.js"></script>
	<script src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/topic/edit.js"></script>
</body>
</html>
