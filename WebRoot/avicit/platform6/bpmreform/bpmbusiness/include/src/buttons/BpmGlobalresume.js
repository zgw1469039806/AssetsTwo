/**
 * 流程恢复
 */
function BpmGlobalresume(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalresume, isEvent);
	this.domeId = "bpm_globalresume";
	this.getHtml();
};
BpmGlobalresume.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobalresume.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeGlobalresume(this.data)){
		return;
	}
	var _self = this;
	flowUtils.confirm("您确定恢复该流程吗？", function() {
		avicAjax.ajax({
			url : "platform/bpm/business/doresume",
			data : {
				processInstanceId : _self.data.procinstDbid
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error,msg.errorDetail);
				} else {
					flowUtils.success("操作成功");
					try{
						_self.flowEditor.defaultForm.afterGlobalresume(_self.data);
					}catch(e){
						
					}
					_self.flowEditor.createButtons();
					flowUtils.refreshBack();
				}
			}
		});
	});
};