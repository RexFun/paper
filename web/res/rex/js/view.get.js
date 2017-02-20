$rex.view.get = {};
/* **************************************************************************************************************
 * config
 * */
$rex.view.get.config = {};
$rex.view.get.config.curPageNum = 1;//配置初始页码
$rex.view.get.config.curPageSize = 10;//配置每页行数
$rex.view.get.config.setPreFormParams = function(){};//保留上次表单参数
$rex.view.get.config.formParams = function(p){return p;};//配置表单参数
$rex.view.get.config.urlParams = function(){return {};};//配置url表单参数
$rex.view.get.config.tableColumns = [];//配置表格列
//配置行菜单
$rex.view.get.config.operateFormatter = function(value, row, index){
    return ['<div class="btn-group">',
	    	'<button type="button" class="btn btn-default dropdown-toggle btn-sm" data-toggle="dropdown">',
	    	'<span class="caret"></span>',
	    	'</button>',
	    	'<ul class="dropdown-menu" role="menu">',
	    	'<li class="upd" pbtnId="pbtn_upd'+index+'">',
	    	'<a href="javascript:void(0);">',
	        '<i class="glyphicon glyphicon-edit"></i>',
	    	'</a>',
	    	'</li>',
	    	'<li class="getById" pbtnId="pbtn_getById'+index+'">',
	    	'<a href="javascript:void(0);">',
	        '<i class="glyphicon glyphicon-info-sign"></i>',
	    	'</a>',
	    	'</li>',
	    	'</ul>',
	    	'</div>'
		    ].join('');
};
//配置行菜单事件
$rex.view.get.config.operateEvents = {
    'click .upd': function (e, value, row, index) {
		location.href = "upd1.action?id="+row.m.id+"&"+$rex.view.get.fn.getUrlParams();
    },
    'click .getById': function (e, value, row, index) {
		location.href = "getById.action?id="+row.m.id+"&"+$rex.view.get.fn.getUrlParams();
    }
};
/* *
 * callback
 * */
$rex.view.get.callback = {};
//删除行回调
$rex.view.get.callback.delRows = function(){
};
//翻页回调
$rex.view.get.callback.onPageChange = function(number,size){
	$rex.view.get.config.curPageNum = number; 
	$rex.view.get.config.curPageSize = size
};
//加载成功回调
$rex.view.get.callback.onLoadSuccess = function(){
};
//加载失败回调
$rex.view.get.callback.onLoadError = function(){
	ajaxOnLoadError();
};

/* **************************************************************************************************************
 * init
 * */
$rex.view.get.init = {};
/* 初始化查询窗口 */
$rex.view.get.init.modalFormQuery = function(){
	$rex.view.get.config.setPreFormParams();
	$("#form_query").submit(function(e){
		e.preventDefault();
		$("#form_query_btn").click();
	});
	$("#form_query_btn").click(function(){
		$('#modal_form_query').modal('hide');
        $("#tb_list").bootstrapTable('selectPage', 1);
	});
};
/* 初始化工具栏 */
$rex.view.get.init.toolbar = function(){
	$("#bar_btn_add").click(function(){
		location.href = "add1.action?"+$rex.view.get.fn.getUrlParams();
	});
	$("#bar_btn_del").click(function(){
		if($rex.view.get.fn.getIdSelections().length<1) {
			alert("没选择");
			return;
		}
		if(!confirm("确认删除？")) return;
		$.post("del.action",{id:$rex.view.get.fn.getIdSelections()},function(data){
	        $("#tb_list").bootstrapTable('refresh'); // 刷新table
	        $rex.view.get.callback.delRows(); // 删除行回调
		});
	});
};
/* 初始化数据表 */
$rex.view.get.init.table = function(pageNum, pageSize){
	if(pageNum != null && pageNum != "") {$rex.view.get.config.curPageNum = parseInt(pageNum);}
	if(pageSize != null && pageSize != "") {$rex.view.get.config.curPageSize = parseInt(pageSize);}
	var thisColumns = $rex.view.get.fn.getColumns();
	$('#tb_list').bootstrapTable({
		height:getGlobalHeight("table"),
		method:'post',
		contentType:"application/x-www-form-urlencoded",//用post，必须采用此参数
	    url: 'getJson.action',
		sidePagination:"server",
		toolbar:"#toolbar",
        showRefresh:true,
        showToggle:true,
        showColumns:true,
        showExport:true,
		striped:true,
		pagination:true,
		pageList:"[5,10,20]",
		pageNumber:$rex.view.get.config.curPageNum,
		pageSize:$rex.view.get.config.curPageSize,
	    queryParams:$rex.view.get.config.formParams,
	    columns:thisColumns,
	    onPageChange:$rex.view.get.callback.onPageChange,
	    onLoadSuccess:$rex.view.get.callback.onLoadSuccess,
	    onLoadError:$rex.view.get.callback.onLoadError
	});
	//随窗口resize 改变 高度
	$(window).resize(function () {
		$('#tb_list').bootstrapTable('resetView', {height: getGlobalHeight("table")});
	});
};

/* **************************************************************************************************************
 * fn
 * */
$rex.view.get.fn = {};
// 获取已选行的ID集合
$rex.view.get.fn.getIdSelections = function(){
    return $.map($("#tb_list").bootstrapTable('getSelections'), function (row) {
        return row.m.id
    });
};
// 获取表格列
$rex.view.get.fn.getColumns = function(){
	var columns = 
		[
	     {checkbox:true, align:'center', valign:'middle'},
	     {title:'操作', field:'operate', align:'center', valign:'middle', width:'50', events:$rex.view.get.config.operateEvents, formatter:$rex.view.get.config.operateFormatter}
	    ];
	return $.merge(columns,$rex.view.get.config.tableColumns);
};
// 获取url表单参数字符串
$rex.view.get.fn.getUrlParams = function(){
	var params = $rex.view.get.config.urlParams();
	params = $.extend(params, {f_page     : $rex.view.get.config.curPageNum,
							   f_pageSize : $rex.view.get.config.curPageSize});
	var paramsStr = "";
	$.map(params, function(value, key){
		paramsStr += key+"="+value+"&";
	});
	paramsStr = paramsStr.substr(0,paramsStr.length-1);//去除最后一个&号
	return paramsStr;
};