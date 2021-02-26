/**
 * 流程退回，包括退回上一步和退回拟稿人
 */
function BpmRetreat(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
	this.doretreattodraft = buttonData.doretreattodraft;
	this.doretreattoprev = buttonData.doretreattoprev;
	this.doretreattowant = buttonData.doretreattowant;
	this.doretreattoactivity = buttonData.doretreattoactivity;
	if (flowUtils.notNull(this.doretreattodraft) || flowUtils.notNull(this.doretreattoprev) || flowUtils.notNull(this.doretreattowant) || flowUtils.notNull(this.doretreattoactivity)) {
		this.enable = true;
		this.flowEditor.needIdeaText = true;
	}
	this.getHtml();
};
BpmRetreat.prototype = new BpmButton();
/**
 * 执行
 */
BpmRetreat.prototype.executeTodraft = function() {
	if (!this.flowEditor.defaultForm.beforeRetreat(this.doretreattodraft)) {
		return;
	}
	var _self = this;
	// 自动保存
	if (this.flowEditor.defaultForm.isAutoSave && this.flowEditor.bpmSave.isEnable()) {
		this.flowEditor.defaultForm.save(function() {
			_self.executeTodraftBack();
			_self.flowEditor.createButtons();
		});
	} else {
		this.validIdeasBySelf("2", function () {
			_self.executeTodraftBack();
		});
	}
};
BpmRetreat.prototype.executeTodraftBack = function() {
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : _self.doretreattodraft.procinstDbid,
			executionId : _self.doretreattodraft.executionId,
			taskId : _self.doretreattodraft.taskId,
			outcome : _self.doretreattodraft.name,
			targetActivityName : _self.doretreattodraft.targetActivityName,
			type : 'doretreattodraft'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				_self.validJsonData(_self.doretreattodraft, result.taskUserSelect, "确定退回拟稿人吗？");
			}
		}
	});

	/**
	 * 回调
	 * 
	 * @param data
	 * @param users
	 */
	this.submit = function(data, users) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
		var idea = _self.getIdeaText();
		if(flowUtils.notNull(this.ideas_text)){
			idea = this.ideas_text + " " + idea;
		}
		var userJson = {
			users : users,
			idea : idea,
			compelManner : "",
			outcome : data.name
		};
		avicAjax.ajax({
			url : "platform/bpm/business/dobacktofirst",
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
					if(_self.isEvent){
						flowUtils.success("退回成功");
						flowUtils.refreshCurrentBack();
					}else{
						flowUtils.success("退回成功！表单将自动关闭", function() {
							flowUtils.refreshBack();
							flowUtils.closeWindowOnDialog();
                            setTimeout(function(){
                                _self.flowEditor.createButtons();
                            },500);
						}, true);
					}
					try {
						_self.flowEditor.defaultForm.afterRetreat(data);
					} catch (e) {

					}
				}
			}
		});
	};
};
BpmRetreat.prototype.executeToprev = function() {
	if (!this.flowEditor.defaultForm.beforeRetreat(this.doretreattoprev)) {
		return;
	}
	var _self = this;
	// 自动保存
	if (this.flowEditor.defaultForm.isAutoSave && this.flowEditor.bpmSave.isEnable()) {
		this.flowEditor.defaultForm.save(function() {
			_self.executeToprevBack();
			_self.flowEditor.createButtons();
		});
	} else {
		this.validIdeasBySelf("2", function () {
			_self.executeToprevBack();
		});
	}
};
BpmRetreat.prototype.executeToprevBack = function() {
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : _self.doretreattoprev.procinstDbid,
			executionId : _self.doretreattoprev.executionId,
			taskId : _self.doretreattoprev.taskId,
			outcome : _self.doretreattoprev.name,
			targetActivityName : _self.doretreattoprev.targetActivityName,
			type : 'doretreattoprev'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				_self.validJsonData(_self.doretreattoprev, result.taskUserSelect, "确定退回上一步吗？");
			}
		}
	});
	/**
	 * 回调
	 */
	this.submit = function(data, users) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
		var idea = _self.getIdeaText();
		if(flowUtils.notNull(this.ideas_text)){
			idea = this.ideas_text + " " + idea;
		}
		var userJson = {
			users : users,
			idea : idea,
			compelManner : "",
			outcome : data.name
		};
		avicAjax.ajax({
			url : "platform/bpm/business/dobacktoprev",
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
					if(_self.isEvent){
						flowUtils.success("退回成功");
						flowUtils.refreshCurrentBack();
					}else{
						flowUtils.success("退回成功！表单将自动关闭", function() {
							flowUtils.refreshBack();
							flowUtils.closeWindowOnDialog();
                            setTimeout(function(){
                                _self.flowEditor.createButtons();
                            },500);
						}, true);
					}
					try {
						_self.flowEditor.defaultForm.afterRetreat(data);
					} catch (e) {

					}
				}
			}
		});
	};
};
BpmRetreat.prototype.executeTowant = function() {
	if (!this.flowEditor.defaultForm.beforeRetreat(this.doretreattowant)) {
		return;
	}
	var _self = this;
	// 自动保存
	if (this.flowEditor.defaultForm.isAutoSave && this.flowEditor.bpmSave.isEnable()) {
		this.flowEditor.defaultForm.save(function() {
			_self.executeTowantSelectTask();
			_self.flowEditor.createButtons();
		});
	} else {
		this.validIdeasBySelf("2", function () {
			_self.executeTowantSelectTask();
		});
	}
};
BpmRetreat.prototype.executeTowantSelectTask = function(){
	var _self = this;
	this.retreattowantDialog = layer.open({
		type : 2,
		title : "任意退回节点选择",
		area : [ "800px", "450px" ],
		content : flowUtils.graphPath + "?entryId=" + _self.doretreattowant.procinstDbid + "&type=doretreattowant"
	});
	if(this.isEvent){
		//如果不是审批页面， 最大化
		layer.full(this.retreattowantDialog);
	}
	window.bpmRetreatToWant = this;
};

