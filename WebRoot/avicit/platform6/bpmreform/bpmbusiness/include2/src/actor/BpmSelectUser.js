
function BpmSelectUser(actorModel,data){
	this.actorModel = actorModel;
	this.data = data;
	this.deptTreeUrl = actorModel.orgDeptTreeUrl==null || actorModel.orgDeptTreeUrl==""?
			"platform/bpmActor/bpmSelectUserAction2/dept?":actorModel.orgDeptTreeUrl;
	this.positionTreeUrl = actorModel.positionTreeUrl==null || actorModel.positionTreeUrl==""?
			"platform/bpmActor/bpmSelectUserAction2/position?":actorModel.positionTreeUrl;
	this.groupTreeUrl = actorModel.groupTreeUrl==null || actorModel.groupTreeUrl==""?
			"platform/bpmActor/bpmSelectUserAction2/group?":actorModel.groupTreeUrl;
	this.roleTreeUrl = actorModel.roleTreeUrl==null || actorModel.roleTreeUrl==""?
			"platform/bpmActor/bpmSelectUserAction2/role?":actorModel.roleTreeUrl;
	//部门主管领导，公司收发文项目
	this.deptManageTreeUrl = actorModel.deptManageTreeUrl==null || actorModel.deptManageTreeUrl==""?
		"ims/oa/bpmtest/oaBpmTestController/getManageUserDataJson?":actorModel.deptManageTreeUrl;
}

BpmSelectUser.prototype.generateLeftHtml = function(){
	var _self = this;
	var html = "";
	var showCount = 0;
	for(var i=0;i<_self.actorModel.nextTask.length;i++){
		var _nextActorModel = _self.actorModel.nextTask[i];
		if(_nextActorModel.currentActivityAttr.isSelectUser=="yes"
		   ||(_nextActorModel.activityType == "foreach" && _nextActorModel.currentActivityAttr.isMustUser == "yes")){
			showCount++;
		}
	}
	if(showCount>1){
		 html+= _self.getNodeTabHeader();
		 //UI修改多分支显示方式追加样式文件 2020-07-01
		 $("#comment-panel").addClass("multi-node");
	}
	html+=_self.getNodeTabContent();
	return html;
};

BpmSelectUser.prototype.generateRightHtml = function(){
	var _self = this;
	var showCount = 0;
	for(var i=0;i<_self.actorModel.nextTask.length;i++){
		var _nextActorModel = _self.actorModel.nextTask[i];
		if(_nextActorModel.currentActivityAttr.isSelectUser=="yes"){
			showCount++;
		}
	}
	if(showCount<2){
		$("#selectedList").attr("class","checkedbox-list full");
	}
	var html =_self.getCheckUserList();
	return html;
};

BpmSelectUser.prototype.getNodeTabHeader = function(){
	var _self = this;
	var html = "<div class='tree-nav' >\n";
	html += "	<ul>\n";
	var isClassOn = true;
	for(var i=0;i<_self.actorModel.nextTask.length;i++){
		var _nextActorModel = _self.actorModel.nextTask[i];
		html += "		<li data-for='tree-"+_nextActorModel.currentActivityAttr.activityName+"'";
		if(_nextActorModel.currentActivityAttr.isSelectUser=="yes"
			||(_nextActorModel.activityType == "foreach" && _nextActorModel.currentActivityAttr.isMustUser == "yes")){
			html += " style='display:block;' ";
		}else{
			html += " style='display:none;' ";
		}
		if(isClassOn && (_nextActorModel.currentActivityAttr.isSelectUser=="yes"
			||(_nextActorModel.activityType == "foreach" && _nextActorModel.currentActivityAttr.isMustUser == "yes"))){
			html += " class='on'";
			isClassOn = false;
		}
		html += ">";
		html += _nextActorModel.currentActivityAttr.activityAlias+"</li>\n";
	}
	html += "	</ul>\n";
	html += "</div>\n";
	return html;
};

BpmSelectUser.prototype.getNodeTabContent = function(){
	var _self = this;
	var html = "<div class='tree-nav-body' >\n";
	for(var i=0;i<_self.actorModel.nextTask.length;i++){
		var _nextActorModel = _self.actorModel.nextTask[i];
		html += "	<div id='tree-";
		html +=_nextActorModel.currentActivityAttr.activityName+"'";
		html += " class = 'tree-nav-panel' ";
		if(i==0){
			html += "style='display: block'";
		}
		html += ">\n";
		html +="		"+_self.getActorTabHeader(_nextActorModel,i);
		html +="		"+ _self.getActorTabContent(_nextActorModel);
		html += "	</div>";
	}
	html += "</div>";
	return html;
};

