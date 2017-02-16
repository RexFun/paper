$rex.validator = {
	/**
	 * prop
	 * 定义规则算法 
	 */
	rules:{
		/**
		 * prop
		 * 规则-正则表达式
		 */
		reg:{
			number:function(v){
				var r = /^(\-|\+)?\d+(\.\d+)?$/;
				return r.test(v);
			},
			integer:function(v){
				var r = /^-?\d+$/;
				return r.test(v);
			},
			email:function(v){
				var r = /^([\w-_]+(?:\.[\w-_]+)*)@((?:[a-z0-9]+(?:-[a-zA-Z0-9]+)*)+\.[a-z]{2,6})$/i;
				return r.test(v);
			}
		},
		/**
		 * prop
		 *  定义规则提示信息 
		 */
		msgs:{
			"required":"必填",
			"number":"输入类型必须为数字",
			"integer":"输入类型必须为整数",
			"minLength":"字符串长度不得大于{0}",
			"maxLength":"字符串长度不到小于{0}"
		},
		/**
		 * fn
		 * 规则-必填
		 */
		required:function(){
			var v = true;
			$("[required]").each(function(){
				if($(this).val().length<1){
					$(this).parent().addClass("has-error");
					$rex.validator.addMsg("required",$(this));
				}else{
					$(this).parent().removeClass("has-error");
					$rex.validator.removeMsg($(this));
				}
			});
			$("[required]").each(function(i){
				if($(this).parent().hasClass("has-error")){
					v = false;
				}
			});
			return v;
		},
		/**
		 * fn
		 * 规则-输入类型
		 */
		inputType:function(){
			var v = true;
			$("[validate-rule-inputType]").each(function(){
				var t = $(this).attr("validate-rule-inputType");
				if(!$rex.validator.rules.reg[t]($(this).val())){
					$(this).parent().addClass("has-error");
					$rex.validator.addMsg(t,$(this));
				}else{
					$(this).parent().removeClass("has-error");
					$rex.validator.removeMsg($(this));
				}
			});
			$("[validate-rule-inputType]").each(function(i){
				if($(this).parent().hasClass("has-error")){
					v = false;
				}
			});
			return v;
		},
		/**
		 * fn
		 * 规则-最小长度
		 */
		minLength:function(){
			var v = true;
			return v;
		},
		/**
		 * fn
		 * 规则-最大长度
		 */
		maxLength:function(){
			var v = true;
			return v;
		}
	},
	/**
	 * fn
	 * 添加提示
	 */
	addMsg:function(ruleType,$e){
		if($e.next(".control-label").length>0){
			$e.next(".control-label").text($rex.validator.rules.msgs[ruleType]);
		}
		else{
			$e.after("<label class=\"control-label\">"+$rex.validator.rules.msgs[ruleType]+"</label>");
		}
	},
	/**
	 * fn
	 * 移除提示
	 */
	removeMsg:function($e){
		$e.next(".control-label").remove();
	},
	/**
	 * fn
	 * 执行验证
	 */
	check:function(){
		var v = true;
		var a = [];
		a.push(this.rules.required());
		a.push(this.rules.inputType());
		a.push(this.rules.minLength());
		a.push(this.rules.maxLength());
		if(a.indexOf(false)!=-1) v=false;
		return v;
	}
};
