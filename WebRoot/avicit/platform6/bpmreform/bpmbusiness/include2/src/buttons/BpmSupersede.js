/**
 * 流程转办
 */
function BpmSupersede(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dosupersede, isEvent);
	this.domeId = "dosupersede";
	this.getHtml();
};
BpmSupersede.prototype = new BpmButton();
/**
 * 执行
 */
BpmSupersede.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeSupersede(this.data)){
		return;
	}
	new BpmActor(this.data, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmSupersede.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
	if (!flowUtils.notNull(users) || users.length == 0) {
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
		url : "platform/bpm/business/dosupersede",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson),
			selectUserId : null,
			formJson : null,
			activityName : data.targetActivityName
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
					_self.flowEditor.defaultForm.afterSupersede(data);
				}catch(e){
					
				}
			}
		}
	});
};