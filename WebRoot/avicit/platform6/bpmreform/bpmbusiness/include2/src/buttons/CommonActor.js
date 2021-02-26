/**
 * 流程通用选人框基础结构
 */
function ActorModel() {
};
/**
 * 下一步节点选人信息列表 ActorModel对象集合
 */
ActorModel.prototype.nextTask = [];
/**
 * 节点类型
 *  task:人工节点
 *
 * @param nextTask
 */
ActorModel.prototype.activityType = null;
/**
 * 部门列表
 */
ActorModel.prototype.deptList = [];
/**
 * 组织树列表
 */
ActorModel.prototype.orgList = [];
/**
 * 组织部门树数据加载url
 */
ActorModel.prototype.orgDeptTreeUrl = null;
/**
 * 组织部门树初始化节点
 */
ActorModel.prototype.orgDeptTreeZNode = [];
/**
 * 用户列表
 */
ActorModel.prototype.userList = [];
/**
 * 群组列表
 */
ActorModel.prototype.groupList = [];
/**
 * 群组树数据加载url
 */
ActorModel.prototype.groupTreeUrl = null;
/**
 * 群组树初始化节点
 */
ActorModel.prototype.groupTreeZNode = [];
/**
 * 角色列表
 */
ActorModel.prototype.roleList = [];
/**
 * 角色树数据加载url
 */
ActorModel.prototype.roleTreeUrl = null;
/**
 * 角色树初始化节点
 */
ActorModel.prototype.roleTreeZNode = [];
/**
 * 岗位列表
 */
ActorModel.prototype.positionList = [];
/**
 * 岗位树数据加载url
 */
ActorModel.prototype.positionTreeUrl = null;
/**
 * 岗位树初始化节点
 */
ActorModel.prototype.positionTreeZNode = [];

/**
 * 节点扩展属性
 */
ActorModel.prototype.currentActivityAttr= {};
/**
 * 是否自由流
 */
ActorModel.prototype.isUflow= null;
/**
 * 排序
 */
ActorModel.prototype.order= null;
/**
 * 密级
 */
ActorModel.prototype.secretLevel= null;
/**
 * 表单id
 */
ActorModel.prototype.formId= null;
/**
 * 流程定义KEY
 */
ActorModel.prototype.processKey= null;
/**
 * 是否是最后一个处理人
 */
ActorModel.prototype.lastDealUser= false;

ActorModel.prototype.setNextTask = function(nextTask){
	this.nextTask = nextTask;
};

ActorModel.prototype.setActivityType = function(activityType){
	this.activityType = activityType;
};

ActorModel.prototype.setDeptList = function(deptList){
	this.deptList = deptList;
};

ActorModel.prototype.setOrgDeptTreeUrl = function(orgDeptTreeUrl){
	this.orgDeptTreeUrl = orgDeptTreeUrl;
};

ActorModel.prototype.setOrgDeptTreeZNode = function(orgDeptTreeZNode){
	this.orgDeptTreeZNode = orgDeptTreeZNode;
};

ActorModel.prototype.setUserList = function(userList){
	this.userList = userList;
};

ActorModel.prototype.setGroupList = function(groupList){
	this.groupList = groupList;
};

ActorModel.prototype.setGroupTreeUrl = function(groupTreeUrl){
	this.groupTreeUrl = groupTreeUrl;
};

ActorModel.prototype.setGroupTreeZNode = function(groupTreeZNode){
	this.groupTreeZNode = groupTreeZNode;
};

ActorModel.prototype.setRoleList = function(roleList){
	this.roleList = roleList;
};

ActorModel.prototype.setRoleTreeUrl = function(roleTreeUrl){
	this.roleTreeUrl = roleTreeUrl;
};

ActorModel.prototype.setRoleTreeZNode = function(roleTreeZNode){
	this.roleTreeZNode = roleTreeZNode;
};

ActorModel.prototype.setPositionList = function(positionList){
	this.positionList = positionList;
};

ActorModel.prototype.setPositionTreeUrl = function(positionTreeUrl){
	this.positionTreeUrl = positionTreeUrl;
};

ActorModel.prototype.setPositionTreeZNode = function(positionTreeZNode){
	this.positionTreeZNode = positionTreeZNode;
};

