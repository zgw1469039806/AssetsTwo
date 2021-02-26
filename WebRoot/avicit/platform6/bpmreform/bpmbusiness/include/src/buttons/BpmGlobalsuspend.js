/**
 * 流程暂停
 */
function BpmGlobalsuspend(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalsuspend, isEvent);
	this.domeId = "bpm_globalsuspend";
	this.getHtml();
};
BpmGlobalsuspend.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobalsuspend.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeGlobalsuspend(this.data)){
		return;
	}
	var _self = this;
	flowUtils.confirm("您确定暂停该流程吗？", function() {
		avicAjax.ajax({
			url : "platform/bpm/business/dosuspend",
			data : {
				processInstanceId : _self.data.procinstDbid
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error,msg.errorDetail);
				} else {
					flowUtils.success("操作成功!");
					try{
						_self.flowEditor.defaultForm.afterGlobalsuspend(_self.data);
					}catch(e){
						
					}
					_self.flowEditor.createButtons();
					flowUtils.refreshBack();
				}
			}
		});
	});
};