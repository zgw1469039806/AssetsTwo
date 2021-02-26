function UserSelectView(option) {
	this.id = option.id; // 用户选择视图id
	this.topId = option.topId;
	this.template = option.template;
	this.beforeRemove = option.beforeRemove;
	this.afterRemove = option.afterRemove;
	var self = this;
	
	this.removeAll = function () {
		if(this.beforeRemove) {
			this.beforeRemove("all");
		}
		$(this.id).empty();
		if(this.afterRemove()) {
			this.afterRemove("all");
		}
	}

	/**
	 * dataId：该条记录唯一id
	 * param: 封装后的数据
	 */
	this.addObject = function(primaryId, param, errMsg) {
		// id 类型为  treeId_type_typeId_deptlevelId_positionId
		if($("#"+primaryId).length > 0) {
			if(errMsg) {
				layer.msg(errMsg);
				return;
			}
			layer.msg("已添加该条记录");
			return ;
		}
		var tmp = this.template().replace(new RegExp("\"","gm"), "'")
			.replace(/\#primaryId\#/g, primaryId)
			.replace(new RegExp("\#currentType\#","gm"), param.typeName)
			.replace(new RegExp("\#data\#","gm"), JSON.stringify(param));
		var showname = param.name;
		if(param.deptlevel) showname += "#"+param.deptlevel.deptlevelName;
		if(param.position) showname += "#"+param.position.positionName;
		if(param.step) showname += "#"+param.step.stepName;
		if(param.customfunction) showname += "#"+param.customfunction.customfunctionName;
		if(param.variable) showname += "#"+param.variable.dataTypeName+"#"+param.variable.variableAlias;
		tmp = tmp.replace(new RegExp("\#name\#","gm"), showname);
		tmp = tmp.replace(new RegExp("\#title\#","gm"), showname);
		//var e = $(this.id).append(tmp).find("#"+primaryId);
		var e = $(this.id).append(tmp).find("[id='"+primaryId+"']");
		e.on("dblclick",function(){
			self.removeObject(primaryId);
		}).find("a").on("click",function(){
			self.removeObject(primaryId);
		});
	}
	
	this.removeObject = function (primaryId) {
		if(this.beforeRemove) {
			this.beforeRemove(primaryId);
		}
		$("[id='"+primaryId+"']").remove();
		if(this.afterRemove) {
			this.afterRemove(primaryId);
		}
	}


	this.getSelectedData = function() {
		var ret = [];
		$(".userSelectedViews").each(function() {
			var userData = $(this).attr("data");
			if (userData && userData != "#data#") {
				var data = JSON.parse($(this).attr("data"));
				ret.push(data);
			}
		});
		return ret;
	}
	this.getJSONSelectedData = function() {
		return JSON.stringify(this.getSelectedData());
	}
	
	this.getPrimaryId = function (treeId, id, type, name, deptlevelId, deptlevelName, positionId, positionName,stepId,stepName,customfunctionId,customfunctionName,variableName,variableAlias,dataType,dataTypeName) {
		return treeId+"_"+type+"_"+id+(deptlevelId?"_"+deptlevelId:"") +(positionId?"_"+positionId:"")+(stepId?"_"+stepId:"")+
		(customfunctionId?"_"+customfunctionId:"")+(variableName?"_"+variableName:"");
	}

	this.getCommonNodeInfo = function(treeId, id,  name, type, typeName) {
		if(!treeId || !name || !id) {
            layer.msg("参数错误-1");
            return;
        }
        var param = {};
        param.treeId = treeId;
        param.id = id;
        param.type = type;
        if(!typeName) {
        	if(type == "user") {
        		param.typeName = "用户";
        	}
        	if(type == "position") {
        		param.typeName = "岗位";
        	}
        	if(type == "group") {
        		param.typeName = "群组";
        	}
        	if(type == "role") {
        		param.typeName = "角色";
        	}
        } else {
        	param.typeName = typeName;
        }
       
        param.name = name;
        param.primaryId = this.getPrimaryId(param.treeId,  param.id,   param.type, param.name);
        return param;
	}
	
	this.getDeptTypeNode = function(treeId, id, name,  positionId, positionName) {
		if(!treeId || !name || !id) {
            layer.msg("参数错误-1");
            return;
        }
        var param = {};
        param.treeId = treeId;
        param.id = id;
        param.type = "dept";
        param.typeName = "部门";
        param.name = name;
        if(positionId != null && positionId != ""){
        	param.position = {
        			positionId : positionId,
        			positionName : positionName
        	};
        }
        param.primaryId = this.getPrimaryId(treeId, id, param.type, name, null, null,  positionId, positionName);
        return param;
	}	
	this.getRelationNode = function(treeId, id, name,  positionId, positionName,deptlevelId,deptlevelName,stepId,stepName,customfunctionId,customfunctionName,variableName,variableAlias,dataType,dataTypeName) {
		if(!treeId || !name || !id) {
            layer.msg("参数错误-1");
            return;
        }
        var param = {};
        param.treeId = treeId;
        param.id = id;
        param.type = "relation";
        param.typeName = "关系";
        param.name = name;
        if(positionId != null && positionId != "") {
        	param.position = {
        	     positionId : positionId,
        	     positionName : positionName
        	};
        }
        if(deptlevelId) {
        	param.deptlevel = {
        			deptlevelId : deptlevelId,
        			deptlevelName : deptlevelName
           	};
        }
        if(stepId) {
        	param.step = {
        			stepId : stepId,
        			stepName : stepName
           	};
        }
        if(customfunctionId) {
        	param.customfunction = {
        			customfunctionId : customfunctionId,
        			customfunctionName : customfunctionName
           	};
        }
        if(variableName){
        	param.variable = {
        			variableName:variableName,
        			variableAlias:variableAlias,
					dataType:dataType,
					dataTypeName:dataTypeName
        	};
        }
        param.primaryId = this.getPrimaryId(treeId, id, param.type, name, deptlevelId, deptlevelName,  positionId, positionName,stepId,stepName,customfunctionId,customfunctionName,variableName,variableAlias,dataType,dataTypeName);
        return param;
	}
	
	return this;
};

function getUserList(){
	var userList = userSelectView.getSelectedData();
	var showUserList = "";
	var selectedDept = ""
	var selectedUser = "";
	var selectedPosition = "";
	var selectedRole = "";
	var selectedGroup = "";
	var selectedRelation = "";
	for(var i = 0;  i< userList.length; i++ ){
		var user = userList[i];
//		【部门】研发中心#普通员工;【用户】张三;【角色】一般用户;【群组】群组1;【岗位】普通员工;
		var type = user.type;
		if(type == "dept") {
			selectedDept += user.name+ (user.position? "#"+user.position.positionName : "")+";";
		} else if (type == "user" ) {
			selectedUser += user.name+";";
		} else if (type == "position") {
			selectedPosition +=  user.name+";";
		} else if (type == "role") {
			selectedRole += user.name + ";";
		} else if (type == "group") {
			selectedGroup += user.name + ";";
		} else if (type == "relation") {
			selectedRelation += user.name;
			if(user.deptlevel) selectedRelation += "#"+user.deptlevel.deptlevelName;
			if(user.position) selectedRelation += (user.position?"#"+user.position.positionName:"");
			if(user.step) selectedRelation += "#"+user.step.stepName;
			if(user.customfunction) selectedRelation += "#"+user.customfunction.customfunctionName;
			if(user.variable) selectedRelation += "#用户#"+user.variable.variableAlias;
			selectedRelation += ";";
		}
	}
	if (selectedDept != "") {
		selectedDept = "【部门】" + selectedDept;
		showUserList += selectedDept;
	}
	if (selectedUser != "") {
		selectedUser = "【用户】" + selectedUser;
		showUserList += selectedUser;
	}
	if (selectedPosition != "") {
		selectedPosition = "【岗位】" + selectedPosition;
		showUserList += selectedPosition;
	}
	if (selectedRole != "") {
		selectedRole = "【角色】" + selectedRole;
		showUserList += selectedRole;
	}
	if (selectedGroup != "") {
		selectedGroup = "【群组】" + selectedGroup;
		showUserList += selectedGroup;
	}
	if (selectedRelation != "") {
		selectedRelation = "【关系】" + selectedRelation;
		showUserList += selectedRelation;
	}
	var strTmp = showUserList.substring(showUserList.length-1,showUserList.length);
    if(showUserList!='' && strTmp==';'){
    	showUserList = showUserList.substring(0, showUserList.length-1);
    }
	return {userList:JSON.stringify(userList), showUserList:showUserList};
}