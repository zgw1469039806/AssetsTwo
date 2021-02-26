/**
 * 关注工作
 */
function BpmFocus(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dofocus, isEvent);
	this.domeId = "bpm_focus";
	this.getHtml();
};
BpmFocus.prototype = new BpmButton();
/**
 * 执行
 */
BpmFocus.prototype.execute = function() {
	avicAjax.ajax({
		url : "platform/bpm/business/setFocusedTask",
		data : {
			processInstanceId : this.flowEditor.flowModel.entryId,
			dbid : this.flowEditor.flowModel.taskId
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				if (msg.mes == false) {
					flowUtils.success("该任务此前已被关注");
				} else {
					flowUtils.success("已成功关注该任务");
				}
			}
		}
	});
};
BpmFocus.prototype.getHtml = function() {
	if (this.isEnable()) {
		var _self = this;
		$("#" + this.domeId).off("click");
		$("#" + this.domeId).on("click", function() {
			_self.execute()
		});
		$("#" + this.domeId).show();
	} else {
		$("#" + this.domeId).hide();
		$("#" + this.domeId).off("click");
	}
};