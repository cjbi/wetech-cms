<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="am-g am-g-fixed  cms-fixed">
	<div class="am-u-sm-12">
		<div data-am-widget="titlebar" class="am-titlebar am-titlebar-default">
			<h2 class="am-titlebar-title ">友情链接</h2>
		</div>
		<div class="am-u-sm-12" style="margin-top: 2rem;">
			<ul class="am-avg-sm-3 am-avg-md-4 am-avg-lg-5">
			<#list links as link>
				<li><a href="${link.url}">${link.title}</a></li>
			</#list>
			</ul>
		</div>
	</div>
</div>