BpmRetreat.prototype.callback = function(targetActivityName) {
	layer.close(this.retreattowantDialog);
	var data = flowUtils.clone(this.doretreattowant);
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
			type : 'doretreattowant'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				_self.validJsonData(data, result.taskUserSelect, "确定退回吗？");
			}
		}
	});

	/**
	 * 回调
	 * 
	 * @param data
	 * @param users
	 */
	this.submit = function(data, users) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
		var idea = _self.getIdeaText();
		if(flowUtils.notNull(this.ideas_text)){
			idea = this.ideas_text + " " + idea;
		}
		var userJson = {
			users : users,
			idea : idea,
			compelManner : "",
			outcome : data.name
		};
		avicAjax.ajax({
			url : "platform/bpm/business/dobacktowant",
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
						flowUtils.success("退回成功");
						flowUtils.refreshCurrentBack();
					}else{
						flowUtils.success("退回成功！表单将自动关闭", function() {
							flowUtils.refreshBack();
							flowUtils.closeWindowOnDialog();
                            setTimeout(function(){
                                _self.flowEditor.createButtons();
                            },500);
						}, true);
					}
					try {
						_self.flowEditor.defaultForm.afterRetreat(data);
					} catch (e) {

					}
				}
			}
		});
	};
};

BpmRetreat.prototype.executeToactivity = function(targetActivityName) {
	if (!this.flowEditor.defaultForm.beforeRetreat(this.doretreattoactivity)) {
		return;
	}
	var _self = this;
	// 自动保存
	if (this.flowEditor.defaultForm.isAutoSave && this.flowEditor.bpmSave.isEnable()) {
		this.flowEditor.defaultForm.save(function() {
			_self.executeToactivityBack(targetActivityName);
			_self.flowEditor.createButtons();
		});
	} else {
		this.validIdeasBySelf("2", function () {
			_self.executeToactivityBack(targetActivityName);
		});
	}
};

