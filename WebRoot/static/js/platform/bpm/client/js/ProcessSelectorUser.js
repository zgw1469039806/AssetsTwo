﻿﻿/**
 * 条件值
 */

//事件
var processSelectorUserEvent = {
		/**
		 * 获取分支数
		 * @returns
		 */
		getBranchLength : function(){
			if(dataJson.nextTask == null){
				return 0;
			}
			return dataJson.nextTask.length;
		}
};

var settings ;
$(function(){
	//下节点的属性值
	if(dataJson){
		if(dataJson.nextTask){
			if($("#workflowSelectorSource").length > 0 ){
				$("#workflowSelectorSource").append("<div id=\"selectorUserTabs\"></div>");
				var tabs = $("#selectorUserTabs").tabs({  
			        border:false,
			        fit : true ,
			        plain : true
			    });
				//创建选人区域
				var getDatas = new GetDatas();
				if(conditions.isBranch()){//多个分支时
					for(var i = 0 ; i < getDatas.getBranchLength() ; i++){
						var branchNo = i;//分支序号
						tabs.tabs('add',{ 
							id : 'selectorUserTab_' + branchNo,
						    title : getDatas.getNextActivityAlias(branchNo),
						    closable:false,
						    content : '<div class=\"easyui-layout\" fit=\"true\"><div region=\"center\" ><div id=\"selectorUserTab_' + branchNo + '_Content\"></div></div><div region=\"east\" split=\"true\" style=\"width:280px;\"><div id=\"selectorUserTabForTargetDataGrid_' + branchNo + '\"></div></div></div>',
						    iconCls : 'icon-branch'
						});
						var secondLayerTabs = $("#selectorUserTab_" + branchNo + '_Content').tabs({  
					        border:false,
					        fit : true ,
					        plain : true
					    });
						drawSecondLayerTabs(dataJson.nextTask[branchNo],secondLayerTabs,branchNo);//绘制第二层
						drawSecondLayerTabsForTargetDataGrid('selectorUserTabForTargetDataGrid_' + branchNo,branchNo);
					}
					//选中第一标签页
					tabs.tabs('select',0);
				} else { // 非分支
					//绘制目标dataGrid布局区域
					var branchNo = 0;
					
					drawSecondLayerTabs(dataJson.nextTask[0],tabs,branchNo);
					drawSecondLayerTabsForTargetDataGrid('selectorUserTabForTargetDataGrid_' + branchNo,branchNo);
					//选中第一标签页
					tabs.tabs('select',0);
				}
				
				setTimeout("processSelectUserComponentEvent.eventOfUserSelectType();" +
						"processSelectUserComponentEvent.eventOfIsDisplayUserSelect()",
						888);
				
				//自动获取用户
				if(type == 'dosubmit'){//只是正常提交时
					for(var i = 0 ; i < getDatas.getBranchLength() ; i++){
						if(conditions.isAutoGetUser(i)){
							getDatas.getAutoGetSysUsers(i);
						}
					}
				}
			}
		} else {
			hideUserSelectArea();
//			$.messager.alert('提示','服务端数据错误!','error');
		}
	}
	settings  = {
			saveToCookieKey : 'processSelectorUserCookie_' + outcome + '_'  + processInstanceId +  '_' + taskId + '_' + executionId
	};
	/*
	 * 流程选人和意见框是否显示控制
	 */
	if(type == 'dosubmit'){//正常提交
		var nextActivityType = conditions.getNextActivityType();
		if(nextActivityType){
			if(nextActivityType == 'sub-process'){//子流程
				if(!conditions.isMustUser()){ 
					hideUserSelectArea();
				}
			} else if(nextActivityType == 'foreach'){//分支
				if(!conditions.isMustUser()){ 
					hideUserSelectArea();
				}
			} else if(nextActivityType == "end"){//下一节点为流程流转结束(归档)
				hideUserSelectArea();
				if(conditions.getIdeaType() == 'cannot'){ //意见不能填写,自动提交
					var b = parent.ButtonProcessing.ButtonPreviousProcessing("dosubmit",processInstanceId,"",parent.framework.bpm.processActivityName,"",parent.framework.form.formId);
					if(b){
						var data = "taskId="+taskId+"&outcome="+outcome+"&formJson=&instanceId="+processInstanceId;
						parent.ajaxRequest("POST",data,"platform/bpm/clientbpmoperateaction/dosubmit","json","submitBack");
					}
					parent.$('#userselectdialog').dialog('close');
				}
			} else if(nextActivityType == 'task'){
				//非分支  && 意见不能填写写 && 不显示选人框  && 单人处理方式 && 自动选择用户 
				if(!conditions.isBranch()){
					//如果配置为 不能填写意见&&不显示选人框&&选人方式自动
					if (conditions.getIdeaType() == 'cannot' && !conditions.isSelectUser() &&  conditions.isUserSelectTypeAuto()) {
						//setTimeout(function(){
							var data = "taskId="+taskId+"&outcome="+outcome+"&formJson=" + getSelectedResultDataJson()+"&instanceId="+processInstanceId;
							easyuiMask();
							parent.ajaxRequest("POST",data,"platform/bpm/clientbpmoperateaction/dosubmit","json","submitBack");
							parent.$('#userselectdialog').dialog('close');
						//},3000);
					} else {
						//意见不能填写
						if (conditions.getIdeaType() == 'cannot') {
							hideCommonIdearArea();
						}
						//不需要显示选人框
						if (!conditions.isSelectUser()) {
							hideUserSelectArea();
						}
					}
				}
			}
		}else{
			if (conditions.getIdeaType() == 'cannot') {
				var data = "taskId="+taskId+"&outcome="+outcome+"&formJson=" + getSelectedResultDataJson()+"&instanceId="+processInstanceId;
				easyuiMask();
				parent.ajaxRequest("POST",data,"platform/bpm/clientbpmoperateaction/dosubmit","json","submitBack");
				parent.$('#userselectdialog').dialog('close');
			}
		}
	} else if(type == 'doretreattodraft' || type == "doretreattoactivity"){ /*退回拟稿人*/
		hideUserSelectArea();
		//意见区域显示,
//		必须填写意见
	} else if(type=='doretreattoprev'){/*退回上一步*/
		//意见区域显示,
//		必须填写意见
		if(!conditions.isBranch()){ //当前有2个以上的分支在流转时,不隐藏选人区域
			hideUserSelectArea();
		}
	} else if(type == 'dotransmit'){//转发
		
	} else if(type == 'dosupersede'){//转办
		
	} else if(type == 'doadduser'){//增发
		
	} else if(type == 'doadduserandsubmit'){//增发并提交
		
	} else if(type == 'doglobaljump'){//跳转
		
	} else if(type == 'doglobalreader'){//全局读者
		
	} else if(type == 'dotaskreader'){//全局读者
		
	} else if(type == 'doglobaltransmit'){//全局转发
		
	} else if(type == 'dowithdrawassignee'){//节点内拿回
		
	} else if(type == 'dosupplement'){//补发
		
	} else if(type =='dowithdraw'){//拿回
		//var frm = document.getElementById('selectorUser').contentWindow;
		//setTimeout(function(){
			//var getDatas = new GetDatas();
			//processSelectUserComponentEvent.eventLoadDataToSelectDataGrid(getDatas.getUserList(0),0);
		//},1000);
		hideUserSelectArea();
		return;
	} else if(type == 'dowriteidea'){//填写意见
		hideUserSelectArea();
	}else if(type == 'dostepuserdefined'){
		processSelectUserComponentEvent.eventLoadDataToSelectDataGridByUserDefined(mySelectUser,0);
		hideCommonIdearArea();
	}
	//判断意见填写区域是否显示dataJson.nextTask
	if(type != 'doretreattodraft' && type != 'doretreattoactivity' && type != 'doretreattoprev' && type != 'dowriteidea' && dataJson.nextTask!=null &&  conditions.getIdeaType() == 'cannot'){
		hideCommonIdearArea();
	}
});
/**
 * 隐藏选人区域
 */
