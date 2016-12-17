/**
 * 序列化表单元素为JSON对象
 * 
 * @param form
 *            Form表单id或表单jquery DOM对象
 * @returns {}
 */
var serialize = function(form) {
	var $form = (typeof (form) == "string" ? $("#" + form) : form);
	var dataArray = $form.serializeArray();
	var result = {};
	$(dataArray).each(function() {
		// 如果在结果对象中存在这个值，那么就说明是多选的情形。
		if (result[this.name]) {
			// 多选的情形，值是数组，直接push
			result[this.name].push(this.value);
		} else {
			// 获取当前表单控件元素
			var element = $form.find("[name='" + this.name + "']")[0];
			// 获取当前控件类型
			var type = (element.type || element.nodeName).toLowerCase();
			// 如果控件类型为多选那么值就是数组形式，否则就是单值形式。
			result[this.name] = (/^(select-multiple|checkbox)$/i).test(type) ? [ this.value ] : this.value;
		}
	});
	return result;
};

// 重置表单
$.fn.clear = function() {
	$(this).get(0).reset();
}