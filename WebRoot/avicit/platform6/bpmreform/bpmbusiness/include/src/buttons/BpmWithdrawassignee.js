/**
 * 节点内拿回
 */
function BpmWithdrawassignee(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dowithdrawassignee, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_withdrawassignee";
	this.getHtml();
};
BpmWithdrawassignee.prototype = new BpmButton();
/**
 * 执行
 */
BpmWithdrawassignee.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeWithdrawassignee(this.data)){
		return;
	}
	new BpmActor(this.data, null, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmWithdrawassignee.prototype.submit = function(data, users) {
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
		url : "platform/bpm/business/dowithdrawactassignee",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson)
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				flowUtils.success("减签成功");
				try{
					_self.flowEditor.defaultForm.afterWithdrawassignee(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
			}
		}
	});
};