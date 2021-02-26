function ExprConfig (option) {
	this.id = option.id;
	this.domId = option.domId;
	this.globalformid = option.globalformid;
	this.process = option.process;
    this.processFlag = option.processFlag;//标记是不是流程启动条件
	this.callback = option.callback;
	this.option = option;
	// 将配置信息保存到dom对象里，方便在弹出页面调用
	$("#"+this.domId).data("data-object", this);
	var id = encodeURIComponent(this.domId);
	this.template = "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ExprConfig/ExprSelect.jsp?id="+id;
	this.init();
}

ExprConfig.prototype.init = function() {
	var _self = this;
	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
		var box = layer.open({
		    type:  2,
		    area: [ "800px",  "620px"],
		    title: "表达式配置",
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		    shade:   0.3,
	        maxmin: false, //开启最大化最小化按钮
		    content: _self.template ,
		    btn: ['保存', '关闭'],
		    yes: function(index, layero){
		    	var $form =_self.form;
                /*var isValidate = $form.validate();
                if (!isValidate.checkForm()) {
                        isValidate.showErrors();
                        return;
                 }*/
                var iframeWin = layero.find('iframe')[0].contentWindow;
                if (!iframeWin.newTest()) {
                    return;
				}
			    var $res = _self.res;
                var resLine =$res[0].innerText;
                if(resLine == null || resLine=="" || resLine=="null"){
                    layer.alert("请先计算表达式的值",{icon: 1,shadeClose:false,time: 60*1000,shade:[0.8, '#393D49']});
                	return;
				}
                var $longRes = _self.longRes;
                var res2 =$longRes[0].innerText;

		    	var fieldAttr = $form.find("#fieldAttr").val();
		    	var oper = $form.find("#oper").val();
		    	var operValue = "";
		    	if(oper=='gt'){
		    		operValue = ">";
		    	}else if(oper=='gteq'){
		    		operValue = ">=";
		    	}else if(oper=='gteq'){
		    		operValue = ">=";
		    	}else if(oper=='lt'){
		    		operValue = "<";
		    	}else if(oper=='lteq'){
		    		operValue = "<=";
		    	}else if(oper=='eq'){
		    		operValue = "==";
		    	}else if(oper=='noeq'){
		    		operValue = "!=";
		    	}
		    	var theValue = $form.find("#theValue").val();
		    	//var expr = "#{"+fieldAttr+operValue+theValue+"}";
		    	//$("#"+_self.domId).val(expr);
		    	var oldValue = $("#"+_self.domId).val();
                $("#"+_self.domId).val(resLine);
                $("#"+_self.domId).attr("longJson",res2);
                var parent = $("#"+_self.domId).parent().parent().parent();
                var isExprConfigUpdate = iframeWin.isConfigUpdate;
                //修改
                if(isExprConfigUpdate=='1'){
                	parent.find("[name='btn-save-start-condition']").click();
                }else{
                	parent.find("[name='btn-add-start-condition']").click();
                }
                /**
                //新增
                if(oldValue ==''){
                	parent.find("[name='btn-add-start-condition']").click();
                }else{
                	parent.find("[name='btn-save-start-condition']").click();
                }
                */
		    	layer.close(index);
			 },
			cancel: function(index){
				layer.close(index);
				$('html').addClass('fix-ie-font-face');
				setTimeout(function() {
					$('html').removeClass('fix-ie-font-face');
				}, 10);
		    },
		   success: function(layero, index){
		   }
		});
}