ActorModel.prototype.setOrgList = function(orgList){
	this.orgList = orgList;
};

ActorModel.prototype.setCurrentActivityAttr = function(currentActivityAttr){
	this.currentActivityAttr = currentActivityAttr;
};

ActorModel.prototype.setIsUflow = function(isUflow){
	this.isUflow = isUflow;
};

ActorModel.prototype.setOrder = function(order){
	this.order = order;
};

ActorModel.prototype.setSecretLevel = function(secretLevel){
	this.secretLevel = secretLevel;
};

ActorModel.prototype.setFormId = function(formId){
	this.formId = formId;
};

ActorModel.prototype.setProcessKey = function(processKey){
	this.processKey = processKey;
};

ActorModel.prototype.setModelList = function(modelList){
	this.modelList = modelList;
};

ActorModel.prototype.setLastDealUser = function(lastDealUser){
	this.lastDealUser = lastDealUser;
};


/**
 * 流程通用选人框
 */
function CommonActor(data,actorModel,submitObj) {
	this.data = data;
	this.actorModel = actorModel;
	this.submitObj = submitObj;
	this.selectUserWindow;
	this.workHandWindow;
	this.init.call(this);
};

CommonActor.prototype.init = function(){
	var _self = this;
	/**
	var _outcome = _self.data.name;
	if(_outcome!=null && _outcome!=undefined){
		_outcome.replaceAll(" ", "@@@");
	}
	_self.actorModel.currentActivityAttr.processInstanceId=_self.data.procinstDbid;
	_self.actorModel.currentActivityAttr.executionId=_self.data.executionId;
	_self.actorModel.currentActivityAttr.outcome=_outcome;
	_self.actorModel.currentActivityAttr.type=_self.data.event;
	_self.actorModel.currentActivityAttr.targetActivityName=_self.data.targetActivityName;
	_self.actorModel.currentActivityAttr.taskId=_self.data.taskId;
	if(_self.actorModel.nextTask && _self.actorModel.nextTask.length && _self.actorModel.nextTask.length>0){
		for(var i=0;i<_self.actorModel.nextTask.length;i++){
			_self.actorModel.nextTask[i].currentActivityAttr.processInstanceId=_self.data.procinstDbid;
			_self.actorModel.nextTask[i].currentActivityAttr.executionId=_self.data.executionId;
			_self.actorModel.nextTask[i].currentActivityAttr.outcome=_outcome;
			_self.actorModel.nextTask[i].currentActivityAttr.type=_self.data.event;
			_self.actorModel.nextTask[i].currentActivityAttr.targetActivityName=_self.data.targetActivityName;
			_self.actorModel.nextTask[i].currentActivityAttr.taskId=_self.data.taskId;
			_self.actorModel.nextTask[i].currentActivityAttr.index = i+"";
		}
	}*/
};

/**
 * 执行
 */
CommonActor.prototype.open = function () {
	var _self = this;
	var percent = window.devicePixelRatio;
	if(!percent){
		percent = 1;
	}
	var title="选人", height=525/percent + "px";
	if(!_self.showSelectUser()){
		height = "350px";
		title = "流程意见";
	}
	var btn = ['确定','取消'];
	//强制表态
	if(_self.isIdeaCompelManner()){
		btn = ['同意并提交','不同意并提交','取消'];
	}
	window['_actorModel'] = _self.actorModel;
	window['_data'] = _self.data;
	var url = 'avicit/platform6/bpmreform/bpmbusiness/include2/src/actor/ProcessSelectUsers.jsp?procinstDbid=' + _self.data.procinstDbid + '&executionId=' + _self.data.executionId + '&taskId=' + _self.data.taskId + '&outcome=' + _self.data.name + '&targetActivityName=' + _self.data.targetActivityName + '&type=' + _self.data.event + '&doSubmitUrl=&doSubmitCallEvent=';
	this.selectUserWindow = top.layer.open({
		skin: 'bpm_selectUser_class',
		type : 2,
		title: title,
		area : [ "680px", height ],
		shade: 0.4,
        shift: 5,
        closeBtn: true,
        shadeClose: false,
		content : url,
		btn : btn,
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;
			var compelManner = "";
			if(_self.submitObj.isEvent){
				compelManner = "yes";
			}else{
				if(_self.isIdeaCompelManner()){
					compelManner = "yes";
				}
			}
			return _self.submit(iframeWin, compelManner);
		},
		btn2 : function(index, layero){
			if(_self.isIdeaCompelManner()){
				var iframeWin = layero.find('iframe')[0].contentWindow;
				var compelManner = "no";
				return _self.submit(iframeWin, compelManner);
			}else{
				return;
			}

		},
		btn3 : function(index, layero){
			return;
		},
		success : function(layero, index){
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
								iframeWin.selectUserForStepuserdefined(obj,"cba-for-tree-"+_self.data.activityName,_self.data.activityName);
							}
						}
					}
				});
			}
		}
	});
};

