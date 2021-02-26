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
	// 隐藏并清空事件
	$("#" + this.domeId).children("a").off("click");
	if (this.isEnable()) {
		if(this.data && this.data.alias){
			$("#" + this.domeId).find("span").html(this.data.alias);
		}else {
			$("#" + this.domeId).find("span").html($("#" + this.domeId).find("a").attr("title"));
		}
		var _self = this;
		$("#" + this.domeId).children("a").on("click", function() {
			_self.execute();
		});
		this.flowEditor.showButtons(this.domeId);
	}
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
;
///<jscompress sourcefile="BpmAttribute.js" />
/**
 * 扩展按钮
 */
function BpmAttribute(flowEditor, defaultForm, buttonData, isEvent) {
    BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
    this.buttonData = buttonData;
    this.getHtml();
};
BpmAttribute.prototype = new BpmButton();

BpmAttribute.prototype.getHtml = function () {
    var _self = this;
    if (this.isEvent) {
        return;
    }
    $("._attribute").each(function (i, n) {
        $(n).children("a").off("click");
    });
    var meshMap = new Map();
    $.each(this.buttonData, function (i, n) {
        if (flowUtils.notNull(n.event) && n.event.endsWith("_attribute")) {
            var id = n.event.replaceAll("_attribute", "");
            if (id.endsWith("_mesh")) {
                $("#" + id).children("ul").empty();
                id = id.replaceAll("_mesh", "");
                meshMap.put(id, n);
            }
        }
    });
    $.each(this.buttonData, function (i, n) {
        if (flowUtils.notNull(n.event) && n.event.endsWith("_attribute")) {
            var id = n.event.replaceAll("_attribute", "");
            var func = $("#" + id).attr("_function");
            if (flowUtils.notNull(func)) {
                if (!id.endsWith("_mesh")) {
                    if (id.indexOf("_") != -1) {
                        var key = id.substr(0, id.indexOf("_"));
                        if (meshMap.containsKey(key)) {
                            var meshDomeId = key + "_mesh";
                            var label = $("#" + id).find("span").text();
                            var li = $('<li class="sub-list-li"><a href="javascript:void(0);" title="'+label+'">' + label + '</a></li>');
                            li.children("a").on("click", function() {
                                eval(func + "(_self)");
                            });
                            $("#" + meshDomeId).children("ul").append(li);
                            _self.flowEditor.showButtons(meshDomeId);
                            return;
                        }
                    }
                }

                $("#" + id).children("a").on("click", function () {
                    eval(func + "(_self)");
                });
                _self.flowEditor.showButtons(id);
            }
        }
    });
};;
///<jscompress sourcefile="BpmAdduser.js" />
/**
 * 流程增发
 */
function BpmAdduser(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doadduser, isEvent);
	this.domeId = "doadduser";
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
	new BpmActor(this.data, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmAdduser.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
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
///<jscompress sourcefile="BpmFocus.js" />
/**
 * 关注工作
 */
function BpmFocus(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dofocus, isEvent);
	this.domeId = "dofocus";
	this.getHtml();
};
BpmFocus.prototype = new BpmButton();
/**
 * 执行
 */
BpmFocus.prototype.execute = function() {
	avicAjax.ajax({
		url : "platform/bpm/business/setFocusedTask",
		data : {
			processInstanceId : this.flowEditor.flowModel.entryId,
			dbid : this.flowEditor.flowModel.taskId
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				if (msg.mes == false) {
					flowUtils.success("该任务此前已被关注");
				} else {
					flowUtils.success("已成功关注该任务");
				}
			}
		}
	});
};;
///<jscompress sourcefile="BpmGlobalend.js" />
/**
 * 流程结束
 */
function BpmGlobalend(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalend, isEvent);
	this.domeId = "doglobalend";
	this.getHtml();
};
BpmGlobalend.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobalend.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeGlobalend(this.data)){
		return;
	}
	new BpmActor(this.data, this).open();
};
BpmGlobalend.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/doend",
		data : {
			executionId : _self.data.executionId,
			message : idea
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				flowUtils.success("操作成功！表单将自动关闭", function() {
					flowUtils.refreshBack();
					flowUtils.closeWindowOnDialog();
					setTimeout(function(){
						_self.flowEditor.createButtons();
					},500);
				}, true);
				try{
					_self.flowEditor.defaultForm.afterGlobalend(_self.data);
				}catch(e){

				}
			}
		}
	});
};
;
///<jscompress sourcefile="BpmGlobalidea.js" />
/**
 * 流程意见修改
 */
function BpmGlobalidea(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalidea, isEvent);
	this.domeId = "doglobalidea";
	this.getHtml();
};
BpmGlobalidea.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobalidea.prototype.execute = function() {
	var _self = this;
	layer.open({
		type : 1,
		title : "修改意见",
		area : [ "800px", "450px" ],
		content : "<table id='ideaTable'></table>",
		btn : [ '确定', '关闭' ],
		success : function(layero, index) {
			$("#ideaTable").jqGrid({
				url : "platform/bpm/business/doGettracksByPage?entryId=" + _self.data.procinstDbid,
				mtype : 'POST',
				datatype : "json",
				rowNum : -1,
				colModel : [ {
					name : 'dbid',
					key : true,
					hidden : true
				}, {
					label : '节点',
					name : 'currentActiveLabel',
					align : 'center'
				}, {
					label : '处理人',
					name : 'assigneeName',
					align : 'center'
				}, {
					label : '接收时间',
					name : 'iTime',
					align : 'center'
				}, {
					label : '处理时间',
					name : 'eTime',
					align : 'center'
				}, {
					label : '操作类型',
					name : 'opType',
					align : 'center'
				}, {
					label : '处理意见',
					name : 'message',
					editable : true
				} ],
				rownumbers : true,
				altRows : true,
				styleUI : 'Bootstrap',
				autowidth : true,
				cellEdit : true,
				cellsubmit : 'clientArray',
				height : 300
			});
		},
		yes : function(index, layero) {
			$("#ideaTable").jqGrid('endEditCell');
			var data = $("#ideaTable").jqGrid('getChangedCells');
			avicAjax.ajax({
				url : 'platform/bpm/business/saveGettracks',
				data : {
					data : JSON.stringify(data),
					processInstanceId : _self.data.procinstDbid
				},
				type : 'post',
				dataType : 'json',
				success : function(msg) {
					if (flowUtils.notNull(msg.error)) {
						flowUtils.error(msg.error);
					} else {
						flowUtils.success("修改成功");
						layer.close(index);
						_self.flowEditor.refreshIdea();
					}
				}
			});
		}
	});
};;
///<jscompress sourcefile="BpmGlobaljump.js" />
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
};;
///<jscompress sourcefile="BpmGlobalresume.js" />
/**
 * 流程恢复
 */
function BpmGlobalresume(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalresume, isEvent);
	this.domeId = "doglobalresume";
	this.getHtml();
};
BpmGlobalresume.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobalresume.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeGlobalresume(this.data)){
		return;
	}
	var _self = this;
	flowUtils.confirm("您确定恢复该流程吗？", function() {
		avicAjax.ajax({
			url : "platform/bpm/business/doresume",
			data : {
				processInstanceId : _self.data.procinstDbid
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error,msg.errorDetail);
				} else {
					flowUtils.success("操作成功");
					try{
						_self.flowEditor.defaultForm.afterGlobalresume(_self.data);
					}catch(e){
						
					}
					_self.flowEditor.createButtons();
					flowUtils.refreshBack();
				}
			}
		});
	});
};;
///<jscompress sourcefile="BpmGlobalsuspend.js" />
/**
 * 流程暂停
 */
function BpmGlobalsuspend(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.doglobalsuspend, isEvent);
	this.domeId = "doglobalsuspend";
	this.getHtml();
};
BpmGlobalsuspend.prototype = new BpmButton();
/**
 * 执行
 */
BpmGlobalsuspend.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeGlobalsuspend(this.data)){
		return;
	}
	var _self = this;
	flowUtils.confirm("您确定暂停该流程吗？", function() {
		avicAjax.ajax({
			url : "platform/bpm/business/dosuspend",
			data : {
				processInstanceId : _self.data.procinstDbid
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error,msg.errorDetail);
				} else {
					flowUtils.success("操作成功!");
					try{
						_self.flowEditor.defaultForm.afterGlobalsuspend(_self.data);
					}catch(e){
						
					}
					_self.flowEditor.createButtons();
					flowUtils.refreshBack();
				}
			}
		});
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
};;
///<jscompress sourcefile="BpmSave.js" />
/**
 * 保存
 */
function BpmSave(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
	this.data = buttonData.doformsave;
	if (this.flowEditor.isStart || flowUtils.notNull(this.data)) {
		this.enable = true;
	}
	this.domeId = "doformsave";
	this.getHtml();
};
BpmSave.prototype = new BpmButton();
/**
 * 禁用标志
 * @type {boolean}
 */
BpmSave.prototype.disabled = false;
/**
 * 执行
 */
BpmSave.prototype.execute = function() {
	var _self = this;
	if (this.disabled) {
		return;
	}
	this.disabled = true;
	setTimeout(function () {
		_self.disabled = false;
	}, 2000);

	if (this.flowEditor.isStart) {
		this.defaultForm.start(this.flowEditor.flowModel.defineId, function(startResult) {
			flowUtils.success("暂存成功");
			_self.flowEditor.afterStart(startResult);
			_self.flowEditor.createButtons();
			flowUtils.refreshBack();
		});
	} else {
		this.defaultForm.save(function() {
			flowUtils.success("暂存成功");
			_self.flowEditor.createButtons();
			//flowUtils.refreshBack();
		});
	}
};;
///<jscompress sourcefile="BpmStepuserdefined.js" />
/**
 * 自定义选人
 */
