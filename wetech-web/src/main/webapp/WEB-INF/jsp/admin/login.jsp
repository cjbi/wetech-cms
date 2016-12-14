<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link rel="alternate icon" type="image/png" href="<%=request.getContextPath()%>/resources/amazeui/assets/i/favicon.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/amazeui/assets/css/amazeui.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/layer/skin/default/layer.css">
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
#vld-tooltip {
	position: absolute;
	z-index: 1000;
	padding: 5px 10px;
	background: #F37B1D;
	min-width: 150px;
	color: #fff;
	transition: all 0.15s;
	box-shadow: 0 0 5px rgba(0, 0, 0, .15);
	display: none;
}

#vld-tooltip:before {
	position: absolute;
	top: -8px;
	left: 50%;
	width: 0;
	height: 0;
	margin-left: -8px;
	content: "";
	border-width: 0 8px 8px;
	border-color: transparent transparent #F37B1D;
	border-style: none inset solid;
}
</style>
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
			<input type="hidden" name="error" id="error" value="${error}" />
			<form action="<%=request.getContextPath()%>/login" method="post" class="am-form" id="loginForm">
				<fieldset>
					<legend> 登录/Login </legend>
					<div class="am-btn-group">
						<a href="#" class="am-btn am-btn-secondary am-btn-sm"><i class="am-icon-github am-icon-sm"></i> Github</a> <a href="#" class="am-btn am-btn-success am-btn-sm"><i
							class="am-icon-google-plus-square am-icon-sm"></i> Google+</a> <a href="#" class="am-btn am-btn-primary am-btn-sm"><i class="am-icon-stack-overflow am-icon-sm"></i>
							stackOverflow</a>
					</div>
					<br> <br>
					<div class="am-form-group">
						<label for="username">用户名：</label> <input type="text" name="username" id="username" minlength="3" placeholder="请输入用户名" required />
					</div>

					<div class="am-form-group">
						<label for="password">密码：</label> <input type="password" name="password" id="password" minlength="6" placeholder="请输入密码" required data-foolish-msg="至少 6 位数字或字符的密码" />
					</div>
					<div class="am-form-group">
						<label for="checkcode">验证码：</label>
						<div class="am-u-md-12 am-padding-0">
							<div class="am-u-md-3 am-padding-0">
								<input type="password" name="checkcode" id="checkcode" placeholder="请输入验证码" pattern="^\d{4}$" minlength="4" required />
							</div>
							<div class="am-u-md-3">
								<img src="drawCheckCode" onclick="reCheckcode(this)">
							</div>
							<div class="am-u-md-6 am-padding-0"></div>
						</div>
					</div>
					<div class="am-cf">
						<button class="am-btn am-btn-primary am-margin-vertical am-fl" type="submit">提交</button>
						<button class="am-btn am-btn-default am-margin-vertical am-fr" type="submit">忘记密码 ^_^?</button>
					</div>
				</fieldset>
			</form>
			<hr>
			<p>© 2014 AllMobilize, Inc. Licensed under MIT license.</p>
		</div>
	</div>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/amazeui/assets/js/amazeui.min.js"></script>
	<script src="<%=request.getContextPath()%>/resources/layer/layer.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/admin/login.js"></script>
</body>
</html>