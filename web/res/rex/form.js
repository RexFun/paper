$rex = {};
$rex.form = {};
$rex.result = {type:"", msg:""};
$rex.checkResult = function(responseText){
	$rex.result = {type:"", msg:""};
	try{
		var _msg = "", _arr = (responseText + "").split(":");
		if(_arr.length > 1){_msg = _arr[1];}
		else{switch(_arr[0]){
			case "0": _msg = "操作失败！";break;
			case "1": _msg = "操作成功！";break;
			default: _msg = (!isNaN(_arr[0]))?"":_arr[0];
		}}
		$rex.result = {type:_arr[0], msg:_msg};
	}
	catch(e){$rex.result = {type:"", msg:""};}
	return $rex.result.msg;
};
$(function(){
	$("#dataFormSave").click(function () {
        var options = {
            url: $("#dataForm").attr("action"),
            type: 'post',
            dataType: 'text',
            data: $("#dataForm").serialize(),
            enctype: $("#dataForm").attr("enctype"),
            success: function (data) {
            	alert($rex.checkResult(data));
                $rex.form.callback();
            }
        };
        $("#dataForm").ajaxSubmit(options);
        return false;
    });
	$("#dataForm").submit(function(e){
		e.preventDefault();try{$("#dataFormSave").click();}catch(e){}
	});
	$("#form_del").submit(function(e){
		e.preventDefault();
        var options = {
            url: $("#form_del").attr("action"),
            type: 'post',
            dataType: 'text',
            data: $("#form_del").serialize(),
            success: function (data) {
            	alert($rex.checkResult(data));
                $rex.form.callback();
            }
        };
        $.ajax(options);
        return false;
	});
});