function BpmStepuserdefined(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dostepuserdefined, isEvent);
	this.domeId = "dostepuserdefined";
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
	new BpmActor(data, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmStepuserdefined.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
	var _self = this;
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
    this.domeId = "dosubmit";
    this.meshDomeId = "dosubmit_mesh";
    this.startDomeId = "dostart";
    this.transmitsubmitDomeId = "dotransmitsubmit";
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
BpmSubmit.prototype.execute = function (data) {
    var _self = this;
    if (this.disabled) {
        return;
    }
    this.disabled = true;
    setTimeout(function () {
        _self.disabled = false;
    }, 2000);

    if (this.flowEditor.isStart) {
        this.defaultForm.start(this.flowEditor.flowModel.defineId, function (startResult) {
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
            this.flowEditor.defaultForm.save(function () {
                _self.flowEditor.createButtons(true, data.name);
            });
        } else {
            this.validIdeasBySelf("1", function () {
                new BpmActor(data, _self).open();
            });
        }
    }
};
/**
 * 提交
 */
BpmSubmit.prototype.submit = function (data, users, idea, compelManner, uflowDealType, isUflow) {
    //重新组织意见
    idea = this.flowEditor.defaultForm.reGetidea(idea, users);

    if(flowUtils.notNull(this.ideas_text)){
        idea = this.ideas_text + " " + idea;
    }

    //如果是已阅按钮，转到已阅方法上
    if(this.transmitData != null){
        this.submitTransmit(idea);
        return;
    }

    var userJson = {
        users: users,
        idea: idea,
        compelManner: compelManner,
        outcome: data.name
    };
    var _self = this;
    avicAjax.ajax({
        url: "platform/bpm/business/dosubmit",
        data: {
            instanceId: data.procinstDbid,
            taskId: data.taskId,
            userJson: JSON.stringify(userJson),
            outcome: data.name,
            formJson: null,
            uflowDealType: uflowDealType,
            isUflow: isUflow
        },
        type: "POST",
        dataType: "JSON",
        success: function (msg) {
            if (flowUtils.notNull(msg.error)) {
                flowUtils.error(msg.error,msg.errorDetail);
            } else {
                if (_self.isEvent) {
                    flowUtils.success("提交成功！", function () {
                        flowUtils.refreshCurrentBack();
                    }, true);
                } else {
                    flowUtils.success("提交成功！表单将自动关闭", function () {
                        flowUtils.refreshBack();
                        flowUtils.closeWindowOnDialog();
                        setTimeout(function () {
                            _self.flowEditor.createButtons();
                        }, 500);
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
BpmSubmit.prototype.getHtml = function () {
    $("#" + this.meshDomeId).children("ul").empty();
    $("#" + this.domeId).children("a").off("click");
    $("#" + this.startDomeId).children("a").off("click");
    $("#" + this.transmitsubmitDomeId).children("a").off("click");
    if (this.isEnable() && !this.isEvent) {
        var _self = this;
        if (this.data != null && this.data.length > 1) {
            //多条分支
            $.each(this.data, function (n, value) {
                var li = $('<li class="sub-list-li"><a href="javascript:void(0);" title="'+value.lable+'">' + value.lable + '</a></li>');
                li.children("a").attr("title", value.description);
                li.children("a").on("click", function () {
                    _self.execute(value);
                });
                $("#" + _self.meshDomeId).children("ul").append(li);
            });
            this.flowEditor.showButtons(this.meshDomeId);
        } else if (this.data != null) {
            //只有一个提交
            var data = this.data[0];
            $("#" + this.domeId).attr("title", data.description);
            $("#" + this.domeId).find("span").text(data.lable);
            $("#" + this.domeId).children("a").on("click", function () {
                _self.execute(data);
            });
            this.flowEditor.showButtons(this.domeId);
        } else if (this.transmitData != null) {
            //完成传阅
            $("#" + this.transmitsubmitDomeId).children("a").on("click", function () {
                _self.executeTransmit();
            });
            this.flowEditor.showButtons(this.transmitsubmitDomeId);
        } else {
            //启动流程
            $("#" + this.startDomeId).children("a").on("click", function () {
                _self.execute();
            });
            this.flowEditor.showButtons(this.startDomeId);
        }
    }
};
/**
 * 完成传阅
 */
BpmSubmit.prototype.executeTransmit = function () {
    var _self = this;
    // flowUtils.confirm("确定提交吗？", function () {
        // _self.submitTransmit();
        new BpmActor(_self.transmitData, _self).open();
    // });
};
BpmSubmit.prototype.submitTransmit = function (idea) {
    var _self = this;
    avicAjax.ajax({
        url: "platform/bpm/business/dosubmitTransmit",
        data: {
            instanceId: this.transmitData.procinstDbid,
            message: idea || "已阅",
            taskId: this.transmitData.taskId
        },
        type: "POST",
        dataType: "JSON",
        success: function (msg) {
            if (flowUtils.notNull(msg.error)) {
                flowUtils.error(msg.error,msg.errorDetail);
            } else {
                flowUtils.success("提交成功！表单将自动关闭", function () {
                    flowUtils.refreshBack();
                    flowUtils.closeWindowOnDialog();
                    setTimeout(function () {
                        _self.flowEditor.createButtons();
                    }, 500);
                }, true);
            }
        }
    });
};
/**
 * 流程启动之后自动点击一次提交按钮,或者触发保存之后再来调用提交
 */
BpmSubmit.prototype.clickBut = function (outcome) {
    var _self = this;
    if (this.isEnable()) {
        if(flowUtils.notNull(outcome)){
            if (this.data != null && this.data.length > 0) {
                for(var i = 0; i < this.data.length; i++){
                    if(this.data[i].name == outcome){
                        this.validIdeasBySelf("1", function () {
                            new BpmActor(_self.data[i], _self).open();
                        });
                        return;
                    }
                }
            }
            layer.msg("路由条件可能已经发生变化，请重新进行提交");
        }else {
            if (this.data != null && this.data.length > 1) {
                layer.msg("流程已创建，请选择一个分支进行提交");
            } else if (this.data != null) {
                this.isAutoClickAfterStart = true;
                try {
                    $("#" + this.domeId).find("a").click();
                } catch (e) {
                    this.isAutoClickAfterStart = false;
                }
                this.isAutoClickAfterStart = false;
            }
        }
    }
};
;
///<jscompress sourcefile="BpmSupersede.js" />
/**
 * 流程转办
 */
function BpmSupersede(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dosupersede, isEvent);
	this.domeId = "dosupersede";
	this.getHtml();
};
BpmSupersede.prototype = new BpmButton();
/**
 * 执行
 */
BpmSupersede.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeSupersede(this.data)){
		return;
	}
	new BpmActor(this.data, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmSupersede.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
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
		url : "platform/bpm/business/dosupersede",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson),
			selectUserId : null,
			formJson : null,
			activityName : data.targetActivityName
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				flowUtils.success("操作成功！表单将自动关闭", function() {
					flowUtils.refreshBack();
					flowUtils.closeWindowOnDialog();
                    setTimeout(function(){
                        _self.flowEditor.createButtons();
                    },500);
				}, true);
				try{
					_self.flowEditor.defaultForm.afterSupersede(data);
				}catch(e){
					
				}
			}
		}
	});
};;
///<jscompress sourcefile="BpmPresstodo.js" />
/**
 * 催办下节点
 */
function BpmPresstodo(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dopresstodo, isEvent);
	this.domeId = "dopresstodo";
	this.getHtml();
};
BpmPresstodo.prototype = new BpmButton();
/**
 * 执行
 */
BpmPresstodo.prototype.execute = function() {
	if (!this.flowEditor.defaultForm.beforePresstodo(this.data)) {
		return;
	}
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/beforepresstodo",
		data : {
			executionId : _self.data.executionId
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(msg.error,msg.errorDetail);
			} else {
				_self.presstodo(result.result);
			}
		}
	});
	
};
BpmPresstodo.prototype.presstodo = function(result){
	var _self = this;
	var message = "";
	if(result.flg == "true"){
		message = "确定对下一节点进行催办吗？" + result.msg;
	}else{
		message = "下一节点在" + result.time + "被催办过，确定继续进行催办吗？" + result.msg;
	}
	flowUtils.confirm(message, function() {
		avicAjax.ajax({
			url : "platform/bpm/business/dopresstodo",
			data : {
				executionId : _self.data.executionId
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error,msg.errorDetail);
				} else {
					flowUtils.success("催办成功");
					try {
						_self.flowEditor.defaultForm.afterPresstodo(_self.data);
					} catch (e) {

					}
				}
			}
		});
	});
}
;
///<jscompress sourcefile="BpmSupplement.js" />
/**
 * 补发
 */
function BpmSupplement(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dosupplement, isEvent);
	this.domeId = "dosupplement";
	this.getHtml();
};
BpmSupplement.prototype = new BpmButton();
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
	new BpmActor(data, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmSupplement.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
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
};;
///<jscompress sourcefile="BpmTaskreader.js" />
/**
 * 增加读者
 */
function BpmTaskreader(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dotaskreader, isEvent);
	this.domeId = "dotaskreader";
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
	new BpmActor(this.data, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmTaskreader.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
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
///<jscompress sourcefile="BpmTransmit.js" />
/**
 * 流程转发
 */
function BpmTransmit(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dotransmit, isEvent);
	this.domeId = "dotransmit";
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
	new BpmActor(this.data, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmTransmit.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
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
///<jscompress sourcefile="BpmWithdraw.js" />
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
};;
///<jscompress sourcefile="BpmRelationflow.js" />
/**
 * 相关流程
 */
function BpmRelationflow(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dorelationprocess, isEvent);
	this.domeId = "dorelationprocess";
	this.getHtml();
};
BpmRelationflow.prototype = new BpmButton();
/**
 * 执行
 */
BpmRelationflow.prototype.execute = function() {
	this.index = layer.open({
		type : 2,
		area : [ '90%', '90%' ],
		title : '添加',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, //开启最大化最小化按钮
		content : 'avicit/platform6/bpmreform/bpmbusiness/include/relatedBpm.jsp?pid=' + encodeURIComponent(this.data.procinstDbid),
		end : function(){
		}
	});
};
;
///<jscompress sourcefile="BpmStartsubflow.js" />
/**
 * 发起子流程
 */
function BpmStartsubflow(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dostartsubprocess, isEvent);
	this.domeId = "dostartsubprocess";
	this.getHtml();
};
BpmStartsubflow.prototype = new BpmButton();
/**
 * 执行
 */
BpmStartsubflow.prototype.execute = function() {
	var _self = this;
	avicAjax.ajax({
		url : "platform/bpm/business/getSubPdId",
		data : {
			procinstDbid : this.data.procinstDbid,
			executionId : this.data.executionId
		},
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				if(result.ids.length == 0){
					//flowUtils.warning("该功能未设置相应的流程模板！");
					//默认展示所有流程模板
					_self.showAllFlowModel();
				}else if(result.ids.length == 1){
					_self.executeUserInfo(result.ids[0].id);
				}else{
					_self.executeSelectId(result.ids);
				}
			}
		}
	});
};
var _bpm_BpmStartsubflow = null;
BpmStartsubflow.prototype.showAllFlowModelFlg = false;
BpmStartsubflow.prototype.showAllFlowModel = function() {
	_bpm_BpmStartsubflow = this;
	var _self = this;
	layer.open({
		type: 2,
		title: "选择子流程模板",
		area: ["800px", "450px"],
		content: "platform/bpm/business/showAllFlowModel",
		end : function() {
			_self.showAllFlowModelFlg = false;
		},
	});
	this.showAllFlowModelFlg = true;
};
BpmStartsubflow.prototype.executeSelectId = function(ids) {
	var _self = this;
	layer.open({
	    type:  1,
	    area: [ "300px",  "450px"],
	    title: "流程模板选择",
	    content: "<table id='processGrid'></table>",
	    btn: ['确定', '关闭'],
		 success : function(layero, index) {
			$("#processGrid").jqGrid({
				datastr : JSON.stringify(ids),
				datatype : "jsonstring",
				colModel : [{
					name : 'id',
					key : true,
					hidden : true
				}, {
					label : '流程名称',
					name : 'name',
					align : 'center'
				} ],
				rownumbers : true,
				altRows : true,
				styleUI : 'Bootstrap',
				autowidth : true,
				height : '100%',
				multiselect: false,  
				multiboxonly:true,  
				beforeSelectRow: _self.beforeSelectRow
			});
		},
		yes: function(index, layero){
			var id = $("#processGrid").jqGrid("getGridParam","selrow");
			if (id != "") {
				_self.executeUserInfo(id);
			} else{
				layer.msg("请选择数据");
				return;
			}
			layer.close(index);
		}
	});
};
BpmStartsubflow.prototype.beforeSelectRow = function(){
	$("#processGrid").jqGrid('resetSelection');  
    return true;
};
BpmStartsubflow.prototype.executeUserInfo = function(id) {
	if(this.showAllFlowModelFlg){
		layer.closeAll();
	}
	this.data.deployId = id;
	new BpmActor(this.data, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmStartsubflow.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
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
		url : "platform/bpm/business/dostartsubprocess",
		data : {
			procinstDbid : data.procinstDbid,
			executionId : data.executionId,
			userJson : JSON.stringify(userJson),
			id : data.deployId
		},
		type : "POST",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				flowUtils.success("操作成功!");
				_self.flowEditor.createButtons();
				flowUtils.refreshBack();
			}
		}
	});
};;
///<jscompress sourcefile="BpmRelationparentflow.js" />
/**
 * 关联父流程
 */
function BpmRelationparentflow(flowEditor, defaultForm, buttonData, isEvent) {
    BpmButton.call(this, flowEditor, defaultForm, buttonData.dorelationparentprocess, isEvent);
    this.domeId = "dorelationparentprocess";
    this.getHtml();
};
BpmRelationparentflow.prototype = new BpmButton();

