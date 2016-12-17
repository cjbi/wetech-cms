<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <div data-am-widget="slider" class="am-u-sm-8 am-slider am-slider-d3" data-am-slider='{&quot;controlNav&quot;:&quot;thumbnails&quot;,&quot;directionNav&quot;:false}' >
  <ul class="am-slides">
  	<#list pics as pic>
      <li data-thumb="<%=request.getContextPath()%>/resources/indexPic/thumbnail/${pic.newName}">
        	<a href="${pic.linkUrl}"><img src="<%=request.getContextPath()%>/resources/indexPic/${pic.newName}"></a>
          <div class="am-slider-desc"><h2 class="am-slider-title">${pic.title}</h2><p>${pic.subTitle}</p></div>
      </li>
     </#list> 
  </ul>
</div>