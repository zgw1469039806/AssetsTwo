///<jscompress sourcefile="DefaultForm.js" />
/**
 * 业务操作父类
 */
function DefaultForm() {
};
/**
 * 流程操作对象
 */
DefaultForm.prototype.flowEditor = null;

/**
 * 提交和退回前是否自动保存
 */
DefaultForm.prototype.isAutoSave = true;

/**
 * 表单主键
 *
 * @param id
 */
DefaultForm.prototype.id = null;
DefaultForm.prototype.setId = function(id) {
	this.id = id;
};
/**
 * 初始化业务数据
 */
DefaultForm.prototype.initFormData = function() {
};
/**
 * 启动流程
 *
 * @param defineId
 * @param callback
 */
DefaultForm.prototype.start = function(defineId, callback) {
};
/**
 * 更新数据
 *
 * @param callback
 */
DefaultForm.prototype.save = function(callback) {
};
/**
 * 刷新权限按钮后事件
 */
DefaultForm.prototype.afterCreateButtons = function() {
};
/**
 * 刷新表单元素权限成功后事件
 */
DefaultForm.prototype.afterControlFormInput = function() {
};
/**
 * 密级下拉框再过滤事件
 */
DefaultForm.prototype.filterSecretLevel = function(secretLevelList) {
	return secretLevelList;
};
/**
 * 引用文档上传前校验密级
 */
DefaultForm.prototype.validSecretLevel = function(secretLevelArr){
	return true;
};
/**
 * 设置附件是否可增删
 */
DefaultForm.prototype.setAttachMagic = function(magic){
};

/**
 * 设置多附件是否可增删
 */
DefaultForm.prototype.setAttachCanAddOrDel = function(tagId,operability,obj){
};

/**
 * 设置多附件是否必填
 */
DefaultForm.prototype.setAttachRequired = function(tagId,required,obj){
};

/**
 * 设置多附件密级是否可修改
 */
DefaultForm.prototype.setAttachSecretLevelModify = function(tagId,modify,obj){
};

/**
 * 自定义元素的权限控制，自定义元素定义通过".bpm_self_class"来实现
 * @param tagId 元素id
 * @param operability 是否可编辑
 */
DefaultForm.prototype.controlSelfElement = function(tagId, operability, obj){
};
/**
 * 自定义元素的权限控制，自定义元素定义通过".bpm_self_class"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlSelfElementForAccess = function(tagId, accessibility, obj){
};
/**
 * 自定义元素的必填控制，自定义元素定义通过".bpm_self_class"来实现
 * @param tagId 元素id
 * @param required 是否必填
 */
DefaultForm.prototype.controlSelfElementForRequired = function(tagId, accessibility, obj){
};

/**
 * 子表按钮元素的权限控制，子表按钮元素定义通过".eform_subtable_bpm_button_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlSubTableButtonForAccess = function(tagId, accessibility, obj){
};

/**
 * 非电子表单子表字段的显隐控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlCustomSubTableForAccess = function(tagId, accessibility, obj){
};
/**
 * 非电子表单子表字段的可编辑控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlCustomSubTableForOperability = function(tagId, operability, obj){
};
/**
 * 非电子表单子表字段的必填控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 */
DefaultForm.prototype.controlCustomSubTableForRequired = function(tagId, required, obj){
};
/**
 * 重新组织意见
 * @param idea
 * @param users
 * @returns {*}
 */
DefaultForm.prototype.reGetidea = function(idea, users){
    return idea;
};
/**
 * 默认流程意见
 * @param operateType 操作类型
 * @returns
 */
DefaultForm.prototype.getDefaultIdea = function (operateType) {
    return null;
};
/**
 * 判断选人框是否正确选人
 * @param users 当前选人数据
 * @returns {boolean} true继续操作，false终止操作
 */
DefaultForm.prototype.selectUserSuccess = function (users) {
	return true;
};
/**
 * 流程页面初始化事件，在按钮第一次加载后被执行
 */
DefaultForm.prototype.afterInit = function(){
};
/**
 * 是否在流程加载前执行用户密级与流程密级的匹配校验，若不匹配，则关闭页面
 */