BpmSelectUser.prototype.getActorTabHeader = function(_nextActorModel,index){
	var _self = this;
	var html = "<div class='sub-tree-nav' >\n";
	html += "	<ul>";
	var selectedClass = "";
	if(index=='0'){
		selectedClass = "on";
	}
	//部门
	if((_nextActorModel.deptList!=null && _nextActorModel.deptList.length && _nextActorModel.deptList.length>0)
			|| (_nextActorModel.orgList!=null && _nextActorModel.orgList.length && _nextActorModel.orgList.length>0)){
		html+="		<li data-for='sub-tree-dept-"+_nextActorModel.currentActivityAttr.activityName+"' ";
		html+=" class='"+selectedClass+"'";
		html+=	">部门</li>\n";
		selectedClass = "";
	}
	//用户
	if(_nextActorModel.userList!=null && _nextActorModel.userList.length && _nextActorModel.userList.length>0){
		html+="		<li data-for='sub-tree-user-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=" class='"+selectedClass+"'";
		html+=">用户</li>\n";
		selectedClass = "";
	}
	//群组
	if(_nextActorModel.groupList!=null && _nextActorModel.groupList.length && _nextActorModel.groupList.length>0){
		html+="		<li data-for='sub-tree-group-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=" class='"+selectedClass+"'";
		html+=">群组</li>\n";
		selectedClass = "";
	}
	//角色
	if(_nextActorModel.roleList!=null && _nextActorModel.roleList.length && _nextActorModel.roleList.length>0){
		html+="		<li data-for='sub-tree-role-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=" class='"+selectedClass+"'";
		html+=">角色</li>\n";
		selectedClass = "";
	}
	//岗位
	if(_nextActorModel.positionList!=null && _nextActorModel.positionList.length && _nextActorModel.positionList.length>0){
		html+="		<li data-for='sub-tree-position-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=" class='"+selectedClass+"'";
		html+=">岗位</li>\n";
		selectedClass = "";
	}
	//部门负责人，公司收发文项目
	if(_nextActorModel.deptManageList!=null && _nextActorModel.deptManageList.length && _nextActorModel.deptManageList.length>0){
		html+="		<li data-for='sub-tree-deptManage-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=" class='"+selectedClass+"'";
		html+=">部门负责人</li>\n";
		selectedClass = "";
	}
	html += "	</ul>\n";
	html += "</div>\n";
	return html;
};
BpmSelectUser.prototype.getActorTabContent = function(_nextActorModel){
	var _self = this;
	var isShow = true;
	var html = "<div class='sub-tree-body' >\n";
	//部门
	if((_nextActorModel.deptList!=null && _nextActorModel.deptList.length && _nextActorModel.deptList.length>0)
			 || (_nextActorModel.orgList!=null && _nextActorModel.orgList.length && _nextActorModel.orgList.length>0)){
		var treeId = "orgDeptTree_"+_nextActorModel.currentActivityAttr.activityName;
		html+="	<div id='sub-tree-dept-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=" class='sub-tree-nav-panel'";
		if(isShow){
			html+=" style='display:block' ";
		}
		html+=">\n";
		html+="		"+_self.getSearchContent("orgDept",treeId,_nextActorModel);
		html+="		"+_self.getTree("orgDept", treeId, _self.deptTreeUrl, _nextActorModel);
		html+="	</div>\n";
		isShow = false;
	}
	//用户
	if(_nextActorModel.userList!=null && _nextActorModel.userList.length && _nextActorModel.userList.length>0){
		var treeId = "sub-tree-user-"+_nextActorModel.currentActivityAttr.activityName;
		html+="	<div id='"+treeId+"'";
		html+=" class='sub-tree-nav-panel' ";
		if(isShow){
			html+="style='display:block'";
		}
		html+=" data-for='cba-for-tree-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=">\n";
		html+="  <div class='userListDiv'>";
		html+="		"+_self.getSearchContent("userList",treeId,_nextActorModel);
		html+="		"+_self.getUserList(_nextActorModel);
		html+="  </div>";
		html+="	</div>\n";
		isShow = false;
	}
	//群组
	if(_nextActorModel.groupList!=null && _nextActorModel.groupList.length && _nextActorModel.groupList.length>0){
		var treeId = "groupTree_"+_nextActorModel.currentActivityAttr.activityName;
		html+="	<div id='sub-tree-group-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=" class='sub-tree-nav-panel'";
		if(isShow){
			html+=" style='display:block' ";
		}
		//html+="data-for='cba-for-tree-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=">\n";
		html+="		"+_self.getSearchContent("group",treeId,_nextActorModel);
		html+="		"+_self.getTree("group", treeId, _self.groupTreeUrl, _nextActorModel);
		html+="	</div>\n";
		isShow = false;
	}
	//角色
	if(_nextActorModel.roleList!=null && _nextActorModel.roleList.length && _nextActorModel.roleList.length>0){
		var treeId = "roleTree_"+_nextActorModel.currentActivityAttr.activityName;
		html+="	<div id='sub-tree-role-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=" class='sub-tree-nav-panel'";
		if(isShow){
			html+=" style='display:block' ";
		}
		//html+="data-for='cba-for-tree-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=">\n";
		html+="		"+_self.getSearchContent("role",treeId,_nextActorModel);
		html+="		"+_self.getTree("role", treeId, _self.roleTreeUrl, _nextActorModel);
		html+="	</div>\n";
		isShow = false;
	}
	//岗位
	if(_nextActorModel.positionList!=null && _nextActorModel.positionList.length && _nextActorModel.positionList.length>0){
		var treeId = "positionTree_"+_nextActorModel.currentActivityAttr.activityName;
		html+="	<div id='sub-tree-position-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=" class='sub-tree-nav-panel'";
		if(isShow){
			html+=" style='display:block' ";
		}
		//html+="data-for='cba-for-tree-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=">\n";
		html+="		"+_self.getSearchContent("position",treeId,_nextActorModel);
		html+="		"+_self.getTree("position", treeId, _self.positionTreeUrl, _nextActorModel);
		html+="	</div>\n";
		isShow = false;
	}
	//部门主管领导，公司收发文项目
	if(_nextActorModel.deptManageList!=null && _nextActorModel.deptManageList.length && _nextActorModel.deptManageList.length>0){
		var treeId = "deptManageTree_"+_nextActorModel.currentActivityAttr.activityName;
		html+="	<div id='sub-tree-deptManage-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=" class='sub-tree-nav-panel'";
		if(isShow){
			html+=" style='display:block' ";
		}
		//html+="data-for='cba-for-tree-"+_nextActorModel.currentActivityAttr.activityName+"'";
		html+=">\n";
		html+="		"+_self.getSearchContent("deptManage",treeId,_nextActorModel);
		html+="		"+_self.getTree("deptManage", treeId, _self.deptManageTreeUrl, _nextActorModel);
		html+="	</div>\n";
		isShow = false;
	}
	html += "</div>";
	return html;
};
BpmSelectUser.prototype.getTree = function(type,treeId,url,_nextActorModel){
	var html = "";
	html+= "<ul id='"+treeId+"' class='ztree'";
	html+=" data-for='cba-for-tree-"+_nextActorModel.currentActivityAttr.activityName+"'";
	html+="></ul>\n";
	html+= this.getTreeScript(type, treeId,url, _nextActorModel);
	return html;
};

