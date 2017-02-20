$rex.view = {};
$rex.view.fn = {};
//获取url表单参数字符串
$rex.view.fn.getUrlParams = function(queryParams){
	queryParams = queryParams.slice(1,queryParams.length-1);
	var paramsStr = "";
	var queryParamArr = queryParams.split(",");
	for(var i=0; i<queryParamArr.length; i++) {
		var a = queryParamArr[i].split("=");
		var k = a[0].trim();
		var v = a[1].trim();
		paramsStr += k+"="+v+"&";
	}
	paramsStr = paramsStr.substr(0,paramsStr.length-1);//去除最后一个&号
	return paramsStr;
};