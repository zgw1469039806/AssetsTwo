/**
 * 拿回
 */
function BpmWithdraw(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dowithdraw, isEvent);
	this.domeId = "dowithdraw";
	this.getHtml();
};
BpmWithdraw.prototype = new BpmButton();
/**
 * 执行
 */
BpmWithdraw.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeWithdraw(this.data)){
		return;
	}
	var _self = this;
	avicAjax.ajax({
		type : "POST",
		data : {
			processInstanceId : _self.data.procinstDbid
		},
		url : "platform/bpm/clientbpmdisplayaction/getcoordinate",
		dataType : "json",
		success : function(result) {
			if (flowUtils.notNull(result, result.activity)) {
				for(var key in result.activity){
					var activity = result.activity[key];
					var activityName = activity.activityName;
					var isCurrent = activity.isCurrent;
					var executionId = activity.executionId;
					var isAlone = activity.executionAlone;
					// 只有一个当前节点时候补发操作和拿回操作自动处理
					if (isAlone && isCurrent == "true") {
						_self.callback(executionId, activityName);
						return;
					}
					if(executionId == _self.data.executionId){
						_self.callback(executionId, activityName);
						return;
					}
				}
				_self.withdrawTaskDialog = layer.open({
					type : 2,
					title : "拿回节点选择",
					area : [ "800px", "450px" ],
					content : flowUtils.graphPath + "?entryId=" + _self.data.procinstDbid + "&type=dowithdraw"
				});
				if(_self.isEvent){
					//如果不是审批页面， 最大化
					layer.full(_self.withdrawTaskDialog);
				}
				window.bpmWithdraw = _self;
			}
		}
	});
};
/**
 * 执行
 */
BpmWithdraw.prototype.callback = function(executionId, targetActivityName) {
	var _self = this;
	if(flowUtils.notNull(this.withdrawTaskDialog)){
		layer.close(this.withdrawTaskDialog);
		this.withdrawTaskDialog = null;
	}
	var data = flowUtils.clone(this.data);
	//循环节点中的拿回传入的executionId不准确
	data.executionId = executionId;
	data.targetActivityName = targetActivityName;
	new BpmActor(data, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmWithdraw.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
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
		url : "platform/bpm/business/dowithdrawcurract",
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
				flowUtils.success("拿回成功！表单将自动关闭", function() {
					flowUtils.refreshBack();
					flowUtils.closeWindowOnDialog();
                    setTimeout(function(){
                        _self.flowEditor.createButtons();
                    },500);
				}, true);
				try {
					_self.flowEditor.defaultForm.afterWithdraw(data);
				} catch (e) {

				}
			}
		}
	});
};