/**
 * 补发
 */
function BpmSupplement(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dosupplement, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_supplement";
};
BpmSupplement.prototype = new BpmButton();
BpmSupplement.prototype.getHtmlForDefaultBar = function() {
	if (this.isEnable()) {
		var _self = this;
		var button = $('<button class="listBtn btn btn-default dropdown-toggle center" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt">' + this.data.lable + '</span></button>');
		button.on("click", function() {
			_self.execute();
		});
		$("#bpm_buttons_default2").append(button);
	}
};
/**
 * 执行
 */
BpmSupplement.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeSupplement(this.data)){
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
				}
				_self.supplementTaskDialog = layer.open({
					type : 2,
					title : "补发节点选择",
					area : [ "800px", "450px" ],
					content : flowUtils.graphPath + "?entryId=" + _self.data.procinstDbid + "&type=dosupplement"
				});
				if(_self.isEvent){
					//如果不是审批页面， 最大化
					layer.full(_self.supplementTaskDialog);
				}
				window.bpmSupplement = _self;
			}
		}
	});
};
/**
 * 执行
 */
BpmSupplement.prototype.callback = function(executionId, targetActivityName) {
	if(flowUtils.notNull(this.supplementTaskDialog)){
		layer.close(this.supplementTaskDialog);
		this.supplementTaskDialog = null;
	}	
	var data = flowUtils.clone(this.data);
	data.executionId = executionId;
	data.targetActivityName = targetActivityName;
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			taskId : data.taskId,
			outcome : data.name,
			targetActivityName : data.targetActivityName,
			type : 'dosupplement'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				new BpmActor(data, result.taskUserSelect, _self).open();
			}
		}
	});
};
/**
 * 
 * @param data
 * @param users
 */
BpmSupplement.prototype.submit = function(data, users) {
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
		url : "platform/bpm/business/dosupplementassignee",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson),
			opType : 'dosupplement'
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				flowUtils.success("补发成功");
				try{
					_self.flowEditor.defaultForm.afterSupplement(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
			}
		}
	});
};