DefaultForm.prototype.checkUserSecretLevel = function(){
	return typeof checkUserSecretLevel !== "undefined" && checkUserSecretLevel;
};
/**
 * 流程变量中哪个值存储密级，默认为"SECRETLEVEL" 或 "secretLevel"，也可以实现这个接口自行指定另外的值
 */
DefaultForm.prototype.secretLevelCode = function(){
	return typeof secretLevelCode !== "undefined" ? secretLevelCode : null;
};
/** 前后置事件 */
/**
 * 提交前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeSubmit = function(data) {
	return true;
};
/**
 * 提交后事件
 *
 * @param data
 */
DefaultForm.prototype.afterSubmit = function(data) {
};

/**
 * 退回前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeRetreat = function(data) {
	return true;
};
/**
 * 退回后事件
 *
 * @param data
 */
DefaultForm.prototype.afterRetreat = function(data) {
};

/**
 * 拿回前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeWithdraw = function(data) {
	return true;
};
/**
 * 拿回后事件
 *
 * @param data
 */
DefaultForm.prototype.afterWithdraw = function(data) {
};

/**
 * 补发前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeSupplement = function(data) {
	return true;
};
/**
 * 补发后事件
 *
 * @param data
 */
DefaultForm.prototype.afterSupplement = function(data) {
};

/**
 * 加签前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeAdduser = function(data) {
	return true;
};
/**
 * 加签后事件
 *
 * @param data
 */
DefaultForm.prototype.afterAdduser = function(data) {
};

/**
 * 转办前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeSupersede = function(data) {
	return true;
};
/**
 * 转办后事件
 *
 * @param data
 */
DefaultForm.prototype.afterSupersede = function(data) {
};

/**
 * 转发前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeTransmit = function(data) {
	return true;
};
/**
 * 转发后事件
 *
 * @param data
 */
DefaultForm.prototype.afterTransmit = function(data) {
};

/**
 * 增加读者前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeTaskreader = function(data) {
	return true;
};
/**
 * 增加读者后事件
 *
 * @param data
 */
DefaultForm.prototype.afterTaskreader = function(data) {
};

/**
 * 减签前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeWithdrawassignee = function(data) {
	return true;
};
/**
 * 减签后事件
 *
 * @param data
 */
DefaultForm.prototype.afterWithdrawassignee = function(data) {
};

/**
 * 流程结束前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeGlobalend = function(data) {
	return true;
};
/**
 * 流程结束后事件
 *
 * @param data
 */
DefaultForm.prototype.afterGlobalend = function(data) {
};

/**
 * 流程跳转前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeGlobaljump = function(data) {
	return true;
};
/**
 * 流程跳转后事件
 *
 * @param data
 */
DefaultForm.prototype.afterGlobaljump = function(data) {
};

/**
 * 流程恢复前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeGlobalresume = function(data) {
	return true;
};
/**
 * 流程恢复后事件
 *
 * @param data
 */
DefaultForm.prototype.afterGlobalresume = function(data) {
};

/**
 * 流程暂停前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeGlobalsuspend = function(data) {
	return true;
};
/**
 * 流程暂停后事件
 *
 * @param data
 */
DefaultForm.prototype.afterGlobalsuspend = function(data) {
};

/**
 * 自定义选人前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforeStepuserdefined = function(data) {
	return true;
};
/**
 * 自定义选人后事件
 *
 * @param data
 */
DefaultForm.prototype.afterStepuserdefined = function(data) {
};
/**
 * 催办前事件
 *
 * @param data
 * @returns {Boolean}
 */
DefaultForm.prototype.beforePresstodo = function(data) {
	return true;
};
/**
 * 催办后事件
 *
 * @param data
 */
DefaultForm.prototype.afterPresstodo = function(data) {
};
/**
 * 引导按钮code
 */
DefaultForm.prototype.getLeadButCodeList = function() {
	var result = new Array();
	result.push("dosubmit");
	result.push("dosubmit_mesh");
	result.push("dostart");
	result.push("dotransmitsubmit");
	return result;
};;
///<jscompress sourcefile="FlowModel.js" />
/**
 * 数据模板
 */
