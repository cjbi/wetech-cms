(function($) {
	var setting;
	$.fn.keywordinput = function(opts) {
		//下拉搜索框需要的div input ul
		var $searchDropdown = $(this);
		var $keywordInput = $searchDropdown.find('input');
		var $searchDropdownUl = $searchDropdown.find('ul');
		//继承的默认参数
		setting = $.extend({
			number : 5,
			url : "#",
			minLength : 1,
			exists_id : "keyword-exists"
		}, opts || {});
		
		init($keywordInput);
		
		initDropdown(this);

		$keywordInput.keydown(inputKeyword);
		
		/**
		 * 通过事件委派处理
		 */
		$("#keywords-wrap").on("click", "a.keyword-shut", function(event) {
			$(this).parent(".keyword-in").remove();
			event.preventDefault();
		});
		
		$keywordInput.keyup(function() {
			$searchDropdown.dropdown('open');
			var url = setting.url;
			var term = $(this).val().trim();
			$.ajax({
				type : "post",
				url : url,
				data : {
					term : term
				},
				dataType : "json",
				success : function(data) {
					$searchDropdownUl.children().remove();
					if (data == '') {
						$searchDropdownUl.append('<li class="am-disabled"><a href="#">没有找到相关的搜索结果</a></li>');
						return;
					}
					$searchDropdownUl.append('<li class="am-dropdown-header">关键字</li>');
					for ( var i in data) {
						$searchDropdownUl.append('<li><a href="#">' + data[i] + '</a></li>');
					}
				},
				error : function(data) {
					console.log(data);
				}
			});
		});
	}

	function initDropdown(input) {
		var $keywordInput = $(input);
		var $searchDropdown = $('#dropdown-search');
		var $searchDropdownUl = $('#dropdown-search-ul');

		$searchDropdownUl.on('click', 'a', function(event) {
			var c = $(this).text();
			if (c != "") {
				if ($(".keyword-in").length >= setting.number) {
					alert("最多只能允许添加" + setting.number + "个关键字");
					event.preventDefault();
					return false;
				}
				var aks = $("input[name='aks']");
				for (var i = 0; i < aks.length; i++) {
					if ($(aks[i]).val() == c) {
						alert("不能添加重复的关键字");
						event.preventDefault();
						return false;
					}
				}
				var ki = createKeyword(c);
				$("#keywords-wrap").append(ki);
				$(this).val("");
				$searchDropdown.dropdown('close');
			}
		});
	}

	function initAddKeyword() {
		$("#" + setting.exists_id + " span").each(function() {
			var ki = createKeyword($(this).html());
			$("#keywords-wrap").append(ki);
		})
	}
	
	//初始化keyword包裹div
	function init(input) {
		$(input).val(setting.msg);
		$(input).addClass("keyword-input");
		$(input).wrap("<div id='keyword-container'></div>").before("<div id='keywords-wrap'></div>");
		initAddKeyword();
		$(input).focus(function() {
			$(this).val("");
		});
	}
	
	//从输入框键入的关键字校验
	function inputKeyword(event) {
		var code = event.keyCode;
		if (code == 188 || code == 13) {
			var c = $(this).val();
			if (c != "") {
				if ($(".keyword-in").length >= setting.number) {
					alert("最多只能允许添加" + setting.number + "个关键字");
					event.preventDefault();
					return false;
				}
				var aks = $("input[name='aks']");
				for (var i = 0; i < aks.length; i++) {
					if ($(aks[i]).val() == c) {
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
	
	//创建keyword需要的div
	function createKeyword(val) {
		return "<div class='keyword-in'><span class='am-badge am-badge-secondary am-radius'>" + val
				+ "</span><a href='#' class='am-close keyword-shut'>&times;</a><input type='hidden' name='aks' value='" + val + "'/></div>";
	}
})(jQuery)