function hideUserSelectArea(){
	//alert('hideUserSelectArea');
	var tempheight = $('#selectorUserlayout').height();
	$('#selectorUserlayout').layout("panel", "south").panel("resize",{height:tempheight});
	$('#selectorUserlayout').layout("resize");
	$('#textAreaIdeas').css('height','300px');
	$('#workflowSelectorSource').css('height','0px');
	$('#selectedResultCompel').css('height','0px');
}
/**
 * 隐藏意见区域
 */
function hideCommonIdearArea(){
	$('#selectorUserlayout').layout("panel", "south").panel("resize",{height:1});
	$('#selectorUserlayout').layout("resize");
}
/**
 * 获取 select user 结果
 * flg 是否排除工作移交判断 默认不排除， true 时不进行判断
 */
function getSelectedResultDataJson(flg){
	//是否填写意见判断
	if(!doIdeaCheck()){ 
		return;
	}
	var selectedUsers  = getSelectedUserDataJson(); //选人结果
	//判断是否必须选人
	if(!doUserSelectCheck(selectedUsers)){ 
		return;
	}
	if(type == 'dosubmit'  && conditions.getIdeaType()!='cannot'){//正常提交下,才对强制表态进行判断
		//判断是否强制表态
		if(!doIdearCompelMannerCheck()){ 
			return;
		}
	}
	var returnValue;
	if(flg){//拿回
		returnValue =  putTogetherSelectedResultDataJson(null);
	}else{
		//判断是否允许工作移交 && 是否最后一个处理人
		if(dataJson.lastDealUser && conditions.isWorkHandUser()){
			returnValue = getWorkHandUsersList();
		} else {
			returnValue =  putTogetherSelectedResultDataJson(null);
		}
	}
	return returnValue;
}
/**
 * 获取已选中的用户
 * @returns json
 */
function getSelectedUserDataJson(){
	//var frm = document.getElementById('selectorUser').contentWindow;
	if(dataJson){
		if(dataJson.nextTask){
			if(conditions.isBranch()){//分支时https://github.com/login?return_to=%2Fdouglascrockford%2FJSON-js
				try{
					var selectedUsers = new Array();
					for(var i = 0 ; i < dataJson.nextTask.length ; i++){
						var branchNo = i;//分支序号
						var dataSetSelectedUser =  $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData');
						if(dataSetSelectedUser.rows.length == 0){
							selectedUsers.push(new Array());
						} else {
							selectedUsers.push(dataSetSelectedUser.rows);
						}
					}
					return selectedUsers;
				}catch(e){
					return null;
				}
			} else {//
				try{
					var dataSetSelectedUser =  $('#selectorUserTabForTargetDataGrid_0').datagrid('getData');
					var selectedUser = dataSetSelectedUser.rows;
					var selectedUsers  = JSON.stringify(selectedUser); //选人结果
					return selectedUsers;
				}catch(e){
					return null;
				}
			}
		}
	}
}
/**
 * 流程提交
 * workhandUsers 工作移交人
 */
function putTogetherSelectedResultDataJson(workhandUsers){
	//var commonIdearFrm = document.getElementById("commonIdear").contentWindow;
	//var selectUserFrm = document.getElementById("selectorUser").contentWindow;
	var selectedUsers  = getSelectedUserDataJson(); //选人结果
	if(typeof(selectedUsers) != 'undefined'){
		try{
			selectedUsers = JSON.parse(selectedUsers);
		}catch(e){}
	} else {
		selectedUsers = null;
	}
//	alert(selectedUsers);
	var ideaValue = $('#textAreaIdeas').val();
	if(typeof(ideaValue) == 'undefined'){
		ideaValue = '';
	}
	var selectedUserAndIdea;
	if (conditions.isBranch()) {
//		var users = [{selectedUsers: selectedUsers,targetActivityName:targetActivityName,outcome:outcome,workhandUsers:workhandUsers},{selectedUsers: selectedUsers,targetActivityName:targetActivityName,outcome:outcome,workhandUsers:workhandUsers}]
		var users = new Array();
		for(var i = 0 ; i < dataJson.nextTask.length ; i++){
			var branchNo = i;//分支序号
			var dataSetSelectedUser =  $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData');
			var branch = {
					selectedUsers : dataSetSelectedUser.rows,
					targetActivityName : dataJson.nextTask[branchNo].currentActivityAttr.activityName,
					outcome : outcome,
					workhandUsers : workhandUsers
			};
			users.push(branch);
		}
	 	selectedUserAndIdea = {
    		users: users,
    		compelManner : $('#ideaCompelManner').val(),
    		idea: ideaValue,
			outcome: outcome
		}; 
	}else{
		var _t = targetActivityName;
		if(dataJson.nextTask != null && dataJson.nextTask.length > 0){
			_t = dataJson.nextTask[0].currentActivityAttr.activityName;
		}
		selectedUserAndIdea = {
			//users : [{selectedUsers: selectedUsers,targetActivityName:targetActivityName,outcome:outcome,workhandUsers:workhandUsers}],
			users : [{selectedUsers: selectedUsers,targetActivityName:_t,outcome:outcome,workhandUsers:workhandUsers}],
    		idea: ideaValue,
    		compelManner : $('#ideaCompelManner').val(),
			outcome: outcome
		};
	}

	//转换为字符串
	var jsonString = JSON.stringify(selectedUserAndIdea);
	return jsonString;
}
/**
 * 判断是否必须选人
 * @returns {Boolean}
 */
function doUserSelectCheck(selectedUsers){
	if(conditions.isBranch()){ //分支 选人判断
		if(typeof(selectedUsers) != 'undefined' && selectedUsers instanceof Array){
			var getDatas = new GetDatas();
			
			//拼接必填用户的分支页签字符串
			var mustUserTabs = "";
			for(var i = 0 ; i < getDatas.getBranchLength() ; i++){
				if(conditions.isMustUser(i)){ 
					mustUserTabs += "【"+dataJson.nextTask[i].currentActivityAttr.activityAlias+"】"
				}
			}
			
			for(var i = 0 ; i < getDatas.getBranchLength() ; i++){
				var selectedUser = selectedUsers[i];
				if(selectedUser){
					if(!isSelectUserCheck(selectedUser,i,mustUserTabs)){
						return false;
					}
				}
			}
			return true;
		} else {
			$.messager.alert('提示','请选择流程处理人。','error');
			return false;
		}
	} else { //非分支
		if (typeof(type) != 'undefined' && type != null && type == "dosubmit") { //正常提交
			if(dataJson.lastDealUser){//最后一个处理人
				var nextActivityType = dataJson.activityType; //下一节点是否task节点
				if (typeof(nextActivityType) != 'undefined' && nextActivityType != null && nextActivityType == "task") {
					return isSelectUserCheck(selectedUsers);
				}else if (nextActivityType != null && nextActivityType == "sub-process") { //子流程
					var nextIsMustUser = dataJson.nextTask[0].currentActivityAttr.isMustUser;
					if(nextIsMustUser!=null && nextIsMustUser=="yes"){ 
						return isSelectUserCheck(selectedUsers);
					}
				}else if (nextActivityType != null && nextActivityType == "foreach") { //循环节点
					var nextIsMustUser = dataJson.nextTask[0].currentActivityAttr.isMustUser;
					if(nextIsMustUser != null && nextIsMustUser=="yes"){ 
						return isSelectUserCheck(selectedUsers);
					}
				}
			} else {//不是最后一个处理人
				return true;
			}
		}else if(typeof(type) != 'undefined' && type !=null && (type == "doretreattoprev" || type == "dowithdraw")){//退回上一步,拿回流程
			var curExecutionNum = dataJson.curExecutionNum;
			if(typeof(curExecutionNum) != 'undefined' && curExecutionNum != null && parseInt(curExecutionNum) == 1){ //分支情况下，最后一个拿回时
				if (selectedUsers == null || selectedUsers == "" || selectedUsers == "[]") {
					$.messager.alert('提示','请选择流程处理人。','error');
	            	return false;
	         	}
			}
		}else if(typeof(type) != 'undefined' && type != null && ( type == "dotransmit" || type == "dosupersede" || type == "doadduser" || type == "doadduserandsubmit" || type == "doglobaljump" || type == "doglobalreader" || type == "dotaskreader" || type == "doglobaltransmit" || type == "doretreattodraft" || type == "doretreattoactivity" || type == "dosupplement")){//转发，转办,增发,跳转, 全局读者，全局转发,退回拟稿人,补发
			if (selectedUsers == null || selectedUsers == "" || selectedUsers == "[]") {
	        	$.messager.alert('提示','请选择流程处理人。','error');
	            return false;
	         }else if(type == "dosupersede" && JSON.parse(selectedUsers).length > 1){
	        	 $.messager.alert('提示','只能选择一个处理人。','error');
	        	 return false;
	         }
		}
	}
	return true;
}
/**
 * 是否必须选人
 */