function FlowModel(defineId, deploymentId, entryId, executionId, taskId) {
	this.defineId = defineId;
	this.deploymentId = deploymentId;
    _fileupload_entryId = entryId;
	this.entryId = entryId;
	this.executionId = executionId;
	this.taskId = taskId;
};
/**
 * 流程定义文件主键
 *
 * @param defineId
 */
FlowModel.prototype.defineId = null;
FlowModel.prototype.setDefineId = function(defineId) {
	this.defineId = defineId;
};
/**
 * 流程部署文件主键
 *
 * @param deploymentId
 */
FlowModel.prototype.deploymentId = null;
FlowModel.prototype.setDeploymentId = function(deploymentId) {
	this.deploymentId = deploymentId;
};

/**
 * 流程实例主键
 *
 * @param entryId
 */
FlowModel.prototype.entryId = null;
FlowModel.prototype.setEntryId = function(entryId) {
    _fileupload_entryId = entryId;
	this.entryId = entryId;
};
/**
 * 流程指针ID
 *
 * @param executionId
 */
FlowModel.prototype.executionId = null;
FlowModel.prototype.setExecutionId = function(executionId) {
	this.executionId = executionId;
};
/**
 * 流程任务ID
 *
 * @param taskId
 */
FlowModel.prototype.taskId = null;
FlowModel.prototype.setTaskId = function(taskId) {
	this.taskId = taskId;
};
/**
 * 当前节点名称
 *
 * @param activityname
 */
FlowModel.prototype.activityname = null;
FlowModel.prototype.setActivityname = function(activityname) {
    _fileupload_taskName = activityname;
	this.activityname = activityname;
};
/**
 * 当前节点显示名
 *
 * @param activityname
 */
FlowModel.prototype.activitylabel = null;
FlowModel.prototype.setActivitylabel = function(activitylabel) {
	this.activitylabel = activitylabel;
};
/**
 * 当前身份
 * 用户身份 1待办人2 已办人 3待阅人 4已阅人 5读者，6拟稿人，7管理员，0未知
 *
 * @param activityname
 */
FlowModel.prototype.userIdentityKey = null;
FlowModel.prototype.setUserIdentityKey = function(userIdentityKey) {
	this.userIdentityKey = userIdentityKey;
};
/**
 * 当前身份
 * 用户身份 待办人 已办人 待阅人 已阅人 读者，拟稿人，管理员
 *
 * @param activityname
 */
FlowModel.prototype.userIdentity = null;
FlowModel.prototype.setUserIdentity = function(userIdentity) {
	this.userIdentity = userIdentity;
};
/**
 * 自定义强制表态意见
 * @type {null}
 */
FlowModel.prototype.ideasBySelf = null;
FlowModel.prototype.setIdeasBySelf = function(ideasBySelf) {
	this.ideasBySelf = ideasBySelf;
};
//暴漏的全局变量，下载附件是像后台传递
var _fileupload_entryId = "";
var _fileupload_taskName = "";
;
///<jscompress sourcefile="BpmButton.js" />
/**
 * 按钮基类
 */
function BpmButton(flowEditor, defaultForm, data, isEvent) {
	this.flowEditor = flowEditor;
	this.defaultForm = defaultForm;
	this.data = data;
	if (flowUtils.notNull(this.data)) {
		this.enable = true;
	}
	this.domeId = "";
	this.isEvent = isEvent;
};
BpmButton.prototype.enable = false;
BpmButton.prototype.isEnable = function() {
	return this.enable;
};
/**
 * 执行
 */
