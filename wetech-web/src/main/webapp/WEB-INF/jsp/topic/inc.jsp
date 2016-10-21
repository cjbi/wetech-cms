<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<span>
<a href="javascript:openWin('<%=request.getContextPath() %>/admin/topic/add','addTopic')" class="admin_link">添加文章</a>
<a href="<%=request.getContextPath() %>/admin/topic/audits" class="admin_link">已发布文章列表</a>
<a href="<%=request.getContextPath() %>/admin/topic/unaudits" class="admin_link">未发布文章列表</a>
</span>