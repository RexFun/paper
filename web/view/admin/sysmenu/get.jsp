<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<%@ include file="/common/inc_js_btn_permit.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/lib/ztree/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript" src="${ctx}/lib/ztree/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript">
/**********************************************************/
/* zTree配置 */
/**********************************************************/
// zTree 的参数配置
var zTreeObj;
var setting = 
{
	view: 
	{
		selectedMulti: false
	},
	check: 
	{
		enable: false
	},
	async: 
	{
		enable: true,
		url:"getMenuTreeNodes.action"
	},
	data: 
	{
		key: 
		{
			name:"tc_name"
		},
		simpleData: 
		{
			idKey:"id",
			pIdKey:"pid",
			enable: true
		}
	},
	callback: {
	}
};
// zTree的初始化
$(function(){
    zTreeObj = $.fn.zTree.init($("#menuTree"), setting);
    // 全部展开/折叠
    $("#expandAll").click(function(){
    	var zTree = $.fn.zTree.getZTreeObj("menuTree");
        if($(this).prop("checked")==true){
        	zTree.expandAll(true);
        }else{
        	zTree.expandAll(false);
        }
    });
});
</script>
<script type="text/javascript">
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
        $("#tb_list").bootstrapTable('refresh'); // 刷新table
	}
};
/* 初始化toolbar */
function initToolbar() {
	$("#bar_btn_add").click(function(){
		location.href = "add1.action";
	});
	$("#bar_btn_del").click(function(){
		if(getIdSelections().length<1) {
			alert("没选择");
			return;
		}
		if(!confirm("确认删除？")) return;
		$.post("del.action",{id:getIdSelections()},function(data){
	        $("#tb_list").bootstrapTable('refresh'); // 刷新table
	        zTreeObj.reAsyncChildNodes(null, "refresh"); // 刷新zTree
		});
	});
}
/* 初始化tb_list */
function initTable(){
	$('#tb_list').bootstrapTable({
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
		pageList:"[10,20,50]",
	    queryParams: function (p) {
	    	p.tc_name = $("#f_tc_name").val();
            return p;
	    },
	    columns:
	    [
	     {checkbox:true, align:'center', valign:'middle'},
	     {title:'操作', field:'operate', align:'center', valign:'middle', width:'50',
	    	 events:operateEvents, 
	    	 formatter:operateFormatter},
	     {title:'ID', field:'m.id', align:'center', valign:'middle', sortable:true},
	     {title:'PID', field:'m.pid', align:'center', valign:'middle', sortable:true},
	     {title:'菜单代号', field:'m.tc_code', align:'center', valign:'middle', sortable:true},
	     {title:'菜单名称', field:'m.tc_name', align:'center', valign:'middle', sortable:true},
	     {title:'菜单URL', field:'m.tc_url', align:'center', valign:'middle', sortable:true},
	     {title:'菜单排序号', field:'m.tc_order', align:'center', valign:'middle', sortable:true},
	     {title:'菜单权限ID', field:'m.tc_sys_permit_id', align:'center', valign:'middle', sortable:true},
	    ],
	    onLoadSuccess:function(){
	    	initBtnPermit("${sessionScope.CUR_MENU_PERMIT_ID}"); //加载完后，执行按钮权限验证
	    }
	});
}
// 操作列
function operateFormatter(value, row, index) {
    return [
    	'<div class="btn-group">',
    	'<button type="button" class="btn btn-default dropdown-toggle btn-sm" data-toggle="dropdown">',
    	'<span class="caret"></span>',
    	'</button>',
    	'<ul class="dropdown-menu" role="menu">',
    	'<li class="upd" pbtnId="pbtn_upd'+index+'">',
    	'<a href="#">',
        '<i class="glyphicon glyphicon-edit"></i>',
    	'</a>',
    	'</li>',
    	'<li class="getById" pbtnId="pbtn_getById'+index+'">',
    	'<a href="#">',
        '<i class="glyphicon glyphicon-info-sign"></i>',
    	'</a>',
    	'</li>',
    	'</ul>',
    	'</div>'
    	/* 
        '<button type="button" class="btn btn-default upd" pbtnId="pbtn_upd'+index+'">',
        '<i class="glyphicon glyphicon-edit"></i>',
        '</button>&nbsp&nbsp&nbsp&nbsp',
        '<button type="button" class="btn btn-default getById" pbtnId="pbtn_getById'+index+'">',
        '<i class="glyphicon glyphicon-info-sign"></i>',
        '</button>'
         */
    ].join('');
}
// 操作列事件
window.operateEvents = {
    'click .upd': function (e, value, row, index) {
		location.href = "upd1.action?id="+row.m.id;
    },
    'click .getById': function (e, value, row, index) {
		location.href = "getById.action?id="+row.m.id;
    }
};
/* 获取列表已选行rowid */
function getIdSelections() {
    return $.map($("#tb_list").bootstrapTable('getSelections'), function (row) {
        return row.m.id
    });
}
/* 初始化modal_form_query */
function initModalFormQuery() {
	$("#form_query").submit(function(e){
		e.preventDefault();
		$("#form_query_btn").click();
	});
	$("#form_query_btn").click(function(){
		$('#modal_form_query').modal('hide');
        $("#tb_list").bootstrapTable('refresh');
	});
}
/* 全局函数 */
$(function() {
	initTable();
	initToolbar();
	initModalFormQuery();
	initBtnPermit("${sessionScope.CUR_MENU_PERMIT_ID}");
});
</script>
</head>
<body>
<!-- toolbar
======================================================================================================= -->
<div id="toolbar">
<button type="button" class="btn btn-default" id="bar_btn_add" pbtnId="pbtn_add"><i class="glyphicon glyphicon-plus"></i></button>
<button type="button" class="btn btn-default" id="bar_btn_del" pbtnId="pbtn_del"><i class="glyphicon glyphicon-remove"></i></button>
<button type="button" class="btn btn-default" id="bar_btn_query" pbtnId="pbtn_query" data-toggle="modal" data-target="#modal_form_query"><i class="glyphicon glyphicon-search"></i></button>
</div>
<!-- data list
======================================================================================================= -->
<div class="wrapper">
	<div class="row clearfix">
		<div class="col-md-10 column">
			<fieldset>
			<legend>列表</legend>
				<table id="tb_list"></table>
			</fieldset>
		</div>
		<div class="col-md-2 column">
			<fieldset>
			<legend>预览</legend>
				<input type="checkbox" id="expandAll"/><label for="expandAll">&nbsp;展开</label>
				<ul id="menuTree" class="ztree" style="height:700px; overflow:auto"></ul>
			</fieldset>
		</div>
	</div>
</div>
<!-- query form modal
======================================================================================================= -->
<form id="form_query">
<div id="modal_form_query" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal_label" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			   <h4 class="modal-title" id="modal_label">筛选条件</h4>
			</div>
			<div class="modal-body">
				<!-- queryForm -->
				<div class="form-group">
					 <label for="f_tc_name">菜单名称：</label><input type="text" class="form-control" id="f_tc_name"/>
				</div>
			</div>
			<div class="modal-footer">
			   <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-repeat"></i></button>
			   <button type="button" class="btn btn-default" data-dismiss="modal"><i class="glyphicon glyphicon-remove"></i></button>
			   <button type="button" class="btn btn-primary" id="form_query_btn"><i class="glyphicon glyphicon-ok"></i></button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
</form>
</body>
</html>