BpmButton.prototype.execute = function() {
	flowUtils.success("该方法开发中");
};
BpmButton.prototype.getHtml = function() {
	if(this.isEvent){
		return;
	}
	if (this.isEnable()) {
		var _self = this;
		if(this.data.alias){
			$("#" + this.domeId).html(this.data.alias);
		}else {
			$("#" + this.domeId).html(this.data.lable);
		}
		$("#" + this.domeId).off("click");
		$("#" + this.domeId).on("click", function() {
			_self.execute()
		});
		$("#" + this.domeId).show();
		$("#" + this.domeId).parent().show();
		$("#" + this.domeId).parent().prev().show();
		$("#bpm_buttons_more").show();
	} else {
		// 隐藏并清空事件
		$("#" + this.domeId).hide();
		$("#" + this.domeId).off("click");
	}
};
BpmButton.prototype.getIdeaText = function() {
	if(this.isEvent){
		return "";
	}
	return this.flowEditor.flowIdea.getIdea(this.ideaElementIdBySelf);
};
BpmButton.prototype.focusIdeaText = function() {
	this.flowEditor.flowIdea.focusIdeaText(this.ideaElementIdBySelf);
};
BpmButton.prototype.hasIdeaElementBySelf = function() {
    if(this.isEvent){
        return false;
    }
    return this.flowEditor.flowIdea.hasIdeaElementBySelf(this.ideaElementIdBySelf);
};
BpmButton.prototype.submit = function(data, users) {
	flowUtils.warning("未实现的方法");
};
BpmButton.prototype.validIdeasBySelf = function(valid_value, callback){
	var self = this;
	if(this.flowEditor.flowModel.ideasBySelf != null && this.flowEditor.flowModel.ideasBySelf.length > 0){
		var content = "<form class='container-fluid'>\n";
		var flg = false;
		for(var i = 0; i < this.flowEditor.flowModel.ideasBySelf.length; i++){
			var ideas = this.flowEditor.flowModel.ideasBySelf[i];
			if(ideas.outcome == "0" || ideas.outcome == valid_value){
				flg = true;
				content += "  <div class=\"form-group\">\n" +
					"    <label><input type='radio' name='ideas_radio'/> " + ideas.content + "</label>\n" +
					"  </div>\n";
			}
		}
		content += "</form>";
		if(!flg){
			callback();
			return;
		}
		layer.open({
			type : 1,
			title : "强制表态",
			area : [ "300px", "400px" ],
			content : content,
			btn: ['确定', '取消'],
			yes: function(index, layero){
				var ideas_radio = $("input[name='ideas_radio']:checked");
				if(ideas_radio.length == 0){
					flowUtils.warning("请先表态");
					return;
				}
				self.ideas_text = ideas_radio.parent().text().trim();
				callback();
				layer.close(index);//查询框关闭
			}
		});
	}else {
		callback();
	}
};
/**
 * 判断路由
 * 
 * @param dataJson
 * @returns {___anonymous1215_5418}
 */
