/**
 * 按钮单独操作
 */
function FlowButtons() {
	this.flowModel = new FlowModel();
	this.defaultForm = new DefaultForm();
	this.defaultForm.flowEditor = this;
	this.defaultForm.isAutoSave = false;
};
FlowButtons.prototype.isStart = false;
FlowButtons.prototype.createButtons = function(){
};
/**
 * 加签
 * @param procinstDbid
 * @param executionId
 * @param taskId
 * @param outcome
 * @param targetActivityName
 */
FlowButtons.prototype.adduser = function(procinstDbid,executionId,taskId,outcome,targetActivityName){
	var doadduser = {};
	doadduser.procinstDbid = procinstDbid;
	doadduser.executionId = executionId;
	doadduser.taskId = taskId;
	doadduser.name = outcome;
	doadduser.targetActivityName = targetActivityName;
	doadduser.event = "doadduser";
	doadduser.lable = "加签";
	this.bpmAdduser = new BpmAdduser(this, this.defaultForm, {doadduser:doadduser}, true);
	this.bpmAdduser.execute();
};
/**
 * 跳转
 * @param procinstDbid
 * @param executionId
 * @param taskId
 * @param outcome
 * @param targetActivityName
 */
FlowButtons.prototype.globaljump = function(procinstDbid,executionId,taskId,outcome,targetActivityName){
	var doglobaljump = {};
	doglobaljump.procinstDbid = procinstDbid;
	doglobaljump.executionId = executionId;
	doglobaljump.taskId = taskId;
	doglobaljump.name = outcome;
	doglobaljump.targetActivityName = targetActivityName;
	doglobaljump.event = "doglobaljump";
	doglobaljump.lable = "流程跳转";
	this.bpmGlobaljump = new BpmGlobaljump(this, this.defaultForm, {doglobaljump:doglobaljump}, true);
	this.bpmGlobaljump.execute();
};
/**
 * 退回拟稿人
 * @param procinstDbid
 * @param executionId
 * @param taskId
 * @param outcome
 * @param targetActivityName
 */
FlowButtons.prototype.todraft = function(procinstDbid,executionId,taskId,outcome,targetActivityName){
	var doretreattodraft = {};
	doretreattodraft.procinstDbid = procinstDbid;
	doretreattodraft.executionId = executionId;
	doretreattodraft.taskId = taskId;
	doretreattodraft.name = outcome;
	doretreattodraft.targetActivityName = targetActivityName;
	doretreattodraft.event = "doretreattodraft";
	doretreattodraft.lable = "退回拟稿人";
	this.bpmRetreat = new BpmRetreat(this, this.defaultForm, {doretreattodraft:doretreattodraft}, true);
	this.bpmRetreat.executeTodraft();
};
/**
 * 退回上一步
 * @param procinstDbid
 * @param executionId
 * @param taskId
 * @param outcome
 * @param targetActivityName
 */
FlowButtons.prototype.toprev = function(procinstDbid,executionId,taskId,outcome,targetActivityName){
	var doretreattoprev = {};
	doretreattoprev.procinstDbid = procinstDbid;
	doretreattoprev.executionId = executionId;
	doretreattoprev.taskId = taskId;
	doretreattoprev.name = outcome;
	doretreattoprev.targetActivityName = targetActivityName;
	doretreattoprev.event = "doretreattoprev";
	doretreattoprev.lable = "退回上一步";
	this.bpmRetreat = new BpmRetreat(this, this.defaultForm, {doretreattoprev:doretreattoprev}, true);
	this.bpmRetreat.executeToprev();
};
/**
 * 增加传阅
 * @param procinstDbid
 * @param executionId
 * @param taskId
 * @param outcome
 * @param targetActivityName
 */
FlowButtons.prototype.dotransmit = function(procinstDbid,executionId,taskId,outcome,targetActivityName){
	var dotransmit = {};
	dotransmit.procinstDbid = procinstDbid;
	dotransmit.executionId = executionId;
	dotransmit.taskId = taskId;
	dotransmit.name = outcome;
	dotransmit.targetActivityName = targetActivityName;
	dotransmit.event = "dotransmit";
	dotransmit.lable = "发送阅知";
	this.bpmTransmit = new BpmTransmit(this, this.defaultForm, {dotransmit:dotransmit}, true);
	this.bpmTransmit.execute();
};
/**
 * 增加读者
 * @param procinstDbid
 * @param executionId
 * @param taskId
 * @param outcome
 * @param targetActivityName
 */
FlowButtons.prototype.dotaskreader = function(procinstDbid,executionId,taskId,outcome,targetActivityName){
	var dotaskreader = {};
	dotaskreader.procinstDbid = procinstDbid;
	dotaskreader.executionId = executionId;
	dotaskreader.taskId = taskId;
	dotaskreader.name = outcome;
	dotaskreader.targetActivityName = targetActivityName;
	dotaskreader.event = "dotaskreader";
	dotaskreader.lable = "增加读者";
	this.bpmTaskreader = new BpmTaskreader(this, this.defaultForm, {dotaskreader:dotaskreader}, true);
	this.bpmTaskreader.execute();
};
/**
 * 相关流程
 * @param procinstDbid
 * @param executionId
 * @param taskId
 * @param outcome
 * @param targetActivityName
 */
FlowButtons.prototype.dorelationprocess = function(procinstDbid,executionId,taskId,outcome,targetActivityName){
	var dorelationprocess = {};
	dorelationprocess.procinstDbid = procinstDbid;
	dorelationprocess.executionId = executionId;
	dorelationprocess.taskId = taskId;
	dorelationprocess.name = outcome;
	dorelationprocess.targetActivityName = targetActivityName;
	dorelationprocess.event = "dorelationprocess";
	dorelationprocess.lable = "相关流程";
	this.bpmRelationflow = new BpmRelationflow(this, this.defaultForm, {dorelationprocess:dorelationprocess}, true);
	this.bpmRelationflow.execute();
};
/**
 * 快速提交
 * @param procinstDbid
 * @param executionId
 * @param taskId
 * @param formId
 */
FlowButtons.prototype.dosubmit = function(procinstDbid,executionId,taskId,formId){
	var _self = this;
	avicAjax.ajax({
		type : "POST",
		data : {
			processInstanceId : procinstDbid,
			executionId : executionId,
			taskId : taskId
		},
		url : "platform/bpm/business/getoperateright",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				var buttonArray = msg.operateRight;
				if (buttonArray == null) {
					flowUtils.error("获取权限失败");
					return;
				}
				var buttonData = {};
				$.each(buttonArray, function(i, button) {
					if (button.event == "dosubmit") {
						if (buttonData.dosubmit == null) {
							buttonData.dosubmit = [];
						}
						buttonData.dosubmit.push(button);
					}
				});
				
				_self.bpmSubmit = new BpmSubmit(_self, _self.defaultForm, buttonData, true);
				_self.bpmSubmit.quickExecute();
			}
		}
	});
};