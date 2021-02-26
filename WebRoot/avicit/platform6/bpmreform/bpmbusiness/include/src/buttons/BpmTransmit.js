/**
 * 流程转发
 */
function BpmTransmit(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dotransmit, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_transmit";
	this.getHtml();
};
BpmTransmit.prototype = new BpmButton();
/**
 * 执行
 */
BpmTransmit.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeTransmit(this.data)){
		return;
	}
	new BpmActor(this.data, null, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmTransmit.prototype.submit = function(data, users) {
	if (!flowUtils.notNull(users) || users.length == 0) {
		flowUtils.warning("选人错误");
		return;
	}
	var _self = this;
	var userJson = {
		users : users,
		idea : _self.getIdeaText(),
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/dotransmit",
		data : {
			procinstDbid : data.procinstDbid,
			taskId : data.taskId,
			userJson : JSON.stringify(userJson)
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				flowUtils.success("操作成功");
				if(_self.isEvent){
					flowUtils.refreshCurrentBack();
				}
				try{
					_self.flowEditor.defaultForm.afterTransmit(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
//				flowUtils.refreshBack();
			}
		}
	});
};