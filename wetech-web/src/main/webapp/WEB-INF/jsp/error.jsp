<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发生错误</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/admin/error.css" />
</head>
<body>
	<div class="am-g">
		<div class="am-u-sm-12">
			<h2 class="am-text-center am-text-xxxl am-margin-top-lg">${exception.message }</h2>
			<pre class="page-404">
          .----.
       _.'__    `.
   .--($)($$)---/#\
 .' @          /###\
 :         ,   #####
  `-..__.-' _.-\###/
        `;_:    `"'
      .'"""""`.
     /,  ya ,\\
    //  500!  \\
    `-._______.-'
    ___`. | .'___
   (______|______)
        </pre>
		</div>
	</div>
</body>
</html>