(function($){
	var setting;
	$.fn.keywordinput = function(opts) {
		setting = $.extend({
			number:5,
			msg:"请输入关键字，通过逗号或者回车确认",
			autocomplete:{
				enable:false,
				url:"#",
				minLength:1
			},
			exists_id:"keyword-exists"
		},opts||{});
		init(this);
		if(setting.autocomplete.enable) {
			$(this).autocomplete({
				source:setting.autocomplete.url,
				minLength:setting.autocomplete.minLength
			});
		}
		$(this).keydown(inputKeyword);
		/**
		 * 通过事件委派处理
		 */
		$("#keywords-wrap").on("click","a.keyword-shut",function(event){
			$(this).parent(".keyword-in").remove();
			event.preventDefault();
		});
	}
	function initAddKeyword() {
		$("#"+setting.exists_id+" span").each(function() {
			var ki = createKeyword($(this).html());
			$("#keywords-wrap").append(ki);
		})
	}
	function init(input) {
		$(input).val(setting.msg);
		$(input).addClass("keyword-input");
		$(input).wrap("<div id='keyword-container'></div>")
				.before("<div id='keywords-wrap'></div>");
		initAddKeyword();
		$(input).focus(function(){
			$(this).val("");
		});
		$(input).blur(function(){
			$(this).val("请输入关键字，通过逗号或者回车确认");
		});
	}
	function inputKeyword(event) {
		var code = event.keyCode;
		if(code==188||code==13) {
			var c = $(this).val();
			if(c!="") {
				if($(".keyword-in").length>=setting.number) {
					alert("最多只能允许添加"+setting.number+"个关键字");
					event.preventDefault();
					return false;
				}
				var aks = $("input[name='aks']");
				for(var i=0;i<aks.length;i++) {
					if($(aks[i]).val()==c) {
						alert("不能添加重复的关键字");
						event.preventDefault();
						return false;
					}
				}
				var ki = createKeyword(c);
				$("#keywords-wrap").append(ki);
				$(this).val("");
			}
		}
	}
	function createKeyword(val) {
		return "<div class='keyword-in'><span>"+val
		+"</span><a href='#' class='keyword-shut'>×</a><input type='hidden' name='aks' value='"+val+"'/></div>";
	}
})(jQuery)