BpmSelectUser.prototype.getTreeScript = function(type,treeId,url,_nextActorModel){
	var html = "";
	html+="<script type='text/javascript'>\n";
	html+="$(document).ready(function(){\n";
	html+=" var zNodes = "+this.getTreeZNodes(type, treeId, _nextActorModel)+";\n";
	html+=" var setting = {\n";
	html+="       check: {enable: true},\n";
	html+="       callback : {\n";
	html+="           beforeExpand:"+this.getTreeBeforeExpand(type,url,_nextActorModel)+",\n";
	html+="           onCheck:"+this.getTreeOnCheck(_nextActorModel)+",\n";
	html+="           onClick:"+this.getTreeOnClick(_nextActorModel)+",\n";
	html+="           onAsyncSuccess:"+this.getAsyncSuccess(_nextActorModel)+"\n";
	html+="       },\n";
	html+="       async: {\n";
	html+="           enable: true,\n";
	html+="           type:\"post\",";
	html+="           url: '"+url+this.getTreeParaUrl(type,_nextActorModel)+"',\n";
	html+="           autoParam:['id', 'name=n', 'level=lv'],\n";
	html+="           otherParam:{'otherParam':'zTreeAsyncTest'}\n";
	html+="       }\n";
	html+="    };\n";
	html+=" var object = $.fn.zTree.init($('#"+treeId+"'), setting, zNodes);\n";
	html+=" var activityObj = {};\n";
	html+=" activityObj.activityName = '"+_nextActorModel.currentActivityAttr.activityName+"';\n";
	html+=" activityObj.tree = object;\n";
	html+=" treeArr.push(activityObj);\n";
	html+="});\n";
	html+="</script>\n";
	return html;

};
BpmSelectUser.prototype.getTreeParaUrl = function(type,_nextActorModel){
	var html = "";
	if(type=='orgDept'){
		var ids = [];
		if(_nextActorModel.orgList!=null && _nextActorModel.orgList.length && _nextActorModel.orgList.length>0){
			html += "nodeType=rootOrg";
			for(var i = 0 ; i < _nextActorModel.orgList.length; i++){
				var org = _nextActorModel.orgList[i];
				if(org != null){
					ids.push(org.id);
				}
			}
		}else if(_nextActorModel.deptList!=null && _nextActorModel.deptList.length && _nextActorModel.deptList.length>0){
			html += "nodeType=root";
			for(var i = 0 ; i < _nextActorModel.deptList.length; i++){
				var dept = _nextActorModel.deptList[i];
				if(dept != null){
					ids.push(dept.id);
				}
			}
		}
		var orgTreeOpenToDept = _nextActorModel.currentActivityAttr.orgTreeOpenToDept;
		var orgTreeDefaultOpen = _nextActorModel.currentActivityAttr.orgTreeDefaultOpen;
		var deptTreeHideOrg = _nextActorModel.currentActivityAttr.deptTreeHideOrg;
		var secretLevel = flowUtils.notNull(this.actorModel.secretLevel)?this.actorModel.secretLevel:"";
		var filterUser = flowUtils.notNull(_nextActorModel.filterUser)?_nextActorModel.filterUser:"";

		html += "&id=&para="+encodeURIComponent(JSON.stringify(ids))
			+"&orgTreeOpenToDept="+orgTreeOpenToDept+"&orgTreeDefaultOpen="+orgTreeDefaultOpen
			+"&deptTreeHideOrg="+deptTreeHideOrg+"&secretLevel="+secretLevel+"&filterUser="+filterUser;
		//自动选人
		if(this.isUserSelectTypeAuto(_nextActorModel)){
			html += "&check=true";
		}else{
			html+= "&check=false";
		}
	}
	return html;
};

