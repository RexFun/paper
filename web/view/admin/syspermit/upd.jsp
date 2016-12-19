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
	check: {
		enable: true,
		chkStyle: "radio",
		radioType: "all"
	},
	view: {
		dblClickExpand: false
	},
	async: 
	{
		enable: true,
		url:"getPermitTreeNodes.action?id=${po.m.pid}"
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
		onClick: onClick,
		onAsyncSuccess: onAsyncSuc
	}
};
function onClick(e, treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj("permitTree");
	zTree.checkNode(treeNode, !treeNode.checked, null, true);
	return false;
}
function onAsyncSuc(e, treeId, treeNode, msg) {
	setCheckedNodeVal();
}
function setCheckedNodeVal() {
	var zTree = $.fn.zTree.getZTreeObj("permitTree");
	var nodes = zTree.getCheckedNodes(true);
	var vPermitName = "";
	var vPermitId = "";
	for (var i=0, l=nodes.length; i<l; i++) {
		var pNode = nodes[i].getParentNode();
		var tNode = nodes[i];
		var pNodeTcName = pNode?pNode.tc_name:"";
		var tNodeTcName = tNode.tc_name;
		vPermitName += pNodeTcName+"-"+tNodeTcName+ ",";
		vPermitId = tNode.id;
	}
	if (vPermitName.length > 0 ) vPermitName = vPermitName.substring(0, vPermitName.length-1);
	$("#sel_permit").val(vPermitName);
	$("#pid").val(vPermitId);
	
}
function showMenu() {
	$("#modal_permitTree").modal("show");
}
function hideMenu() {
	$("#modal_permitTree").modal("hide");
}
// zTree的初始化
$(function(){
    zTreeObj = $.fn.zTree.init($("#permitTree"), setting);
    // 全部展开/折叠
    $("#ckb_expandAll").click(function(){
    	var zTree = $.fn.zTree.getZTreeObj("permitTree");
        if($(this).prop("checked")==true){
        	zTree.expandAll(true);
        }else{
        	zTree.expandAll(false);
        }
    });
    $("#sel_permit").click(showMenu);
    $("#modal_btn_ok").click(function(){
    	setCheckedNodeVal();
    	hideMenu();
    });
});
</script>
<script type="text/javascript">
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
	<div class="form-group"><label for="pid">父ID：</label>
		<input type="text" class="form-control" id="sel_permit"/>
		<input type="hidden" class="form-control" id="pid" name="po.m.pid" value="${po.m.pid}"/>
	</div>
	<div class="form-group"><label for="tc_code">权限代号：</label><input type="text" class="form-control" id="tc_code" name="po.m.tc_code" value="${po.m.tc_code}"/></div>
	<div class="form-group"><label for="tc_name">权限名称：</label><input type="text" class="form-control" id="tc_name" name="po.m.tc_name" value="${po.m.tc_name}"/></div>
	<div class="form-group"><label for="tc_type">权限类型：</label><input type="text" class="form-control" id="tc_type" name="po.m.tc_type" value="${po.m.tc_type}"/></div>
	<div class="form-group"><label for="tc_url">权限URL：</label><input type="text" class="form-control" id="tc_url" name="po.m.tc_url" value="${po.m.tc_url}"/></div>
	<div class="form-group"><label for="tc_order">权限排序号：</label><input type="text" class="form-control" id="tc_order" name="po.m.tc_order" value="${po.m.tc_order}"/></div>
	<input type="hidden" name="po.m.id" value="${po.m.id}">
	<button type="submit" class="btn btn-default" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
	<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
</form>
<!-- 权限树选择框
======================================================================================================= -->
<div id="modal_permitTree" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal_label" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			   <h4 class="modal-title" id="modal_label" style="display:inline;">权限树</h4>&nbsp;&nbsp;&nbsp;&nbsp;
			   <input type="checkbox" id="ckb_expandAll"/><label for="ckb_expandAll">&nbsp;展开</label>
			</div>
			<div class="modal-body" style="max-height:400px;overflow:auto;">
				<ul id="permitTree" class="ztree"></ul>
			</div>
			<div class="modal-footer">
			   <button type="button" class="btn btn-default" id="modal_btn_cancel" data-dismiss="modal"><i class="glyphicon glyphicon-remove"></i></button>
			   <button type="button" class="btn btn-primary" id="modal_btn_ok"><i class="glyphicon glyphicon-ok"></i></button>
			</div>
		</div>
	</div>
</div>
</body>
</html>
