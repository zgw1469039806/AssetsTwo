function TransitionTimeOut (option) {
	this.id = option.id;
	this.domId = option.domId
	this.callback = option.callback;
	this.option = option;
	// 将配置信息保存到dom对象里，方便在弹出页面调用
	$("#"+this.domId).data("data-object", this);
	var id = encodeURIComponent(this.domId);
	this.template = "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/TransitionTimeOut/TransitionTimeOut.jsp?id="+id;
	this.init();
}

TransitionTimeOut.prototype.init = function() {
	var _self = this;
	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
		var box = layer.open({
		    type:  2,
		    area: [ "700px",  "170px"],
		    title: "触发规则",
		    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		    shade:   0.3,
	        maxmin: false, //开启最大化最小化按钮
		    content: _self.template ,
		    btn: ['确定', '关闭'],
		    yes: function(index, layero){
		    	var $form =_self.form;
		    	var isValidate = $form.validate();
		    	if (!isValidate.checkForm()) {
			            isValidate.showErrors();
			            return;
			     }
		    	var timeRule = $form.find("#timeRule").val();
		    	var timeType = $form.find("#timeType").val();
		    	var timeUnit = $form.find("#timeUnit").val();
		    	if(flowUtils.notNull(timeRule)){
                    var rule = timeRule;
                    if(timeType!=''){
                        rule =rule+ " "+timeType;
                    }
                    rule = rule + " "+timeUnit;
                    $("#"+_self.domId).val(rule);
				}else{
                    $("#"+_self.domId).val("");
				}
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
