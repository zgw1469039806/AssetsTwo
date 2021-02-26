/**
 * 自定义选人
 */
function BpmStepuserdefined(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dostepuserdefined, isEvent);
	this.domeId = "bpm_stepuserdefined";
	this.getHtml();
};
BpmStepuserdefined.prototype = new BpmButton();
/**
 * 执行
 */
BpmStepuserdefined.prototype.execute = function() {
	if (!this.flowEditor.defaultForm.beforeStepuserdefined(this.data)) {
		return;
	}
	var _self = this;
	this.stepuserdefinedDialog = layer.open({
		type : 2,
		title : "自定义审批人",
		area : [ "800px", "450px" ],
		content : flowUtils.graphPath + "?entryId=" + _self.data.procinstDbid + "&type=dostepuserdefined"
	});
	if(this.isEvent){
		//如果不是审批页面， 最大化
		layer.full(this.stepuserdefinedDialog);
	}
	window.bpmStepuserdefined = this;
};
/**
 * 执行
 */
BpmStepuserdefined.prototype.callback = function(activityName) {
	var data = flowUtils.clone(this.data);
	data.activityName = activityName;
	data.targetActivityName = activityName;
	new BpmActor(data, null, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmStepuserdefined.prototype.submit = function(data, users) {
	if (!flowUtils.notNull(users) || users.length == 0) {
		flowUtils.warning("选人错误");
		return;
	}
	var userJson = {
		users : users,
		idea : "",
		compelManner : "",
		outcome : data.name
	};
	avicAjax.ajax({
		url : "platform/bpm/business/douserdefined",
		data : {
			procinstDbid : data.procinstDbid,
			userJson : JSON.stringify(userJson),
			activityName : data.activityName
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				flowUtils.success("操作成功");
				try {
					_self.flowEditor.defaultForm.afterStepuserdefined(data);
				} catch (e) {

				}
			}
		}
	});
};