<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<span>
当前栏目:${pc.name }[${pc.id }]&nbsp;
<a href="<%=request.getContextPath() %>/admin/channel/add/${pid}" class="admin_link">添加子栏目</a>
<a href="<%=request.getContextPath() %>/admin/channel/channels/${pid}/-1" class="admin_link">子栏目列表</a>
</span>