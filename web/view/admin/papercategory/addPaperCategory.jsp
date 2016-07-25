<%@ page contentType="text/html; charset=UTF-8"%>
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
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li><a href="getPaperCategorys.action">类别管理</a></li>
	<li class="active">新增</li>
</ol>
<!-- form -->
<form id="dataForm" role="form" action="addPaperCategory2.action" method="post">
	<div class="form-group"><label for="name">类别名：</label><input type="text" class="form-control" name="po.name" /></div>
	<div class="form-group"><label for="name">排序号：</label><input type="text" class="form-control" name="po.sort" /></div>
	<button type="submit" class="btn btn-default" id="dataFormSave">保存</button>
</form>
</body>
</html>

