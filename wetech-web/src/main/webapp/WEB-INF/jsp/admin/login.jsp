<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page | Amaze UI Example</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone=no">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<link rel="alternate icon" type="image/png"
	href="<%=request.getContextPath()%>/resources/assets/i/favicon.png">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/amazeui.min.css" />
<style>
.header {
	text-align: center;
}

.header h1 {
	font-size: 200%;
	color: #333;
	margin-top: 30px;
}

.header p {
	font-size: 14px;
}
</style>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.validate.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.validate.js"></script>
<script type="text/javascript">
	$(function() {
		$("#myForm").cmsvalidate();
	});
</script>
<script type="text/javascript">
	function reCheckcode(img) {
		img.src = "drawCheckCode?" + Math.random();
	}
</script>
</head>
<body>
	<div class="header">
		<div class="am-g">
			<h1>Wetech CMS</h1>
			<p>
				Integrated Development Environment<br />代码编辑，代码生成，界面设计，调试，编译
			</p>
		</div>
		<hr />
	</div>
	<div class="am-g">
		<div class="am-u-lg-6 am-u-md-8 am-u-sm-centered">
			<h3>登录</h3>
			<hr>
			<div class="am-btn-group">
				<a href="#" class="am-btn am-btn-secondary am-btn-sm"><i
					class="am-icon-github am-icon-sm"></i> Github</a> <a href="#"
					class="am-btn am-btn-success am-btn-sm"><i
					class="am-icon-google-plus-square am-icon-sm"></i> Google+</a> <a
					href="#" class="am-btn am-btn-primary am-btn-sm"><i
					class="am-icon-stack-overflow am-icon-sm"></i> stackOverflow</a>
			</div>
			<br> <br>

			<form method="post" id="myForm" class="am-form am-form-inline">
				<label for="username">登录用户:</label> <input type="text"
					name="username" id="username" required> <br> <label
					for="password">登录密码:</label> <input type="password" name="password"
					id="password" required> <br>
				<label for="password">验证码:</label><br>
				<div class="am-form-group">
				<input type="text" name="checkcode" id="validateCode" placeholder="请输入验证码" required>
				
				</div>
				<div class="am-form-group"><img src="drawCheckCode" onclick="reCheckcode(this)"></div>
				 <br>
				 ${error}
				 <%-- <br> 
				<label for="remember-me"> <input id="remember-me" type="checkbox"> 记住密码 </label> --%>
				<br>
				<div class="am-cf">
					<input type="submit" name="" value="登 录"
						class="am-btn am-btn-primary am-btn-sm am-fl"> <input
						type="submit" name="" value="忘记密码 ^_^? "
						class="am-btn am-btn-default am-btn-sm am-fr">
				</div>
			</form>
			<hr>
			<p>© 2014 AllMobilize, Inc. Licensed under MIT license.</p>
		</div>
	</div>
</body>
</html>