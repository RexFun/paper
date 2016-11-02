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
		enable: true
	},
	async: 
	{
		enable: true,
		url:"getRoleTreeNodesByUser.action?id=${po.m.id}"
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
			var zTree = $.fn.zTree.getZTreeObj("roleTree")
		    var nodes = zTree.getCheckedNodes(true);
	    	var ids = [];
	    	for(var i=0; i<nodes.length; i++) {
	    		ids.push(nodes[i].id);
	    	}
	    	$("#tc_sys_role_ids").val(ids);
		}
	}
};
// zTree的初始化
$(function(){
    zTreeObj = $.fn.zTree.init($("#roleTree"), setting);
    // 全选/全不选
    $("#chkAll").click(function(){
    	var zTree = $.fn.zTree.getZTreeObj("roleTree");
        if($(this).prop("checked")==true){
        	zTree.checkAllNodes(true);
        }else{
        	zTree.checkAllNodes(false);
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
	<li><a href="get.action">用户管理</a></li>
	<li class="active">修改</li>
</ol>
<div class="container">
	<div class="row clearfix">
		<div class="col-md-6 column">
			<!-- form -->
			<form id="dataForm" role="form" action="upd2.action" method="post">
				<div class="form-group"><label for="tc_code">用户代号：</label><input type="text" class="form-control" id="tc_code" name="po.m.tc_code" value="${po.m.tc_code}"/></div>
				<div class="form-group"><label for="tc_name">用户名称：</label><input type="text" class="form-control" id="tc_name" name="po.m.tc_name" value="${po.m.tc_name}"/></div>
				<div class="form-group"><label for="tc_email">用户邮箱：</label><input type="text" class="form-control" id="tc_email" name="po.m.tc_email" value="${po.m.tc_email}"/></div>
				<div class="form-group"><label for="tc_password">用户密码：</label><input type="text" class="form-control" id="tc_password" name="po.m.tc_password" value="${po.m.tc_password}"/></div>
				<input type="hidden" name="po.m.id" value="${po.m.id}">
				<input type="hidden" id="tc_sys_role_ids" name="po.m.tc_sys_role_ids" value="${po.m.tc_sys_role_ids}">
				<button type="submit" class="btn btn-default" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
				<button type="button" class="btn btn-default" id="back" onclick="window.history.back()"><i class="glyphicon glyphicon-arrow-left"></i></button>
			</form>
		</div>
		<div class="col-md-6 column">
			<div style="border:solid 1px gray;margin:10px 0px 10px 0px">
				<div style="margin-left:10px">
					<input type="checkbox" id="chkAll" value=""/><label for="chkAll">全选</label>
				</div>
				<ul id="roleTree" class="ztree"></ul>
			</div>
		</div>
	</div>
</div>
</body>
</html>
