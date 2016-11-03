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
</script>
</head>
<body>
<!-- title -->
<ol class="breadcrumb">
	<li><a href="get.action">菜单管理</a></li>
	<li class="active">明细</li>
</ol>
<div class="container">
	<div class="row clearfix">
		<div class="col-md-6 column">
			<fieldset>
			<legend>基础信息</legend>
				<dl class="dl-horizontal">
					<dt>菜单ID：</dt><dd>${po.m.id}</dd>
					<dt>菜单父ID：</dt><dd>${po.m.pid}</dd>
					<dt>菜单代号：</dt><dd>${po.m.tc_code}</dd>
					<dt>菜单名称：</dt><dd>${po.m.tc_name}</dd>
					<dt>菜单URL：</dt><dd>${po.m.tc_url}</dd>
					<dt>菜单权限ID：</dt><dd>${po.m.tc_sys_permit_id}</dd>
				</dl>
			</fieldset>
		</div>
		<div class="col-md-6 column">
			<fieldset>
			<legend>权限</legend>
				<input type="checkbox" id="expandAll"/><label for="expandAll">&nbsp;展开</label>
				<ul id="permitTree" class="ztree"></ul>
			</fieldset>
		</div>
	</div>
</div>
</body>
</html>