function isSelectUserCheck(selectedUsers,branchNo,mustUserTabs){
	if(typeof(branchNo) == 'undefined'){
		branchNo = 0;
	}
	if(conditions.isBranch()){//分支判断
		if(conditions.isMustUser(branchNo)){//判断是否必须选人
			var curDealType = conditions.getDealType(branchNo);
			var single = conditions.getSingle(branchNo);
			if (curDealType == "1" || curDealType == "3") { //单人处理1，多人任意3
				//alert('单人处理1，多人任意3 selectedUsers = ' + selectedUsers);
				if (selectedUsers == null || selectedUsers == "" || selectedUsers == "[]") {
					if (typeof(mustUserTabs) != 'undefined') {
						$.messager.alert('提示',mustUserTabs+'必须选人。','error');	
					} else {
						$.messager.alert('提示','请选择流程处理人。','error');
					}
					return false;
				}
			}else if (curDealType == "2" || curDealType == "4") { //多人顺序2，多人并行4
				var curIsLastDealUser = dataJson.lastDealUser;
				if (curIsLastDealUser != null && (curIsLastDealUser == true || curIsLastDealUser == "true")) { //该人是最后1个处理人
					if (selectedUsers == null || selectedUsers == "" || selectedUsers == "[]") {
						if (typeof(mustUserTabs) != 'undefined') {
							$.messager.alert('提示',mustUserTabs+'必须选人。','error');	
						} else {
							$.messager.alert('提示','请选择流程处理人。','error');
						}
						return false;
					}else if(curDealType == "4" && single == "yes" && JSON.parse(selectedUsers).length > 1){
						if (typeof(mustUserTabs) != 'undefined') {
							$.messager.alert('提示',mustUserTabs+'只允许选择一个流程处理人。','error');	
						} else {
							$.messager.alert('提示','只允许选择一个流程处理人。','error');
						}
						return false;
					}
				}
			}
		}
	} else {//非分支
		var curDealType = conditions.getDealType(branchNo);
		var single = conditions.getSingle(branchNo);
		if (curDealType == "1" || curDealType == "3") { //单人处理1，多人任意3
			//alert('单人处理1，多人任意3 selectedUsers = ' + selectedUsers);
			if (selectedUsers == null || selectedUsers == "" || selectedUsers == "[]") {
				$.messager.alert('提示','请选择流程处理人。','error');
				return false;
			}
		}else if (curDealType == "2" || curDealType == "4") { //多人顺序2，多人并行4
			//alert('curDealType == "2/3" selectedUsers = ' + selectedUsers);
			var curIsLastDealUser = dataJson.lastDealUser;
			if (curIsLastDealUser != null && (curIsLastDealUser == true || curIsLastDealUser == "true")) { //该人是最后1个处理人
				if (selectedUsers == null || selectedUsers == "" || selectedUsers == "[]") {
					$.messager.alert('提示','请选择流程处理人。','error');
					return false;
				}else if(curDealType == "4" && single == "yes" && JSON.parse(selectedUsers).length > 1){
					$.messager.alert('提示','只允许选择一个流程处理人。','error');
					return false;
				}
			}
		}
	}
	return true;
}
/**
 * 是否填写意见判断
 * @returns {Boolean}
 */
function doIdeaCheck(){
	//var frm = document.getElementById("commonIdear").contentWindow;
	var curIdeaType = conditions.getIdeaType(); //意见处理类型
	var splitFlag = dataJson.currentActivityAttr.splitFlag; //是否是分支调用，true表示是，false表示否
	if (typeof(type) == 'undefined' || type != null && type == "dosubmit") { //正常提交
		if (typeof(splitFlag) == 'undefined' || splitFlag == null || splitFlag == "false" || splitFlag== false) { //非分支情况下
			var ideaValue = $('#textAreaIdeas').val();
  			if (curIdeaType == "must" && (typeof(ideaValue) == 'undefined' || ideaValue == null || ideaValue == '')) {
  				$.messager.alert('提示','请填写意见后再提交!','error');
        		return false;
			}
		}
	}else if(typeof(type) != 'undefined' && type!=null && type == "dowithdraw" ){//流程拿回
		//可填可不填
		return true;
	}else if(typeof(type) != 'undefined' && type !=null  && (type == "dotransmit" || type == "dosupersede" || type == "doadduser" || type == "doadduserandsubmit" || type == "doglobaljump" || type == "doglobalreader" || type == "dotaskreader" || type == "doglobaltransmit" || type == "dosupplement")){//转发，转办,增发,跳转, 全局读者，全局转发,补发
	 	//可填可不填 
		return true;
	} else if(typeof(type) != 'undefined' && type!=null && (type == 'doretreattodraft' || type == 'doretreattoactivity' || type == 'doretreattoprev')){//退回拟稿人,退回上一步,必须填写意见
		if(conditions.isNeedIdea()){
			var ideaValue = $('#textAreaIdeas').val();
			if (typeof(ideaValue) == 'undefined' || ideaValue == null || ideaValue == '') {
		    	$.messager.alert('提示','请填写意见后再提交!','error');
		    	return false;
			}
		}
	}
	return true;
}
/**
 * 是否强强制表态
 * @returns {Boolean}
 */
function doIdearCompelMannerCheck(){
	if($('#bottomFrame').css('height') == '0px'){//如果意见不能填写,不再继续判断强制表态
		return true;
	}
	//var frm = document.getElementById("commonIdear").contentWindow;
	var idearCompelMannerValue = $('#ideaCompelManner').val();
	if(conditions.isIdeaCompelManner() && idearCompelMannerValue == ''){
		$.messager.alert('提示','强制表态不允许为空!','error');
		return false;
	}
	return true;
}
/**
 * 获取工作移交usersList
 * @returns {String}
 */
function getWorkHandUsersList(){
	var selectedUsers = getSelectedUserDataJson();
	if(typeof(selectedUsers) == 'undefined' || selectedUsers == '[]'){
		selectedUsers = '';
	}
	if(selectedUsers instanceof Array){
		var selectedUsersArray = new Array();
		for(var i = 0 ; i < selectedUsers.length ; i++){
			selectedUsersArray.push(selectedUsers[i][0]);
		}
		var selectedUsers = JSON.stringify(selectedUsersArray);
	}
	var returnValue;
	if(selectedUsers != '' && typeof(selectedUsers) != ""){
		$.ajax({
			   type: "POST",
			   url: getPath2() + '/platform/user/bpmSelectUserAction/getWorkHandUsers',
			   async: false,
			   data: {userList:selectedUsers, processKey: processKey},
			   dataType: 'json',
			   success: function(workHandUsersList){
			     if(workHandUsersList && workHandUsersList.length > 0){
			    	$('#processSubimt').linkbutton('disable');
			    	$('#close').linkbutton('disable');
			    	var usd = new UserSelectDialog('workflowWorkhandDialog','550','300',getPath2() + '/platform/user/bpmSelectUserAction/getWorkHandSelectUser?userList=' + encodeURI(encodeURI(JSON.stringify(workHandUsersList))),'工作移交选人窗口');
			 		var buttons = [{
			 			text:'提交',
			 			id : 'workhandSubmit',
			 			//iconCls : 'icon-submit',
			 			handler:function(){
			 				$('#workhandSubmit').linkbutton('disable');
			 				easyuiMask();
			 				var frmId = $('#workflowWorkhandDialog iframe').attr('id');
			 				var frm = document.getElementById(frmId).contentWindow;
			 				var workhandUsers = frm.$('#workhandDataGrid').datagrid('getData').rows;
			 				returnValue =  putTogetherSelectedResultDataJson(workhandUsers);
			 				var seleUserJson = returnValue;
//			 				var data = "procinstDbid=" + processInstanceId + "&instanceId=" + processInstanceId +"&taskId=" + taskId + "&outcome=" + outcome + "&executionId="+executionId+"&userJson="+seleUserJson;
			 				var data = {procinstDbid:processInstanceId,instanceId:processInstanceId,taskId:taskId,outcome:outcome,executionId:executionId,userJson:seleUserJson,activityName:targetActivityName,opType:type};
			 				//ajaxRequest("POST",data,doSubmitUrl,"json","parent." + doSubmitCallEvent);
			 				//工作移交情况下，流程提交的后处理 start
			 				var _t = targetActivityName;
			 				if(dataJson.nextTask != null && dataJson.nextTask.length > 0){
			 					_t = dataJson.nextTask[0].currentActivityAttr.activityName;
			 				}
		 					ajaxRequest("POST",data,doSubmitUrl,"json","parent." + doSubmitCallEvent);
							//工作移交情况下，流程提交的后处理 end
			 				usd.close();
			 			}
			 		}];
			 		usd.createButtonsInDialog(buttons);
			 		usd.show(); 
			     } else {
			    	 returnValue =  putTogetherSelectedResultDataJson(null);
			     }
			   },
			   error : function(msg){
				   $.messager.alert('错误',msg,'error');
				   return ;
			   }
		});
	}else {
		returnValue =  putTogetherSelectedResultDataJson(null);
    }
	return returnValue;
}
/**
 * 临时保存到cookie
 */