BpmSelectUser.prototype.getTreePara = function(type,_nextActorModel){
	var para = "";
	var ids = [];
	if(type=='orgDept'){
		if(_nextActorModel.orgList!=null && _nextActorModel.orgList.length && _nextActorModel.orgList.length>0){
			for(var i = 0 ; i < _nextActorModel.orgList.length; i++){
				var org = _nextActorModel.orgList[i];
				if(org != null){
					ids.push(org.id);
				}
			}
		}else if(_nextActorModel.deptList!=null && _nextActorModel.deptList.length && _nextActorModel.deptList.length>0){
			for(var i = 0 ; i < _nextActorModel.deptList.length; i++){
				var dept = _nextActorModel.deptList[i];
				if(dept != null){
					ids.push(dept.id);
				}
			}
		}
		para = encodeURIComponent(JSON.stringify(ids));
	}
	return para;
};

BpmSelectUser.prototype.getTreeBeforeExpand = function(type,url,_nextActorModel){
	var para = this.getTreePara(type,_nextActorModel);
	var secretLevel = flowUtils.notNull(this.actorModel.secretLevel)?this.actorModel.secretLevel:"";
	var filterUser = flowUtils.notNull(_nextActorModel.filterUser)?_nextActorModel.filterUser:"";
	var html = "";
	html+="function(treeId, node){\n";
	html+="	var para = node.attributes.para;\n";
	html+="	if(typeof(para) == 'undefined'){\n";
	html+=" 	para = '';\n";
	html+=" }\n";
    if(type == "orgDept"){
		html+="   object.setting.async.url = '"+url+"nodeType=' + node.attributes.nodeType +'&para="+para+"&secretLevel="+ secretLevel + "&formId=" + this.actorModel.formId + "&filterUser="+filterUser
			+"&processInstanceId="+this.data.procinstDbid+"&executionId="+this.data.executionId+"&outcome="+this.data.name+"&targetActivityName="+this.data.targetActivityName+"&taskId="+this.data.taskId+"&type="+this.data.event+"&checked='+node.checked;\n";
	}else{
		html+="   object.setting.async.url = '"+url+"nodeType=' + node.attributes.nodeType +'&para=' + para + '&secretLevel="+secretLevel + "&formId=" + this.actorModel.formId + "&filterUser="+filterUser+"&checked='+node.checked;\n";
	}
	html+="}\n";
	return html;
};

