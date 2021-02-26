/**
 * 流程结束
 */
function BpmGlobalend(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalend, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_globalend";
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
	var _self = this;
	flowUtils.confirm("流程一旦结束将无法恢复，您确定结束该流程吗？", function() {
		avicAjax.ajax({
			url : "platform/bpm/business/doend",
			data : {
				executionId : _self.data.executionId,
				message : _self.getIdeaText()
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
	});
};