function tempSaveToCookie(){
	//常用意见保存到cookie
	//var frm = document.getElementById("commonIdear").contentWindow;
	var ideasValue = $("#textAreaIdeas").val();
	saveToCookieTip();
	$.cookie(settings.saveToCookieKey,ideasValue,{expires: 10});
}
/**
 * 为意见输入框绑定事件，输入框改变后调用方法使“暂存”按钮可用
 */
$(function(){
	var tempIEOnload = true;
	$("#textAreaIdeas").on("change input propertychange", function(event){
		if(event.type == "propertychange"){
			if(tempIEOnload){
				tempIEOnload = false;
				return;
			}
		}
		window.parent.enableTmpSave();
	});
});


/**
 * 获取数据
 */
function GetDatas(){
	this.getBranchLength = function(){
		return dataJson.nextTask.length;
	};
	this.getOrgList = function(branchNo){
		if(dataJson.nextTask[branchNo].orgList == null){
			return new Array();
		}
		return dataJson.nextTask[branchNo].orgList;
	};
	this.getDeptList = function(branchNo){
		if(dataJson.nextTask[branchNo].deptList == null){
			return new Array();
		}
		return dataJson.nextTask[branchNo].deptList;
	};
	this.getUserList = function(branchNo){
		if(dataJson.nextTask[branchNo].userList == null){
			return new Array();
		}
		return dataJson.nextTask[branchNo].userList;
	};
	this.getGroupList = function(branchNo){
		if(dataJson.nextTask[branchNo].groupList == null){
			return new Array();
		}
		return dataJson.nextTask[branchNo].groupList;
	};
	this.getRoleList = function(branchNo){
		if(dataJson.nextTask[branchNo].roleList == null){
			return new Array();
		}
		return dataJson.nextTask[branchNo].roleList;
	};
	this.getPositionList = function(branchNo){
		if(dataJson.nextTask[branchNo].positionList == null){
			return new Array();
		}
		return dataJson.nextTask[branchNo].positionList;
	};
	this.getNextActivityAlias = function(branchNo){
		if(typeof(branchNo) == 'undefined'){
			branchNo = 0;
		}
		return dataJson.nextTask[branchNo].currentActivityAttr.activityAlias;
	};
	/**
	 *  从流程引擎中读取上次流经当前节点时的用户
	 */
	this.getAutoGetSysUsers = function(branchNo){

		$.ajax({
			   type: "GET",
			   url: getPath2() + '/platform/user/bpmSelectUserAction/getAutoGetSysUsers',
			   async: false,
//			   data: 'userList=' + JSON.stringify(selectedUsers),
			   data: 'executionId=' + executionId + '&targetActivityName=' + targetActivityName,
			   dataType: 'json',
			   success: function(userList){
			      if(userList && userList.length > 0){
			    	  for(var i = 0 ; i< userList.length ; i++){
			    		  var record = {
			    		    		userId : userList[i].id,
			    		    		userName : userList[i].name,
			    		    		deptId : userList[i].deptId,
			    		    		deptName : userList[i].deptName
			    				};
			    		 processSelectUserComponentEvent.eventAppendToSelectorTargetDataGrid(branchNo,record);
			    	  }
			      }
			   },
			   error : function(msg){
				   $.messager.alert('错误',msg,'error');
				   return ;
			   }
		});
	};
}


/**
 * 绘制第二层
 */
function drawSecondLayerTabs(data,tabs,branchNo){
	
	var drawer = new Drawer(branchNo);
	var tabNo = 0;
	if(data.deptList != null && (data.deptList.length > 0 || data.orgList.length > 0)){//绘制部门标签页
		drawer.drawTab(tabs,'tabs_departmentTree_' + branchNo , '部门' ,'departmentTree_' + branchNo , 'icon-department');
		if(data.orgList.length > 0){
			drawer.drawOrgTabContent(data.orgList,'departmentTree_' + branchNo,tabNo++);//绘制部门标签页内容
		} else if(data.deptList.length > 0){
			drawer.drawDepartmentTabContent(data.deptList,'departmentTree_' + branchNo,branchNo);//绘制部门标签页内容
		}
		
	}
	if(data.userList != null && data.userList.length > 0){//绘制用户标签页
		drawer.drawTab(tabs,'tabs_userDataGrid_' + branchNo , '用户' ,'userDataGrid_' + branchNo , 'icon-users');
		drawer.drawUserTabContent(data.userList,'userDataGrid_' + branchNo,tabNo++);//绘制用户标签页内容
//		loadDataForTargetDataGrid_UserList(branchNo,data.userList);//如果是自动选人方式,加载用户dataGrid数据到target DataGrid
	}
	if(data.roleList != null && data.roleList.length > 0){//绘制角色标签页
		drawer.drawTab(tabs,'tabs_roleTree_' + branchNo , '角色' ,'roleTree_' + branchNo , 'icon-role');
		drawer.drawRoleTabContent(data.roleList,'roleTree_' + branchNo,tabNo++);//绘制角色标签页内容
	}
	if(data.positionList != null && data.positionList.length > 0){//绘制岗位标签页
		drawer.drawTab(tabs,'tabs_positionTree_' + branchNo , '岗位' ,'positionTree_' + branchNo , 'icon-position');
		drawer.drawPositionTabContent(data.positionList,'positionTree_' + branchNo,tabNo++);//绘制角色标签页内容
	}
	if(data.groupList != null && data.groupList.length > 0){//绘制群组标签页
		drawer.drawTab(tabs,'tabs_groupTree_' + branchNo , '群组' ,'groupTree_' + branchNo , 'icon-group');
		drawer.drawGroupTabContent(data.groupList,'groupTree_' + branchNo,tabNo++);//绘制群组标签页内容
	}
	//选中第一标签页
	tabs.tabs('select',0);
}

/**
 * 绘制
 * @returns
 */
