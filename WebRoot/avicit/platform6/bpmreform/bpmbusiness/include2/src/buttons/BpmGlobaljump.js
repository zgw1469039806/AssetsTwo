/**
 * 流程跳转
 */
function BpmGlobaljump(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobaljump, isEvent);
	this.domeId = "doglobaljump";
	this.getHtml();
};
BpmGlobaljump.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobaljump.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeGlobaljump(this.data)){
		return;
	}
	var _self = this;
	this.jumpTaskDialog = layer.open({
		type : 2,
		title : "跳转节点选择",
		area : [ "800px", "450px" ],
		content : flowUtils.graphPath + "?entryId=" + _self.data.procinstDbid + "&type=doglobaljump"
	});
	if(this.isEvent){
		//如果不是审批页面， 最大化
		layer.full(this.jumpTaskDialog);
	}
	window.bpmGlobaljump = this;
};
/**
 * 执行
 */
BpmGlobaljump.prototype.callback = function(executionId, targetActivityName) {
	layer.close(this.jumpTaskDialog);
	var data = flowUtils.clone(this.data);
	if(flowUtils.notNull(executionId)){
		data.executionId = executionId;
	}
	data.targetActivityName = targetActivityName;
	new BpmActor(data, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmGlobaljump.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
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
		url : "platform/bpm/business/dojump",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson),
			activityName : data.targetActivityName
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				if(_self.isEvent){
					flowUtils.success("跳转成功");
					flowUtils.refreshCurrentBack();
				}else{
					flowUtils.success("跳转成功！表单将自动关闭", function() {
						flowUtils.refreshBack();
						flowUtils.closeWindowOnDialog();
                        setTimeout(function(){
                            _self.flowEditor.createButtons();
                        },500);
					}, true);
				}
				try{
					_self.flowEditor.defaultForm.afterGlobaljump(data);
				}catch(e){
					
				}
			}
		}
	});
};