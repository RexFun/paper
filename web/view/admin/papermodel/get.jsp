<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
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
	    	p.name = $("#f_name").val();
	    	p.pid = $("#f_pid").val();
            return p;
	    },
	    columns:
	    [
	     {checkbox:true, align:'center', valign:'middle'},
	     {title:'ID', field:'m.id', align:'center', valign:'middle', sortable:true},
	     {title:'PID', field:'m.pid', align:'center', valign:'middle', sortable:true, visible:false},
	     {title:'类别名', field:'m.catname', align:'center', valign:'middle', sortable:true},
	     {title:'模型名', field:'m.name', align:'center', valign:'middle', sortable:true},
	     {title:'排序号', field:'m.sort', align:'center', valign:'middle', sortable:true},
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
        '</button>',
        '&nbsp&nbsp&nbsp&nbsp',
        '<button type="button" class="btn btn-default getById">',
        '<i class="glyphicon glyphicon-info-sign"></i>',
        '</button>'
        ,'&nbsp&nbsp&nbsp&nbsp',
        '<button type="button" class="btn btn-default getImages">',
        '<i class="glyphicon glyphicon-picture"></i>',
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
    },
    'click .getImages': function (e, value, row, index) {
		location.href = "../paperimage/getPaperImages.action?pid="+row.m.id+"&ppid="+row.m.pid;
    }
};
// 获取列表已选行rowid
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
<li class="active">模型管理</li>
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
<table id="tb_list"></table>
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
			<div class="modal-body form-body">
				<!-- queryForm -->
				<div class="form-group">
					<label for="f_pid">类别名：</label>
				 	<select class="form-control" id="f_pid">
						<option value="">请选择</option>
						<s:iterator var="c" value="result.data.catList">
						<option value="${c.m.id}">${c.m.name}</option>
						</s:iterator>
					</select>
				</div>
				<div class="form-group">
					<label for="f_name">模型名：</label><input type="text" class="form-control" id="f_name"/>
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
