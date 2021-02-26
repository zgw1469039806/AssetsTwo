/**
 * 流程选人
 */
function BpmActor(data,submitObj) {
	this.data = data;
	this.submitObj = submitObj;
};
/**
 * 执行
 */
BpmActor.prototype.open = function () {
	var _self = this;
	var data = _self.data;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo2",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			taskId : data.taskId,
			outcome : data.name,
			targetActivityName : data.targetActivityName,
			type : data.event
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				var commonActor = new CommonActor(data,result.taskUserSelect,_self.submitObj);
				commonActor.open();
			}
		}
	});
	
};
