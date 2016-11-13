<script type="text/javascript">
//----------------����֧�ִ��뿪ʼ(�ǿ��򻷾���ɾ�����δ���)----------------
var JSON = JSON || {};
JSON.stringify = JSON.stringify || function (obj) {
	var t = typeof (obj);
	if (t != "object" || obj === null) {
		if (t == "string")obj = '"'+obj.replace(/(["\\])/g,'\\$1')+'"';
		return String(obj);
	}
	else { 
		var n, v, json = [], arr = (obj && obj.constructor == Array);
		for (n in obj) {
			v = obj[n]; t = typeof(v);
			if (t == "string") v = '"'+v.replace(/(["\\])/g,'\\$1')+'"';
			else if (t == "object" && v !== null) v = JSON.stringify(v);
			json.push((arr ? "" : '"' + n + '":') + String(v));
		}
		return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
	}  
};
var callback = callback || function(v){
	v=JSON.stringify(v);
	window.name=escape(v);
	window.location='http://<?php echo $_POST['parenthost'];?>/xheditorproxy.html';//�����ļ�������һ��0�ֽ��ļ��������޴��ļ�Ҳ����������	
}
//----------------����֧�ִ�������----------------

var url='test2.zip';

setTimeout(function(){callback(url);},100);
//����ģʽ�¿�ֱ�ӵ���callback������ҪsetTimeout�ӳ�
//callback(url);

</script>