<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/inc_ctx.jsp"%>
<%@ include file="/common/inc_css.jsp"%>
<%@ include file="/common/inc_js.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/res/ztree/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript" src="${ctx}/res/ztree/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript">
/**********************************************************/
/* 保存后回调函数 */
/**********************************************************/
$rex.form.callback = function(){
	if($rex.result.type == 1){
		location.href = "getMyInfo.action?id=${po.m.id}";
	}
};
/**********************************************************/
/* 全局函数 */
/**********************************************************/
$(function(){
	// zTree的初始化
    zTreeObj = $.fn.zTree.init($("#roleTree"), setting);
    // 全部展开/折叠
    $("#expandAll").click(function(){
    	var zTree = $.fn.zTree.getZTreeObj("roleTree");
        if($(this).prop("checked")==true){
        	zTree.expandAll(true);
        }else{
        	zTree.expandAll(false);
        }
    });
});
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
	}
};
</script>
</head>
<body>
<!-- toolbar
======================================================================================================= -->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
<div class="container-fluid">
<div class="navbar-header"><a class="navbar-brand" href="#"><i class="glyphicon glyphicon-info-sign"></i></a></div>
<button type="submit" class="btn btn-default navbar-btn dataFormSave" id="dataFormSave"><i class="glyphicon glyphicon-floppy-save"></i></button>
</div>
</nav>
<!-- form -->
<form class="dataForm" id="dataForm" role="form" action="upd2.action" method="post">
<div class="wrapper">
	<div class="row clearfix">
		<div class="col-md-6 column">
			<fieldset>
			<legend>基础信息</legend>
				<div class="form-group"><label for="tc_code">用户代号：</label><input type="text" class="form-control" id="tc_code" name="po.m.tc_code" value="${po.m.tc_code}"/></div>
				<div class="form-group"><label for="tc_name">用户名称：</label><input type="text" class="form-control" id="tc_name" name="po.m.tc_name" value="${po.m.tc_name}"/></div>
				<div class="form-group"><label for="tc_email">用户邮箱：</label><input type="text" class="form-control" id="tc_email" name="po.m.tc_email" value="${po.m.tc_email}"/></div>
				<input type="hidden" name="po.m.id" value="${po.m.id}">
				<input type="hidden" id="tc_sys_role_ids" name="po.m.tc_sys_role_ids" value="${po.m.tc_sys_role_ids}">
			</fieldset>
		</div>
		<div class="col-md-6 column">
			<fieldset>
			<legend>角色</legend>
				<input type="checkbox" id="expandAll"/><label for="expandAll">&nbsp;展开</label>
				<ul id="roleTree" class="ztree" style="height:700px; overflow:auto"></ul>
			</fieldset>
		</div>
	</div>
</div>
</form>
</body>
</html>
