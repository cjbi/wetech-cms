$(function(){
	$("#rollpic").cycle({
		fx:"fadeout",
		pauseOnHover:true,
		slides:"> a",
		caption:"#rollCaption span",
		captionTemplate:"{{title}}",
		pager:"#rollPager"
	});
	$("#rollpic").hover(function(){
		$("#rollCaption").slideDown(200);
	},function(){
		$("#rollCaption").slideUp(200);
	})
	$("#rollCaption").css("opacity",0.5);
	if($("#content_con").height()<350) {
		$("#content_con").height(350);
	}
	$("#content").height($("#content_con").height());
	$("#search_con").css("opacity",0.5);
	var search_v;
	$("#search_con").focus(function(){
		search_v = $(this).val();
		$(this).css("border","none");
		$("#search_con").css("opacity",1.0);
		$(this).val("");
	});
	$("#search_con").blur(function(){
		if($(this).val()=="") {
			$(this).css("opacity",0.5);
			$(this).val(search_v);
		}
	});
	$("#search_btn").click(function(){
		var sc = $("#search_con").val();
		if(sc==""||sc=="Search..") {
			alert("你需要输入相应的检索内容");
		} else {
			window.location.href=$("#ctx").val()+"/search/"+sc;
		}
	});
	$("#nav_con ul li").hover(function() {
		$(this).addClass("nav_hover");
	},function(){
		$(this).removeClass("nav_hover");
	});
	$("#chief_keyword div span").hover(function() {
		$(this).removeClass("keyword");
		$(this).addClass("keyword_hover");
	},function(){
		$(this).removeClass("keyword_hover");
		$(this).addClass("keyword");
	});
	$("#chief_keyword div span").click(function() {
		window.location.href=$(this).attr("href");
	});
	$("#nav_con ul li").click(function(){
		window.location.href = $(this).children("span").attr("href");
	});
	
	$(".channel_img").css("opacity","0.5");
	$(".channel_img").hover(function(){
		$(this).css("opacity","1.0");
	},function(){
		$(this).css("opacity","0.5");
	});
});