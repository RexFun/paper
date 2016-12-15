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
		enable: true,
		chkStyle: "radio",
		radioType: "all"
	},
	async: 
	{
		enable: true,
		url:"getPermitTreeNodesByMenu.action?id=${po.m.id}"
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
		onCheck: function (event, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("permitTree")
		    var nodes = zTree.getCheckedNodes(true);
			if (nodes.length>0) $("#tc_sys_permit_id").val(nodes[0].id);
		}
	}
};
// zTree的初始化
$(function(){
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
});
/**********************************************************/
/* 界面回调函数 */
/**********************************************************/
$gwen.form.callback = function(){
	if($gwen.result.type == 1){
		location.href = "get.action";
	}
};
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li class="active">修改</li>
</ol>
<!-- form -->
<form id="dataForm" role="form" action="upd2.action" method="post">
<div class="wrapper">
	<div class="row clearfix">
		<div class="col-md-6 column">
			<fieldset>
			<legend>基础信息</legend>
				<div class="form-group"><label for="pid">父ID：</label><input type="text" class="form-control" id="pid" name="po.m.pid" value="${po.m.pid}"/></div>
				<div class="form-group"><label for="tc_code">菜单代号：</label><input type="text" class="form-control" id="tc_code" name="po.m.tc_code" value="${po.m.tc_code}"/></div>
				<div class="form-group"><label for="tc_name">菜单名称：</label><input type="text" class="form-control" id="tc_name" name="po.m.tc_name" value="${po.m.tc_name}"/></div>
				<div class="form-group"><label for="tc_url">菜单URL：</label><input type="text" class="form-control" id="tc_url" name="po.m.tc_url" value="${po.m.tc_url}"/></div>
				<div class="form-group"><label for="tc_order">菜单排序号：</label><input type="text" class="form-control" id="tc_order" name="po.m.tc_order" value="${po.m.tc_order}"/></div>
				<div class="form-group"><label for="tc_sys_permit_id">菜单权限ID：</label><input type="text" class="form-control" id="tc_sys_permit_id" name="po.m.tc_sys_permit_id" value="${po.m.tc_sys_permit_id}" readonly="readonly"/></div>
				<input type="hidden" name="po.m.id" value="${po.m.id}">
				<button type="submit" class="btn btn-default" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
				<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
			</fieldset>
		</div>
		<div class="col-md-6 column">
			<fieldset>
			<legend>权限</legend>
				<input type="checkbox" id="expandAll"/><label for="expandAll">&nbsp;展开</label>
				<ul id="permitTree" class="ztree" style="height:700px; overflow:auto"></ul>
			</fieldset>
		</div>
	</div>
</form>
</body>
</html>
