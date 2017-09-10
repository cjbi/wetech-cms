<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- content start --%>
<div class="admin-content">
    <div class="admin-content-body">
        <div class="am-cf am-padding am-padding-bottom-0">
            <div class="am-fl am-cf">
                <strong class="am-text-primary am-text-lg">一级目录</strong> / <small>二级目录</small>
            </div>
        </div>
        <hr>
        <div class="am-u-sm-12">

            这个是示例页面

        </div>
    </div>
    <%-- footer start --%>
    <jsp:include page="/jsp/admin/footer.jsp" />
    <%-- footer end --%>
</div>
<%-- content end --%>

<script type="text/javascript">
    $.getScript("<%=request.getContextPath()%>/resources/js/admin/example.js");
</script>