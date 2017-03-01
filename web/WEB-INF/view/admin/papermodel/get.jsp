<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_header.jsp"%>
<div class="box box-default">
<div class="box-body">
<div class="row">
<div class="col-md-12">
<!-- toolbar
======================================================================================================= -->
<div id="toolbar">
<button type="button" class="btn btn-default" id="bar_btn_add" pbtnId="pbtn_add"><i class="glyphicon glyphicon-plus"></i></button>
<button type="button" class="btn btn-default" id="bar_btn_del" pbtnId="pbtn_del"><i class="glyphicon glyphicon-remove"></i></button>
<button type="button" class="btn btn-default" id="bar_btn_query" pbtnId="pbtn_query" data-toggle="modal" data-target="#modal_form_query"><i class="glyphicon glyphicon-search"></i></button>
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
				 	<select class="form-control input-sm" id="f_pid">
						<option value="">请选择</option>
						<s:iterator var="c" value="result.data.catList">
						<option value="${c.m.id}">${c.m.name}</option>
						</s:iterator>
					</select>
				</div>
				<div class="form-group">
					<label for="f_name">模型名：</label><input type="text" class="form-control input-sm" id="f_name"/>
				</div>
			</div>
			<div class="modal-footer">
			   <button type="reset" class="btn btn-default"><i class="glyphicon glyphicon-repeat"></i></button>
			   <button type="button" class="btn btn-primary" id="form_query_btn"><i class="glyphicon glyphicon-ok"></i></button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
</form>
</div>
</div>
</div>
</div>
<%@ include file="/common/inc_footer.jsp"%>
<%@ include file="/common/inc_js_btn_permit.jsp"%>
<script type="text/javascript" src="${ctx}/res/rex/js/view.get.js"></script>
<script type="text/javascript">
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function() {
	$rex.view.fn.selectSidebarMenu("${param.menuId}");
	$rex.view.get.init.toolbar();
	$rex.view.get.init.modalFormQuery();
	$rex.view.get.init.table("${queryParams.f_page}","${queryParams.f_pageSize}");
	initBtnPermit("${sessionScope.CUR_MENU_PERMIT_ID}");
});
/**********************************************************/
/* 初始化配置 */
/**********************************************************/
$rex.view.get.config.setPreFormParams = function(){
	$("#f_name").val(typeof("${queryParams.f_name}")=="undefined"?"":"${queryParams.f_name}");
	$("#f_pid").val(typeof("${queryParams.f_pid}")=="undefined"?"":"${queryParams.f_pid}");
};
$rex.view.get.config.formParams = function(p){
	p.name = $("#f_name").val();
	p.pid = $("#f_pid").val();
    return p;
};
$rex.view.get.config.urlParams = function(){
	return {f_name : $("#f_name").val(),
			f_pid  : $("#f_pid").val()};
};
$rex.view.get.config.tableColumns = 
[
    {title:'ID', field:'m.id', align:'center', valign:'middle', sortable:true},
    {title:'PID', field:'m.pid', align:'center', valign:'middle', sortable:true, visible:false},
    {title:'模型名', field:'m.name', align:'center', valign:'middle', sortable:true},
    {title:'分类名', field:'m.catname', align:'center', valign:'middle', sortable:true},
    {title:'排序号', field:'m.sort', align:'center', valign:'middle', sortable:true}
];
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
	    	'<li class="getImages" pbtnId="pbtn_getImages'+index+'">',
	    	'<a href="javascript:void(0);">',
	        '<i class="glyphicon glyphicon-picture"></i>',
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
    },
    'click .getImages': function (e, value, row, index) {
		location.href = "../paperimage/get.action?pid="+row.m.id+"&ppid="+row.m.pid+"&"+$rex.view.get.fn.getUrlParams();
    }
};
$rex.view.get.callback.delRows = function(){
};
$rex.view.get.callback.onLoadSuccess = function(){
	initBtnPermit("${sessionScope.CUR_MENU_PERMIT_ID}");
};
</script>