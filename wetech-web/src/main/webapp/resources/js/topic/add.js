$(function() {
    var editor = $('#content').xheditor({
	tools : 'full',
	width : '100%',
	height: '200',
	skin :'nostyle'
    });

    $("#keyword").keywordinput({
	autocomplete : {
	    enable : true,
	    url : contextPath + "/admin/topic/searchKeyword",
	    minLength : 2
	}
    });
});