BpmButton.prototype.getConditions = function(dataJson) {
	return {
		// 分支
		isBranch : function() {
			if (dataJson.nextTask != null && dataJson.nextTask.length > 1) {// 分支
				return true;
			} else {// 非分支
				return false;
			}
		},
		// 选人方式
		isUserSelectTypeAuto : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.userSelectType) {
				if (dataJson.nextTask[branchNo].currentActivityAttr.userSelectType == 'auto') {
					return true;// 自动选人方式
				} else {
					return false;
				}
			} else {
				return false;// 手动选人方式
			}
		},
		// 是否启用工作移交
		isWorkHandUser : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isWorkHandUser) {
				if (dataJson.nextTask[branchNo].currentActivityAttr.isWorkHandUser == 'no') {
					return false;// 启用
				} else {
					return true;// 不启用
				}
			} else {// 默认
				return true;// 不启用
			}
		},
		// 处理方式
		getDealType : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.dealType) {
				return dataJson.nextTask[branchNo].currentActivityAttr.dealType;
			}
			return "2";
		},
		// 处理方式
		getSingle : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.single) {
				return dataJson.nextTask[branchNo].currentActivityAttr.single;
			}
			return "no";
		},
		// 是否必须选人
		isMustUser : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isMustUser) {
				if (dataJson.nextTask[branchNo].currentActivityAttr.isMustUser == 'no') {// 必须选人
					return false;
				} else {
					return true;// 必须选人
				}
			} else {
				return true;// 默认值
			}
		},
		// 是否启用密级
		isSecret : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isSecret) {
				if (dataJson.nextTask[branchNo].currentActivityAttr.isMustUser == 'yes') {// 启用
					return true;
				} else {
					return false;// 不启用
				}
			} else {
				return false;// 不启用
			}
		},
		// 意见添写方式
		getIdeaType : function() {
			if (dataJson.currentActivityAttr.ideaType) {
				return dataJson.currentActivityAttr.ideaType;
			}
			return "";
		},
		// 是否强制表态
		isIdeaCompelManner : function() {
			if (dataJson.currentActivityAttr.ideaCompelManner) {
				if (dataJson.currentActivityAttr.ideaCompelManner == 'yes') {// 强制
					return true;
				} else {
					return false;// 不强制
				}
			} else {
				return false;// 不强制
			}
		},
		// 退回意见是否必填
		isNeedIdea : function() {
			if (dataJson.currentActivityAttr.isNeedIdea) {
				if (dataJson.currentActivityAttr.isNeedIdea == 'no') {// 强制
					return false;
				} else {
					return true;// 不强制
				}
			} else {
				return true;// 不强制
			}
		},
		// 是否显示选人框
		isSelectUser : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isSelectUser) {
				if (dataJson.nextTask[branchNo].currentActivityAttr.isSelectUser == 'no') {// 不显示
					return false;
				} else {
					return true;// 显示
				}
			} else {
				return true;// 显示
			}
		},
		/**
		 * 是否自动获取用户
		 */
		isAutoGetUser : function(branchNo) {
			if (typeof (branchNo) == 'undefined') {
				branchNo = 0;
			}
			if (dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isAutoGetUser) {
				if (dataJson.nextTask[branchNo].currentActivityAttr.isAutoGetUser == 'no') {// 不显示
					return false;
				} else {
					return true;// 是
				}
			} else {
				return false;
			}
		},
		// 获取下节点类型
		getNextActivityType : function() {
			return dataJson.activityType;
		},
		//是否是自由流程
		isUflow : function(){
			return dataJson.isUflow == "2";
		}
		
	}
};
;
///<jscompress sourcefile="BpmAdduser.js" />
/**
 * 流程增发
 */
function BpmAdduser(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doadduser, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_adduser";
	this.getHtml();
};
BpmAdduser.prototype = new BpmButton();
/**
 * 执行
 */
BpmAdduser.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeAdduser(this.data)){
		return;
	}
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : _self.data.procinstDbid,
			executionId : _self.data.executionId,
			taskId : _self.data.taskId,
			outcome : _self.data.name,
			targetActivityName : _self.data.targetActivityName,
			type : 'doadduser'
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				new BpmActor(_self.data, result.taskUserSelect, _self).open();
			}
		}
	});
};
/**
 * 
 * @param data
 * @param users
 */
BpmAdduser.prototype.submit = function(data, users) {
	if(!flowUtils.notNull(users) || users.length == 0){
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
			opType : 'doadduser'
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				flowUtils.success("加签成功");
				if(_self.isEvent){
					flowUtils.refreshCurrentBack();
				}
				try{
					_self.flowEditor.defaultForm.afterAdduser(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
//				flowUtils.refreshBack();
			}
		}
	});
};;
///<jscompress sourcefile="BpmGlobaljump.js" />
/**
 * 流程跳转
 */
