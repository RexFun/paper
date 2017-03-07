<script type="text/javascript">
/* 初始化按钮权限 
 * btnPermitArr : ${sessionScope.CUR_LOGIN_USER.m.btn_permit_json}
 * menuPermitId : 菜单权限id
 * */
function initBtnPermit(menuPermitId) {
	var btnPermitArr = ${sessionScope.CUR_LOGIN_USER.m.btnPermitJson};
	if (!btnPermitArr) return;
	if(btnPermitArr.length>0){
		$.each($("[pbtnId^='pbtn_']"),function(i,o) {
			for(var j=0; j<btnPermitArr.length; j++) {
				if(menuPermitId==btnPermitArr[j].pid) {
					if(($(o).attr('pbtnId')).indexOf(btnPermitArr[j].tc_code) == -1) {
						$(o).css({"display":"none"});
					}else{
						$(o).css({"display":""});
						break;
					}
				}else{
					$(o).css({"display":"none"});
				}
			}
		});
	}else{
		$("[pbtnId^='pbtn_']").css({"display":"none"});
	}
}
</script>
