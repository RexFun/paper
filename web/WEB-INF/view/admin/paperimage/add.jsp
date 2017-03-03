<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_header.jsp"%>
<!-- 主内容面板 -->
<div class="content-wrapper">
	<section class="content-header">
		<h1>${param.menuName}<small>${modelName}</small></h1>
		<ol class="breadcrumb">
			<li><a href="${ctx}/index.jsp"><i class="fa fa-dashboard"></i> 首页</a></li>
			<li><a href="../papermodel/get.action?menuId=${param.menuId}&menuName=${param.menuName}">${param.menuName}</a></li>
			<li class="active">${modelName}</li>
		</ol>
	</section>
	<section class="content	>
		<div class="box box-default">
			<di	 class="box-header with-border">
				<h3 class="box-title"><small><i class="glyphicon 	lyphicon-plus"></i></small></h3>
				<	iv class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool" id="back"><i class="glyphicon gl	phicon-ar	ow-left"	</i></button>
				</div>
			</div>
			<div class="box-body">
				<form class="dataForm">
					<input id="myFile" name="myFile" type="fil		 multiple class="file-loading">
					<div id="kv-error-2" style="mar		n-top:10px;display:none"></div>
					<div id="kv-success-2" class="alert alert-success fade in" style="mar	in-top:10p	;display	none"></div>
				</form>
			</div>
			<div class="box-footer">&nbsp;</div>
		</div>
	</section>
</div>
<%@ include file="/common/inc_footer.jsp"%>
<!-- ======================================================================================================= -->
<%@ include file="/common/inc_js_btn_permit.jsp"%>
<link rel="stylesheet" href="${ctx}/res/bs/fileinput/css/fileinput.min.css"/>
<script type="text/javascript" src="${ctx}/res/bs/fileinput/js/fileinput.min.js"></script>
<script type="text/javascript" src="${ctx}/res/chok/js/chok.view.add.js"></script>
<script type="text/javascript">
$(function(){
	$chok.view.fn.selectSidebarMenu("${param.menuId}","${param.menuName}");
	// 返回列表页
	$("#back").click(function(){
		history.back();
	});
	//
	$("#myFile").fileinput({
	    uploadUrl: "add2.action?pid=${pid}&ppid=${ppid}", // server upload action
	    allowedFileExtensions : ['jpg','png','gif'],
	    uploadAsync: false,
	    minFileCount: 1,
	    maxFileCount: 10
	}).on('filebatchpreupload', function(event, data, id, index) {
	    $('#kv-success-2').html('<h4>Upload Status</h4><ul></ul>').hide();
	}).on('filebatchuploaderror', function(event, data, msg) {
	    var form = data.form, files = data.files, extra = data.extra,
	        response = data.response, reader = data.reader;
	    var out = '';
	    $.each(data.files, function(key, file) {
	        var fname = file.name;
	        out = out + '<li>' + '上传 # ' + (key + 1) + ' - '  +  fname + ' 失败.' + '</li>';
	    });
	    $('#kv-error-2 ul').append(out);
	    $('#kv-error-2').show();
	}).on('filebatchuploadsuccess', function(event, data, previewId, index) {
	    var form = data.form, files = data.files, extra = data.extra,
	        response = data.response, reader = data.reader;
	    var out = '';
	    $.each(data.files, function(key, file) {
	        var fname = file.name;
	        out = out + '<li>' + '上传 # ' + (key + 1) + ' - '  +  fname + ' 成功.' + '</li>';
	    });
	    $('#kv-success-2 ul').append(out);
	    $('#kv-success-2').show();
	    alert("上传图片成功！");
	    history.back();
		//location.href = "get.action?pid=${pid}&ppid=${ppid}";
	});
});
</script>