function Drawer(branchNo){
	
	var createComponent = new CreateComponent(branchNo);
	/**
	 * 创建tab
	 * @param tabs
	 * @param tabId
	 * @param tabTitle
	 * @param contentId
	 * @param iconCls
	 */
	this.drawTab = function(tabs,tabId,tabTitle,contentId,iconCls){
		var contentStr = 
			'<div id="' + contentId + '_content" class="easyui-layout" fit="true">' +
               '<div region="center" style="overflow: hidden;">' +
		         '<div id="' + contentId + '" branchNo="' + branchNo + '" style="width: 100%; height: 100%;"></div>' +
		       '</div>' +
		    '</div>';
		tabs.tabs('add',{  
			id : tabId,
		    title: tabTitle,
		    fit: true,
		    closable:false,
		    content : contentStr,
		    iconCls : iconCls
		});
	};
	/**
	 * 绘制组织标签
	 */
	this.drawOrgTabContent = function(data,objectId,tabNo){
//		var datas = [];
//		var ids = '';
//		for(var i = 0 ; i< data.length ; i++){
//			var jsonData = {
//					id : data[i].id,
//					text: data[i].name,
//					state: 'closed',
//					nodeType : 'org',
//					iconCls : 'icon-org',
//					attributes : {
//						nodeType : 'org',
//						expandFlag : ''
//					}
//			};
//			ids += data[i].id + ',';
//			datas[i] = jsonData;
//		}
//		var beforeExpandUrl = '/platform/user/bpmSelectUserAction/dept?';
//		createComponent.createTreeComponent(objectId,datas,'',beforeExpandUrl,tabNo,'org');
		var ids = '';
		for(var i = 0 ; i< data.length ; i++){
			if(i < data.length - 1){
				ids += data[i].id + ',';
			}else{
				ids += data[i].id;
			}
		}
		var beforeExpandUrl = '/platform/user/bpmSelectUserAction/dept?';
		var treeUrl =  beforeExpandUrl + 'nodeType=rootOrg&id=&para=' + ids;
		createComponent.createTreeComponent(objectId,null,treeUrl,beforeExpandUrl,tabNo,'org');
		//绘制搜索input
		createComponent.createSearchInputComponent(objectId,'org',ids,branchNo);
	};
	/**
	 * 绘制部门标签
	 */
	this.drawDepartmentTabContent = function(data,objectId,tabNo){
		var ids = '';
		for(var i = 0 ; i< data.length ; i++){
			if(i < data.length - 1){
				ids += data[i].id + ',';
			}else{
				ids += data[i].id;
			}
		}
		var beforeExpandUrl = '/platform/user/bpmSelectUserAction/dept?';
		var treeUrl =  beforeExpandUrl + 'nodeType=root&id=&para=' + ids;
		var object = $('#' + objectId);
		createComponent.createTreeComponent(objectId,null,treeUrl,beforeExpandUrl,tabNo,'dept');
		//绘制搜索input
		createComponent.createSearchInputComponent(objectId,'dept',ids,branchNo);
	};
	/**
	 * 绘制用户标签内容
	 */
	this.drawUserTabContent = function(data,objectId,tabNo){
		var object = $('#' + objectId);
		object.datagrid({
			fit: true,
			fitColumns: true,
			nowrap:false,
			idField:'userId',
			rownumbers:true,
			frozenColumns:[[
	            {field:'ck',checkbox:true}
			]],
			columns:[[
				{field:'id',title:'用户ID',width:120,align:'center',hidden : true },
				{field:'name',title:'姓名',width:120,align:'left'},
				{field:'deptName',title:'部门',width:120,align:'left'},
				{field:'deptId',title:'部门ID',width:120,align:'center',hidden : true},
			]],
			onCheck : function(rowIndex,rowData){
				if(getRecordIndexInTargetDataGrid(rowData.id,branchNo) == -1){//目标dataGrid 重复判断
	    			var record = {
	    		    		userId : rowData.id,
	    		    		userName : rowData.name,
	    		    		deptId : rowData.deptId,
	    		    		deptName : rowData.deptName
	    				};
	    			processSelectUserComponentEvent.eventAppendToSelectorTargetDataGrid(branchNo,record);
//	    			$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('appendRow',record);	    		
	    		}
			},
			onUncheck : function(rowIndex,rowData){
				try{
					var index = getRecordIndexInTargetDataGrid(rowData.id,branchNo);
					$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('deleteRow', index);
				}catch(e){

				}
				
			},
			onSelectAll : function(rows){
				if(rows.length > 0){
					for(var i = 0 ; i < rows.length; i++){
						var record = {
		    		    		userId : rows[i].id,
		    		    		userName : rows[i].name,
		    		    		deptId : rows[i].deptId,
		    		    		deptName : rows[i].deptName
		    			};
						processSelectUserComponentEvent.eventAppendToSelectorTargetDataGrid(branchNo,record);
					}
				}
			},
			onUnselectAll : function(rows){
				try{
					if(rows.length > 0){
						for(var i = 0 ; i < rows.length; i++){
							var index = getRecordIndexInTargetDataGrid(rows[i].id,branchNo);
							$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('deleteRow', index);
						}
					}
				}catch(e){

				}
				
			}
		});
		//为用户 dataGrid追加数据
		for(var i = 0 ; i< data.length ; i++){
			object.datagrid('appendRow',{
				id : data[i].id,
				name : data[i].name,
				deptName : data[i].deptName,
				deptId : data[i].deptId
			});
		}
	};
	/**
	 * 绘制角色标签页
	 */
	this.drawRoleTabContent = function(data,objectId,tabNo){
		var datas = [];
		var ids = '';
		for(var i = 0 ; i< data.length ; i++){
			var jsonData = {
					id : data[i].id,
					text: data[i].name,
					state: 'closed',
					nodeType : 'role',
					iconCls : 'icon-role',
					attributes : {
						nodeType : 'role',
						expandFlag : ''
					}
			};
			datas[i] = jsonData;
			ids += data[i].id + ',';
		}
		var beforeExpandUrl = '/platform/user/bpmSelectUserAction/role?';
		createComponent.createTreeComponent(objectId,datas,'',beforeExpandUrl,tabNo,'role');
		//绘制搜索input
		createComponent.createSearchInputComponent(objectId,'role',ids,branchNo);
	};
	/**
	 * 绘制岗位标签页
	 */
	this.drawPositionTabContent = function(data,objectId,tabNo){
		var datas = [];
		var ids = '';
		for(var i = 0 ; i< data.length ; i++){
			var jsonData = {
					id : data[i].id,
					text: data[i].name,
					state: 'closed',
					nodeType : 'position',
					iconCls : 'icon-position',
					attributes : {
						nodeType : 'position',
						expandFlag : ''
					}
			};
			datas[i] = jsonData;
			ids += data[i].id + ',';
		}
		var beforeExpandUrl = '/platform/user/bpmSelectUserAction/position?';
		createComponent.createTreeComponent(objectId,datas,'',beforeExpandUrl,tabNo,'position');
		//绘制搜索input
		createComponent.createSearchInputComponent(objectId,'position' , ids,branchNo);
	};
	/**
	 * 绘制群组标签内容
	 */
	this.drawGroupTabContent = function(data,objectId,tabNo){
		var datas = [];
		var ids = '';
		for(var i = 0 ; i< data.length ; i++){
			var jsonData = {
					id : data[i].id,
					text: data[i].name,
					state: 'closed',
					nodeType : 'group',
					iconCls : 'icon-group',
					attributes : {
						nodeType : 'group',
						expandFlag : ''
					}
			};
			datas[i] = jsonData;
			ids += data[i].id + ',';
		}
		var beforeExpandUrl = '/platform/user/bpmSelectUserAction/group?';
		createComponent.createTreeComponent(objectId,datas,'',beforeExpandUrl,tabNo,'group');
		//绘制搜索input
		createComponent.createSearchInputComponent(objectId,'group',ids,branchNo);
	};
}

var _checkflg = new Object();
/**
 * create
 * @param branchNo
 * @returns
 */