function BpmGlobaljump(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobaljump, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_globaljump";
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
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getActJsonInfo",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			taskId : data.taskId,
			outcome : data.name,
			targetActivityName : data.targetActivityName,
			type : 'doglobaljump'
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
BpmGlobaljump.prototype.submit = function(data, users) {
	if(!flowUtils.notNull(users) || users.length == 0){
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
};;
///<jscompress sourcefile="BpmRetreat.js" />
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
};;
///<jscompress sourcefile="BpmSubmit.js" />
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
;
///<jscompress sourcefile="BpmActor.js" />
function BpmActor(data,taskJsonData,obj, isUflow) {
	this.data = data;
	this.submitObj = obj;
	this.taskJsonData = taskJsonData;
	this.isUflow = isUflow;
};
//BpmSubmit.prototype = new BpmButton();
/**
 * 执行
 */
BpmActor.prototype.open = function() {
	var _self = this;
	var title = _self.getActorHandTitle();
	if(!flowUtils.notNull(title)){
		title = "下一节点";
	}
	var url = 'platform/bpmActor/bpmSelectUserAction2/main?procinstDbid=' + this.data.procinstDbid + '&executionId=' + this.data.executionId + '&taskId=' + this.data.taskId + '&outcome=' + this.data.name + '&targetActivityName=' + this.data.targetActivityName + '&type=' + this.data.event + '&doSubmitUrl=&doSubmitCallEvent=';
	top.layer.open({
		skin: 'bpm_selectUser_class',
		type : 2,
		title: "选择【" + title + "】处理人",
		area : [ "800px", "450px" ],
		content : url,
		btn : [ '确定', '取消' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;
			var selectedUsers = iframeWin.getSelectedUsers();
			var targetActivityName = iframeWin.targetActivityName;
			if(iframeWin.currentActivityAttr_single == 'yes' || iframeWin.currentActivityAttr_dealType == '1'){//单选用户
				if(selectedUsers.length > 1){
					top.layer.msg('当前节点只允许选择一个处理人！');
					return;
				}
			}
			if(selectedUsers == null || selectedUsers.length == 0){
				top.layer.msg("请选择处理人");
				return;
			}

			/**
			 * 如果只选择了抄送节点则不能提交
			 */
			if(selectedUsers.length == 1 && selectedUsers[0].targetActivityName == "carbonCopy"){
				top.layer.msg("请选择处理人");
				return false;
			}

			//增加选人判断
			if(_self.submitObj instanceof BpmSubmit){
				var userFlg = _self.submitObj.flowEditor.defaultForm.selectUserSuccess(selectedUsers);
				if(!userFlg){
					return false;
				}
			}

			var uflowDealType = _self.getUflowDealType();
			var users;
			if(!_self.checkIsBranch()){//非分支提交
				if(_self.checkWorkHandUser()){//工作移交
					actorWorkerHandlerOperation(selectedUsers,_self,false,null, uflowDealType,targetActivityName);
					return;
				} else {//非工作移交
					users = [{
						selectedUsers : selectedUsers,
						targetActivityName : targetActivityName,//_self.data.targetActivityName == null ? "" : _self.data.targetActivityName,
						outcome : _self.data.name  == null ? "" : _self.data.name,
						workhandUsers : []
					}];
				}
			} else {//分支
				users = selectedUsers;
				if(_self.checkWorkHandUser()){//工作移交
					var workHandSelectedUsers = _self.geBranchWorkHandSelectedUsers(users);
					actorWorkerHandlerOperation(workHandSelectedUsers,_self,true,users,uflowDealType);
					return;
				}
			}
			top.layer.closeAll();
			_self.submitObj.submit(_self.data, users, false, uflowDealType);
		},
		success : function(layero, index){
			if(_self.isUflow){
				var tempDom = $(".bpm_selectUser_class");
				if(tempDom.length == 0){
					tempDom = parent.$(".bpm_selectUser_class");
				}
				if(tempDom.length == 0){
					return;
				}
				tempDom.find(".layui-layer-btn").append("<div class='pull-left'><input type='radio' name='dealtype' value='4' checked style='vertical-align:middle; margin-top:-2px; margin-bottom:1px;'/>多人并行&nbsp;&nbsp<input type='radio' name='dealtype' value='3' style='vertical-align:middle; margin-top:-2px; margin-bottom:1px;'/>多人任意</div>");
			}

            if(flowUtils.notNull(_self.data) && "dostepuserdefined" == _self.data.event){
                var iframeWin = layero.find('iframe')[0].contentWindow;
				$.ajax({
					url:"platform/bpm/business/getBpmStepPerson",
                    data:{
						entryId:_self.data.procinstDbid,
                        activityName:_self.data.activityName
					},
                    type : "POST",
                    dataType : "JSON",
                    success : function(result) {
						if(flowUtils.notNull(result)){
							for(var i = 0; i < result.length; i++){
								var user = result[i];
								var obj = {
									id:user.id,
									name:user.name,
                                    attributes:{
                                        deptId:user.deptId,
                                        deptName:user.deptName
									}
								};
                                iframeWin.selectorData(obj);
							}
						}
                    }
				});
			}
		}
	});
};
BpmActor.prototype.getUflowDealType = function(){
	if(this.isUflow){
		var tempDom = $(".bpm_selectUser_class");
		if(tempDom.length == 0){
			tempDom = parent.$(".bpm_selectUser_class");
		}
		if(tempDom.length == 0){
			return "";
		}
		return tempDom.find(".layui-layer-btn").find("input[name='dealtype']:checked").val();
	}
	return "";
};
BpmActor.prototype.getUsers = function(){
	var users;
	var _self = this;
	var url = 'platform/bpmActor/bpmSelectUserAction2/getAutoSelectedUsersJSONData';
	$.ajax({
		url : url,
		async: false,
		dataType : "JSON",
		data : {
			procinstDbid : this.data.procinstDbid,
			executionId : this.data.executionId,
			taskId: this.data.taskId,
			targetActivityName : this.data.targetActivityName,
			type : this.data.event,
			outcome : this.data.name
		},
		type : "GET",
		success : function(msg) {
			if(_self.data.event  == "doretreattodraft" || _self.data.event  == "doretreattoprev" || _self.data.event  == "dowithdraw"){//非分支
				users = [{
					selectedUsers : msg,
					targetActivityName : _self.data.targetActivityName == null ? "" : _self.data.targetActivityName,
					outcome : _self.data.name == null ? "" : _self.data.name,
					workhandUsers : []
				}];
			} else {
				users = msg;
			}
		}
	});
	return users;
};
BpmActor.prototype.checkIsBranch = function(){
	try{
		if(this.submitObj.conditions.isBranch()){
			return true;
		} else {
			return false;
		}
	}catch(e){
		return false;
	}
}
/**
 * 获取对话框标题
 * @returns
 */
BpmActor.prototype.getActorHandTitle = function(){
	try{
		if(!this.checkIsBranch()){
			var title = this.taskJsonData.nextTask[0].currentActivityAttr.activityAlias;
			if(title != null){
				return title;
			}else{
				return this.submitObj.data.lable;
			}
		} else {
			return '分支';
		}
	}catch(e){
		return this.submitObj.data.lable;
	}
}
/**
 * 判断是否存在工作移交
 */
BpmActor.prototype.checkWorkHandUser = function(){
	if(this.taskJsonData && this.taskJsonData.nextTask){
		for(var i = 0 ; i < this.taskJsonData.nextTask.length ; i++){
			var jsonData = this.taskJsonData.nextTask[i];
			if(jsonData.currentActivityAttr.isWorkHandUser == 'yes'){
				return true;
			}
		}
	} else {
		return false;
	}
};
/**
 * 获取工作移交的选人结果
 * @param users
 * @returns {Array}
 */
BpmActor.prototype.geBranchWorkHandSelectedUsers = function(users){
	var returnSelectedUsers = new Array();
	for(var i = 0 ; i < users.length ; i++){
		var selectedUsers = users[i].selectedUsers;
		for(var j = 0 ; j < selectedUsers.length ; j++){
			returnSelectedUsers.push(selectedUsers[j]);
		}
	}
	return returnSelectedUsers;
};
/**
 * 工作移交处理
 * @param users
 * @param taskData
 */
function actorWorkerHandlerOperation(users,parentObject,isBranch,originalUsers, uflowDealType, targetActivityName){
	$.ajax({
		   type: "POST",
		   url: 'platform/bpmActor/bpmSelectUserAction2/getWorkHandUsers',
		   async: false,
		   data: {
			   userList:JSON.stringify(users),
			   processKey: parentObject.taskJsonData.processKey
		   },
		   dataType: 'json',
		   success: function(workHandUsersList){
		     if(workHandUsersList && workHandUsersList.length > 0){
		    	 //var url = 'platform/bpmActor/bpmSelectUserAction2/getWorkHandSelectUser?userList=' + encodeURI(JSON.stringify(workHandUsersList));
		    	 var url = 'platform/bpmActor/bpmSelectUserAction2/getWorkHandSelectUser?userList=' + encodeURI(encodeURI(JSON.stringify(workHandUsersList)));
		    	 top.layer.open({
		    		    skin: 'bs-modal',
		    			title: "选择流程委托处理人",
		    			content: url,
		    			area: ['600px', '400px'],
		    			type:2,
		    			shade:0.3,
		    			btn: ['确定', '取消'],
		    			yes:function(index, layero){
		    				var iframeWin = layero.find('iframe')[0].contentWindow;
		    				var selectedUsers = iframeWin.getWorkhandSelectedUsers();
		    				if(isBranch){
		    					for(var i = 0 ; i < originalUsers.length ; i++){
		    						originalUsers[i].workhandUsers = selectedUsers;
		    					}
		    					top.layer.closeAll();
		    					parentObject.submitObj.submit(parentObject.data, originalUsers, false, uflowDealType);
		    				} else {
		    					var workhandUsers = [{
									selectedUsers : users,
									targetActivityName : targetActivityName,//parentObject.data.targetActivityName == null ? "" : parentObject.data.targetActivityName,
									outcome : parentObject.data.name,
									workhandUsers : selectedUsers
								}];
		    					top.layer.closeAll();
		    					parentObject.submitObj.submit(parentObject.data, workhandUsers, false, uflowDealType);
		    				}
		    			},
		    			init:function(index, layer){
		    			}
		    		});
		     } else {
		    	 if(isBranch){
		    		 top.layer.closeAll();
 					parentObject.submitObj.submit(parentObject.data, originalUsers, false, uflowDealType);
 				} else {
 					var workhandUsers = [{
							selectedUsers : users,
							targetActivityName : targetActivityName,//parentObject.data.targetActivityName == null ? "" : parentObject.data.targetActivityName,
							outcome : parentObject.data.name,
							workhandUsers : null
						}];
 					top.layer.closeAll();
 					parentObject.submitObj.submit(parentObject.data, workhandUsers, false, uflowDealType);
 				}
		     }
		   },
		   error : function(msg){
			   layer.alert(msg, {
					icon : 2
				});
			   return ;
		   }
	});
}
;
///<jscompress sourcefile="BpmTaskreader.js" />
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
};;
///<jscompress sourcefile="BpmRelationflow.js" />
/**
 * 相关流程
 */
