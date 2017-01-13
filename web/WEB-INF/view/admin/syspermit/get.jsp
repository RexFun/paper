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
	edit: 
	{
		enable: false//,
		/* editNameSelectAll: true,
		showRemoveBtn: showRemoveBtn,
		showRenameBtn: showRenameBtn */
	},
	check: 
	{
		enable: false
	},
	async: 
	{
		enable: true,
		url:"getPermitTreeNodes.action"
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
function initTree() {
    zTreeObj = $.fn.zTree.init($("#permitTree"), setting);
    // 全部展开/折叠
    $("#expandAll").click(function(){
    	var zTree = $.fn.zTree.getZTreeObj("permitTree");
        if($(this).prop("checked")==true){
        	zTree.expandAll(true);
        }else{
        	zTree.expandAll(false);
        }
    });
}
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
	    queryParams: function (p) {
	    	p.tc_p_name = $("#f_tc_p_name").val();
	    	p.tc_code = $("#f_tc_code").val();
	    	p.tc_name = $("#f_tc_name").val();
	    	p.tc_type = $("#f_tc_type").val();
            return p;
	    },
	    columns:
	    [
	     {checkbox:true, align:'center', valign:'middle'},
	     {title:'操作', field:'operate', align:'center', valign:'middle', width:'50',
	    	 events:operateEvents, 
	    	 formatter:operateFormatter},
	     {title:'权限代号', field:'m.tc_code', align:'center', valign:'middle', sortable:false},
	     {title:'权限名称', field:'m.tc_name', align:'center', valign:'middle', sortable:false},
	     {title:'权限URL', field:'m.tc_url', align:'center', valign:'middle', sortable:false},
	     {title:'权限排序号', field:'m.tc_order', align:'center', valign:'middle', sortable:false},
	     {title:'权限类型', field:'m.tc_type_name', align:'center', valign:'middle', sortable:false},
	     {title:'父节点', field:'m.tc_p_name', align:'center', valign:'middle', sortable:false}
	    ],
	    onLoadSuccess:function(){
	    	initBtnPermit("${sessionScope.CUR_MENU_PERMIT_ID}"); //加载完后，执行按钮权限验证
	    }
	});
	//随窗口resize 改变 高度
	$(window).resize(function () {
		$('#tb_list').bootstrapTable('resetView', {height: getGlobalHeight("table")});
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
        $("#tb_list").bootstrapTable('selectPage', 1);
	});
}
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function() {
	initTree();
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
			<table id="tb_list"></table>
		</div>
		<div class="col-md-2 column">
			<input type="checkbox" id="expandAll"/><label for="expandAll">&nbsp;展开</label>
			<ul id="permitTree" class="ztree" style="overflow:auto"></ul>
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
					<label for="f_tc_p_name">父节点名称：</label><input type="text" class="form-control" id="f_tc_p_name"/>
					<label for="f_tc_code">权限代号：</label><input type="text" class="form-control" id="f_tc_code"/>
					<label for="f_tc_name">权限名称：</label><input type="text" class="form-control" id="f_tc_name"/>
					<label for="f_tc_type">权限类型：</label>
					<select class="form-control" id="f_tc_type" name="po.m.tc_type">
						<option value="">全部</option>
						<option value="0">默认</option>
						<option value="1">按钮</option>
					</select>
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