function CreateComponent(branchNo){
	/**
	 *  创建树组件
	 * @param objectId tree id
	 * @param datas 表态数据
	 * @param treeUrl tree url 
	 * @param beforeExpandUrl tree展开前url
	 * @param tabNo 第二层页签no
	 */
	this.createTreeComponent = function(objectId,datas,treeUrl,beforeExpandUrl,tabNo,type){
		var object = $('#' + objectId);
		
		var baseUrl = '';
		if(treeUrl != ''){
			baseUrl = getPath2() + treeUrl;
		}
		//改为一个初始化方法，多个会引起问题 modify by xingc
		object.tree({
			url : baseUrl,
			data : datas,
			checkbox : true,
		    lines : true,
		    method : 'post',
			onBeforeExpand:function(node,param){
				var para = node.attributes.para;
				if(typeof(para) == 'undefined'){
					para = '';
				}
				if(type == 'dept'){
					object.tree('options').url = getPath2() + beforeExpandUrl + 'nodeType=' + node.attributes.nodeType +'&para=' + para + '&secretLevel='+secretLevel + '&filterUser='+filterUser;
				} else {
					object.tree('options').url = getPath2() + beforeExpandUrl + 'nodeType=' + node.attributes.nodeType +'&para=' + para + '&secretLevel='+secretLevel + '&filterUser='+filterUser;
				}
				_checkflg[node.id] = true;
		    },
		    onExpand : function(node){
		    	_checkflg[node.id] = false;
		    	if(node.attributes.expandFlag == '' || node.attributes.expandFlag == ""){
		    		processSelectUserComponentEvent.eventSelectedTreeNodeExpand(object,node,branchNo);
		    		node.attributes.expandFlag = 'expanded';
		    	}
		    },
		    onCheck : function(node,checked){
		    	if(node.attributes.nodeType == 'user'){//判断是用户的节点
		    		var parentNode = object.tree('getParent', node.target);
		    		if(_checkflg[parentNode.id]){
		    			return;
		    		}
		    		processSelectUserComponentEvent.selectedTreeUserNodeToTargetDataGrid(node,checked,branchNo);
		    		
//		    		processSelectUserComponentEvent.refreshSelectedTree(branchNo);
		    	} else if(node.attributes.nodeType == 'dept' || node.attributes.nodeType == 'role' || node.attributes.nodeType == 'position' || node.attributes.nodeType == 'group'){
		    		if(conditions.getDealType(branchNo) == 1){
		    			checked = false;
		    		}
		    		//岗位自动选人时有问题，仿照6322屏蔽这段代码
//		    		if(checked){
//		    			$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid({
//		    				url : getPath2() + '/platform/user/bpmSelectUserAction/dept?nodeType=deptUser&id=' + node.id + '&para=&secretLevel=' + secretLevel
//		    			});
//		    		
//		    		} else {
		    			//第一次调用getChildren方法会报错，可能easyui的本身的bug modify by xingc
			    		var subNodes;
						try {
							subNodes = object.tree('getChildren', node.target);
						} catch (e) {
							// TODO: handle exception
						}
						if(subNodes){
							for(var i = 0 ; i < subNodes.length ; i++){
				    			var isLeaf = object.tree('isLeaf',subNodes[i].target);
			    	    		if(isLeaf){
			    	    			processSelectUserComponentEvent.selectedTreeUserNodeToTargetDataGrid(subNodes[i],checked,branchNo);
			    	    		}
				    		}
							processSelectUserComponentEvent.refreshSelectedTree(branchNo);
						}
//		    		}
		    	}
		    },
		    onBeforeCheck : function(node,checked){
		    	//选中之前,判断是否在target dataGrid中存在,如果存,不允许选择(return false)
		    	if(checked && processSelectUserComponentEvent.eventCheckIsHaveForTargetDataGrid(branchNo,node.id)){
		    		//alert('该用户【' + node.text + '】已经选择');
		    		return false;
		    	}
		    	if(checked && conditions.getDealType(branchNo) == 1){
		    		if(node.attributes.nodeType == 'user'){//判断是用户的节点
		    			var checkedDatas = object.tree('getChecked');
						if (checkedDatas.length > 0){
							for(var k = 0 ; k < checkedDatas.length ; k++){
								if(checkedDatas[k].id == node.id){
									object.tree('uncheck', checkedDatas[k].target);
								}
							}
						}
			    	} else if(node.attributes.nodeType == 'dept'){
			    		return false;
			    	}
		    	}
		    	//当树节点是关闭状态的时候才触发
		    	if(checked && node.state=='closed'){
		    		
		    		if(node.attributes.nodeType == 'dept'){
		    			//自动获取用户的情况下，展开节点会冲掉之前选中的数据，所以去掉了
		    			/**
		    			$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid({
		    				url : getPath2() + '/platform/user/bpmSelectUserAction/dept?nodeType=deptUser&id=' + node.id + '&para=&secretLevel=' + secretLevel
		    			});**/ 
		    		} else {
		    			object.tree('expand',node.target);
		    		}
		    		
		    	}
		    },
		    onLoadSuccess:function(node,data){
		    	//加载完树，展开根,默认只展开第一个页签的
		    	if(tabNo==0 && type != "group" && type != "role" && type != "position"){
		    		var roots = object.tree('getRoots');
			    	for(i=0;i<roots.length;i++){
			    		var tempNode = roots[i];
			    		object.tree('expand',tempNode.target);
			    	}
		    	}
		    	//加载子节点后，如果父节点已选中，则选中所有的子节点
//		    	if(node && node.checked){
//		    		var nodes = object.tree('getChildren', node.target);
//					for(var i = 0 ; i < nodes.length ; i++){
//						if(nodes[i].checked == false){
//						    object.tree('check', nodes[i].target);
//					    }
//					}
//		    	}
		    	//隐藏org前面的checkbox
		    	$(this).find(".icon-org").next('span.tree-checkbox').hide();
		    }
		});
		if(tabNo==0 && (type == "group" || type == "role" || type == "position")){
    		var roots = object.tree('getRoots');
	    	for(i=0;i<roots.length;i++){
	    		var tempNode = roots[i];
	    		object.tree('expand',tempNode.target);
	    	}
    	}
	};
	/**
	 * 创建搜索input
	 * @param objectId
	 */
	this.createSearchInputComponent = function(objectId,searchType,para){
		$('#' + objectId + "_content").layout('add', {region: 'north', height: 30, content: '<div class="searcher" id="searcher"><input class="searchInput" name="searcherInfo_' + objectId + '" id="searcherInfo_' + objectId + '" onblur="EventOnBlur(this)" onfocus="eventOnFocus(this)" value="按登录名/用户名/用户名称首字母进行检索.." /><div class="searchOp" title="搜索">&nbsp;&nbsp;&nbsp;</div></div>' });
		$('#searcher #searcherInfo_' + objectId).liveSearch({url: getPath2() + '/platform/user/bpmSelectUserAction/liveSearcher?searchType=' + searchType + '&para=' + para  + '&secretLevel=' + secretLevel  + '&filterUser=' + filterUser + '&branchNo=' + branchNo + '&searchInfo='});
	};
}



