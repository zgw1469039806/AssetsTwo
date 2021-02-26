/**
 * 流程结束
 */
function BpmGlobalend(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalend, isEvent);
	this.domeId = "doglobalend";
	this.getHtml();
};
BpmGlobalend.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobalend.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeGlobalend(this.data)){
		return;
	}
	new BpmActor(this.data, this).open();
};
BpmGlobalend.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/doend",
		data : {
			executionId : _self.data.executionId,
			message : idea
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				flowUtils.success("操作成功！表单将自动关闭", function() {
					flowUtils.refreshBack();
					flowUtils.closeWindowOnDialog();
					setTimeout(function(){
						_self.flowEditor.createButtons();
					},500);
				}, true);
				try{
					_self.flowEditor.defaultForm.afterGlobalend(_self.data);
				}catch(e){

				}
			}
		}
	});
};
