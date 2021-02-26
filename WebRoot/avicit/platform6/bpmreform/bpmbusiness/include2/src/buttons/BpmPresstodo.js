/**
 * 催办下节点
 */
function BpmPresstodo(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dopresstodo, isEvent);
	this.domeId = "dopresstodo";
	this.getHtml();
};
BpmPresstodo.prototype = new BpmButton();
/**
 * 执行
 */
BpmPresstodo.prototype.execute = function() {
	if (!this.flowEditor.defaultForm.beforePresstodo(this.data)) {
		return;
	}
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/beforepresstodo",
		data : {
			executionId : _self.data.executionId
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				_self.presstodo(result.result);
			}
		}
	});
	
};
BpmPresstodo.prototype.presstodo = function(result){
	var _self = this;
	var message = "";
	if(result.flg == "true"){
		message = "确定对下一节点进行催办吗？" + result.msg;
	}else{
		message = "下一节点在" + result.time + "被催办过，确定继续进行催办吗？" + result.msg;
	}
	flowUtils.confirm(message, function() {
		avicAjax.ajax({
			url : "platform/bpm/business/dopresstodo",
			data : {
				executionId : _self.data.executionId
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error,msg.errorDetail);
				} else {
					flowUtils.success("催办成功");
					try {
						_self.flowEditor.defaultForm.afterPresstodo(_self.data);
					} catch (e) {

					}
				}
			}
		});
	});
}