CommonActor.prototype.submit = function(iframeWin,compelManner){
	var _self = this;
	var users = [];
	var ideaText = _self.getIdeaText(iframeWin);;
	if(_self.actorModel.nextTask){
		if(!_self.noNeedSelectUser()){
			var selectedUsers = iframeWin.getSelectedUsers();
			if(selectedUsers.length<1){
				top.layer.msg("请选择处理人");
				return false;
			}else if(selectedUsers.length==1){
				if(selectedUsers[0].selectedUsers == null
						|| selectedUsers[0].selectedUsers.length==0){
					top.layer.msg("请选择处理人");
					return false;
				}
			}else{
				var newSelectUsers = [];
				for(var i=0;i<selectedUsers.length;i++){
					if(_self.isMustUser(i)){
						if(selectedUsers[i].selectedUsers == null
								|| selectedUsers[i].selectedUsers.length==0){
							var targetActivityName = selectedUsers[i].targetActivityName
							var targetActivity = _self.getActorModel(i);
							if(targetActivity){
								targetActivityName = targetActivity.currentActivityAttr.activityAlias
							}
							top.layer.msg("请选择【"+targetActivityName+"】节点处理人");
							return false;
						}
					}
					if(selectedUsers[i].selectedUsers != null
							&& selectedUsers[i].selectedUsers.length>0){
						newSelectUsers.push(selectedUsers[i]);
					}
				}
				if(newSelectUsers.length<1){
					top.layer.msg("请选择处理人");
					return false;
				}
				/**
				 * 如果只选择了抄送节点则不能提交
				 */
				if(newSelectUsers.length == 1 && newSelectUsers[0].targetActivityName == "carbonCopy"){
					top.layer.msg("请选择处理人");
					return false;
				}
				selectedUsers = newSelectUsers;
			}
			/**
			 * 意见判断
			 *
			 */
			//流程提交
			if(_self.data.event=='dosubmit'){
				if(!_self.submitObj.isEvent && _self.actorModel.currentActivityAttr.ideaType=='must'){
					if (!flowUtils.notNull(ideaText)) {
						flowUtils.warning('请填写流程意见');
						iframeWin.focusIdeaText();
						return false;
					}
				}

			}else if(_self.data.event=='doretreattodraft'
						|| _self.data.event=='doretreattoprev'
						|| _self.data.event=='doretreattowant'){//回退
				if (!_self.submitObj.isEvent && _self.actorModel.currentActivityAttr.isNeedIdea == 'yes') {// 意见必须填写
					if (!flowUtils.notNull(ideaText)) {
						flowUtils.warning('请填写流程意见');
						iframeWin.focusIdeaText();
						return false;
					}
				}
			}
			var isUflow = _self.isUflow();
			users = selectedUsers;

			//增加选人判断
			if(_self.submitObj instanceof BpmSubmit) {
				var userFlg = _self.submitObj.flowEditor.defaultForm.selectUserSuccess(users);
				if (!userFlg) {
					return false;
				}
			}

			if(_self.checkWorkHandUser()){//工作移交
				var workHandSelectedUsers = _self.geBranchWorkHandSelectedUsers(users);
				_self.actorWorkerHandlerOperation(workHandSelectedUsers,users, null,ideaText,compelManner);
			} else {//非工作移交
				users = selectedUsers;
				_self.submitObj.submit(_self.data, users, ideaText,compelManner,null,false);
				if(this.selectUserWindow){
					top.layer.close(this.selectUserWindow);
				}else{
					top.layer.closeAll();
				}

			}
		}else{

			_self.submitObj.submit(_self.data, users, ideaText,compelManner,null,false);
			if(this.selectUserWindow){
				top.layer.close(this.selectUserWindow);
			}else{
				top.layer.closeAll();
			}
		}
	}else{
		_self.submitObj.submit(_self.data, users, ideaText,compelManner,null,false);
		if(this.selectUserWindow){
			top.layer.close(this.selectUserWindow);
		}else{
			top.layer.closeAll();
		}
	}


};

