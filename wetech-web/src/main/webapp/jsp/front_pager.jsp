<%@page import="tech.wetech.basic.model.SystemContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<pg:pager export="curPage=pageNumber" 
	items="${param.totalRecord }" 
	maxPageItems="<%=SystemContext.getPageSize() %>"
	url="${param.url }">
	<c:forEach items="${param.params }" var="p">
		<pg:param name="${p }"/>
	</c:forEach>
	<pg:last>
	<span class="weith">总页数：${pageNumber}页,共${param.totalRecord }条记录</span>
	</pg:last> 
	<pg:first>
		<span><a href="${pageUrl }"class="bottom_page_span">首页</a></span> 
	</pg:first>
	<pg:prev>
		<span><a href="${pageUrl }" class="bottom_page_span">上一页</a></span>
	</pg:prev>
	<pg:pages>
		<c:if test="${curPage eq pageNumber }">
			<span class="curPage_span">[${pageNumber }]</span>
		</c:if>
		<c:if test="${curPage != pageNumber }">
			<span><a href="${pageUrl }" class="bottom_page_span">${pageNumber }</a></span>
		</c:if>
	</pg:pages>
	<pg:next>
		<span><a href="${pageUrl }" class="bottom_page_span">下一页</a></span>
	</pg:next>
	<pg:last>
		<span><a href="${pageUrl }" class="bottom_page_span">尾页</a></span>
		<span class="weith">页次：${curPage }/${pageNumber}</span>
	</pg:last>
</pg:pager>