BpmRelationparentflow.prototype.showDialog = function (procinstDbid, hasParent) {
    var _self = this;
    layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '添加页',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        btn: ['保存', '取消已关联的父流程', '返回'],
        content: 'avicit/platform6/bpmreform/bpmbusiness/include/SubprocessAdd.jsp',
        yes: function (index1, layero) {
            var body = layer.getChildFrame('body', index1);
            var selectedRowIds = body.find("#firstjqGrid").getGridParam("selarrrow");//行数据
            var len = selectedRowIds.length;
            if (len == 0) {
                flowUtils.warning("请选择要关联的父流程！");
            } else if (len > 1) {
                flowUtils.warning("只允许关联一条父流程！");
            } else {
                var rowData = body.find("#firstjqGrid").getRowData(selectedRowIds[0]);
                avicAjax.ajax({
                    url: 'bpm/business/related/subProcessSaveData',
                    data: {
                        dbid1: procinstDbid,
                        task: '',
                        dbid2: rowData["dbId"]
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function (r) {
                        if (r.flag == "success") {
                            flowUtils.success("关联成功！");
                            layer.close(index1);
                        } else if (r.flag == 'same') {
                            flowUtils.warning("父流程不能与当前流程相同！");
                        } else if (r.flag == 'parentOrSub') {
                            flowUtils.warning("已经存在父子流程关系！");
                        } else {
                            flowUtils.warning("关联失败！");
                        }
                    }
                });
            }
            return false;
        },
        end: function () {
            _self.flowEditor.createButtons();
        },
        btn2: function (index1, layero) {
            if(!hasParent){
                flowUtils.warning("当前无已关联的父流程！");
                return false;;
            }
            flowUtils.confirm('确定取消已关联的父流程吗?', function () {
                avicAjax.ajax({
                    url: 'bpm/business/related/subDelData',
                    data: {
                        id: procinstDbid
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function (r) {
                        if (r.flag == "success") {
                            flowUtils.success("取消成功！");
                            layer.close(index1);
                        } else {
                            flowUtils.warning("取消失败！");
                        }
                    }
                });
            });
            return false;
        }
    });
};
/**
 * 执行
 */
BpmRelationparentflow.prototype.execute = function () {
    var _self = this;
    var procinstDbid = this.data.procinstDbid;//主流程实例ID
    avicAjax.ajax({
        url: 'bpm/business/related/findSubProcessById',
        data: {
            data: procinstDbid
        },
        type: 'post',
        dataType: 'json',
        success: function (r) {
            if (r.flag == "success") {
                _self.showDialog(procinstDbid, false);
            } else if (r.flag == "exist") {
                flowUtils.confirm('已关联父流程，确认要重新关联吗?', function () {
                    _self.showDialog(procinstDbid, true);
                });
            }else if(r.flag == "existAndNoEdit"){
                flowUtils.warning("该流程为父流程自动发起，不允许手动关联父流程！");
            }else if(r.flag == "failure"){
                flowUtils.warning("查询数据异常！");
            }
        }
    });
};
;
///<jscompress sourcefile="BpmWithdrawassignee.js" />
/**
 * 节点内拿回
 */
function BpmWithdrawassignee(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, buttonData.dowithdrawassignee, isEvent);
	this.domeId = "dowithdrawassignee";
	this.getHtml();
};
BpmWithdrawassignee.prototype = new BpmButton();
/**
 * 执行
 */
BpmWithdrawassignee.prototype.execute = function() {
	if(!this.flowEditor.defaultForm.beforeWithdrawassignee(this.data)){
		return;
	}
	new BpmActor(this.data, this).open();
};
/**
 * 
 * @param data
 * @param users
 */
BpmWithdrawassignee.prototype.submit = function(data, users, idea, compelManner, uflowDealType, isUflow) {
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
		url : "platform/bpm/business/dowithdrawactassignee",
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
				flowUtils.success("减签成功");
				try{
					_self.flowEditor.defaultForm.afterWithdrawassignee(data);
				}catch(e){
					
				}
				_self.flowEditor.createButtons();
			}
		}
	});
};;
///<jscompress sourcefile="BpmButFile.js" />
/**
 * 引用文档
 */
function BpmButFile(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
	this.enable = false;
	this.domeId = "bpm_but_file";
	this.getHtml();
};
BpmButFile.prototype = new BpmButton();
/**
 * 执行
 */
BpmButFile.prototype.execute = function() {
	var dialog = layer.open({
		type : 2,
		title : "引用文档",
		area : [ "800px", "450px" ],
		content : ""
	});
	layer.full(dialog);
};;
///<jscompress sourcefile="BpmButTrack.js" />
/**
 * 流程跟踪
 */
function BpmButTrack(flowEditor, defaultForm, buttonData, isEvent) {
    BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
    this.enable = true;
    this.domeId = "bpm_but_track";
    this.getHtml();
};
BpmButTrack.prototype = new BpmButton();
/**
 * 执行
 */
BpmButTrack.prototype.execute = function() {
    var url = "avicit/platform6/bpmreform/bpmdesigner/picture/picAndTracks.jsp?";
    if(flowUtils.notNull(this.flowEditor.flowModel.entryId)){
        url += "entryId=" + this.flowEditor.flowModel.entryId;
    }else{
        url += "deploymentId=" + this.flowEditor.flowModel.deploymentId;
    }
    var dialog = layer.open({
        type : 2,
        title : "流程跟踪",
        area : [ "800px", "450px" ],
        content : url
    });
    layer.full(dialog);
};;
///<jscompress sourcefile="BpmButRelation.js" />
/**
 * 关联流程
 */
function BpmButRelation(flowEditor, defaultForm, buttonData, isEvent) {
    BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
    this.enable = flowUtils.notNull(this.flowEditor.flowModel.entryId);
    this.domeId = "bpm_but_relation";
    this.getHtml();
};
BpmButRelation.prototype = new BpmButton();
/**
 * 执行
 */
BpmButRelation.prototype.execute = function () {
    var url = "avicit/platform6/bpmreform/bpmbusiness/include2/bpmRelationflow.jsp?entryId=" + this.flowEditor.flowModel.entryId;
    var dialog = layer.open({
        type: 2,
        title: "关联流程",
        area: ["800px", "450px"],
        content: url
    });
    layer.full(dialog);
};;
///<jscompress sourcefile="BpmButHelp.js" />
/**
 * 帮助
 */
function BpmButHelp(flowEditor, defaultForm, buttonData, isEvent) {
	BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
	this.enable = true;
	this.domeId = "bpm_but_help";
	this.getHtml();
};
BpmButHelp.prototype = new BpmButton();
/**
 * 执行
 */
BpmButHelp.prototype.execute = function() {
	help($("#" + this.domeId).find("a"));
};;
///<jscompress sourcefile="FlowIdea.js" />
/**
 * 流程意见操作
 */
function FlowIdea(flowEditor) {
    this.flowEditor = flowEditor;
};
/**
 * 流程操作对象
 */
FlowIdea.prototype.flowEditor = null;

FlowIdea.prototype.refresh = function () {
    if(!flowUtils.notNull(this.flowEditor.flowModel.entryId)){
        //初始化时，没有数据，默认隐藏
        $('.l-radio[data-for="bpm_idea_tab"]').click();
        return;
    }
    var _self = this;
    $.ajax({
        url: "platform/bpm/business/getAllIdeaStyleData",
        data: {entryId: this.flowEditor.flowModel.entryId},
        type: "POST",
        dataType: "JSON",
        success: function (r) {
            if(flowUtils.notNull(r)){
                _self.drawIdeaAndSign(r);
            }
        }
    });
};
FlowIdea.prototype.drawIdeaAndSign = function (r){
    var result = r.result;
    if(!flowUtils.notNull(result)){
        //没有数据时，默认隐藏
        $('.l-radio[data-for="bpm_idea_tab"]').click();
        return;
    }
    var _self = this;
    $("#ideaDiv").empty();
    $.each(result, function (x, ideas) {
        if(!flowUtils.notNull(ideas)){
            return;
        }
        var $tr = $("<tr class='pttable'></tr>");
        var $td1 = $("<td class='l pttable'></td>");
        $tr.append($td1);
        var $td2 = $("<td class='r pttable'></td>");
        var $td2_table = $("<table class='pslist-table'></table>");
        var $td2_tbody = $("<tbody class='pslist-text'></tbody>");
        $.each(ideas, function (y, idea) {
            if(y == 0){
                $td1.text(idea.title);
            }
            var $td2_tr = $("<tr></tr>");
            var $td2_tr_td1 = $("<td></td>");
            if(idea.showSign=="1"){
                var $img = $('<img width="80" height="30" title="电子签名" style="cursor: pointer;" src="platform/cc/sysuserphoto/upload/signphoto?sysUserId=' + idea.userId + '"/>');
                $td2_tr_td1.append($img);
            }else{
                $td2_tr_td1.text(idea.user+"/"+idea.dept);
            }
            $td2_tr.append($td2_tr_td1);
            var $td2_tr_td2 = $("<td class='r'></td>");
            $td2_tr_td2.text(_self.getComment(idea));
            $td2_tr.append($td2_tr_td2);
            $td2_tbody.append($td2_tr);
        });
        $td2_table.append($td2_tbody);
        $td2.append($td2_table);
        $tr.append($td2);
        $("#ideaDiv").append($tr);
    });
};
FlowIdea.prototype.getComment = function(ideaData){
    var comment = "";
    var displayStyle = ideaData.displayStyle;
    var displayStyleArr = displayStyle.split(",");
    for(var i = 0; i < displayStyleArr.length; i++){
        if(displayStyleArr[i] == "user" || displayStyleArr[i] == "dept"){
            continue;
        }
        comment += ideaData[displayStyleArr[i]] + " ";
    }
    return comment;
};;
///<jscompress sourcefile="FlowForm.js" />
/**
 * 表单操作
 */
function FlowForm(flowEditor) {
    this.flowEditor = flowEditor;
};
/**
 * 流程操作对象
 */
FlowForm.prototype.flowEditor = null;

/**
 * 控制表单元素
 */
