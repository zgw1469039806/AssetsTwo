/**
 * 流程增发
 */
function BpmAdduser(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doadduser, isEvent);
	this.domeId = "doadduser";
	this.getHtml();
};
BpmAdduser.prototype = new BpmButton();
/**
 * 执行
 */
BpmAdduser.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeAdduser(this.data)){
		return;
	}
	new BpmActor(this.data, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmAdduser.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
	if(!flowUtils.notNull(users) || users.length == 0){
		flowUtils.warning("选人错误");
		return;
	}
	var _self = this;
	var userJson = {
		users : users,
		idea : idea,
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/dosupplementassignee",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson),
			opType : 'doadduser'
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				flowUtils.success("加签成功");
				if(_self.isEvent){
					flowUtils.refreshCurrentBack();
				}
				try{
					_self.flowEditor.defaultForm.afterAdduser(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
//				flowUtils.refreshBack();
			}
		}
	});
};