/**
 * 自动选人
 */
CommonActor.prototype.isAutoSelectUser = function(){
	if(this.data.event  == "doretreattodraft"
		|| this.data.event  == "doretreattoprev"
		|| this.data.event  == "dowithdraw"
		|| this.data.event  == "doretreattowant"){
		return true;
	}
	return false;
};

/**
 * 获取工作移交的选人结果
 * @param users
 * @returns {Array}
 */
CommonActor.prototype.geBranchWorkHandSelectedUsers = function(users){
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
CommonActor.prototype.actorWorkerHandlerOperation = function (users,originalUsers, uflowDealType,ideaText,compelManner){
	var _self = this;
	$.ajax({
		   type: "POST",
		   url: 'platform/bpmActor/bpmSelectUserAction2/getWorkHandUsers',
		   async: false,
		   data: {
			   userList:JSON.stringify(users),
			   processKey: _self.actorModel.processKey
		   },
		   dataType: 'json',
		   success: function(workHandUsersList){
		     if(workHandUsersList && workHandUsersList.length > 0){
		    	 //var url = 'platform/bpmActor/bpmSelectUserAction2/getWorkHandSelectUser?userList=' + encodeURI(JSON.stringify(workHandUsersList));
		    	 var url = 'platform/bpmActor/bpmSelectUserAction2/getWorkHandSelectUser?userList=' + encodeURI(encodeURI(JSON.stringify(workHandUsersList)));
		    	 _self.workHandWindow = top.layer.open({
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
	    					for(var i = 0 ; i < originalUsers.length ; i++){
	    						originalUsers[i].workhandUsers = selectedUsers;
	    					}
	    					_self.submitObj.submit(_self.data, originalUsers, ideaText, compelManner,uflowDealType,false);
							if(_self.workHandWindow){
								top.layer.close(_self.workHandWindow);
							}else{
								top.layer.closeAll();
							}
		    			},
		    			init:function(index, layer){
		    			}
		    		});
		     } else {
	    		_self.submitObj.submit(_self.data, originalUsers, ideaText, compelManner,uflowDealType,false);
				 if(_self.selectUserWindow){
					 top.layer.close(_self.selectUserWindow);
				 }else{
					 top.layer.closeAll();
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

/**
 * 判断是否存在工作移交
 */
CommonActor.prototype.checkWorkHandUser = function(){
	if(this.data.event  == "doretreattodraft"
		|| this.data.event  == "doretreattoprev"
		|| this.data.event  == "dowithdraw"
		|| this.data.event  == "dotransmit"
	    || this.data.event  == "dotaskreader"
	    || this.data.event  == "dowithdrawassignee"){
		return false;
	}
	if(this.actorModel && this.actorModel.nextTask){
		for(var i = 0 ; i < this.actorModel.nextTask.length ; i++){
			var jsonData = this.actorModel.nextTask[i];
			if(jsonData.currentActivityAttr.isWorkHandUser == 'yes'){
				return true;
			}
		}
	} else {
		return false;
	}
};

/**
 * 不需要选人
 */
CommonActor.prototype.noNeedSelectUser = function(){
	var iaAll = false;
	var count = 0;
	for(var i=0;i<this.actorModel.nextTask.length;i++) {
		var _nextActorModel = this.actorModel.nextTask[i];
		if(_nextActorModel.activityType=='end'){
			return true;
		}else if(_nextActorModel.activityType=='sub-process' || _nextActorModel.activityType=='foreach'){
			if(_nextActorModel.currentActivityAttr.isMustUser=="yes"){
				return false;
			}else{
				count ++;
			}
		}
	}
	if(this.actorModel.nextTask.length>0 && count == this.actorModel.nextTask.length){
		return true;
	}
	return false;
};

/**
 * 显示选人框
 */
CommonActor.prototype.showSelectUser = function(){
	if(!this.actorModel.nextTask){
		return false;
	}else if(this.isAutoSelectUser()){
		return false;
	}else{
		for(var i=0;i<this.actorModel.nextTask.length;i++) {
			var _nextActorModel = this.actorModel.nextTask[i];
			if(_nextActorModel.activityType=='sub-process' || _nextActorModel.activityType=='foreach'){
				if(_nextActorModel.currentActivityAttr.isMustUser=="yes"){
					return true;
				}
			}else if(_nextActorModel.activityType=='end'){
				return false;
			}else{
				if(_nextActorModel.currentActivityAttr.isSelectUser=="yes"){
					return true;
				}
			}
		}
	}
	return false;
};

/**
 * 允许显示选人框
 * @returns {Boolean}
 */
CommonActor.prototype.isShowSelectUser = function(index){
	if(index>-1){
		for(var i=0;i<this.actorModel.nextTask.length;i++){
			var _nextActorModel = this.actorModel.nextTask[i];
			if(i==index){
				if(_nextActorModel.currentActivityAttr.isSelectUser=="yes"){
					return true;
				}else{
					return false;
				}
			}

		}
	}else{
		for(var i=0;i<this.actorModel.nextTask.length;i++){
			var _nextActorModel = this.actorModel.nextTask[i];
			if(_nextActorModel.currentActivityAttr.isSelectUser=="yes"){
				return true;
			}
		}
	}

	return false;
};

/**
 * 分支节点必须选人
 */
CommonActor.prototype.isMustUser = function(index){
	if(index>-1){
		for(var i=0;i<this.actorModel.nextTask.length;i++){
			var _nextActorModel = this.actorModel.nextTask[i];
			if(i==index){
				if(_nextActorModel.currentActivityAttr.isMustUser=="yes"){
					return true;
				}else{
					return false;
				}
			}

		}
	}else{
		for(var i=0;i<this.actorModel.nextTask.length;i++){
			var _nextActorModel = this.actorModel.nextTask[i];
			if(_nextActorModel.currentActivityAttr.isMustUser=="yes"){
				return true;
			}
		}
	}
	return false;
}
/**
 * 获取节点对象
 * @param index
 * @returns {null}
 */
CommonActor.prototype.getActorModel = function(index){
	for(var i=0;i<this.actorModel.nextTask.length;i++){
		var _nextActorModel = this.actorModel.nextTask[i];
		if(i==index){
			return _nextActorModel;
		}
	}
	return null;
}
/**
 * 后台自动选人
 */
CommonActor.prototype.isAutoSelectUser = function(){
	if(this.data.event  == "doretreattodraft"
		|| this.data.event  == "doretreattoprev"
		|| this.data.event  == "dowithdraw"
		|| this.data.event  == "doretreattowant"){
		return true;
	}

	return false;
};

CommonActor.prototype.isUflow = function(){
	return this.actorModel.isUflow == "2";
};

CommonActor.prototype.getUflowDealType = function(){
	/**
	if(this.isUflow()){
		var tempDom = $(".bpm_selectUser_class");
		if(tempDom.length == 0){
			tempDom = parent.$(".bpm_selectUser_class");
		}
		if(tempDom.length == 0){
			return "";
		}
		return tempDom.find(".layui-layer-btn").find("input[name='dealtype']:checked").val();
	}*/
	return "";
};

CommonActor.prototype.getIdeaText = function(iframeWin) {
	if(this.submitObj.isEvent){
		return "";
	}
	return iframeWin.getIdea();
};

CommonActor.prototype.isIdeaCompelManner = function() {
	if (this.actorModel.currentActivityAttr.ideaCompelManner) {
		if (this.actorModel.currentActivityAttr.ideaCompelManner == 'yes'
		  && this.data.event=='dosubmit') {// 强制
			return true;
		} else {
			return false;// 不强制
		}
	} else {
		return false;// 不强制
	}
};

/**
 * 判断路由
 *
 * @param dataJson
 * @returns
 */
CommonActor.prototype.getConditions = function(dataJson) {
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