FlowForm.prototype.controlFormInput = function() {
    var _self = this;
    //是否电子表单
    var isEform = true;
    var userIdentityKey = this.flowEditor.flowModel.userIdentityKey;
    if(this.flowEditor.flowModel.userIdentityKey == "7" && this.flowEditor.bpmSave.isEnable()){
        //管理员允许编辑表单
    }else{
        // 全部只读，包括按钮
        $("#formTab").find("select").not(".bpm_nosec_class").not(".ui-pg-selbox").attr("disabled", "disabled");
        $("#formTab").find(':checkbox').not(".bpm_nosec_class").not(".bpm_nosec_class :checkbox").not(".eform_subtable_bpm_auth :checkbox").not(".customform_subtable_bpm_auth :checkbox").attr("disabled", "disabled");
        $("#formTab").find(':radio').not(".bpm_nosec_class").attr("disabled", "disabled");
        $("#formTab").find(':text').not(".bpm_nosec_class").not(".view-box :text").not(".ui-pg-input").attr("disabled", "disabled");
        //ie8以下textarea disabled之后滚动条没法用,改为readonly
        $("#formTab").find("textarea").not(".bpm_nosec_class").attr("readonly", "readonly");
		//非电子表单子表表头的checkbox处理
		var customform_subtable_bpm_auth = $(".panel-body").eq(0).find(".customform_subtable_bpm_auth");
		if(customform_subtable_bpm_auth && customform_subtable_bpm_auth.length){
			customform_subtable_bpm_auth.each(function () {
				var customTableId = $("this").attr("id");
				var headCheckBok = $("#cb_"+customTableId);
				if(headCheckBok){
					headCheckBok.removeAttr("disabled");
				}
			});
		}
        //禁用图标事件
        $("#formTab").find(".input-group-addon").not(".bpm_nosec_class").css('cursor',"not-allowed");
        $("#formTab").find(".input-group-addon").not(".bpm_nosec_class").bind('click', function(){return false;});
        $("#formTab").find(".input-group-addon").not(".bpm_nosec_class").off('click');
        //子表按钮隐藏
        $("#formTab").find(".eform_subtable_bpm_button_auth").hide();
		//电子表单子表所有元素禁用
		$("#formTab").find(".eform_subtable_bpm_auth").each(function(index,item){
			var subTableName = $(item).attr("title");
			if(undefined!=subTableName && ''!=subTableName){
				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						$('#'+subTableName).jqGrid('endEditCell');
						$("#"+subTableName).setColProp(colModel[m].name,{editable:false});
					}
				}
                $("#"+subTableName).jqGrid('setGridParam',{'altRows':false}).trigger('reloadGrid');
                $("#"+subTableName).hideCol("cb");
			}
		});

		//非电子表单子表所有元素禁用
		$("#formTab").find(".customform_subtable_bpm_auth").each(function(index,item){
			var subTableName = $(item).attr("id");
			if(undefined!=subTableName && ''!=subTableName){
				//子表添加按钮id
				var subTableButtonAddId = subTableName+"_insert";
				if($("#"+subTableButtonAddId)){
					$("#"+subTableButtonAddId).hide();
				}
				//子表删除按钮id
				var subTableButtonDelId = subTableName+"_del";
				if($("#"+subTableButtonDelId)){
					$("#"+subTableButtonDelId).hide();
				}
				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						$('#'+subTableName).jqGrid('endEditCell');
						$("#"+subTableName).setColProp(colModel[m].name,{editable:false,classes:'datatable-readonly'});
					}
				}
			}
		});

        //自定义元素置为只读
        $(".bpm_self_class").each(function(i){
            var id = $(this).attr("id");
            _self.flowEditor.defaultForm.controlSelfElement(id, false);
        });

        // 全部显示，包括按钮
        $("#formTab").find("select").not(".bpm_nosec_class").removeAttr("readonly");
        $("#formTab").find(':checkbox').not(".bpm_nosec_class").not(".bpm_nosec_class :checkbox").removeAttr("readonly");
        $("#formTab").find(':radio').not(".bpm_nosec_class").removeAttr("readonly");
        $("#formTab").find(':checkbox').parent("label").not(".bpm_nosec_class").not(".bpm_nosec_class :checkbox").removeAttr("readonly");
        $("#formTab").find(':radio').parent("label").not(".bpm_nosec_class").removeAttr("readonly");
        $("#formTab").find(':text').not(".bpm_nosec_class").removeAttr("readonly");
        //ie8及以下需要用readonly disabled滚动条没法用
        //$("#formTab").find("textarea").not(".bpm_nosec_class").removeAttr("readonly");
        //显示图标
        $("#formTab").find(".input-group-addon").not(".bpm_nosec_class").removeAttr("readonly");

        //自定义元素置为显示
       /* $(".bpm_self_class").each(function(i){
            var id = $(this).attr("id");
            _self.flowEditor.defaultForm.controlSelfElementForAccess(id, true);
        });*/
        //附件置为只读
        this.flowEditor.defaultForm.setAttachMagic(false);
		/**
		 * 多附件区域设置为只读
		 */
		$("#formTab").find(".eform_mutiattach_auth").each(function(){
			_self.flowEditor.defaultForm.setAttachCanAddOrDel($(this).attr("id"), false, null);
			//设置附件密级是否可修改
			_self.flowEditor.defaultForm.setAttachSecretLevelModify($(this).attr("id"),false,null);
		});

        // 允许编辑
        avicAjax.ajax({
            type : "POST",
            data : {
                defineId : this.flowEditor.flowModel.defineId,
                activityname : this.flowEditor.flowModel.activityname
            },
            url : "platform/bpm/business/getFormSecuritys",
            dataType : "JSON",
            success : function(msg) {
                if (flowUtils.notNull(msg.error)) {
                    flowUtils.error(msg.error);
                } else {
                    /**
                     * 获取字段关联权限控制，字段权限控制以关联权限为准
                     */
         	    var fieldRelationAuths = _self.getInitFieldGroupAuths(msg);
                    if (_self.flowEditor.bpmSave.isEnable()) {
                        	//控制附件权限 修改为先控制附件权限
						_self.controlAttachmentAuths(msg.attachMagic,msg.attachmentAuths);
						//控制表单字段是否可编辑
						_self.controlFormOperability(msg.result);
						//关联字段控制是否可编辑
            			_self.controlFormOperability(fieldRelationAuths);
						//控制表单字段是否必填
						_self.controlFormRequired(msg.result,isEform);
           				 //关联字段控制是否必填
						_self.controlFormRequired(fieldRelationAuths,isEform);

            			//绑定字段联动事件
            			_self.bindEventByFieldGroupAuth(msg,isEform);
                    }
                    //控制表单字段显隐
                    _self.controlFormAccessibility(msg.result);
			        //关联字段控制字段显隐
                    _self.controlFormAccessibility(fieldRelationAuths);
                    //已办 已阅 读者 未知 状态的隐藏子表按钮 禁用子表字段
                    if(userIdentityKey =="2" || userIdentityKey =="4"
                        || userIdentityKey =="5" || userIdentityKey =="0"){
                        //电子表单子表按钮
                        $("#formTab").find(".eform_subtable_bpm_button_auth").hide();

                    }
                    $(window).resize();
                }
                _self.flowEditor.defaultForm.afterControlFormInput();
            }
        });
    }
};

/**
 * 控制表单字段是否可编辑
 * @param msg
 */
FlowForm.prototype.controlFormOperability = function(auths){
    var _self = this;
    var subtableMap = {};
    $.each(auths, function(i, n) {
		var operability = n.operability == "1";
		// 允许编辑
		if(operability){
			if(n.elementType == "bpm_self_class"
				|| n.elementType == "autocode-box"
				|| n.elementType == "waautocode-box"
				|| n.elementType == "bpmopinion-box"
				|| n.elementType == "waidea-box"
				|| n.elementType =="photo-box"){
				//自定义元素
                _self.flowEditor.defaultForm.controlSelfElement(n.tag, operability, n);
            }else if(n.elementType == "pt6:h5checkbox" || n.elementType == "pt6:h5radio" || n.elementType == "checkbox" || n.elementType == "radio"){
                var $tag = $('input[name="' + n.tag + '"]');
                $tag.removeAttr("disabled");
            }else if(n.elementType == "textarea"){
                var $tag = $('#' + n.tag);
                $tag.removeAttr("readonly");
            }else if(n.elementType == "eform_subtable_bpm_auth"){
                var tagArr = n.tag.split("__");
                var colName = tagArr[1];
                var subTableName = tagArr[0];
                var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
                var hasColNameName = false;
                var colNameName = colName+"Name";
                if(colModel!=null && colModel.length>0){
                    for(var m=0;m<colModel.length;m++){
                        if(colModel[m].name==colNameName){
                            hasColNameName = true;
                            break;
                        }
                    }
                }
				if(hasColNameName){
					$("#"+subTableName).setColProp(colName+"Name",{editable:true,classes:''});
					$("[aria-describedby='"+subTableName+"_"+colName+"Name']").removeClass("datatable-readonly");
				}else{
					$("#"+subTableName).setColProp(colName,{editable:true,classes:''});
					$("[aria-describedby='"+subTableName+"_"+colName+"']").removeClass("datatable-readonly");
				}
				subtableMap[subTableName] = true;

            }else if(n.elementType == "eform_subtable_bpm_button_auth"){
                //子表按钮不做处理
            }else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
                var tagArr = n.tag.split("__");
                var colName = tagArr[1];
                _self.flowEditor.defaultForm.controlCustomSubTableForOperability(colName, true, n);
            }else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				_self.flowEditor.defaultForm.setAttachCanAddOrDel(n.tag, operability, n);
	    }else{
                var $tag = $('#' + n.tag);
                $tag.removeAttr("disabled");
                //启用图标事件
                $tag.parent().find(".input-group-addon").css('cursor',"pointer");
                //杨勇删除
                //$tag.parent().find(".input-group-addon").off('click');
                if($tag.parent().find(".input-group-addon")){
					$tag.parent().find(".input-group-addon").unbind('click');
                    $tag.parent().find(".input-group-addon").click(function(){
                        $tag.trigger('focus');
                    });
                }
            }
        }else{
            if(n.elementType == "bpm_self_class"
				|| n.elementType == "autocode-box"
				|| n.elementType == "waautocode-box"
				|| n.elementType == "bpmopinion-box"
				|| n.elementType == "waidea-box"
				|| n.elementType =="photo-box"){
                //自定义元素
                _self.flowEditor.defaultForm.controlSelfElement(n.tag, operability, n);
            }else if(n.elementType == "pt6:h5checkbox" || n.elementType == "pt6:h5radio" || n.elementType == "checkbox" || n.elementType == "radio"){
                var $tag = $('input[name="' + n.tag + '"]');
                $tag.attr("disabled","disabled");
            }else if(n.elementType == "textarea"){
                var $tag = $('#' + n.tag);
                $tag.attr("readonly","readonly");
            }else if(n.elementType == "eform_subtable_bpm_auth"){
                var tagArr = n.tag.split("__");
                var colName = tagArr[1];
                var subTableName = tagArr[0];

                var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
                var hasColNameName = false;
                var colNameName = colName+"Name";
                if(colModel!=null && colModel.length>0){
                    for(var m=0;m<colModel.length;m++){
                        if(colModel[m].name==colNameName){
                            hasColNameName = true;
                        }
                    }
                }
				if(hasColNameName){
					$('#'+subTableName).jqGrid('endEditCell');
					$("#"+subTableName).setColProp(colName+"Name",{editable:false,classes:'datatable-readonly'});
					$("[aria-describedby='"+subTableName+"_"+colName+"Name']").addClass("datatable-readonly");
				}else{
					$('#'+subTableName).jqGrid('endEditCell');
					$("#"+subTableName).setColProp(colName,{editable:false,classes:'datatable-readonly'});
					$("[aria-describedby='"+subTableName+"_"+colName+"']").addClass("datatable-readonly");
				}



            }else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
                var tagArr = n.tag.split("__");
                var colName = tagArr[1];
                _self.flowEditor.defaultForm.controlCustomSubTableForOperability(colName, false, n);
			}else if(n.elementType == "eform_subtable_bpm_button_auth"){
				//子表按钮不做处理
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				_self.defaultForm.setAttachCanAddOrDel(n.tag, operability, n);
			}else{
                var $tag = $('#' + n.tag);
                $tag.attr("disabled","disabled");
                //启用图标事件
                $tag.parent().find(".input-group-addon").css('cursor',"");
                //杨勇删除
                /*$tag.parent().find(".input-group-addon").unbind('click');
                //$tag.parent().find(".input-group-addon").off('click');

                if($tag.parent().find(".input-group-addon")){
                    $tag.parent().find(".input-group-addon").click(function(){
                        $tag.trigger('focus');
                    });
                }*/
            }
        }
    });
    /**
     * 判断如果子表如果有可编辑的列则显示左侧复选框
     */
    for(var key in subtableMap){
		if (subtableMap[key]){
			$("#"+key).jqGrid('setGridParam',{'altRows':true}).trigger('reloadGrid');
			$("#"+key).showCol("cb");
		}
	}
};

/**
 * 控制表单附件权限
 * @param msg
 */
FlowForm.prototype.controlAttachmentAuths = function(attachMagic,attachmentAuths){
	var _self = this;
	var attachMagic = attachMagic || attachMagic == "true";
	if(attachMagic){
		_self.flowEditor.defaultForm.setAttachMagic(attachMagic);
	}

	//附件权限
	$.each(attachmentAuths, function(i, n) {
		var operability = n.operability == "1";
		var required = n.required == "1";
		var modifySecretLevel = n.modifySecretLevel == "1";

		_self.flowEditor.defaultForm.setAttachCanAddOrDel(n.tag, operability, n);
		if(operability && required){
			required = true;
		}else{
			required = false;
		}
		_self.flowEditor.defaultForm.setAttachRequired(n.tag,required,n);
		//设置附件密级是否可修改，改为调用表单接口
		_self.flowEditor.defaultForm.setAttachSecretLevelModify(n.tag,modifySecretLevel,n);
	});
};

/**
 * 控制表单字段必填
 * @param msg
 */