BpmSelectUser.prototype.getTreeOnCheck = function(_nextActorModel){
	var html = "";
	html+="function(event, treeId, node){\n";
	html+="     if(node.checked){\n";
	html+="    		if(node.attributes.nodeType == 'user'){\n";
	html+="       		selectorData(node,treeId,'"+_nextActorModel.currentActivityAttr.single+"','"+_nextActorModel.currentActivityAttr.dealType+"','"+_nextActorModel.currentActivityAttr.activityName+"');\n";
	html+="    		}else{\n";
	/*html+="       		var childrenNodes = node.children;\n";
	html+="       		if(childrenNodes){\n";
	html+="            		for(var i = 0 ; i < childrenNodes.length ; i++){\n";
	html+="				     var node = childrenNodes[i];\n";
	html+="				     selectorData(node,treeId,'"+_nextActorModel.currentActivityAttr.single+"','"+_nextActorModel.currentActivityAttr.dealType+"','"+_nextActorModel.currentActivityAttr.activityName+"');\n";
	html+="             	}\n";
	html+="       	  	} else {\n ";
	html+="            		$('#' + node.tId + '_switch').trigger('click');\n";
	html+="            		childrenNodes = node.children;\n";
	html+="					if(childrenNodes){\n";
	html+="            			for(var i = 0 ; i < childrenNodes.length ; i++){\n";
	html+="				     		var node = childrenNodes[i];\n";
	html+="				    	 	selectorData(node,treeId,'"+_nextActorModel.currentActivityAttr.single+"','"+_nextActorModel.currentActivityAttr.dealType+"','"+_nextActorModel.currentActivityAttr.activityName+"');\n";
	html+="             		}\n";
	html+="					}\n";
	html+="        		} \n ";*/
    html+="       		selectorNodeData(node,treeId,'"+_nextActorModel.currentActivityAttr.single+"','"+_nextActorModel.currentActivityAttr.dealType+"','"+_nextActorModel.currentActivityAttr.activityName+"');\n";
	html+="    		}\n";
	html+="    } else{\n";
	html+="    		if(node.attributes.nodeType == 'user'){\n";
	html+="       		removeEvent(node.id,treeId);\n";
	html+="    		}else{\n";
	html+="       		removeNodeCheck(node,treeId);\n";
	html+="    		}\n";
	html+="    }\n";
	html+="}\n";
	return html;
};

BpmSelectUser.prototype.getTreeOnClick = function(_nextActorModel){
	var html = "";
	html+="function(event, treeId, node){";
	html+="  var treeObj =  $.fn.zTree.getZTreeObj(treeId);\n";
	html+="  if(node.attributes.nodeType == 'user'){\n";
	html+="     treeObj.checkNode(treeObj.getNodeByParam('id', node.id, null), true, true);\n";
	html+="  }";
	//html+="  treeObj.checkNode(treeObj.getNodeByParam('id', node.id, null), true, true);\n";
	html+="  if(node.checked && node.attributes.nodeType == 'user'){";
	html+="     selectorData(node,treeId,'"+_nextActorModel.currentActivityAttr.single+"','"+_nextActorModel.currentActivityAttr.dealType+"','"+_nextActorModel.currentActivityAttr.activityName+"');";
	html+="  }\n";
	html+="  else if(!node.checked && node.attributes.nodeType == 'user'){\n";
	html+="  	removeEvent(node.id,treeId);\n";
	html+="  }";
	html+="}";
	return html;
};

BpmSelectUser.prototype.getAsyncSuccess = function(_nextActorModel){
	var html = "";
	html+="function(event, treeId, treeNode, msg){\n";
	html+="  var treeObj = $.fn.zTree.getZTreeObj(treeId);\n";
	html+="  if(treeNode && treeNode.checked && treeNode.attributes.nodeType != 'user'){\n";
/*	html+="      var childrenNodes = treeNode.children;\n";
	html+="      for(var i = 0 ; i < childrenNodes.length ; i++){\n";
	html+="			var node = childrenNodes[i];\n";
	html+="         treeObj.checkNode(node, true, true);";
	html+="     	selectorData(node,treeId,'"+_nextActorModel.currentActivityAttr.single+"','"+_nextActorModel.currentActivityAttr.dealType+"','"+_nextActorModel.currentActivityAttr.activityName+"');";
	html+="      }\n";*/
    html+="     selectorNodeData(treeNode,treeId,'"+_nextActorModel.currentActivityAttr.single+"','"+_nextActorModel.currentActivityAttr.dealType+"','"+_nextActorModel.currentActivityAttr.activityName+"');";
	html+="  }\n";
	html+="}\n";
	return html;
};

