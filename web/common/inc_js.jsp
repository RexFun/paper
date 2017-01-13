<script type="text/javascript" src="${ctx}/lib/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/lib/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ctx}/lib/bs/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/lib/bs/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${ctx}/lib/bs/js/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript" src="${ctx}/lib/bs/js/bootstrap-table-fixed-columns.js"></script>
<script type="text/javascript" src="${ctx}/lib/jquery/jquery.form.js"></script>
<script type="text/javascript" src="${ctx}/lib/gwen/form.js"></script>
<script type="text/javascript" src="${ctx}/lib/gwen/ztree-selector-modal.js"></script>
<script type="text/javascript">
var $ctx="${ctx}";
function getGlobalHeight(type) {
	if (type=='table')
	   	return $(window).height() - 115;
	else if (type=='tree')
		return $(window).height() - 35;
}
</script>