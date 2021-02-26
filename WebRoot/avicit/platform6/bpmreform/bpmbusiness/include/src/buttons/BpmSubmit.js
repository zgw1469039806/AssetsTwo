/**
 * 提交，多个提交合成一个
 */
function BpmSubmit(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
	this.data = buttonData.dosubmit;
	this.transmitData = buttonData.dotransmitsubmit;
	if (this.flowEditor.isStart || flowUtils.notNull(this.data) || flowUtils.notNull(this.transmitData)) {
		this.enable = true;
	}
	if(flowUtils.notNull(buttonData.dosubmit) && flowUtils.notNull(buttonData.dosubmit[0].attribute) && flowUtils.notNull(buttonData.dosubmit[0].attribute.ideaElementIdBySelf)){
        this.ideaElementIdBySelf = buttonData.dosubmit[0].attribute.ideaElementIdBySelf;
	}
	//有提交按钮并且没有自定义意见框，则显示默认意见框
	if(this.enable && !this.hasIdeaElementBySelf()){
        this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_submit";
	this.getHtml();
	//是否是启动流程后的自动点击事件
    this.isAutoClickAfterStart = false;
};
BpmSubmit.prototype = new BpmButton();

/**
 * 禁用标志
 * @type {boolean}
 */
BpmSubmit.prototype.disabled = false;
/**
 * 执行
 */
BpmSubmit.prototype.execute = function(data) {
	var _self = this;
    if(this.disabled){
    	return;
	}
	this.disabled = true;
    setTimeout(function(){
        _self.disabled = false;
    },2000);

	if (this.flowEditor.isStart) {
		this.defaultForm.start(this.flowEditor.flowModel.defineId, function(startResult) {
			_self.flowEditor.afterStart(startResult);
			_self.flowEditor.createButtons(true);
			flowUtils.refreshBack();
		});
	} else {
		if (!this.flowEditor.defaultForm.beforeSubmit(data)) {
			return;
		}
		// 自动保存
		if (!this.isAutoClickAfterStart && !this.isEvent && this.flowEditor.defaultForm.isAutoSave && this.flowEditor.bpmSave.isEnable()) {
			this.flowEditor.defaultForm.save(function() {
				_self.flowEditor.createButtons(true, data.name);
			});
		} else {
			this.validIdeasBySelf("1", function () {
				_self.executeBack(data);
			});
		}
	}
};
BpmSubmit.prototype.executeBack = function(data) {
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			taskId : data.taskId,
			outcome : data.name,
			targetActivityName : data.targetActivityName,
			type : 'dosubmit'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				_self.validJsonData(data, result.taskUserSelect);
			}
		}
	});
};
/**
 * 校验数据并调用选人框
 *
 * @param taskUserSelect
 */
