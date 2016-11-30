<%@page import="tech.wetech.basic.model.SystemContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<pg:pager export="curPage=pageNumber" items="${param.totalRecord }" maxPageItems="<%=SystemContext.getPageSize() %>" url="${param.url }">
<ul class="am-pagination am-pagination-right">
	共<pg:last>
		${pageNumber } 页[${param.totalRecord }条记录]
	</pg:last>
	
	<c:forEach items="${param.params }" var="p">
		<pg:param name="${p }" />
	</c:forEach>
	
	<pg:first>
	<li><a href="<%=request.getContextPath() %>/${pageUrl }">首页</a></li>
	</pg:first>
	
	<pg:prev>
	<li><a href="<%=request.getContextPath() %>/${pageUrl }">&laquo;</a></li>
	</pg:prev>
	
	<pg:pages>
		<c:if test="${curPage eq pageNumber }">
		<li class="am-active"><a href="#">${pageNumber }</a></li>
		</c:if>
		<c:if test="${curPage != pageNumber }">
			<li><a href="<%=request.getContextPath() %>/${pageUrl }">${pageNumber }</a></li>
		</c:if>
	</pg:pages>
	
	<pg:next>
	<li><a href="<%=request.getContextPath() %>/${pageUrl }">&raquo;</a></li>
	</pg:next>
	<pg:last>
	<li><a href="<%=request.getContextPath() %>/${pageUrl }">尾页</a></li>
	</pg:last>
	
</ul>
</pg:pager>
