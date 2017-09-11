<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:forEach items="${datas.datas}" var="topic">
    <li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-bottom-left">
        <a href="<%=request.getContextPath() %>/topic/${topic.id}" class="am-list-item-hd"><h2>${topic.title }</h2></a>
        <c:if test="${not empty topic.thumb}">
            <div class="am-u-sm-2 am-list-thumb">
                <a href="<%=request.getContextPath() %>/topic/${topic.id}"><img src="${topic.thumb }"/></a>
            </div>
            <div class=" am-u-sm-10  am-list-main">
                <div class="am-list-item-text">${topic.summary }</div>
            </div>
        </c:if>
        <c:if test="${empty topic.thumb}">
            <div class=" am-u-sm-12  am-list-main">
                <div class="am-list-item-text">${topic.summary }</div>
            </div>
        </c:if>
        <p class="am-article-meta am-text-right">
            <span class="am-icon-navicon"></span>&nbsp;${topic.cname }&nbsp;&nbsp;
            <span class="am-icon-user"></span>&nbsp;<a href="#">${topic.author }</a>&nbsp;&nbsp;<span class="am-icon-clock-o"></span>&nbsp;
            <fmt:formatDate value="${topic.publishDate }" pattern="yyyy-MM-dd"/>
            &nbsp;&nbsp;
        </p></li>
</c:forEach>