BpmSelectUser.prototype.getTreeZNodes = function(type,treeId,_nextActorModel){
	var zNodes = [];
	if(type=='orgDept'){
		if(this.actorModel.orgDeptTreeZNode && this.actorModel.orgDeptTreeZNode.length>0){
			zNodes = this.actorModel.orgDeptTreeZNode;
		}
	}else if(type=='role'){
		if(this.actorModel.roleTreeZNode && this.actorModel.roleTreeZNode.length>0){
			zNodes = this.actorModel.roleTreeZNode;
		}else{
			for(var i=0;i<_nextActorModel.roleList.length;i++){
				zNodes.push(this.getTreeZNode(_nextActorModel.roleList[i],"trv-icon-role","role",_nextActorModel));
			}
		}
	}else if(type=='model'){
		for(var i=0;i<_nextActorModel.modelList.length;i++){
			zNodes.push(this.getTreeZNode(_nextActorModel.modelList[i],"","model",_nextActorModel));
		}
	}else if(type=='group'){
		if(this.actorModel.groupTreeZNode && this.actorModel.groupTreeZNode.length>0){
			zNodes = this.actorModel.groupTreeZNode;
		}else{
			for(var i=0;i<_nextActorModel.groupList.length;i++){
				zNodes.push(this.getTreeZNode(_nextActorModel.groupList[i],"trv-icon-group","group",_nextActorModel));
			}
		}
	}else if(type=='position'){
		if(this.actorModel.positionTreeZNode && this.actorModel.positionTreeZNode.length>0){
			zNodes = this.actorModel.positionTreeZNode;
		}else{
			for(var i=0;i<_nextActorModel.positionList.length;i++){
				zNodes.push(this.getTreeZNode(_nextActorModel.positionList[i],"trv-icon-position","position",_nextActorModel));
			}
		}
	}else if(type=='deptManage'){//公司收发文项目
		if(this.actorModel.deptManageTreeZNode && this.actorModel.deptManageTreeZNode.length>0){
			zNodes = this.actorModel.deptManageTreeZNode;
		}else{
			for(var i=0;i<_nextActorModel.deptManageList.length;i++){
				zNodes.push(this.getTreeZNode(_nextActorModel.deptManageList[i],"","deptManage",_nextActorModel));
			}
		}
	}
	return JSON.stringify(zNodes);

};
BpmSelectUser.prototype.getTreeZNode = function(nodeObj,iconSkin,nodeType,_nextActorModel){
	var node = {};
	node.id = nodeObj.id;
	node.name = nodeObj.name;
	node.isParent = true;
	node.iconSkin = iconSkin;
	node.checked = this.isUserSelectTypeAuto(_nextActorModel);
	node.attributes = {"nodeType":nodeType};
	return node;
};


BpmSelectUser.prototype.isUserSelectTypeAuto = function(_nextActorModel){
	if(_nextActorModel != null && "auto"==_nextActorModel.currentActivityAttr.userSelectType){
		return true;
	}
	return false;
};
BpmSelectUser.prototype.getUserList = function(_nextActorModel){
	var html = "";
	for(var i=0;i<_nextActorModel.userList.length;i++){
		var user = _nextActorModel.userList[i];
		html+= "<div class='user-lsit'>\n";
		html+= "	<label >";
		html+=" 	<input type='checkbox' value='"+user.id+"'";
		if(this.isUserSelectTypeAuto(_nextActorModel)){
			html+=" checked ";
		}
		html+=" onClick='userListSelector(this,\""+user.id+"\",\""+user.name+"\",\""+user.deptId+"\",\""+user.deptName+"\",\""
		+_nextActorModel.currentActivityAttr.activityName+"\",\""+_nextActorModel.currentActivityAttr.single+"\",\""
		+_nextActorModel.currentActivityAttr.dealType+"\")'";
		html+=" />\n";
		html+=user.name+"/"+user.deptName;
		html+= "	</label >\n";
		html+= "</div>\n";
	}
	return html;
};

BpmSelectUser.prototype.getSearchContent = function(searchType,treeId,_nextActorModel){
	var _self = this;
	var html="";
	html+="<div class='input-group  input-group-sm' >";
	html+="		<input class='form-control' placeholder='请输入用户信息' type='text' id='search-user' name='search-user'";
	html+=" 	searchCondition='"+_self.getSearchCondition(searchType,_nextActorModel)+"'";
	html+=" 	secretLevel='"+_self.actorModel.secretLevel+"'";
	html+=" 	treeId='"+treeId+"'";
	html+=" 	single='"+_self.actorModel.currentActivityAttr.single+"'";
	html+=" 	dealType='"+_self.actorModel.currentActivityAttr.dealType+"'";
	html+="		activityName='"+_self.actorModel.currentActivityAttr.activityName+"'";
	html+=" 	searchType='"+searchType+"'/>\n";
	html+="	<div class='searchResult'></div>\n";
	html+="	<span class='input-group-btn'>\n";
	html+="		<button id='btn-search-user' class='btn btn-default' type='button' ";
	html+=" 	searchCondition='"+_self.getSearchCondition(searchType,_nextActorModel)+"'";
	html+=" 	secretLevel='"+_self.actorModel.secretLevel+"'";
	html+=" 	treeId='"+treeId+"'";
	html+=" 	single='"+_self.actorModel.currentActivityAttr.single+"'";
	html+=" 	dealType='"+_self.actorModel.currentActivityAttr.dealType+"'";
	html+="		activityName='"+_self.actorModel.currentActivityAttr.activityName+"'";
	html+=" 	searchType='"+searchType+"'\n>";
	html+=" 	<span class='glyphicon glyphicon-search'></span>";
	html+="		</button>\n";
	html+="	</span>\n";
	html+="</div>";
	return html;
};

