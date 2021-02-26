/**
 * 流程转办
 */
function BpmSupersede(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dosupersede, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_supersede";
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
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : _self.data.procinstDbid,
			executionId : _self.data.executionId,
			taskId : _self.data.taskId,
			outcome : _self.data.name,
			targetActivityName : _self.data.targetActivityName,
			type : 'dosupersede'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				new BpmActor(_self.data, result.taskUserSelect, _self).open();
			}
		}
	});
};
/**
 * 
 * @param data
 * @param users
 */
BpmSupersede.prototype.submit = function(data, users) {
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