BpmRetreat.prototype.executeToactivityBack = function(targetActivityName) {
	var data = flowUtils.clone(this.doretreattoactivity);
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
			type : 'doretreattoactivity'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				_self.validJsonData(data, result.taskUserSelect, "确定退回吗？");
			}
		}
	});

	/**
	 * 回调
	 * 
	 * @param data
	 * @param users
	 */
	this.submit = function(data, users) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
		var idea = _self.getIdeaText();
		if(flowUtils.notNull(this.ideas_text)){
			idea = this.ideas_text + " " + idea;
		}
		var userJson = {
			users : users,
			idea : idea,
			compelManner : "",
			outcome : data.name
		};
		avicAjax.ajax({
			url : "platform/bpm/business/dobacktoactivity",
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
						flowUtils.success("退回成功");
						flowUtils.refreshCurrentBack();
					}else{
						flowUtils.success("退回成功！表单将自动关闭", function() {
							flowUtils.refreshBack();
							flowUtils.closeWindowOnDialog();
                            setTimeout(function(){
                                _self.flowEditor.createButtons();
                            },500);
						}, true);
					}
					try {
						_self.flowEditor.defaultForm.afterRetreat(data);
					} catch (e) {

					}
				}
			}
		});
	};
};

/**
 * 校验数据
 * 
 * @param data
 * @param taskUserSelect
 */
BpmRetreat.prototype.validJsonData = function(data, taskUserSelect, message) {
	var _self = this;
	if (flowUtils.notNull(taskUserSelect)) {
		// 初始化路由对象
		this.conditions = this.getConditions(taskUserSelect);
		if (this.validIdeaMust()) {
			if (this.conditions.isBranch()) {
				new BpmActor(data, taskUserSelect, this).open();
			} else {
				flowUtils.confirm(message, function() {
					var user = new BpmActor(data, taskUserSelect, _self).getUsers();
					_self.submit(data, user);
				});
			}
		}
	}
};
/**
 * 流程填写意见判断
 * 
 * @returns {Boolean}
 */
BpmRetreat.prototype.validIdeaMust = function() {
	if(this.isEvent){
		return true;
	}
	if (this.conditions.isNeedIdea()) {// 意见必须填写
		var ideaText = this.getIdeaText();
		if (!flowUtils.notNull(ideaText)) {
			flowUtils.warning('请填写流程意见');
			this.focusIdeaText();
			return false;
		}
	}
	return true;
};
BpmRetreat.prototype.getHtml = function() {
	if(this.isEvent){
		return true;
	}
	if (this.isEnable()) {
		var _self = this;
		var button = $('<button class="listBtn grey btn btn-default dropdown-toggle" type="button" id="dropmenu_retreat" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt">退回</span><i></i></button>');
		var ul = $('<ul class="dropdown-menu" aria-labelledby="dropmenu_retreat">');
		if(this.doretreattodraft != null){
			var li_draft = $('<li></li>');
			var a_draft = $('<a href="javascript:void(0);">' + this.doretreattodraft.lable + '</a>');
			a_draft.on("click", function() {
				_self.executeTodraft();
			});
			li_draft.append(a_draft);
			ul.append(li_draft);
		}
		if(this.doretreattoprev != null){
			var li_prev = $('<li></li>');
			var a_prev = $('<a href="javascript:void(0);">' + this.doretreattoprev.lable + '</a>');
			a_prev.on("click", function() {
				_self.executeToprev();
			});
			li_prev.append(a_prev);
			ul.append(li_prev);
		}
		if(this.doretreattowant != null){
			var li_want = $('<li></li>');
			var a_want = $('<a href="javascript:void(0);">' + this.doretreattowant.lable + '</a>');
			a_want.on("click", function() {
				_self.executeTowant();
			});
			li_want.append(a_want);
			ul.append(li_want);
		}
		if(this.doretreattoactivity != null){
			var activityArr = this.doretreattoactivity.targetName.split(",");
			var activityNameArr = this.doretreattoactivity.lable.split(",");
			$.each(activityArr, function(k, m){
				var li_activity = $('<li></li>');
				var a_activity = $('<a href="javascript:void(0);">退回到【' + activityNameArr[k] + '】节点</a>');
				a_activity.on("click", function() {
					_self.executeToactivity(m);
				});
				li_activity.append(a_activity);
				ul.append(li_activity);
			});
		}
		$("#bpm_buttons_default1").append(button);
		$("#bpm_buttons_default1").append(ul);
	}
};