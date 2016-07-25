<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=path%>/js/bootstrap/css/bootstrap.min.css"/>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery.js"></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="<%=path%>/js/gwen/form.js"></script>
<script type="text/javascript">
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
		location.href = "getPaperCategorys.action";
	}
};
$(function(){
	$("#ckb_all").click(function(){
		$("input[name='keyIndex']").prop("checked",$(this).prop("checked"));
	});
	$("button[name='b_add']").click(function(){
		location.href = "addPaperCategory1.action";
	});
	$("button[name='b_del']").click(function(){
		$("#form_del").submit();
	});
	$("button[name='b_query']").click(function(){
		$("#form_query").submit();
	});
});
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
  <li class="active">类别管理</li>
</ol>
<!-- toolbar -->
<div class="btn-group">
<button type="button" class="btn btn-default" name="b_add">新增</button>
<button type="button" class="btn btn-default" name="b_del">删除</button>
<button type="button" class="btn btn-default" name="b_query" >查询</button>
</div>
<hr>
<!-- queryForm -->
<form role="form" class="form-inline" id="form_query" action="getPaperCategorys.action" method="post">
<div class="form-group">
	 <label for="name">类别名：</label><input type="text" class="form-control" name="name" />
</div>
</form>
<hr>
<!-- list -->
<form id="form_del" action="delPaperCategory.action" method="post">
<table class="table table-striped table-hover">
	<tr>
		<td style="width:2%"><input id="ckb_all" type="checkbox"/></td>
		<td>主键</td>
		<td>类别名</td>
		<td>排序号</td>
		<td>操作</td>
	</tr>
	<s:iterator var="o" value="result.data.resultList">
	<tr>
		<td><input name="keyIndex" type="checkbox" value="${o.id}"/></td>
		<td>${o.id}</td>
		<td>${o.name}</td>
		<td>${o.sort}</td>
		<td>
			<a name="a_upd" href="updPaperCategory1.action?id=${o.id}">修改</a>
			<a name="a_getById" href="getPaperCategoryById.action?id=${o.id}">明细</a>
			<%-- <a name="a_getPaperModelsByPid" href="../papermodel/getPaperModels.action?pid=${d.id}">模型管理</a> --%>
		</td>
	</tr>
	</s:iterator>
</table>
<input name="page" type="hidden" value="${page.curPage}" />
</form>
<div align="right">
${pageNav.pageHtml}
</div>
</body>
</html>