FlowForm.prototype.controlFormRequired = function(auths,isEform){
	var _self = this;
	/**
	 * 必填处理
	 */
	//删除错误提示信息
	$('.errDom').remove();
	$.each(auths, function(i, n) {
		//
		if(n.required == "0" ||
				(n.required == "1" && (n.accessibility == "0" || n.operability == "0"))){

			if(n.elementType == "bpm_self_class"
				|| n.elementType == "autocode-box"
				|| n.elementType == "waautocode-box"
				|| n.elementType == "bpmopinion-box"
				|| n.elementType == "waidea-box"
				|| n.elementType =="photo-box"){
				$("#"+n.tag).removeAttr("required");
				//自定义元素
				_self.flowEditor.defaultForm.controlSelfElementForRequired(n.tag, false, n);
                var $tagLabel = $('label[for="' + n.tag + '"]');
                var $i = $tagLabel.children("i[class=required]");
                $i.remove();
				var validator = $("form").validate();
				validator.removeRequiredError();
                /*if($i && $i.length>0){
                    for(var a=0;a<$i.length;a++){
                        $i[a].remove();
                    }
                }*/
			}else if(n.elementType == "pt6:h5checkbox" || n.elementType == "pt6:h5radio"
				|| n.elementType == "checkbox" || n.elementType == "radio"){
				var $tag = $('input[name="' + n.tag + '"]');
				if(isEform){
					$tag.removeAttr("required","required");
				}else{
					$tag.rules("remove");
				}

				var $tagLabel = $('label[for="' + n.tag + '"]');
				var $i = $tagLabel.children("i[class=required]");
                $i.remove();
				var validator = $("form").validate();
				validator.removeRequiredError();
				/*if($i && $i.length>0){
					for(var a=0;a<$i.length;a++){
						$i[a].remove();
					}
				}*/
			}else if(n.elementType == "textarea"){
				var $tag = $('#' + n.tag);
				if(isEform){
					$tag.removeAttr("required","required");
				}else{
					$tag.rules("remove");
				}
				var $tagLabel = $('label[for="' + n.tag + '"]');
				var $i = $tagLabel.children("i[class=required]");
                $i.remove();
				var validator = $("form").validate();
				//validator.prepareForm();
				validator.removeRequiredError();
				//validator.resetForm();
				/*if($i && $i.length>0){
					for(var a=0;a<$i.length;a++){
						$i[a].remove();
					}
				}*/
			}else if(n.elementType == "eform_subtable_bpm_auth"){
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				var subTableName = tagArr[0];
				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				var hasColNameName = false;
				var colNameName = colName+"Name";
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						if(colModel[m].name==colNameName){
							hasColNameName = true;
							break;
						}

					}
				}
				if(hasColNameName){
					$('#'+subTableName).validateJqGrid("deleteValidate",colName+"Name","required");
				}
				$('#'+subTableName).validateJqGrid("deleteValidate",colName,"required");
			}else if(n.elementType == "eform_subtable_bpm_button_auth"){
				//子表按钮不做处理
			}else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				_self.flowEditor.defaultForm.controlCustomSubTableForRequired(colName, false, n);
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				$("#"+n.tag).removeAttr("required");
				_self.flowEditor.defaultForm.setAttachRequired(n.tag,false,n);
			}else{
				var $tag = $('#' + n.tag);
				if(isEform){
					$tag.removeAttr("required","required");
				}else{
					$tag.rules("remove");
				}
				var $tagLabel = $('label[for="' + n.tag + '"]');
				var $i = $tagLabel.children("i[class=required]");
                $i.remove();
				var validator = $("form").validate();
				validator.removeRequiredError();
				/*if($i && $i.length>0){
					for(var a=0;a<$i.length;a++){
						$i[a].remove();
					}
				}*/
			}

		}else if(n.required == "1" && n.accessibility == "1" && n.operability == "1"){
			if(n.elementType == "bpm_self_class"
				|| n.elementType == "autocode-box"
				|| n.elementType == "waautocode-box"
				|| n.elementType == "bpmopinion-box"
				|| n.elementType == "waidea-box"
				|| n.elementType =="photo-box"){
				$("#"+n.tag).attr("required","required");
				//自定义元素
				_self.flowEditor.defaultForm.controlSelfElementForRequired(n.tag,true, n);
                var $tagLabel = $('label[for="' + n.tag + '"]');
                var $i = $tagLabel.children("i[class=required]");
                if(!$i || $i.length<1){
                    var requiredElement = $("<i class='required'>*</i>");
                    $tagLabel.prepend(requiredElement);
                }
			}else if(n.elementType == "pt6:h5checkbox" || n.elementType == "pt6:h5radio"
				|| n.elementType == "checkbox" || n.elementType == "radio"
			){
				var $tag = $('input[name="' + n.tag + '"]');
				if(isEform){
					$tag.attr("required","required");
				}else{
					$tag.rules("add",{required:true});
				}

				var $tagLabel = $('label[for="' + n.tag + '"]');
				var $i = $tagLabel.children("i[class=required]");
				if(!$i || $i.length<1){
					var requiredElement = $("<i class='required'>*</i>");
					$tagLabel.prepend(requiredElement);
				}
			}else if(n.elementType == "textarea"){
				var $tag = $('#' + n.tag);
				if(isEform){
					$tag.attr("required","required");
				}else{
					$tag.rules("add",{required:true});
				}
				var $tagLabel = $('label[for="' + n.tag + '"]');
				var $i = $tagLabel.children("i[class=required]");
				if(!$i || $i.length<1){
					var requiredElement = $("<i class='required'>*</i>");
					$tagLabel.prepend(requiredElement);
				}
			}else if(n.elementType == "eform_subtable_bpm_auth"){
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				var subTableName = tagArr[0];

				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				var hasColNameName = false;
				var colNameName = colName+"Name";
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						if(colModel[m].name==colNameName){
							hasColNameName = true;
							break;
						}
					}
				}
				if(hasColNameName){
					$('#'+subTableName).validateJqGrid("addValidate",colName+"Name","required");
				}else{
					$('#'+subTableName).validateJqGrid("addValidate",colName,"required");
				}
			}else if(n.elementType == "eform_subtable_bpm_button_auth"){
				//子表按钮不做处理
			}else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				_self.flowEditor.defaultForm.controlCustomSubTableForRequired(colName, true, n);
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				$("#"+n.tag).attr("required","required");
				_self.flowEditor.defaultForm.setAttachRequired(n.tag,true,n);
			}else{
				var $tag = $('#' + n.tag);
				if(isEform){
					$tag.attr("required","required");
				}else{
					$tag.rules("add",{required:true});
				}
				var $tagLabel = $('label[for="' + n.tag + '"]');
				var $i = $tagLabel.children("i[class=required]");
				if(!$i || $i.length<1){
					var requiredElement = $("<i class='required'>*</i>");
					$tagLabel.prepend(requiredElement);
				}
			}

		}
	});
};

/**
 * 控制表单字段显隐
 * @param msg
 */
FlowForm.prototype.controlFormAccessibility = function(auths){
    var _self = this;
	$.each(auths, function(i, n) {
		var accessibility = n.accessibility == "1";
		//隐藏行
		var hideRow = false;
		if(flowUtils.notNull(n.hideRow) && n.hideRow=="1"){
            hideRow = true;
        }
		// 进行隐藏
		if(!accessibility){
			if(n.elementType == "bpm_self_class"
				|| n.elementType == "autocode-box"
				|| n.elementType == "waautocode-box"
				|| n.elementType == "bpmopinion-box"
				|| n.elementType == "waidea-box"
				|| n.elementType =="photo-box"){
				//自定义元素
				_self.flowEditor.defaultForm.controlSelfElementForAccess(n.tag, accessibility, n);
				var $tag = $("#"+n.tag);
                var $tagLabel = $('label[for="' + n.tag + '"]');
                if($tagLabel && $tagLabel.length){
					$tagLabel.hide();
				}
                if(hideRow){
                    _self.hideRow($tag);
                }
			}else if(n.elementType == "pt6:h5checkbox" || n.elementType == "pt6:h5radio" || n.elementType == "checkbox" || n.elementType == "radio"){
				var $tag = $('input[name="' + n.tag + '"]');
				$tag.hide();
                $tag.parent("label").hide();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.hide();
				}
                if(hideRow){
                    _self.hideRow($tag);
                }
			}else if(n.elementType == "textarea"){
				var $tag = $('#' + n.tag);
				$tag.hide();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.hide();
				}
                if(hideRow){
                    _self.hideRow($tag);
                }
			}else if(n.elementType == "eform_subtable_bpm_auth"){
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				var subTableName = tagArr[0];

				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				var hasColNameName = false;
				var colNameName = colName+"Name";
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						if(colModel[m].name==colNameName){
							hasColNameName = true;
							break;
						}
					}
				}
				if(hasColNameName){
					jQuery("#" + subTableName).setGridParam().hideCol(colName+"Name");
				}else{
					jQuery("#" + subTableName).setGridParam().hideCol(colName);
				}
				$(window).trigger("resize");

			}else if(n.elementType == "eform_subtable_bpm_button_auth"){
				_self.flowEditor.defaultForm.controlSubTableButtonForAccess(n.tag, accessibility, n);
			}else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				_self.flowEditor.defaultForm.controlCustomSubTableForAccess(colName, accessibility, n);

			}else if(n.elementType =="datatable"){//子表div
				var $tag = $('#' + n.tag + "_control");
				$tag.hide();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.hide();
				}
				if(hideRow){
					_self.hideRowForSubTable($tag);
				}
			}else if(n.elementType =="photo-box"){//上传图片
				var $tag = $('#' + n.tag+"photo");
				$tag.hide();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.hide();
				}
				if(hideRow){
					_self.hideRow($tag);
				}
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				var $tag = $('#' + n.tag);
				$tag.attr("style","display:none;");
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.hide();
				}
				if(hideRow){
					_self.hideRow($tag);
				}
			}else{
				var $tag = $('#' + n.tag);
				$tag.hide();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				$tagLabel.hide();
				//隐藏图标
				$tag.parent().find(".input-group-addon").hide();
                if(hideRow){
                    _self.hideRow($tag);
                }
			}
		}else{
            if(n.elementType == "bpm_self_class"
				|| n.elementType == "autocode-box"
				|| n.elementType == "waautocode-box"
				|| n.elementType == "bpmopinion-box"
				|| n.elementType == "waidea-box"
				|| n.elementType =="photo-box"){
                //自定义元素
                _self.flowEditor.defaultForm.controlSelfElementForAccess(n.tag, accessibility, n);
                var $tag = $("#"+n.tag);
                var $tagLabel = $('label[for="' + n.tag + '"]');
                if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}
				_self.showRow($tag);
            }else if(n.elementType == "pt6:h5checkbox" || n.elementType == "pt6:h5radio" || n.elementType == "checkbox" || n.elementType == "radio"){
                var $tag = $('input[name="' + n.tag + '"]');
                $tag.show();
                $tag.parent("label").show();
                var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}
				_self.showRow($tag);
            }else if(n.elementType == "textarea"){
                var $tag = $('#' + n.tag);
                $tag.show();
                var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}
				_self.showRow($tag);
            }else if(n.elementType == "eform_subtable_bpm_auth"){
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				var subTableName = tagArr[0];
				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				var hasColNameName = false;
				var colNameName = colName+"Name";
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						if(colModel[m].name==colNameName){
							hasColNameName = true;
							break;
						}
					}
				}
				if(hasColNameName){
					jQuery("#" + subTableName).setGridParam().showCol(colName+"Name");
				}else{
					jQuery("#" + subTableName).setGridParam().showCol(colName);
				}
				$(window).trigger("resize");

			}else if(n.elementType == "eform_subtable_bpm_button_auth"){
				_self.flowEditor.defaultForm.controlSubTableButtonForAccess(n.tag, accessibility, n);
			}else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				_self.flowEditor.defaultForm.controlCustomSubTableForAccess(colName, accessibility, n);

			}else if(n.elementType =="datatable"){//子表div
				var $tag = $('#' + n.tag + "_control");
				_self.showRowForSubTable($tag);
				$(window).resize();
				$tag.show();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}

			}else if(n.elementType =="photo-box"){//上传图片
				var $tag = $('#' + n.tag+"photo");
				$tag.show();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}
				_self.showRow($tag);
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				var $tag = $('#' + n.tag);
				$tag.show();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}
				_self.showRow($tag);
			}else{
                var $tag = $('#' + n.tag);
                $tag.show();
                var $tagLabel = $('label[for="' + n.tag + '"]');
                if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}
                //隐藏图标
                $tag.parent().find(".input-group-addon").show();
				_self.showRow($tag);
            }
		}
	});
};

/**
 * 隐藏行
 * @param tagObj
 */
FlowForm.prototype.hideRow = function(tagObj){
    if(flowUtils.notNull(tagObj)){
        //var _row = tagObj.parentsUntil("tr").parent();
		var _row = tagObj.parents("tr");
        if(_row){
            //_row.attr("style","display:none;");
			_row.hide();
        }
    }
};

