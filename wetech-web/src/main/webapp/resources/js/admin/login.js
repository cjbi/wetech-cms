//生成验证码
function reCheckcode(img) {
	img.src = "drawCheckCode?" + Math.random();
}

$(function() {
	var $form = $('#loginForm');
	var $tooltip = $('<div id="vld-tooltip">提示信息！</div>');
	$tooltip.appendTo(document.body);

	$form.validator();

	var validator = $form.data('amui.validator');

	$form.on('focusin focusout', '.am-form-error input', function(e) {
		if (e.type === 'focusin') {
			var $this = $(this);
			var offset = $this.offset();
			var msg = $this.data('foolishMsg') || validator.getValidationMessage($this.data('validity'));

			$tooltip.text(msg).show().css({
				left : offset.left + 10,
				top : offset.top + $(this).outerHeight() + 10
			});
		} else {
			$tooltip.hide();
		}
	});

	var error = $('#error').val();
	if (error != "") {
		layer.msg(error, {
			time : 2000,
			icon : 5
		});
	}
});