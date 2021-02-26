/**
 * 关注工作
 */
function BpmFocus(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dofocus, isEvent);
	this.domeId = "dofocus";
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