/**
 * 隐藏行
 * @param tagObj
 */
FlowForm.prototype.hideRowForSubTable = function(tagObj){
	if(flowUtils.notNull(tagObj)){
		var _row = tagObj.parents("table").parents("tr");
		if(_row){
			//_row.attr("style","display:none;");
			_row.hide();
		}
	}
};

/**
 * 显示行
 * @param tagObj
 */
FlowForm.prototype.showRow = function(tagObj){
    if(flowUtils.notNull(tagObj)){
		//var _row = tagObj.parentsUntil("tr").parent();
		var _row = tagObj.parents("tr");
        if(_row){
            _row.show();
        }
    }
};
/**
 * 显示行
 * @param tagObj
 */
FlowForm.prototype.showRowForSubTable = function(tagObj){
	if(flowUtils.notNull(tagObj)){
		var _row = tagObj.parents("table").parents("tr");
		if(_row){
			_row.show();
		}
	}
};

/**
 * 根据字段组关联权限给被控制字段绑定事件
 * @param msg
 * @param isEform
 */
FlowForm.prototype.bindEventByFieldGroupAuth = function(msg,isEform){
	var _self = this;
	var fieldGroupList = msg.fieldRelationAuthList;
	if(flowUtils.notNull(fieldGroupList)){
		for(var i=0;i<fieldGroupList.length;i++){
			var fieldGroup = fieldGroupList[i];
			_self.bindEventByFieldRelationAuth(fieldGroup,fieldGroupList,msg.result,msg.attachmentAuths,isEform);
		}
	}
}

/**
 * 根据字段关联权限给控制字段绑定事件
 * @param msg
 */
FlowForm.prototype.bindEventByFieldRelationAuth = function(fieldGroup,fieldGroupList,defaultAuths,defaultAttachmentAuths,isEform){
    var _self = this;
    if(flowUtils.notNull(fieldGroup)){
        $.each(fieldGroup.conditonValues, function(i, n) {
            var controlDomId = flowUtils.notNull(n.controlDomId)?n.controlDomId:n.controlTag;
            var controlElementType = n.controlElementType;
            var controlDomType = n.controlDomType;
            var data = {"fieldGroup":fieldGroup,"fieldGroupList":fieldGroupList,"defaultAuths":defaultAuths,"defaultAttachmentAuths":defaultAttachmentAuths};
            if (controlDomType == 'radio-box' || controlDomType == 'radio'
                || controlDomType == 'select-box' || controlDomType == 'select'
                || controlDomType == 'check-box' || controlDomType == 'check'
				|| controlDomType == 'secret-box' || controlDomType == 'secret'){
                _self.bindFieldEvent(controlDomId,controlDomType,"change",data,isEform);
            }else{
                _self.bindFieldEvent(controlDomId,controlDomType,"blur",data,isEform);
            }
        });
    }
};

/**
 * 给指定字段绑定事件
 * @param eventType
 * @param data
 */
FlowForm.prototype.bindFieldEvent = function(bindDomId,controlDomType,eventType,data,isEform){
    var _self = this;
    //选人、选部门等
    if (controlDomType == 'user-box' || controlDomType == 'user'
        || controlDomType == 'dept-box' || controlDomType == 'dept'
        || controlDomType == 'position-box' || controlDomType == 'position'
        || controlDomType == 'role-box' || controlDomType == 'role'
        || controlDomType == 'group-box' || controlDomType == 'group'
		|| controlDomType == 'org-box' || controlDomType == 'org'
		|| controlDomType == 'waorg-box'
		|| controlDomType =='custom-select-box'){
        bindDomId = bindDomId + "Name";
    }
    var controlObj = $("#"+bindDomId);
    if(controlDomType == 'radio-box' || controlDomType == 'radio'
		|| controlDomType == 'check-box' || controlDomType == 'check'){
		controlObj = $("input[name='"+bindDomId+"']");
	}
	controlObj.on(eventType,null,data,
        function(event){
			var _fieldGroup = event.data.fieldGroup;
			var _fieldGroupList = event.data.fieldGroupList;
			var _beControledField = _fieldGroup.beControledFields[0];
			_beControledField.domId = flowUtils.notNull(_beControledField.domId)?_beControledField.domId:_beControledField.tag;
            var _defaultAuths = event.data.defaultAuths;
            var _defaultAttachmentAuths = event.data.defaultAttachmentAuths;
            //该组条件计算结果
            var allExprTrue = _self.calculateFieldGroup(_fieldGroup,_fieldGroupList);
            //当条件不满足时是否执行默认显隐配置
            var isExecDefaultConfig = true;
            //判断被控制字段相同的其他组是否全部不满足条件，当所有都不满足条件时才按默认显隐控制处理
            if(!allExprTrue && _fieldGroup.repeatCount>0){
            	for(var k=0;k<_fieldGroupList.length;k++){
            		var _thisfieldGroup = _fieldGroupList[k];
            		//排除当前组
            		if(_thisfieldGroup.order!=_fieldGroup.order){
						var result = _self.calculateFieldGroup(_thisfieldGroup);
						if(result){
							isExecDefaultConfig = false;
						}
					}
				}

			}
            var _tag = _beControledField.tag;
			//选人、选部门等
			if (_beControledField.domType == 'user-box' || _beControledField.domType == 'user'
				|| _beControledField.domType == 'dept-box' || _beControledField.domType == 'dept'
				|| _beControledField.domType == 'position-box' || _beControledField.domType == 'position'
				|| _beControledField.domType == 'role-box' || _beControledField.domType == 'role'
				|| _beControledField.domType == 'group-box' || _beControledField.domType == 'group'
				|| _beControledField.domType == 'org-box' || _beControledField.domType == 'org'
				|| _beControledField.domType == 'waorg-box'
				|| _beControledField.domType =='custom-select-box'){
				_tag = _tag + "Name";
			}
            //满足控制条件
            if(allExprTrue){
                //组装被控制字段数据
                var beControlFieldAuths = [];
                var beControlFieldAuth = {};
                beControlFieldAuth.domId = _beControledField.domId;
                beControlFieldAuth.tag = _tag;
                beControlFieldAuth.tagName = _beControledField.tagName;
				beControlFieldAuth.elementType = _beControledField.elementType;
                beControlFieldAuth.accessibility = _beControledField.accessibility;
                beControlFieldAuth.operability = _beControledField.operability;
                beControlFieldAuth.required = _beControledField.required;
                beControlFieldAuth.hideRow = _beControledField.hideRow;
				/**
				 * 隐藏行时判断在默认显隐配置中的
				 * 必填字段（字段关联中没有该字段或者字段关联中有该字段但条件不成立），
				 * 是否是同一行
				 * 如果在同一行，则不设置隐藏行
				 */
				_self.dealSameRowFields(beControlFieldAuth,_defaultAuths,_fieldGroupList);//字段
				_self.dealSameRowFields(beControlFieldAuth,_defaultAttachmentAuths,_fieldGroupList);//附件
				_self.dealSameRowFieldsForRelation(beControlFieldAuth,_fieldGroupList);//字段关联配置
                beControlFieldAuths.push(beControlFieldAuth);
                //显隐
                _self.controlFormAccessibility(beControlFieldAuths);
                //可编辑
                _self.controlFormOperability(beControlFieldAuths);
                //必填
                _self.controlFormRequired(beControlFieldAuths,isEform);
            }else if(isExecDefaultConfig){//条件不成立,并且判断可以执行默认配置
				if(_defaultAuths && _defaultAuths.length){
					var tagObj;
					var tagArr = [];
					for(var m =0;m<_defaultAuths.length;m++){
						if(_tag==_defaultAuths[m].tag){
							tagObj = _defaultAuths[m];
							break;
						}
					}
					if(tagObj){
						tagArr.push(tagObj);
						//显隐
						_self.controlFormAccessibility(tagArr);
						//可编辑
						_self.controlFormOperability(tagArr);
						//必填
						_self.controlFormRequired(tagArr,isEform);
						return;
					}
				}
				/**
				 * 多附件的处理
				 */
				if(_defaultAttachmentAuths && _defaultAttachmentAuths.length){
					var tagObj;
					var tagArr = [];
					for(var m =0;m<_defaultAttachmentAuths.length;m++){
						if(_tag==_defaultAttachmentAuths[m].tag){
							tagObj = _defaultAttachmentAuths[m];
							tagObj.accessibility = "1";
							break;
						}
					}

					if(tagObj){
						tagArr.push(tagObj);
						//显隐
						_self.controlFormAccessibility(tagArr);
						//可编辑
						_self.controlFormOperability(tagArr);
						//必填
						_self.controlFormRequired(tagArr,isEform);
					}
				}

				/**
				 * 子表、流程意见默认值
				 */
				if(_beControledField.elementType == "datatable" || _beControledField.elementType == "bpmopinion-box"){
					var otherTagObj = {};
					var tagArr = [];
					otherTagObj.tag = _tag;
					otherTagObj.elementType = _beControledField.elementType;
					otherTagObj.accessibility = "1";
					otherTagObj.operability = "1";
					otherTagObj.required = "0";
					otherTagObj.hideRow = "0";
					tagArr.push(otherTagObj);
					//显隐
					_self.controlFormAccessibility(tagArr);
				}
			}
        });
};

/**
 * 页面初始化计算所有字段组关联权限控制
 */
FlowForm.prototype.getInitFieldGroupAuths = function(msg){
	var _self = this;
	var _fieldGroups = msg.fieldRelationAuthList;
	var _defaultAuths = msg.result;
	var _attachmentAuths = msg.attachmentAuths;
	var initFieldAuths = [];
	if(flowUtils.notNull(_fieldGroups)){
		for(var i=0;i<_fieldGroups.length;i++){
			var fieldGroup = _fieldGroups[i];
			var allResultTrue = _self.calculateFieldGroup(fieldGroup);
			if(allResultTrue){
				var tagObj = {};
				tagObj.domId = fieldGroup.beControledFields[0].domId;
				tagObj.tag = fieldGroup.beControledFields[0].tag;
				tagObj.elementType = fieldGroup.beControledFields[0].elementType;
				tagObj.tagName = fieldGroup.beControledFields[0].tagName;
				tagObj.accessibility = fieldGroup.beControledFields[0].accessibility;
				tagObj.operability = fieldGroup.beControledFields[0].operability;
				tagObj.required = fieldGroup.beControledFields[0].required;
				tagObj.hideRow = fieldGroup.beControledFields[0].hideRow;
				//选人、选部门等
				if (fieldGroup.beControledFields[0].domType == 'user-box' || fieldGroup.beControledFields[0].domType == 'user'
					|| fieldGroup.beControledFields[0].domType == 'dept-box' || fieldGroup.beControledFields[0].domType == 'dept'
					|| fieldGroup.beControledFields[0].domType == 'position-box' || fieldGroup.beControledFields[0].domType == 'position'
					|| fieldGroup.beControledFields[0].domType == 'role-box' || fieldGroup.beControledFields[0].domType == 'role'
					|| fieldGroup.beControledFields[0].domType == 'group-box' || fieldGroup.beControledFields[0].domType == 'group'
					|| fieldGroup.beControledFields[0].domType == 'org-box' || fieldGroup.beControledFields[0].domType == 'org'
					|| fieldGroup.beControledFields[0].domType == 'waorg-box'
					|| fieldGroup.beControledFields[0].domType =='custom-select-box'){
					tagObj.tag = tagObj.tag + "Name";
				}
				/**
				 * 隐藏行时判断在默认显隐配置中的
				 * 必填字段（字段关联中没有该字段或者字段关联中有该字段但条件不成立），
				 * 是否是同一行
				 * 如果在同一行，则不设置隐藏行
				 */
				_self.dealSameRowFields(tagObj,_defaultAuths,_fieldGroups);//字段
				_self.dealSameRowFields(tagObj,_attachmentAuths,_fieldGroups);//附件
				initFieldAuths.push(tagObj);
			}

		}
	}
	return initFieldAuths;
};