BpmSubmit.prototype.validJsonData = function(data, taskUserSelect) {
	var _self = this;
	if (flowUtils.notNull(taskUserSelect)) {
		// 初始化路由对象
		this.conditions = this.getConditions(taskUserSelect);
		//强制表态
		if(!this.isEvent && this.conditions.isIdeaCompelManner()){
			if($(".bpm_compelManner_div input[name='bpm_compelManner']:checked").length == 0){
				$(".bpm_compelManner_div").show();
				flowUtils.warning("请您表态");
				return;
			}
		}
		if (this.validIdeaMust()) {
			var nextActivityType = this.conditions.getNextActivityType();
			if (nextActivityType) {
				if (nextActivityType == "end") {// 下一节点为流程流转结束(归档)
					flowUtils.confirm("确定提交吗？", function() {
						_self.submit(data, [], true);
					});
					return;
				} else if(nextActivityType == 'sub-process'){
					//子流程
					if(!this.conditions.isMustUser()){
						flowUtils.confirm("确定提交吗？", function() {
							_self.submit(data, [], true);
						});
						return;
					}
				} else if(nextActivityType == 'foreach'){
					//循环节点
					if(!this.conditions.isMustUser()){
						flowUtils.confirm("确定提交吗？", function() {
							_self.submit(data, [], true);
						});
						return;
					}
				} else if (nextActivityType == 'task') {
					// 非分支
					if (!this.conditions.isBranch()) {
						// 不显示选人框&&自动选人
						if (!this.conditions.isSelectUser() && this.conditions.isUserSelectTypeAuto()) {
							flowUtils.confirm("确定提交吗？", function() {
								var user = new BpmActor(data, taskUserSelect, _self).getUsers();
								_self.submit(data, user);
							});
							return;
						} else {
							// 不需要显示选人框
							if (!this.conditions.isSelectUser()) {
								flowUtils.warning("配置错误：配置不显示选人框，但未配置自动选人");
								return;
							}
						}
					}
				}
				new BpmActor(data, taskUserSelect, this, this.conditions.isUflow()).open();
			} else if (!taskUserSelect.nextTask) {
				// 填写意见提交
				flowUtils.confirm("确定提交吗？", function() {
					_self.submit(data, [], true);
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
BpmSubmit.prototype.validIdeaMust = function() {
	if (!this.isEvent && this.conditions.getIdeaType() == 'must') {// 意见必须填写
		var ideaText = this.getIdeaText();
		if (!flowUtils.notNull(ideaText)) {
			flowUtils.warning('请填写流程意见');
			this.focusIdeaText();
			return false;
		}
	}
	return true;
};
/**
 * 提交
 */
BpmSubmit.prototype.submit = function(data, users, canBlank, uflowDealType) {
	if (!canBlank) {
		if (!flowUtils.notNull(users) || users.length == 0) {
			flowUtils.warning("选人错误");
			return;
		}
	}
	var idea = this.isEvent ? "同意" : this.getIdeaText();

	//重新组织意见
	idea = this.flowEditor.defaultForm.reGetidea(idea, users);

	var compelManner = "";
	if(this.conditions.isIdeaCompelManner()){
		if(this.isEvent){
			compelManner = "yes";
		}else{
			compelManner = $(".bpm_compelManner_div input[name='bpm_compelManner']:checked").val();
		}
	}
	if(flowUtils.notNull(this.ideas_text)){
		idea = this.ideas_text + " " + idea;
	}
	var userJson = {
		users : users,
		idea : idea,
		compelManner : compelManner,
		outcome : data.name
	};
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/dosubmit",
		data : {
			instanceId : data.procinstDbid,
			taskId : data.taskId,
			userJson : JSON.stringify(userJson),
			outcome : data.name,
			formJson : null,
			uflowDealType : uflowDealType,
			isUflow : this.conditions.isUflow()
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				if(_self.isEvent){
					flowUtils.success("提交成功！", function() {
						flowUtils.refreshCurrentBack();
					}, true);
				}else{
					flowUtils.success("提交成功！表单将自动关闭", function() {
						flowUtils.refreshBack();
						flowUtils.closeWindowOnDialog();
						setTimeout(function(){
							_self.flowEditor.createButtons();
						},500);
					}, true);
				}
				try {
					_self.flowEditor.defaultForm.afterSubmit(data);
				} catch (e) {

				}
			}
		}
	});
};
BpmSubmit.prototype.getHtml = function() {
	if (this.isEnable() && !this.isEvent) {
		var _self = this;
		if (this.data != null && this.data.length > 1) {
			//多条分支
			var button = $('<button class="listBtn btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt">提交</span><i></i></button>');
			button.attr("id", this.domeId);
			var ul = $('<ul class="dropdown-menu" aria-labelledby="' + this.domeId + '">');
			$.each(this.data, function(n, value) {
				var li = $('<li></li>');
				var a = $('<a href="javascript:void(0);">' + value.lable + '</a>');
				a.attr("title", value.description);
				a.on("click", function() {
					_self.execute(value);
				});
				li.append(a);
				ul.append(li);
				if(flowUtils.notNull(value.attribute)){
					if("yes" == value.attribute.ideaCompelManner){
						//$(".bpm_compelManner_div input[name='bpm_compelManner']").removeAttr("checked");
						$(".bpm_compelManner_div").show();
					}
				}
			});
			$("#bpm_buttons_default2").append(button);
			$("#bpm_buttons_default2").append(ul);
		} else if (this.data != null) {
			var data = this.data[0];
			var button = $('<button class="listBtn btn btn-default dropdown-toggle center" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt">提交</span></button>');
			button.attr("id", this.domeId);
			button.attr("title", data.description);
			button.on("click", function() {
				_self.execute(data);
			});
			$("#bpm_buttons_default2").append(button);
			if(flowUtils.notNull(data.attribute)){
				if("yes" == data.attribute.ideaCompelManner){
					//$(".bpm_compelManner_div input[name='bpm_compelManner']").removeAttr("checked");
					$(".bpm_compelManner_div").show();
				}
			}
		} else if (this.transmitData != null) {
			//完成传阅
			var button = $('<button class="listBtn btn btn-default dropdown-toggle center" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt">提交</span></button>');
			button.attr("id", this.domeId);
			button.attr("title", "填写意见");
			button.on("click", function() {
				_self.executeTransmit();
			});
			$("#bpm_buttons_default2").append(button);
		} else {
			//启动流程
			var button = $('<button class="listBtn btn btn-default dropdown-toggle center" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><span class="txt" id="bpm_firsttasksubmitname">提交</span></button>');
			button.attr("id", this.domeId);
			button.on("click", function() {
				_self.execute();
			});
			$("#bpm_buttons_default2").append(button);
			if(flowUtils.notNull(this.flowEditor.ideaCompelManner)){
				if("yes" == this.flowEditor.ideaCompelManner){
					//$(".bpm_compelManner_div input[name='bpm_compelManner']").removeAttr("checked");
					$(".bpm_compelManner_div").show();
				}
			}
            $.ajax({
                url:"platform/bpm/business/getFirstTaskSubmitName",
                data : {},
                type : "POST",
                dataType : "TEXT",
                success : function(msg) {
                    if(flowUtils.notNull(msg)){
                        $("#bpm_firsttasksubmitname").html(msg);
                    }
                }
            });
		}
	}
};
/**
 * 完成传阅
 */
BpmSubmit.prototype.executeTransmit = function() {
	var _self = this;
	flowUtils.confirm("确定提交吗？", function() {
		_self.submitTransmit();
	});
};
BpmSubmit.prototype.submitTransmit = function() {
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/dosubmitTransmit",
		data : {
			instanceId : this.transmitData.procinstDbid,
			message : this.getIdeaText(),
			taskId : this.transmitData.taskId
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				flowUtils.success("提交成功！表单将自动关闭", function() {
					flowUtils.refreshBack();
					flowUtils.closeWindowOnDialog();
                    setTimeout(function(){
                        _self.flowEditor.createButtons();
                    },500);
				}, true);
			}
		}
	});
};
/**
 * 流程启动之后自动点击一次提交按钮,或者触发保存之后再来调用提交
 */
