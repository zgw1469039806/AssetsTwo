/**
 * 增加读者
 */
function BpmTaskreader(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dotaskreader, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_taskreader";
	this.getHtml();
};
BpmTaskreader.prototype = new BpmButton();
/**
 * 执行
 */
BpmTaskreader.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeTaskreader(this.data)){
		return;
	}
	new BpmActor(this.data, null, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmTaskreader.prototype.submit = function(data, users) {
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
		url : "platform/bpm/business/dotaskreader",
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
					_self.flowEditor.defaultForm.afterTaskreader(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
//				flowUtils.refreshBack();
			}
		}
	});
};