BpmSelectUser.prototype.getSearchCondition = function(_searchType,_nextActorModel){
	var conditionList = [];
	if(_searchType=='userList'){
		var condition = {};
		condition.processInstanceId = _nextActorModel.currentActivityAttr.processInstanceId;
		condition.executionId = _nextActorModel.currentActivityAttr.executionId;
		if(_nextActorModel.currentActivityAttr.outcome == null || _nextActorModel.currentActivityAttr.outcome == 'null'){
			condition.outcome = "";
		}else{
			condition.outcome =_nextActorModel.currentActivityAttr.outcome;
		}

		condition.type = _nextActorModel.currentActivityAttr.type;
		condition.targetActivityName = _nextActorModel.currentActivityAttr.targetActivityName;
		condition.userId = _nextActorModel.currentActivityAttr.userId;
		condition.taskId = _nextActorModel.currentActivityAttr.taskId;
		condition.index = _nextActorModel.currentActivityAttr.index;
		conditionList[0]=condition;
	}else if(_searchType=='orgDept'){
		if(_nextActorModel.orgList!=null && _nextActorModel.orgList.length && _nextActorModel.orgList.length>0){
			for(var i=0;i<_nextActorModel.orgList.length;i++){
				var orgInfo = {};
				orgInfo.id = _nextActorModel.orgList[i].id;
				orgInfo.name = _nextActorModel.orgList[i].name;
				orgInfo.type = "org";
				conditionList.push(orgInfo);
			}
		}else{
			for(var i=0;i<_nextActorModel.deptList.length;i++){
				var deptInfo = {};
				deptInfo.id = _nextActorModel.deptList[i].id;
				deptInfo.name = _nextActorModel.deptList[i].name;
				deptInfo.type = "dept";
				conditionList.push(deptInfo);
			}
		}

	}else if(_searchType=='role'){
		conditionList = _nextActorModel.roleList;
	}else if(_searchType=='model'){
		conditionList = _nextActorModel.modelList;
	}else if(_searchType=='group'){
		conditionList = _nextActorModel.groupList;
	}else if(_searchType=='position'){
		conditionList = _nextActorModel.positionList;
	}

	return JSON.stringify(conditionList);
};

BpmSelectUser.prototype.getCheckUserList = function(){
	var html = "";
	html+="<div class='c-list-arr'>\n";
	html+="	<em></em>\n";
	html+="</div>\n";

	html+="<div class='c-list-boxes'>\n";
	for(var i=0;i<this.actorModel.nextTask.length;i++){
		var _nextActorModel = this.actorModel.nextTask[i];
		html +="	<div id='cb-for-tree-";
		html +=_nextActorModel.currentActivityAttr.activityName+"'";
		html +=" class = 'checked-box on' ";
		html +=" data-for='tree-";
		html +=_nextActorModel.currentActivityAttr.activityName+"'";
		if(_nextActorModel.activityType=='sub-process' || _nextActorModel.activityType=='foreach'){
			if(_nextActorModel.currentActivityAttr.isMustUser=="yes"){
				html += " style='display:block;' ";
			}else{
				html += " style='display:none;' ";
			}
		}else if(_nextActorModel.currentActivityAttr.isSelectUser=="yes"){
			html += " style='display:block;' ";
		}else{
			html += " style='display:none;' ";
		}

		html += ">\n";

		html +="		<div class='cb-tool'>\n";
		//if(this.actorModel.nextTask.length>1){
		    if(flowUtils.notNull(_nextActorModel.currentActivityAttr.activityAlias)){
				html +="			<span class='title'>"+_nextActorModel.currentActivityAttr.activityAlias;
				if(_nextActorModel.currentActivityAttr.isMustUser=="yes"){
					html +="<i class='required'>*</i>";
				}
			}else{
				html +="			<span class='title'>已选";
			}


		//}
		html +="			</span>\n";
		html +="			<ul class='btns on'>\n";
		html +="				<li class='del' title='删除'></li>\n";
		html +="				<li class='clear' title='清空'></li>\n";
		html +="			</ul>\n";
		html += "		</div>\n";

		html +="		<div id='cba-for-tree-";
		html +=_nextActorModel.currentActivityAttr.activityName+"'";
		html +=" class = 'cb-checked-area' ";
		html += ">\n";
		html += "		</div>\n";

		html += "	</div>\n";
	}
	html+="</div>\n";

	return html;
};

