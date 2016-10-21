<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/js/base/jquery-ui.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/core/jquery.cms.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/admin/main.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/admin/inc.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/ui/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/ui/jquery.ui.button.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/ui/jquery.ui.spinner.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
<script type="text/javascript">
$(function(){
	$(".setPos").click(setPos);
	function setPos(event) {
		event.preventDefault();
		var pos = $(this).attr("pos");
		var id = $(this).attr("picid");
		$(this).after("<span>&nbsp;<input type='text' value='"+pos+"' size='3'/>&nbsp;<input id='pos"+id+"' type='hidden' value='"+pos+"'/><a href='#' class='list_opg confirmPos'>确定</a>&nbsp;<a href='' class='list_opg cancelPos'>取消</a></span>");
		$(this).next("span").children("input:text").spinner({
			min:$("#minPos").val(),
			max:$("#maxPos").val(),
			spin:function(event,ui){
				$("#pos"+id).val(ui.value);
			}
		});
		$(this).off("click");
	}
	$(".posCon").on("click",".cancelPos",function(e){
		e.preventDefault();
		$(this).parent("span").prev("a.setPos").on("click",setPos);
		$(this).parent("span").remove();
	});
	$(".posCon").on("click",".confirmPos",function(e){
		e.preventDefault();
		var id = $(this).parent("span").prev("a").attr("picid");
		var op = $(this).parent("span").prev("a").attr("pos");
		var np = $(this).prev("input").val();
		if(op!=np) {
			//通过dwr更新节点
			dwrService.updatePicPos(id,op,np,function(){
				window.location.reload();
			});
		}
		$(this).parent("span").prev("a.setPos").on("click",setPos);
		$(this).parent("span").remove();
	});
}) 
</script>
</head>
<body>
<div id="content">
<input type="hidden" id="maxPos" value="${max }"/>
<input type="hidden" id="minPos" value="${min }"/>
	<h3 class="admin_link_bar">
		<jsp:include page="inc.jsp"></jsp:include>
	</h3>
	<table width="800" cellspacing="0" cellPadding="0" id="listTable">
		<thead>
		<tr>
			<td>缩略图</td>
			<td width="240">图片标题</td>
			<td>状态</td>
			<td>链接类型</td>
			<td>位置</td>
			<td>用户操作</td>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${datas.datas }" var="pic">
			<tr>
				<td><img src='<%=request.getContextPath()%>/resources/indexPic/thumbnail/${pic.newName}'/></td>
				<td><a href="javascript:openWin('<%=request.getContextPath() %>/admin/pic/indexPic/${pic.id }','showPic')" class="list_link">${pic.title }</a></td>
				<td>
				<c:if test="${pic.status eq 0}"><span class="emp">未启用</span><a href="updateIndexPicStatus/${pic.id }"  class="list_op">启用</a></c:if>
				<c:if test="${pic.status eq 1}"><span>启用</span><a href="updateIndexPicStatus/${pic.id }"  class="list_op">停用</a></c:if>
				</td>
				<td>
				<c:if test="${pic.linkType eq 0}">站内链接</c:if>
				<c:if test="${pic.linkType eq 1}"><a href='${pic.linkUrl }' class="list_link">站外链接</a></c:if>
				</td>
				<td class="posCon">
				${pic.pos }&nbsp;<a href="#" class="list_opg setPos" pos="${pic.pos }" picid="${pic.id }">排序</a>
				</td>
				<td>
					<a href="deleteIndexPic/${pic.id }" class="list_op delete">删除</a>
					<a href="javascript:openWin('<%=request.getContextPath() %>/admin/pic/updateIndexPic/${pic.id }','updatePic')" class="list_op">更新</a>
				&nbsp;
				</td>
			</tr>
		</c:forEach>
		</tbody>
		<tfoot>
		<tr>
			<td colspan="6" style="text-align:right;margin-right:10px;">
			<jsp:include page="/jsp/pager.jsp">
				<jsp:param value="${datas.total }" name="totalRecord"/>
				<jsp:param value="indexPics" name="url"/>
			</jsp:include>
			</td>
		</tr>
		</tfoot>
	</table>
</div>
</body>
</html>