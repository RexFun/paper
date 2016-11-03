<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
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
	check: 
	{
		enable: true
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
        $("#tb_list").bootstrapTable('refresh');
	}
};
/* 初始化toolbar */
function initToolbar() {
	$("#b_add").click(function(){
		location.href = "add1.action";
	});
	$("#b_del").click(function(){
		if(getIdSelections().length<1) {
			alert("没选择");
			return;
		}
		if(!confirm("确认删除？")) return;
		$.post("del.action",{id:getIdSelections()},function(data){
			$("#tb_list").bootstrapTable('refresh');
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
		height:"500",
		striped:true,
		pagination:true,
		pageList:"[5,10,20]",
	    queryParams: function (p) {
	    	p.tc_name = $("#f_tc_name").val();
            return p;
	    },
	    columns:
	    [
	     {checkbox:true, align:'center', valign:'middle'},
	     {title:'ID', field:'m.id', align:'center', valign:'middle', sortable:true},
	     {title:'PID', field:'m.pid', align:'center', valign:'middle', sortable:true},
	     {title:'菜单代号', field:'m.tc_code', align:'center', valign:'middle', sortable:true},
	     {title:'菜单名称', field:'m.tc_name', align:'center', valign:'middle', sortable:true},
	     {title:'菜单URL', field:'m.tc_url', align:'center', valign:'middle', sortable:true},
	     {title:'菜单权限ID', field:'m.tc_sys_permit_id', align:'center', valign:'middle', sortable:true},
	     {title:'操作', field:'operate', align:'center', valign:'middle', 
	    	 events:operateEvents, 
	    	 formatter:operateFormatter}
	    ]
	});
}
// 操作列
function operateFormatter(value, row, index) {
    return [
        '<button type="button" class="btn btn-default upd">',
        '<i class="glyphicon glyphicon-edit"></i>',
        '</button>&nbsp&nbsp&nbsp&nbsp',
        '<button type="button" class="btn btn-default getById">',
        '<i class="glyphicon glyphicon-info-sign"></i>',
        '</button>'
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
		$("#b_query").click();
	});
	$("#b_query").click(function(){
		$('#modal_form_query').modal('hide');
        $("#tb_list").bootstrapTable('refresh');
	});
}
/* 全局函数 */
$(function() {
	initTable();
	initToolbar();
	initModalFormQuery();
});
</script>
</head>
<body>
<!-- title
======================================================================================================= -->
<ul class="breadcrumb">
<li class="active">菜单管理</li>
</ul>
<!-- toolbar
======================================================================================================= -->
<div id="toolbar">
<div class="btn-group">
<button type="button" class="btn btn-default" id="b_add"><i class="glyphicon glyphicon-plus"></i></button>
<button type="button" class="btn btn-default" id="b_del"><i class="glyphicon glyphicon-remove"></i></button>
<button type="button" class="btn btn-default" data-toggle="modal" data-target="#modal_form_query"><i class="glyphicon glyphicon-search"></i></button>
</div>
</div>
<!-- data list
======================================================================================================= -->
<div class="container">
	<div class="row clearfix">
		<div class="col-md-10 column">
			<fieldset>
			<legend>菜单列表</legend>
				<table id="tb_list"></table>
			</fieldset>
		</div>
		<div class="col-md-2 column">
			<fieldset>
			<legend>预览</legend>
				<input type="checkbox" id="expandAll"/><label for="expandAll">&nbsp;展开</label>
				<ul id="menuTree" class="ztree"></ul>
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
			   <button type="button" class="btn btn-primary" id="b_query"><i class="glyphicon glyphicon-ok"></i></button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
</form>
</body>
</html>

