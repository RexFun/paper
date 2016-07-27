<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<script type="text/javascript">
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
		location.href = "getPaperModels.action?pid=${pid}";
	}
};
$(function(){
	$("#pid").val("${result.data.pid}");
	
	$("#ckb_all").click(function(){
		$("input[name='keyIndex']").prop("checked",$(this).prop("checked"));
	});
	$("button[name='b_add']").click(function(){
		location.href = "addPaperModel1.action";
	});
	$("button[name='b_del']").click(function(){
		$("#form_del").submit();
	});
	$("button[name='b_query']").click(function(){
		$('#modal_form_query').modal('hide');
		$("#form_query").submit();
	});
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
<div class="btn-group">
	<button type="button" class="btn btn-default" name="b_add">新增</button>
	<button type="button" class="btn btn-default" name="b_del">删除</button>
	<button type="button" class="btn btn-default" data-toggle="modal" data-target="#modal_form_query">查询</button>
</div>
<!-- data list
======================================================================================================= -->
<form style="padding-top:10px;padding-bottom:10px" id="form_del" action="delPaperModel.action" method="post">
<table data-toggle="table" data-striped="true" onload="this.height=mainFrame.document.body.scrollHeight" >
	<thead>
	<tr>
		<th style="width:2%"><input id="ckb_all" type="checkbox"/></th>
		<th data-sortable="true">主键</th>
		<th data-sortable="true">外键</th>
		<th data-sortable="true">模型名</th>
		<th data-sortable="true">排序号</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator var="o" value="result.data.resultList">
	<tr>
		<td><input name="keyIndex" type="checkbox" value="${o.id}"/></td>
		<td>${o.id}</td>
		<td>${o.pid}</td>
		<td>${o.name}</td>
		<td>${o.sort}</td>
		<td>
			<a name="a_upd" href="updPaperModel1.action?id=${o.id}">修改</a>
			<a name="a_getById" href="getPaperModelById.action?id=${o.id}">明细</a>
			<a name="a_getPaperImagesByPid" href="../paperimage/getPaperImages.action?pid=${o.id}&ppid=${o.pid}">图片管理</a>
		</td>
	</tr>
	</s:iterator>
	</tbody>
</table>
<input name="page" type="hidden" value="${page.curPage}" />
</form>
<div>
${pageNav.pageHtml}
</div>
<!-- query form modal
======================================================================================================= -->
<div id="modal_form_query" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			   <h4 class="modal-title" id="myModalLabel">筛选条件</h4>
			</div>
			<div class="modal-body">
				<!-- queryForm -->
				<form role="form" id="form_query" action="getPaperModels.action" method="post">
				<div class="form-group">
					<label for="pid">类别名：</label>
				 	<select class="form-control" id="pid" name="pid">
						<option value="">请选择</option>
						<s:iterator var="po" value="result.data.catList">
						<option value="${po.id}">${po.name}</option>
						</s:iterator>
					</select>
				</div>
				<div class="form-group">
					<label for="name">模型名：</label><input type="text" class="form-control" name="name" />
				</div>
				</form>
			</div>
			<div class="modal-footer">
			   <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			   <button type="button" class="btn btn-primary" name="b_query">确定</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
</body>
</html>