BpmSubmit.prototype.clickBut = function(outcome) {
	var _self = this;
	if (this.isEnable()) {
		if(flowUtils.notNull(outcome)){
			if (this.data != null && this.data.length > 0) {
				for(var i = 0; i < this.data.length; i++){
					if(this.data[i].name == outcome){
						this.validIdeasBySelf("1", function () {
							_self.executeBack(_self.data[i]);
						});
						return;
					}
				}
			}
			layer.msg("路由条件可能已经发生变化，请重新进行提交");
		}else{
			if (this.data != null && this.data.length > 1) {
				layer.msg("流程已创建，请选择一个分支进行提交");
				$("#" + this.domeId).parent().addClass("open");
			} else if (this.data != null) {
				this.isAutoClickAfterStart = true;
				try{
					$("#" + this.domeId).click();
				}catch(e){
					this.isAutoClickAfterStart = false;
				}
				this.isAutoClickAfterStart = false;
			}
		}
	}
};
BpmSubmit.prototype.quickExecute = function() {
	if (this.isEnable() && this.isEvent) {
		var _self = this;
		if (this.data != null && this.data.length > 1) {
			var html = "";
			$.each(this.data, function(n, value) {
				if(n == 0){
					html += '<input checked _val="' + n + '" type="radio" name="submitName" id="' + value.id + '">&nbsp;&nbsp;<label for="' + value.id + '">' + value.lable + '</label>';
				}else{
					html += '<br/><input _val="' + n + '" type="radio" name="submitName" id="' + value.id + '">&nbsp;&nbsp;<label for="' + value.id + '">' + value.lable + '</label>';
				}
			});

			layer.open({
				title : "请选择办理事项",
				content : html,
				btn : [ '确定', '取消' ],
				yes : function(index, layero) {
					var radio = layero.find("input[name='submitName']:checked");
					if(radio.length == 0){
						flowUtils.error("请选择办理事项");
					}else{
						var i = Number(radio.attr("_val"));
						layer.close(index);
						_self.execute(_self.data[i])
					}
				}
			});
		} else if (this.data != null) {
			this.execute(this.data[0]);
		}
	}else{
		flowUtils.error("目前没有办理权限");
	}
};