BpmSelectUser.prototype.autoSelectToCheckUserList = function(){
	var _self = this;
	for(var i=0;i<this.actorModel.nextTask.length;i++){
		var _nextActorModel = this.actorModel.nextTask[i];
		if(_self.isUserSelectTypeAuto(_nextActorModel) || _self.isAutoSelectUser()){
			_self.autoSelectUser(_nextActorModel);
		}
	}

};

BpmSelectUser.prototype.autoSelectUser = function(_nextActorModel){
	//部门
	if((_nextActorModel.orgDeptUserList!=null && _nextActorModel.orgDeptUserList.length && _nextActorModel.orgDeptUserList.length>0)){
		for(var i=0;i<_nextActorModel.orgDeptUserList.length;i++){
			var user = _nextActorModel.orgDeptUserList[i];
			var tmp = {id:user.id,name:user.name,attributes:{deptId:user.deptId,deptName:user.deptName}};
			var subUserTreeId = "orgDeptTree_"+_nextActorModel.currentActivityAttr.activityName;
		    selectorData(tmp,subUserTreeId,_nextActorModel.currentActivityAttr.single,_nextActorModel.currentActivityAttr.dealType,_nextActorModel.currentActivityAttr.activityName);
		}
	}
	//用户
	if(_nextActorModel.userList!=null && _nextActorModel.userList.length && _nextActorModel.userList.length>0){
		for(var i=0;i<_nextActorModel.userList.length;i++){
			var user = _nextActorModel.userList[i];
			var tmp = {id:user.id,name:user.name,attributes:{deptId:user.deptId,deptName:user.deptName}};
			var subUserTreeId = "sub-tree-user-"+_nextActorModel.currentActivityAttr.activityName;
		    selectorData(tmp,subUserTreeId,_nextActorModel.currentActivityAttr.single,_nextActorModel.currentActivityAttr.dealType,_nextActorModel.currentActivityAttr.activityName);
		}
	}
	//群组
	if(_nextActorModel.groupUserList!=null && _nextActorModel.groupUserList.length && _nextActorModel.groupUserList.length>0){
		for(var i=0;i<_nextActorModel.groupUserList.length;i++){
			var user = _nextActorModel.groupUserList[i];
			var tmp = {id:user.id,name:user.name,attributes:{deptId:user.deptId,deptName:user.deptName}};
			var subUserTreeId = "groupTree_"+_nextActorModel.currentActivityAttr.activityName;
		    selectorData(tmp,subUserTreeId,_nextActorModel.currentActivityAttr.single,_nextActorModel.currentActivityAttr.dealType,_nextActorModel.currentActivityAttr.activityName);
		}
	}
	//角色
	if(_nextActorModel.roleUserList!=null && _nextActorModel.roleUserList.length && _nextActorModel.roleUserList.length>0){
		for(var i=0;i<_nextActorModel.roleUserList.length;i++){
			var user = _nextActorModel.roleUserList[i];
			var tmp = {id:user.id,name:user.name,attributes:{deptId:user.deptId,deptName:user.deptName}};
			var subUserTreeId = "roleTree_"+_nextActorModel.currentActivityAttr.activityName;
		    selectorData(tmp,subUserTreeId,_nextActorModel.currentActivityAttr.single,_nextActorModel.currentActivityAttr.dealType,_nextActorModel.currentActivityAttr.activityName);
		}
	}
	//岗位
	if(_nextActorModel.positionUserList!=null && _nextActorModel.positionUserList.length && _nextActorModel.positionUserList.length>0){
		for(var i=0;i<_nextActorModel.positionUserList.length;i++){
			var user = _nextActorModel.positionUserList[i];
			var tmp = {id:user.id,name:user.name,attributes:{deptId:user.deptId,deptName:user.deptName}};
			var subUserTreeId = "positionTree_"+_nextActorModel.currentActivityAttr.activityName;
		    selectorData(tmp,subUserTreeId,_nextActorModel.currentActivityAttr.single,_nextActorModel.currentActivityAttr.dealType,_nextActorModel.currentActivityAttr.activityName);
		}
	}
};

/**
 * 显示选人框
 */
BpmSelectUser.prototype.showSelectUser = function(){
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
				if(_nextActorModel.currentActivityAttr.isSelectUser=="yes" && _nextActorModel.currentActivityAttr.activityName!="carbonCopy"){
					return true;
				}
			}
		}
	}
	return false;
};

/**
 * 后台自动选人
 */
BpmSelectUser.prototype.isAutoSelectUser = function(){
	if(this.data.event  == "doretreattodraft"
		|| this.data.event  == "doretreattoprev"
		|| this.data.event  == "dowithdraw"
		|| this.data.event  == "doretreattowant"){
		return true;
	}

	return false;
};


