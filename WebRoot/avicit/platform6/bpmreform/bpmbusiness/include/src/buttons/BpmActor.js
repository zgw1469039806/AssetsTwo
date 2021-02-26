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