var processSelectUserComponentEvent = {
		/**
		 * 树中数据用户节点选中到目标DataGrid
		 */
		selectedTreeUserNodeToTargetDataGrid : function(node,checked,branchNo){
			if(checked){//选中
				var record = {
			    		userId : node.id,
			    		userName : node.text,
			    		deptId : node.attributes.deptId,
			    		deptName : node.attributes.deptName,
			    		order : 0
				};
				processSelectUserComponentEvent.eventAppendToSelectorTargetDataGrid(branchNo,record);
			} else {//反选
				var index = getRecordIndexInTargetDataGrid(node.id,branchNo);
				//增加判断 add by xingc
				if(index != -1){
					$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('deleteRow', index);
				}
			}
		},
		
		/**
		 * 刷新目标DataGrid
		 * @param branchNo
		 */
		refreshSelectedTree: function (branchNo){
			var datas = reloadDataForDataGridOrderType($('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData'));
			$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('loadData',datas);
		},
		
		/**
		 * 根据userId,校验是否在目标选择的dataGrid中存在
		 * @param branchNo
		 * @param userId
		 * @return true  : 存在
		 *         false : 不存在
		 */
		eventCheckIsHaveForTargetDataGrid : function(branchNo,userId){
			var datas = $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData');
			if(datas.rows.length > 0){
				for(var i = 0 ; i < datas.rows.length ; i++){
					if(userId == datas.rows[i].userId){
						return true;
					}
				}
			}
			return false;
		},
		/**
		 * 向目标datagrid追加数据
		 * @param branchNo
		 * @param record
		 */
		eventAppendToSelectorTargetDataGrid : function(branchNo,record){
			if(conditions.getDealType(branchNo) == 1 || type == "dosupersede"){//单人处理
				var datas = $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData');
				if(datas.rows.length > 0){
					var isRecoverFlag = confirm(type == "dosupersede"? '【转办】只能选择一个处理人,确定覆盖吗?' : '该节点为【单人处理】方式,确定要覆盖吗?');
					if(isRecoverFlag){
						//清空目标选择datagrid数据
						var data = {
								total : 0,
								rows : new Array()
						};
						$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('loadData',data);
						
						//追加数据
						record.order = -2;
						record.orderIndex = 0;
						$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('appendRow',record);
					}
					//清空select source tab标签页各控件的多余选择
//					var userIds = new Array();
//					userIds.push(record.userId);
//					unCheckedOfSelectorData(userIds,branchNo);
				} else {
					//追加数据
					record.order = -2;
					record.orderIndex = 0;
					$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('appendRow',record);
				}
			} else {
				if (record != undefined && record.userId != undefined) {
					var rowIndex = $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getRowIndex', record.userId);
					//判断是否存在，不存在才增加
					if(rowIndex == -1){
						if(typeof(record.order) == "undefined"){
							record.order = 0;
						}
						$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('appendRow',record);
					}
				}
			}
		},
		/**
		 * 树的展开事件
		 * @param node
		 */
		eventSelectedTreeNodeExpand : function(object,node,branchNo){
			//判断该节点是否为单人处理,如果不是,搜行event事件 当设置节点审批人的时候不起效果dostepuserdefined
			if(conditions.getDealType(branchNo) != '1' && conditions.isUserSelectTypeAuto(branchNo) && type != 'dostepuserdefined'){
				var nodes = object.tree('getChildren',node.target);
				for(var i = 0 ; i < nodes.length ; i++){
					object.tree('check',nodes[i].target);
					if(nodes[i].attributes.nodeType == 'org' || nodes[i].attributes.nodeType == 'dept'){
						
						var isLeaf = object.tree('isLeaf',nodes[i].target);
						if(!isLeaf){
							if(nodes[i]){
								object.tree('expand',nodes[i].target);
							} else {
								object.tree('expand',nodes[i]);
							}
						}
					}
				}
			}
		},

		/**
		 * 根据"选人方式"进行操作
		 */
		eventOfUserSelectType : function(){
			var getDatas = new GetDatas();
			for(var branchNo = 0 ; branchNo < getDatas.getBranchLength() ;branchNo++){
				if(conditions.isUserSelectTypeAuto(branchNo) && type != 'dostepuserdefined' && type != 'doretreattodraft' && type != 'doretreattoactivity' && type != 'doretreattoprev' && type != 'dowithdraw'){//选人方式 是"自动"
					if(conditions.getDealType(branchNo) == '1'){//处理方式是"单人顺序"
						if(getDatas.getOrgList(branchNo).length == 0  
								&& getDatas.getDeptList(branchNo).length == 0 	
								&& getDatas.getPositionList(branchNo).length == 0 	
								&& getDatas.getGroupList(branchNo).length == 0 	
								&& getDatas.getRoleList(branchNo).length == 0 	
								&& getDatas.getUserList(branchNo).length == 1) {
							processSelectUserComponentEvent.eventLoadDataToSelectDataGrid(getDatas.getUserList(branchNo),branchNo);
						} else {
							var stepActivityName = getDatas.getNextActivityAlias(branchNo);
							$.messager.alert('提示','节点【' + stepActivityName + '】配置错误!','error');
						}
					} else {
						processSelectUserComponentEvent.eventLoadTabsDataToSelectDataGrid(branchNo);
						processSelectUserComponentEvent.eventLoadDataToSelectDataGrid(getDatas.getUserList(branchNo),branchNo);
					}
				}
				if(type == 'doretreattodraft' || type == 'doretreattoactivity' || type == 'doretreattoprev' || type == 'dowithdraw'){//退回拟稿人/退回上一步,自动选人
					processSelectUserComponentEvent.eventLoadDataToSelectDataGrid(getDatas.getUserList(branchNo),branchNo);
				}
			}
		},
		//加载指定数据到选中的DataGrid
		eventLoadDataToSelectDataGrid : function(datas,branchNo){
			//setTimeout(function(){
				for(var i = 0 ; i< datas.length ; i++){
					var record = {
							userId : datas[i].id,
							userName : datas[i].name,
							deptName : datas[i].deptName,
							deptId : datas[i].deptId
						};
					processSelectUserComponentEvent.eventAppendToSelectorTargetDataGrid(branchNo,record);
//					$("#selectorUserTabForTargetDataGrid_" + branchNo).datagrid('appendRow',);
				}
			//},1000);
		},
		//加载流程定义审批人时指定数据到选中的DataGrid
		eventLoadDataToSelectDataGridByUserDefined : function(datas,branchNo){
			//setTimeout(function(){
				for(var i = 0 ; i< datas.length ; i++){
					var record = {
							userId : datas[i].userId,
							userName : datas[i].userName,
							deptName : datas[i].deptName,
							deptId : datas[i].deptId
						};
					processSelectUserComponentEvent.eventAppendToSelectorTargetDataGrid(branchNo,record);
//					$("#selectorUserTabForTargetDataGrid_" + branchNo).datagrid('appendRow',);
				}
			//},1000);
		},
		/**
		 * 加载tab标签页的component的数据到选中的DataGrid
		 */
		eventLoadTabsDataToSelectDataGrid : function(branchNo){
			if($('#selectorUserTabs').find('#selectorUserTab_' + branchNo + '_Content').length == 0){//非分支
				var tabs = $('#selectorUserTabs').tabs('tabs');
				for(var i = 0 ; i < tabs.length ; i++){
					 var pp = $('#selectorUserTabs').tabs('getTab',i);
					 var tabId = pp.panel('options').id;
					 if (tabId != undefined && tabId.length > 5) {
						 var contentId = tabId.substring(5, tabId.length);
						 if (contentId.indexOf("Tree_") > -1) {
							 var roots = $('#' + contentId).tree('getRoots');
							 for(var j = 0 ; j < roots.length ; j++){
								 var root = roots[j];
								 $('#' + contentId).tree('select',root.target);
								 expandAllAndCheckTreeNode(contentId,root);
							 }
						 } else if (contentId.indexOf("Grid_") > -1) {
							 $('#' + contentId).datagrid('selectAll');
						 }
					 }
				}
			} else {//分支
				var tabs = $('#selectorUserTab_' + branchNo + '_Content').tabs('tabs');
				for(var i = 0 ; i < tabs.length ; i++){
					var pp = $('#selectorUserTab_' + branchNo + '_Content').tabs('getTab',i);
					 var tabId = pp.panel('options').id;
					 if (tabId != undefined && tabId.length > 5) {
						 var contentId = tabId.substring(5, tabId.length);
						 if (contentId.indexOf("Tree_") > -1) {
							 var roots = $('#' + contentId).tree('getRoots');
							 for(var j = 0 ; j < roots.length ; j++){
								 var root = roots[j];
								 $('#' + contentId).tree('select',root.target);
								 expandAllAndCheckTreeNode(contentId,root);
							 }
						 } else if (contentId.indexOf("Grid_") > -1) {
							 $('#' + contentId).datagrid('selectAll');
						 }
					 }
				}
			}
		},
		//是否显示选人框
		eventOfIsDisplayUserSelect : function(){
			var getDatas = new GetDatas();
			for(var branchNo = 0 ; branchNo < getDatas.getBranchLength() ;branchNo++){
				if(!conditions.isSelectUser(branchNo)){
					//parent.hideUserSelectArea();
				}
			}
		}
};



/**
 * 同步树及表格下所有选中的数据为uncheck状态
 * @param userIds Array
 * @param branchNo 分支序号
 */
