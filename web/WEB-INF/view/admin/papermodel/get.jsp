<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_header.jsp"%>
<!-- 主内容面板 -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>${param.menuName}</h1>
		<ol class="breadcrumb">
			<li><a href="${ctx}/index.jsp"><i class="fa fa-dashboard"></i> 首页</a></li>
			<li class="active">${param.menuName}</li>
		</ol>
	</section>
	<section class="content">
		<div class="row">
		<div class="col-md-12">
		<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title"><small><i class="glyphicon glyphicon-th-list"></i></small></h3>
		</div>
		<div class="box-body">
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
		</div>
		</div>
		</div>
		</div>
	</section>
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
			<div class="modal-body form-body">
				<!-- queryForm -->
				<div class="form-group">
					<label for="f_pid">类别名：</label>
				 	<select class="form-control input-sm" id="f_pid">
						<option value="">请选择</option>
						<c:forEach var="c" items="${catList}">
						<option value="${c.m.id}">${c.m.name}</option>
						</c:forEach>
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
<%@ include file="/common/inc_footer.jsp"%>
<%@ include file="/common/inc_js_btn_permit.jsp"%>
<script type="text/javascript" src="/static/res/chok/js/chok.view.get.js"></script>
<script type="text/javascript">
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function() {
	$chok.view.fn.selectSidebarMenu("${param.menuId}","${param.menuName}");
	$chok.view.get.init.toolbar();
	$chok.view.get.init.modalFormQuery();
	$chok.view.get.init.table("${queryParams.f_page}","${queryParams.f_pageSize}");
	initBtnPermit("${sessionScope.CUR_MENU_PERMIT_ID}");
});
/**********************************************************/
/* 初始化配置 */
/**********************************************************/
$chok.view.get.config.setPreFormParams = function(){
	$("#f_name").val(typeof("${queryParams.f_name}")=="undefined"?"":"${queryParams.f_name}");
	$("#f_pid").val(typeof("${queryParams.f_pid}")=="undefined"?"":"${queryParams.f_pid}");
};
$chok.view.get.config.formParams = function(p){
	p.name = $("#f_name").val();
	p.pid = $("#f_pid").val();
    return p;
};
$chok.view.get.config.urlParams = function(){
	return {f_name : $("#f_name").val(),
			f_pid  : $("#f_pid").val()};
};
$chok.view.get.config.tableColumns = 
[
    {title:'ID', field:'m.id', align:'center', valign:'middle', sortable:true},
    {title:'PID', field:'m.pid', align:'center', valign:'middle', sortable:true, visible:false},
    {title:'模型名', field:'m.name', align:'center', valign:'middle', sortable:true},
    {title:'分类名', field:'m.catname', align:'center', valign:'middle', sortable:true},
    {title:'排序号', field:'m.sort', align:'center', valign:'middle', sortable:true}
];
//配置行菜单
$chok.view.get.config.operateFormatter = function(value, row, index){
	var url_upd1 = "upd1.action?id="+row.m.id+"&"+$chok.view.get.fn.getUrlParams();
	var url_getById = "getById.action?id="+row.m.id+"&"+$chok.view.get.fn.getUrlParams();
	var url_getImages = "../paperimage/get.action?pid="+row.m.id+"&ppid="+row.m.pid+"&"+$chok.view.get.fn.getUrlParams();
    return ['<div class="btn-group">',
	    	'<button type="button" class="btn btn-default dropdown-toggle btn-sm" data-toggle="dropdown">',
	    	'<span class="caret"></span>',
	    	'</button>',
	    	'<ul class="dropdown-menu" role="menu">',
	    	'<li class="upd" pbtnId="pbtn_upd'+index+'">',
	    	'<a href="'+url_upd1+'">',
	        '<i class="glyphicon glyphicon-edit"></i>',
	    	'</a>',
	    	'</li>',
	    	'<li class="getById" pbtnId="pbtn_getById'+index+'">',
	    	'<a href="'+url_getById+'">',
	        '<i class="glyphicon glyphicon-info-sign"></i>',
	    	'</a>',
	    	'</li>',
	    	'<li class="getImages" pbtnId="pbtn_getImages'+index+'">',
	    	'<a href="'+url_getImages+'">',
	        '<i class="glyphicon glyphicon-picture"></i>',
	    	'</a>',
	    	'</li>',
	    	'</ul>',
	    	'</div>'
		    ].join('');
};
$chok.view.get.callback.delRows = function(){
};
$chok.view.get.callback.onLoadSuccess = function(){
	initBtnPermit("${sessionScope.CUR_MENU_PERMIT_ID}");
};
</script>