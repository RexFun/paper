$rex.view = {};
$rex.view.menuId = 0;
$rex.view.menuName = "首页";
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
// 选中侧栏菜单
$rex.view.fn.selectSidebarMenu = function(menuId,menuName){
	$rex.view.menuId = menuId;
	$rex.view.menuName = menuName;
	// set current menu
	$(".sidebar-menu li").each(function(){
		$(this).removeClass("active");
		if($(this).attr("menuId")==menuId){
			//
	 		$(this).siblings(".treeview").children(".treeview-menu").removeClass("menu-open").css({"display":"none"});
			//
			$(this).addClass("active");
			$(this).parents(".treeview").addClass("active");
			$(this).parents(".treeview-menu").addClass("menu-open").css({"display":""});
		}
	});
	// set left title
	$(".content-header h1").html(menuName);
	// set right title
	$(".content-header ol li[class='active']").html(menuName);
};