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
