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
	}
	this.retreattodraftDomeId = "doretreattodraft";
	this.retreattoprevDomeId = "doretreattoprev";
	this.retreattowantDomeId = "doretreattowant";
	this.retreattoactivityDomeId = "doretreattoactivity";
	this.meshDomeId = "doretreat_mesh";
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
		this.executeTodraftBack();
	}
};
BpmRetreat.prototype.executeTodraftBack = function() {
	var _self = this;
	this.validIdeasBySelf("2", function () {
		new BpmActor(_self.doretreattodraft, _self).open();
	});
	/**
	 * 回调
	 * 
	 * @param data
	 * @param users
	 */
	this.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
		if(flowUtils.notNull(_self.ideas_text)){
			idea = _self.ideas_text + " " + idea;
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
		this.executeToprevBack();
	}
};
BpmRetreat.prototype.executeToprevBack = function() {
	var _self = this;
	this.validIdeasBySelf("2", function () {
		new BpmActor(_self.doretreattoprev, _self).open();
	});
	/**
	 * 回调
	 */
	this.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
		if(flowUtils.notNull(_self.ideas_text)){
			idea = _self.ideas_text + " " + idea;
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
					flowUtils.error(msg.error);
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
		this.executeTowantSelectTask();
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
	this.validIdeasBySelf("2", function () {
		new BpmActor(data, _self).open();
	});
	/**
	 * 回调
	 * 
	 * @param data
	 * @param users
	 */
	this.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
		if(flowUtils.notNull(_self.ideas_text)){
			idea = _self.ideas_text + " " + idea;
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
		this.executeToactivityBack(targetActivityName);
	}
};

BpmRetreat.prototype.executeToactivityBack = function(targetActivityName) {
	var data = flowUtils.clone(this.doretreattoactivity);
	data.targetActivityName = targetActivityName;
	var _self = this;
	this.validIdeasBySelf("2", function () {
		new BpmActor(data, _self).open();
	});


	/**
	 * 回调
	 * 
	 * @param data
	 * @param users
	 */
	this.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
		if(flowUtils.notNull(_self.ideas_text)){
			idea = _self.ideas_text + " " + idea;
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
BpmRetreat.prototype.getHtml = function() {
	if(this.isEvent){
		return true;
	}
	$("#" + this.meshDomeId).children("ul").empty();
	$("#" + this.retreattodraftDomeId).children("a").off("click");
	$("#" + this.retreattoprevDomeId).children("a").off("click");
	$("#" + this.retreattowantDomeId).children("a").off("click");
	$("#" + this.retreattoactivityDomeId).children("a").off("click");
	if (this.isEnable()) {
		var _self = this;
		var temp_int = 0;
		if(this.doretreattodraft != null){
			temp_int = temp_int + 1;
		}
		if(this.doretreattoprev != null){
			temp_int = temp_int + 1;
		}
		if(this.doretreattowant != null){
			temp_int = temp_int + 1;
		}
		if(this.doretreattoactivity != null){
			var activityArr = this.doretreattoactivity.targetName.split(",");
			$.each(activityArr, function(k, m){
				temp_int = temp_int + 1;
			});
		}
		if(temp_int > 1){
			if(this.doretreattodraft != null){
				var label = $("#" + this.retreattodraftDomeId).find("span").text();
				var li = $('<li class="sub-list-li"><a href="javascript:void(0);" title="'+label+'">' + label + '</a></li>');
				li.children("a").on("click", function() {
					_self.executeTodraft();
				});
				$("#" + this.meshDomeId).children("ul").append(li);
			}
			if(this.doretreattoprev != null){
				var label = $("#" + this.retreattoprevDomeId).find("span").text();
				var li = $('<li class="sub-list-li"><a href="javascript:void(0);" title="'+label+'">' + label + '</a></li>');
				li.children("a").on("click", function() {
					_self.executeToprev();
				});
				$("#" + this.meshDomeId).children("ul").append(li);
			}
			if(this.doretreattowant != null){
				var label = $("#" + this.retreattowantDomeId).find("span").text();
				var li = $('<li class="sub-list-li"><a href="javascript:void(0);" title="'+label+'">' + label + '</a></li>');
				li.children("a").on("click", function() {
					_self.executeTowant();
				});
				$("#" + this.meshDomeId).children("ul").append(li);
			}
			if(this.doretreattoactivity != null){
				var activityArr = this.doretreattoactivity.targetName.split(",");
				var activityNameArr = this.doretreattoactivity.lable.split(",");
				var labelTemplate = $("#" + this.retreattoactivityDomeId).attr("label-template");
				$.each(activityArr, function(k, m){
					var label = labelTemplate.replaceAll("taskName", activityNameArr[k]);
					var li = $('<li class="sub-list-li"><a href="javascript:void(0);" title="'+label+'">' + label + '</a></li>');
					li.children("a").on("click", function() {
						_self.executeToactivity(m);
					});
					$("#" + _self.meshDomeId).children("ul").append(li);
				});
			}
			this.flowEditor.showButtons(this.meshDomeId);
		}else {
			if(this.doretreattodraft != null){
				$("#" + this.retreattodraftDomeId).children("a").on("click", function() {
					_self.executeTodraft();
				});
				this.flowEditor.showButtons(this.retreattodraftDomeId);
			}
			if(this.doretreattoprev != null){
				$("#" + this.retreattoprevDomeId).children("a").on("click", function() {
					_self.executeToprev();
				});
				this.flowEditor.showButtons(this.retreattoprevDomeId);
			}
			if(this.doretreattowant != null){
				$("#" + this.retreattowantDomeId).children("a").on("click", function() {
					_self.executeTowant();
				});
				this.flowEditor.showButtons(this.retreattowantDomeId);
			}
			if(this.doretreattoactivity != null){
				var activityArr = this.doretreattoactivity.targetName.split(",");
				var activityNameArr = this.doretreattoactivity.lable.split(",");
				var labelTemplate = $("#" + this.retreattoactivityDomeId).attr("label-template");
				$.each(activityArr, function(k, m){
					var label = labelTemplate.replaceAll("taskName", activityNameArr[k]);
					$("#" + _self.retreattoactivityDomeId).find("span").text(label);
					$("#" + _self.retreattoactivityDomeId).children("a").on("click", function() {
						_self.executeToactivity(m);
					});
				});
				this.flowEditor.showButtons(this.retreattoactivityDomeId);
			}
		}
	}
};