function unCheckedOfSelectorData(userIds,branchNo){
	//1,先获取tab页
	//2,获取tab页的ui元素
	//3,判断ui元素的类型
	//4,获取ui元素的选中的数据
	//5,使该数据为uncheck状态
	var panels = $('.panel .panel-body');
	for(var i = 0 ; i < panels.length ; i++){
		if(panels[i].id.indexOf('tabs') != -1){
			var subPanels = $('#' + panels[i].id + ' div');
			for(var j = 0 ; j < subPanels.length ; j++){
				if(typeof(subPanels[j].id) != 'undefined' && subPanels[j].id != ''){
					if($('#' + subPanels[j].id).attr('branchNo') == branchNo){
						var checkedDatas;
						try{
							if((subPanels[j].id).indexOf('Tree')!=-1){
								// tree 操作
								checkedDatas = $('#' + subPanels[j].id).tree('getChecked');
								if (checkedDatas.length > 0){
									for(var k = 0 ; k < checkedDatas.length ; k++){
										for(var m = 0 ; m < userIds.length;m++){
											if(checkedDatas[k].id == userIds[m]){
												$('#' + subPanels[j].id).tree('uncheck', checkedDatas[k].target);
											}
										}
									}
								}
							}
							if((subPanels[j].id).indexOf('Grid')!=-1){
								// dataGrid 操作
								checkedDatas = $('#' + subPanels[j].id).datagrid('getChecked');
								if (checkedDatas.length > 0){
									for(var k = 0 ; k < checkedDatas.length ; k++){
										for(var m = 0 ; m < userIds.length;m++){
											if(checkedDatas[k].id == userIds[m]){
												var index = $('#' + subPanels[j].id).datagrid('getRowIndex', checkedDatas[k]);
												$('#' + subPanels[j].id).datagrid('uncheckRow', index);
											}
										}
									}
								}
							}
						}catch(e){}
					}
				}
			}
		}
	}
}

/**
 * 循环调用,展开树的节点
 */
function expandAndCheckTreeNode(treeId,node){
	$('#' + treeId).tree('expand',node.target);
	$('#' + treeId).tree('check',node.target);
}

function expandAllAndCheckTreeNode(treeId,node){
	$('#' + treeId).tree('expandAll',node.target);
	$('#' + treeId).tree('check',node.target);
}

/**
 * 绘制目标选人dataGird
 */
function drawSecondLayerTabsForTargetDataGrid(objId,branchNo){
	$('#' + objId).datagrid({
		fit: true,
		fitColumns: true,
		remoteSort: false,
		nowrap:false,
		idField:'userId',
		loadMsg : '正在加载数据，请稍候...',
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'移除全部',
			iconCls:'icon-users-remove',
			handler:function(){
//				var datas = $('#' + objId).datagrid('getData');
//				if (datas.rows.length > 0){
//					var userIds = new Array();
//					for(var i = 0 ; i < datas.rows.length ; i++){
//						//同步树及表格下所有选中的数据为uncheck状态
//						userIds.push(datas.rows[i].userId);
//					}
//					unCheckedOfSelectorData(userIds,branchNo);
//				}
				
				var data = {
						total : 0,
						rows : new Array()
				};
				$('#' + objId).datagrid('loadData',data);
			} 
		}],
		columns:[[
			{field:'userId',title:'用户ID',width:120,align:'left' ,hidden : true},
			{field:'userName',title:'用户名',width:150,align:'left',sortable:true},
			{field:'deptId',title:'部门ID',width:120,align:'left',hidden : true},
			{field:'deptName',title:'部门',width:150,align:'left'},
			{field:'selectedType',title:'当前选中的是用户还是部门',width:120,align:'left',hidden : true},
			{field:'removeOp',title:'',width:32,align:'center',sortable:'true',formatter:function(value,row,index){
				var e =  "";
				var d = "<span class=\"user-remove\" onclick=\"removeOp('" + objId + "','" + row.userId + "'," + branchNo + ");return false;\">&nbsp;&nbsp;&nbsp;&nbsp;</span>";
				return e+d;
			}},
			{field:'orderIndex',title:'排序值',width:20,align:'left',hidden : true},
			{field:'order',title:'',width:60,align:'center',sortable:'true',formatter:function(value,row,index){
				var e =  "";
				var d = "";
				if(value == -1){//first
					d = "<span class=\"user-order-desc\" onclick=\"orderDownOp(" + value + "," + index + "," + branchNo + ")\">&nbsp;&nbsp;&nbsp;&nbsp;</span>";
				} else if(value == 0){// middle
					d = "<span class=\"user-order-asc\" onclick=\"orderUpOp(" + value + "," + index + "," + branchNo + ")\">&nbsp;&nbsp;&nbsp;&nbsp;</span><span class=\"user-order-desc\" onclick=\"orderDownOp(" + value + "," + index + "," + branchNo + ")\">&nbsp;&nbsp;&nbsp;&nbsp;</span>";
				} else if(value == 1){//last
					d = "<span class=\"user-order-asc\" onclick=\"orderUpOp(" + value + "," + index + "," + branchNo + ")\">&nbsp;&nbsp;&nbsp;&nbsp;</span>";
				}
				return e + d;
			}}
		]]
	});
}
/**
 * 向上交换排序
 * @param value
 * @param index
 * @param branchNo
 */
function orderUpOp(value,index,branchNo){
	var datas = $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData');
	if(index == 0){
		return;
	}
	var changeData = datas.rows[index];
	datas.rows[index] = datas.rows[index - 1];
	datas.rows[index - 1] = changeData;
	datas = reloadDataForDataGridOrderType(datas);
	$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('loadData',datas);
	return;
}
/**
 * 向下交换排序
 * @param value
 * @param index
 * @param branchNo
 */
function orderDownOp(value,index,branchNo){
	var datas = $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData');
	if(datas.rows.length - 1 == index){
		return;
	}
	var changeData = datas.rows[index];
	datas.rows[index] = datas.rows[index + 1];
	datas.rows[index + 1] = changeData;
	datas = reloadDataForDataGridOrderType(datas);
	$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('loadData',datas);
	return;
}
/**
 * 移除操作
 * @param objId
 * @param userId
 * @param branchNo
 * @returns {Boolean}
 */
function removeOp(objId,userId,branchNo){
	var index = getRecordIndexInTargetDataGrid(userId,branchNo);
	//$('#' + objId).datagrid('deleteRow', index);
	var userIds = new Array();
	userIds.push(userId);
	unCheckedOfSelectorData(userIds,branchNo);
	//
	var index = getRecordIndexInTargetDataGrid(userId,branchNo);
	//增加判断 add by xingc
	if(index != -1){
		$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('deleteRow', index);
	}
	
	var datas = reloadDataForDataGridOrderType($('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData'));
	$('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('loadData',datas);
	return false;
}
function reloadDataForDataGridOrderType(datas){
	if(datas.rows.length == 1){
		datas.rows[0].order = 2;
	} else {
		for(var i = 0 ; i < datas.rows.length ; i++){
			if(i == 0){
				datas.rows[i].order = -1;
			} else if(i == datas.rows.length - 1){
				datas.rows[i].order = 1;
			} else {
				datas.rows[i].order = 0;
			}
		}
	}
	return datas;
}
function eventOnFocus(obj){
    if(obj.value=="按登录名/用户名/用户名称首字母进行检索.."){
    	obj.style.color="#000000";
    	obj.value="";
     }
 }
function EventOnBlur(obj){
    if(obj.value==""){
    	obj.style.color="";
    	obj.value="按登录名/用户名/用户名称首字母进行检索..";
    }
}
/**
 * search event
 * @param obj
 * @param userId
 * @param userName
 * @param deptId
 * @param deptName
 */
function eventSearcherCheckBox(obj,userId,userName,deptId,deptName,branchNo){
	if(obj.checked){
		if(getRecordIndexInTargetDataGrid(userId,branchNo) == -1){
			var record = {
		    		userId : userId,
		    		userName : userName,
		    		deptId : deptId,
		    		deptName : deptName
				};
			processSelectUserComponentEvent.eventAppendToSelectorTargetDataGrid(branchNo,record);
		}
	}
	return;
}
/**
 * 获取数据记录在目标数据表格中的索引值
 */
function getRecordIndexInTargetDataGrid(userId,branchNo){
	var datas = $('#selectorUserTabForTargetDataGrid_' + branchNo).datagrid('getData');
	if(datas.total == 0){
		return -1;
	} else {
		for( var i = 0 ; i < datas.rows.length ; i++){
			if(userId == datas.rows[i].userId){
				return i;
			}
		}
	}
	return -1;
}