/**
 * 同一行字段处理
 * 隐藏行时判断在默认显隐配置中的
 * 必填字段（字段关联中没有该字段或者字段关联中有该字段但条件不成立），
 * 是否是同一行
 * 如果在同一行，则不设置隐藏行
 */
FlowForm.prototype.dealSameRowFields = function(_tagObj,_defaultAuths,_fieldRelationGroups){
	var _self = this;
	if(_tagObj.hideRow == "1"){
		for(var i=0;i<_defaultAuths.length;i++){
			if(_defaultAuths[i].tag!=_tagObj.tag
				&&_defaultAuths[i].required=='1'){
				//是否是同一行
				var rowObj = $("#"+_tagObj.tag).parents("tr").find("#"+_defaultAuths[i].tag);
				if(rowObj && rowObj.attr("id") == _defaultAuths[i].tag){
					var isRelationTrue = false;
					for(var j=0;j<_fieldRelationGroups.length;j++){
						if(_fieldRelationGroups[j].beControledFields[0].tag
							== _defaultAuths[i].tag){
							if(_self.calculateFieldGroup(_fieldRelationGroups[j])){
								isRelationTrue = true;
								break;
							}

						}
					}
					if(!isRelationTrue){
						_tagObj.hideRow = "0";
					}
				}
			}
		}

	}
};

/**
 * 同一行字段处理
 * 隐藏行时判断在字段关联显隐配置中的
 * 必填字段，
 * 是否是同一行
 * 如果在同一行，则不设置隐藏行
 */
FlowForm.prototype.dealSameRowFieldsForRelation = function(_tagObj,_fieldRelationGroups){
	var _self = this;
	if(_tagObj.hideRow == "1"){
		for(var i=0;i<_fieldRelationGroups.length;i++){
			var beControledField = _fieldRelationGroups[i].beControledFields[0];
			if(beControledField.tag!=_tagObj.tag
				&&beControledField.required=='1'){
				//是否是同一行
				var rowObj;
				//当前控件为子表
				if(_tagObj.elementType == 'datatable'){
					rowObj = $("#"+_tagObj.tag).parents("table").parents("tr").find("#"+beControledField.tag);
				}else{
					rowObj = $("#"+_tagObj.tag).parents("tr").find("#"+beControledField.tag);
				}
				if(rowObj && rowObj.attr("id") == beControledField.tag){
					if(_self.calculateFieldGroup(_fieldRelationGroups[i])){
						_tagObj.hideRow = "0";
						break;
					}
				}
			}
		}

	}
};

/**
 * 计算字段组中所有条件是否都满足
 * @param fieldGroup
 */
FlowForm.prototype.calculateFieldGroup = function(fieldGroup){
	var _self = this;
	var _fieldAuths = fieldGroup.conditonValues;
	var allExprTrue = true;
	if(!_fieldAuths || _fieldAuths.length<1){
		allExprTrue = false;
	}else{
		for(var m = 0;m<_fieldAuths.length;m++){
			var _controlDomId = flowUtils.notNull(_fieldAuths[m].controlDomId)?_fieldAuths[m].controlDomId:_fieldAuths[m].controlTag;
			var _controlValue = $("#"+_controlDomId).val();
			var _controlDomType = _fieldAuths[m].controlDomType;
			//自动编码控件和网安 编号控件
			if(_controlDomType == 'waautocode-box' || _controlDomType =='autocode-box'){
				_controlValue = $("#"+_controlDomId).attr("initvalue");
			}
			if(_controlDomType == 'radio-box' || _controlDomType == 'radio'){
				_controlValue = $("input[name='"+_controlDomId+"']:checked").val();
			}
			if(_controlDomType == 'check-box' || _controlDomType == 'check'){
				_controlValue = "";
				var checkboxs = $("input[type=checkbox][name="+_controlDomId+"]:checked");

				if(checkboxs && checkboxs.length){
					var i = 0;
					checkboxs.each(function(){
						if(i==(checkboxs.length-1)){
							_controlValue += $(this).val();
						}else{
							_controlValue += $(this).val()+"@@@";
						}
						i++;
					});
				}
			}
			var _oper = _fieldAuths[m].oper;
			var _compareValue = _fieldAuths[m].compareValue;
			var _exprValue = flowUtils.calculateExpr(_controlDomType,_controlValue,_oper,_compareValue);
			if(!_exprValue){
				allExprTrue = false;
				break;
			}
		}
	}
	return allExprTrue;
};
;
///<jscompress sourcefile="FlowPic.js" />
var mxBasePath = "avicit/platform6/bpmreform/bpmdesigner/editors/mxgraph/src";
flowUtils.include("avicit/platform6/bpmreform/bpmdesigner/editors/mxgraph/mxClient.js");
flowUtils.include("avicit/platform6/bpmreform/bpmdesigner/editors/js/CountUtils.js");
flowUtils.include("avicit/platform6/bpmreform/bpmdesigner/editors/js/DesignerEditor.js");
flowUtils.include("avicit/platform6/bpmreform/bpmdesigner/picture/MyDesignerEditor.js");
var designerEditor = null;
var _iconType;
function initFlowPic(entryId, deploymentId, callback) {
	designerEditor = new MyDesignerEditor();
	//重写graph提示框
	mxUtils.alert = function(message) {
		flowUtils.warning(message);
	};
	//全局参数设置
	mxGraph.prototype.htmlLabels = true;
	/*mxGraph.prototype.isWrapping = function(cell) {
		return true;
	};*/
    mxGraph.prototype.collapseExpandResource = '';
	mxConstants.DEFAULT_HOTSPOT = 1;
	mxGraphHandler.prototype.guidesEnabled = true;
	mxGuide.prototype.isEnabledForEvent = function(evt) {
		return !mxEvent.isAltDown(evt);
	};
	mxEdgeHandler.prototype.snapToTerminals = true;
	//画布工具栏初始化及设置
	avicAjax.ajax({
		type : "POST",
		data : {
			entryId : entryId,
			deploymentId : deploymentId
		},
		url : "platform/bpm/business/getIconType",
		dataType : "json",
		success : function(result) {
			if (flowUtils.notNull(result.error)) {
				flowUtils.error(result.error);
			} else {
				mxObjectCodec.allowEval = true;
				var tempUrl = "";
				_iconType = result.iconType;
				if(result.iconType == "1"){
					tempUrl = "avicit/platform6/bpmreform/bpmdesigner/picture/config/new/workfloweditor.xml";
				}else{
					tempUrl = "avicit/platform6/bpmreform/bpmdesigner/picture/config/workfloweditor.xml";
					$(".uFlowKeyCss").hide();
					$(".uFlowKeyCss").next().hide();
				}
				var node = mxUtils.load(tempUrl).getDocumentElement();
				var editor = new mxEditor(node);
				mxObjectCodec.allowEval = false;
//				editor.graph.allowAutoPanning = true;
//				editor.graph.timerAutoScroll = true;
				//初始化数据
				designerEditor.setEditor(editor);
				editor.graph.addListener(mxEvent.CLICK, function(sender, evt) {
					var cell = evt.getProperty('cell');
					if (flowUtils.notNull(cell)) {
						var id = cell.id;
						var pid = cell.pid;
						if (flowUtils.notNull(pid)) {
							id = pid;
						}
						var node = designerEditor.myCellMap.get(id);
						if (flowUtils.notNull(node)) {
							if (typeof (node.actNodeClick) == "function") {
								node.actNodeClick();
							}
						}
					}
				});
				callback(designerEditor);
			}
		}
	});
	if(flowUtils.notNull(entryId)){
		$.ajax({
			type : "POST",
			data : {
				entryId : entryId
			},
			url : "platform/bpm/business/getParentprocess",
			dataType : "text",
			success : function(result) {
				if(flowUtils.notNull(result)){
					$("#bpmParentFlowPic").show();
					$("#bpmParentFlowPic").on("click", function(){
						var dialog = layer.open({
							type : 2,
							title: "父流程",
							area : [ "800px", "450px" ],
							content : "avicit/platform6/bpmreform/bpmdesigner/picture/picAndTracks.jsp?entryId=" + result
						});
						layer.full(dialog);
					});
				}
			}
		});
		if(typeof(_showBpmOpenFormBut) != "undefined"){
			$("#bpmOpenForm").show();
			$("#bpmOpenForm").on("click", function(){
				flowUtils.detail(entryId, "2");
			});
		}
	}
}
;
///<jscompress sourcefile="FlowEditor.src.js" />
/**
 * 流程操作
 */
function FlowEditor(defaultForm) {
    this.simulation = _bpm_simulation;
    this.flowModel = new FlowModel(_bpm_defineId, _bpm_deploymentId, _bpm_entryId, _bpm_executionId, _bpm_taskId);
    this.defaultForm = defaultForm;
    this.defaultForm.flowEditor = this;
    this.flowForm = new FlowForm(this);
    //流程意见扩展，使用名称FlowIdeaBySelf的function
    if(typeof FlowIdeaBySelf == "function"){
        this.flowIdea = eval("new FlowIdeaBySelf(this)");
    }else{
        this.flowIdea = new FlowIdea(this);
    }
    _flow_editor = this;
    return this;
};
FlowEditor.prototype.setFlowIdea = function(flowIdea){
    this.flowIdea = flowIdea;
};
FlowEditor.prototype.init = function(){
    // 初始化参数
    if (flowUtils.notNull(_bpm_defineId)) {
        this.isStart = true;
        this.isStartPage = true;
        this.flowModel.setActivityname(_bpm_firstTaskName);
        this.flowModel.setActivitylabel(_bpm_firstTaskAlias);
        this.flowModel.setUserIdentityKey("6");
        this.flowModel.setUserIdentity("拟稿人");
        // 权限按钮
        this.createButtons();
    } else if (flowUtils.notNull(_bpm_entryId, _bpm_executionId, _bpm_taskId, _bpm_formId)) {
        this.defaultForm.setId(_bpm_formId);

        //当检查到checkUserSecretLevel方法返回true，或存在checkUserSecretLevel的全局变量为true时，执行密级校验
        //管理员也需要符合密级要求
        if(this.defaultForm.checkUserSecretLevel()){
            var that = this;
            avicAjax.ajax({
                type : "POST",
                data : {
                    processInstanceId: _bpm_entryId,
                    secretLevelCode: that.defaultForm.secretLevelCode()
                },
                url : "platform/bpm/clientbpmdisplayaction/isUserSecretLevel",
                dataType : "json",
                success : function(r) {
                    var b = r.result;
                    if (b) {
                        that.defaultForm.initFormData();
                        that.flowModel.defineId = that.getDefineIdByEntryId(_bpm_entryId);
                        // 权限按钮
                        that.createButtons();
                    } else {
                        that.hideBody();
                        flowUtils.error("人员密级不符合要求", function () {
                            flowUtils.closeWindowOnDialog();
                        });
                        return false;
                    }
                }
            });
        }else {
            this.defaultForm.initFormData();
            this.flowModel.defineId = this.getDefineIdByEntryId(_bpm_entryId);
            // 权限按钮
            this.createButtons();
        }
    } else {
        this.hideBody();
        flowUtils.error("流程参数错误！无法初始化权限按钮！您可能是通过非法的途径进入了当前页面，例如重复刷新页面，拷贝链接到浏览器地址栏等操作。点击确定关闭表单", function () {
            flowUtils.closeWindowOnDialog();
        });
        return false;
    }
    var title = flowUtils.getUrlQuery("title");
    if (flowUtils.notNull(title)) {
        document.title = unescape(title);
    }
};
/**
 * 表单对象
 */
FlowEditor.prototype.defaultForm = null;
/**
 * 数据模板
 */
FlowEditor.prototype.flowModel = null;
/**
 * 是否新建
 */
FlowEditor.prototype.isStart = false;
/**
 * 是否是发起页面
 * @type {boolean}
 */
FlowEditor.prototype.isStartPage = false;
/**
 * 是否是模拟状态
 */
FlowEditor.prototype.simulation = "0";
/**
 * 自定义的加载后事件是否已经执行
 */
FlowEditor.prototype.afterInit = false;
/**
 * 隐藏页面，关闭页面
 */
FlowEditor.prototype.hideBody = function () {
    this.hideButtons();
    $("#main").hide();
};
/**
 * 隐藏按钮
 */