function BpmRelationflow(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dorelationprocess, isEvent);
	this.domeId = "bpm_relationprocess";
	this.getHtml();
};
BpmRelationflow.prototype = new BpmButton();
/**
 * 执行
 */
BpmRelationflow.prototype.execute = function() {
	var _self = this;
	var procinstDbid = this.data.procinstDbid;
	this.index = layer.open({
		type : 2,
		area : [ '90%', '90%' ],
		title : '添加',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : 'avicit/platform6/bpmreform/bpmbusiness/include/relatedBpm.jsp?pid=' + encodeURIComponent(this.data.procinstDbid),
		end : function(){
			//刷新相关流程页签
			_self.flowEditor.reloadProcesslevelPage();
		}
	});
};
;
///<jscompress sourcefile="BpmTransmit.js" />
/**
 * 流程转发
 */
function BpmTransmit(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dotransmit, isEvent);
	if(this.isEnable()){
		this.flowEditor.needIdeaText = true;
	}
	this.domeId = "bpm_transmit";
	this.getHtml();
};
BpmTransmit.prototype = new BpmButton();
/**
 * 执行
 */
BpmTransmit.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeTransmit(this.data)){
		return;
	}
	new BpmActor(this.data, null, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmTransmit.prototype.submit = function(data, users) {
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
		url : "platform/bpm/business/dotransmit",
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
					_self.flowEditor.defaultForm.afterTransmit(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
//				flowUtils.refreshBack();
			}
		}
	});
};;
///<jscompress sourcefile="FlowButtons.src.js" />
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
};;