FlowEditor.prototype.hideButtons = function () {
    $(".bpmhide").hide();
    $(".bpmhide").removeClass("but_lead");
};
/**
 * 显示按钮
 */
FlowEditor.prototype.showButtons = function (domId) {
    /*if(this.leadButCodeList.indexOf(domId) != -1 &&  !$("#" + domId).hasClass("sub-list-li")){
        $("#" + domId).addClass("but_lead");
    }
    if($("#" + domId).hasClass("sub-list-li")){
        $(".more-list").show();
    }
    $("#" + domId).show();*/
    if(this.leadButCodeList.indexOf(domId) != -1){
        $("#" + domId).addClass("but_lead");
    }
    $("#" + domId).show();
};

/**
 * 引导按钮
 * @type {Array}
 */
FlowEditor.prototype.leadButCodeList = [];
/**
 * 权限按钮重置
 */
FlowEditor.prototype.createButtons = function (flg, outcome) {
    var _self = this;
    this.leadButCodeList = this.defaultForm.getLeadButCodeList();
    // 隐藏所有按钮
    this.hideButtons();
    if (this.simulation == "1") {
        //模拟状态
        this.bpmSubmit = new BpmSubmit(this, this.defaultForm, new Object());
        // 默认保存
        this.bpmSave = new BpmSave(this, this.defaultForm, new Object());
        // 帮助
        this.bpmButHelp = new BpmButHelp(this, this.defaultForm, new Object());
        //引用文档
        this.bpmButFile = new BpmButFile(this, this.defaultForm, new Object());
        //流程跟踪
        this.bpmButTrack = new BpmButTrack(this, this.defaultForm, new Object());

        this.bpmSubmit.execute = function () {
            flowUtils.success("模拟提交");
        };

        this.bpmSave.execute = function () {
            flowUtils.success("模拟保存");
        };

        this.setRoles();
        //当前节点描述
        this.hoverRemark();
        // 控制表单元素
        this.flowForm.controlFormInput();
        // 流程图
        this.refreshPic();
        // 流程意见
        this.refreshIdea();
        //刷新权限按钮后事件
        this.defaultForm.afterCreateButtons();

        $(window).resize();

        //自定义的加载事件
        if (!this.afterInit) {
            this.defaultForm.afterInit();
            this.afterInit = true;
        }
    } else {
        if (this.isStart) {
            // 默认提交
            this.bpmSubmit = new BpmSubmit(this, this.defaultForm, new Object());
            // 默认保存
            this.bpmSave = new BpmSave(this, this.defaultForm, new Object());
            // 帮助
            this.bpmButHelp = new BpmButHelp(this, this.defaultForm, new Object());
            //引用文档
            this.bpmButFile = new BpmButFile(this, this.defaultForm, new Object());
            //流程跟踪
            this.bpmButTrack = new BpmButTrack(this, this.defaultForm, new Object());

            this.setRoles();
            //当前节点描述
            this.hoverRemark();
            // 控制表单元素
            this.flowForm.controlFormInput();
            // 流程图
            this.refreshPic();
            // 流程意见
            this.refreshIdea();
            //刷新权限按钮后事件
            this.defaultForm.afterCreateButtons();

            $(window).resize();

            //自定义的加载事件
            if (!this.afterInit) {
                this.defaultForm.afterInit();
                this.afterInit = true;
            }
        } else {
            // 流程图
            this.refreshPic();
            // 流程意见
            this.refreshIdea();
            avicAjax.ajax({
                type: "POST",
                data: {
                    processInstanceId: _self.flowModel.entryId,
                    executionId: _self.flowModel.executionId,
                    taskId: _self.flowModel.taskId
                },
                url: "platform/bpm/business/getoperateright",
                dataType: "JSON",
                success: function (msg) {
                    if (flowUtils.notNull(msg.error)) {
                        flowUtils.error(msg.error);
                    } else {
                        _self.drawButtons(msg);
                        //调用正文模板的方法
                        if (typeof word_oa_refresh != 'undefined' && flowUtils.notNull(word_oa_refresh)) {
                            word_oa_refresh(_self);
                        }
                        // 默认点击提交
                        if (flg) {
                            _self.bpmSubmit.clickBut(outcome);
                        }
                        //刷新权限按钮后事件
                        _self.defaultForm.afterCreateButtons();

                        $(window).resize();

                        //自定义的加载事件
                        if (!_self.afterInit) {
                            _self.defaultForm.afterInit();
                            _self.afterInit = true;
                        }
                    }
                }
            });
        }
    }
};
/**
 * 画按钮
 *
 * @param json
 */
FlowEditor.prototype.drawButtons = function (json) {
    var bpmContent = json.bpmContent;

    //如果曾经在当前节点办理过，提示用户
    if(flowUtils.notNull(bpmContent.messageForEver)){
        layer.alert(bpmContent.messageForEver);
    }

    this.flowModel.setActivityname(bpmContent.processActivityName);
    this.flowModel.setActivitylabel(bpmContent.processActivityLabel);
    this.flowModel.setUserIdentityKey(bpmContent.userIdentityKey);
    this.flowModel.setUserIdentity(bpmContent.userIdentity);
    this.flowModel.setIdeasBySelf(bpmContent.ideasBySelf);
    this.setRoles();
    //当前节点描述
    this.hoverRemark();

    var buttonArray = json.operateRight;
    if (buttonArray == null) {
        return;
    }
    var buttonData = {};
    $.each(buttonArray, function (i, button) {
        if (button.event == "dosubmit") {
            if (buttonData.dosubmit == null) {
                buttonData.dosubmit = [];
            }
            buttonData.dosubmit.push(button);
        } else {
            eval("buttonData." + button.event + "= button");
        }
    });

    this.bpmSave = new BpmSave(this, this.defaultForm, buttonData);
    this.bpmRetreat = new BpmRetreat(this, this.defaultForm, buttonData);
    this.bpmSubmit = new BpmSubmit(this, this.defaultForm, buttonData);
    this.bpmWithdraw = new BpmWithdraw(this, this.defaultForm, buttonData);
    this.bpmSupplement = new BpmSupplement(this, this.defaultForm, buttonData);
    this.bpmAdduser = new BpmAdduser(this, this.defaultForm, buttonData);
    this.bpmSupersede = new BpmSupersede(this, this.defaultForm, buttonData);
    this.bpmTransmit = new BpmTransmit(this, this.defaultForm, buttonData);
    this.bpmWithdrawassignee = new BpmWithdrawassignee(this, this.defaultForm, buttonData);
    this.bpmFocus = new BpmFocus(this, this.defaultForm, buttonData);
    this.bpmGlobalend = new BpmGlobalend(this, this.defaultForm, buttonData);
    this.bpmGlobalidea = new BpmGlobalidea(this, this.defaultForm, buttonData);
    this.bpmGlobaljump = new BpmGlobaljump(this, this.defaultForm, buttonData);
    this.bpmGlobalresume = new BpmGlobalresume(this, this.defaultForm, buttonData);
    this.bpmGlobalsuspend = new BpmGlobalsuspend(this, this.defaultForm, buttonData);
    this.bpmStepuserdefined = new BpmStepuserdefined(this, this.defaultForm, buttonData);
    this.bpmTaskreader = new BpmTaskreader(this, this.defaultForm, buttonData);
    this.bpmPresstodo = new BpmPresstodo(this, this.defaultForm, buttonData);
    this.bpmStartsubflow = new BpmStartsubflow(this, this.defaultForm, buttonData);
    this.bpmRelationparentflow = new BpmRelationparentflow(this, this.defaultForm, buttonData);
    this.bpmRelationflow = new BpmRelationflow(this, this.defaultForm, buttonData);
    this.bpmButFile = new BpmButFile(this, this.defaultForm, buttonData);
    this.bpmButTrack = new BpmButTrack(this, this.defaultForm, buttonData);
    this.bpmButRelation = new BpmButRelation(this, this.defaultForm, buttonData);
    this.bpmButHelp = new BpmButHelp(this, this.defaultForm, buttonData);
    this.bpmAttribute = new BpmAttribute(this, this.defaultForm, buttonData);
    // 控制表单元素
    this.flowForm.controlFormInput();
};



/**
 * 流程启动后
 *
 * @param result
 */
FlowEditor.prototype.afterStart = function (result) {
    this.isStart = false;
    this.flowModel.setDefineId(result.defineId);
    this.flowModel.setEntryId(result.entryId);
    this.flowModel.setExecutionId(result.executionId);
    this.flowModel.setTaskId(result.taskId);
    this.defaultForm.setId(result.formId);
};
/**
 * 刷新是否被挂起
 * @type {boolean}
 */
FlowEditor.prototype.needRefreshPic = false;
/**
 * 刷新流程图
 */
FlowEditor.prototype.refreshPic = function () {
    this.needRefreshPic = true;
    if($("#bpm_pic_tab").is(':hidden')){
        return;
    }
    this.needRefreshPic = false;
    if(this.designerEditor == null){
        var _self = this;
        if($("#graph").length == 0){
            return;
        }
        // 初始化流程图画布
        initFlowPic(this.flowModel.entryId, this.flowModel.deploymentId, function(designerEditor) {
            _self.designerEditor = designerEditor;
            _self.designerEditor.init(_self.flowModel.entryId, _self.flowModel.deploymentId);
            //IE8下把决定定位去掉，不然样式有问题
            if(flowUtils.isIE8()){
                $("#graph").children("div").css("position","");
            }
        });
    }else{
        this.designerEditor.init(this.flowModel.entryId, this.flowModel.deploymentId);
        if(flowUtils.isIE8()) {
            $("#graph").children("div").css("position", "");
        }
    }
};
/**
 * 刷新是否被挂起
 * @type {boolean}
 */
FlowEditor.prototype.needRefreshIdea = false;
/**
 * 刷新流程意见
 */
FlowEditor.prototype.refreshIdea = function () {
    this.needRefreshIdea = true;
    if($("#bpm_idea_tab").is(':hidden')){
        return;
    }
    this.needRefreshIdea = false;
    this.flowIdea.refresh();
};

/**
 * 需要获取定义文件id
 *
 * @param entryId
 */
FlowEditor.prototype.getDefineIdByEntryId = function (entryId) {
    var defineId = null;
    $.ajax({
        type: "POST",
        async: false,// 同步请求
        data: {
            entryId: entryId
        },
        url: "platform/bpm/business/getDefineIdByEntryId",
        dataType: "JSON",
        success: function (msg) {
            if (flowUtils.notNull(msg.error)) {
                flowUtils.error(msg.error);
            } else {
                defineId = msg.defineId;
            }
        }
    });
    return defineId;
};

/**
 * 初始化节点描述
 */
FlowEditor.prototype.hoverRemark = function () {
    if ($("#help-panel").attr("isload") == "true") {
        return;
    }
    $("#help-panel").attr("isload", "true");
    $.ajax({
        type: "POST",
        data: {
            defineId: this.flowModel.defineId,
            activityname: this.flowModel.activityname
        },
        url: "platform/bpm/business/getTaskRemark",
        dataType: "JSON",
        success: function (msg) {
            if (flowUtils.notNull(msg.error)) {
                flowUtils.error(msg.error);
            } else {
                var html = "";
                if (flowUtils.notNull(msg.result)) {
                    html = "<p>" + msg.result + "</p>";
                } else {
                    html = "<p>当前节点无描述</p>";
                }
                $("#help-panel").html(html);
            }
        }
    });
};
FlowEditor.prototype.setRoles = function () {
    $(".nav-role").find("p").text("角色：" + this.flowModel.activitylabel + "节点" + this.flowModel.userIdentity);
};
// 暴漏的全局属性
var _flow_editor = null;
$(function () {
    $("#formTabParent").append($("#formTab"));
    $("#formTab").show();
    $("#formBut").children().each(function (i, n) {
        var order = $(n).attr("order");
        if(order == null || order == ""){
            order = "99";
        }
        var orderNumber = Number(order);
        if(orderNumber < $(".top-btns").children("ul").children().length && orderNumber >= 0){
            $(".top-btns").children("ul").children().eq(Number(order)).before($(n));
        }else {
            $(".top-btns").children("ul").append($(n));
        }
    });
});
;
