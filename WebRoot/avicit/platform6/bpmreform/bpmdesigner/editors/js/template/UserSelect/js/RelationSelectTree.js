function MyUserExpand(){
	this.strList = [];
	this.objList = [];
};
MyUserExpand.prototype.add = function(str){
	this.strList.push(str);
};
MyUserExpand.prototype.init = function(str){
	for(var i = 0; i < this.strList.length; i++){
		var obj = eval("new " + this.strList[i] + "()");
		this.objList.push(obj);
	}
};
MyUserExpand.prototype.setOption = function(newNodes){
	for(var i = 0; i < this.objList.length; i++){
		var option = this.objList[i].getOption();
		option.iconSkin = "trv-icon-relationship";
		option.nodeType = "relation";
		option.parentId = "-1";
		newNodes.push(option);
	}
};
MyUserExpand.prototype.click = function(id){
	for(var i = 0; i < this.objList.length; i++){
		if(this.objList[i].id == id){
			this.objList[i].click();
			return;
		}
	}
};
var myUserExpand = new MyUserExpand();
/**
 * 关系树选择
 * @param option
 */
function RelationSelectTree(option) {
	this.treeId = "selectRelationTree";
	this.onClickTimer = null;
	this.activeFirst = false;
	this.processId = option.processId;
	this.init.call(this);
	
}


RelationSelectTree.prototype.init = function() {
	var _self = this;
	var newNodes =  [
	             	{ "id":"-1", "text":"所有关系",open:true},
	            	{ "id":"alluser", "text":"当前人所在组织","iconSkin":"trv-icon-relationship","nodeType":"relation",parentId:"-1"},
	            	{ "id":"allorguser", "text":"所有组织","iconSkin":"trv-icon-relationship","nodeType":"relation",parentId:"-1"},
	            	{ "id":"draftuser", "text":"拟稿人","iconSkin":"trv-icon-relationship","nodeType":"relation",parentId:"-1"},
	            	{ "id":"draftdept", "text":"拟稿人部门","iconSkin":"trv-icon-relationship","nodeType":"relation",parentId:"-1"},
	            	{ "id":"currentdept", "text":"当前人部门","iconSkin":"trv-icon-relationship","nodeType":"relation",parentId:"-1"},
	            	{ "id":"currentusergroup", "text":"当前人自定义群组","iconSkin":"trv-icon-relationship","nodeType":"relation",parentId:"-1"},
	            	{ "id":"stepuser", "text":"某一节点处理人","iconSkin":"trv-icon-relationship","nodeType":"relation",parentId:"-1"},
	            	{ "id":"customfunction", "text":"自定义函数","iconSkin":"trv-icon-relationship","nodeType":"relation",parentId:"-1"},
	            	{ "id":"variable", "text":"流程变量","iconSkin":"trv-icon-relationship","nodeType":"relation",parentId:"-1"},
	            	{ "id":"intersection", "text":"交集选人","iconSkin":"trv-icon-relationship","nodeType":"relation",parentId:"-1"}
	            ];
	myUserExpand.init();
	myUserExpand.setOption(newNodes);
	_self.zTree =  $.fn.zTree.init($("#"+_self.treeId), _self.setting.call(_self),newNodes);
}

RelationSelectTree.prototype.setting = function() {
	var _self = this;
	return {
        view: {
            selectedMulti: false,
            dblClickExpand: false
        },
        check: {
            autoCheckTrigger:false,
            enable: false
        },
        data: {
            key: {
                id: "id",
                name: "text",
                children: "children"
            },
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "parentId",
                rootPId: -1
            }
        },
        edit : {
            enable : false,
            showRemoveBtn : false,
            showRenameBtn : false
        },
       callback: {
            onAsyncError:  function(){
                layer.msg("加载失败！");
            },
            onAsyncSuccess:  function(event, treeId, msg){
            	if(!_self.activeFirst) {
	            	var node = _self.zTree.getNodeByParam('_parentId', "-1");//获取id为1的点  
	            	if(node) {
	            		_self.zTree.expandNode(node);
	            		_self.activeFirst = true;
	            	}
            	}
            },
            onClick: function(event, treeId, treeNode) {
                // clearTimeout(_self.onClickTimer);
                // _self.onClickTimer = setTimeout(function() {
                // },300);
                if (treeNode) {
                    var type = treeNode.nodeType;
                    var id = treeNode.id;
                    if(id == "alluser" || id == "allorguser" || id == "draftuser" || id == "currentusergroup") {
                        addNodeIntoUserSelectView(treeNode.id, treeNode.id, treeNode.nodeType, treeNode.text)
                    } else if (id == "draftdept" || id == "currentdept"){
                        layer.open({
                            type:  2,
                            area: [ "400px",  "350px"],
                            title: "部门级别、岗位或角色选择框",
                            skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                            shade:   0.3,
                            maxmin: false, //开启最大化最小化按钮
                            content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/deptPositionSelectTree.jsp?id="+treeNode.id+"&name="+treeNode.text + "&showRoles=1" ,
                            btn: ['确定', '关闭'],
                            yes: function(index, layero){
                                var iframeWin = layero.find('iframe')[0].contentWindow;
                                var selectedNodes = iframeWin.tree.zTree.getSelectedNodes();
                                if(selectedNodes.length <= 0) {
                                } else {
                                    var node = selectedNodes[0];
                                    if(node.nodeType != "position") {
                                        addNodeIntoUserSelectView(treeNode.id,treeNode.id,"relation",treeNode.text, iframeWin.$("#select-deptlevel").val(), iframeWin.$("select[id='select-deptlevel'] option:selected").text(),"",{text:""});
                                        layer.close(index);
                                    } else {
                                        addNodeIntoUserSelectView(treeNode.id,treeNode.id,"relation",treeNode.text, iframeWin.$("#select-deptlevel").val(), iframeWin.$("select[id='select-deptlevel'] option:selected").text(),node.id,node.text);
                                        layer.close(index);
                                    }
                                }
                            }
                        });
                    }else if( id == "stepuser"){
                        layer.open({
                            type:  2,
                            area: [ "400px",  "350px"],
                            title: "流程节点选择框",
                            skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                            shade:   0.3,
                            maxmin: false, //开启最大化最小化按钮
                            content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/TaskNodeSelect.jsp?id="+treeNode.id+"&name="+treeNode.text ,
                            btn: ['确定', '关闭'],
                            yes: function(index, layero){
                                var iframeWin = layero.find('iframe')[0].contentWindow;
                                if(flowUtils.notNull(iframeWin.stepId, iframeWin.stepName)){
                                    addStepNodeInfoUserSelectView(treeNode.id,treeNode.text,iframeWin.stepId,iframeWin.stepName);
                                    layer.close(index);
                                }else {
                                    flowUtils.warning("请先选择数据")
                                }
                            }
                        });
                    } else if (id == "customfunction") {
                        layer.open({
                            type:  2,
                            area: [ "400px",  "350px"],
                            title: "函数输入框",
                            skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                            shade:   0.3,
                            maxmin: false, //开启最大化最小化按钮
                            content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/customFunctionSelect.jsp?id="+treeNode.id+"&name="+treeNode.text ,
                            btn: ['确定', '关闭'],
                            yes: function(index, layero){
                                var iframeWin = layero.find('iframe')[0].contentWindow;
                                if(flowUtils.notNull(iframeWin.$("#input-function-name").val())){
                                    addCustomNodeInfoUserSelectView(treeNode.id,treeNode.text,iframeWin.$("#input-function-name").val().replaceAll("/",".").replaceAll(":","：").replaceAll(",","，"),iframeWin.$("#input-function-name").val());
                                    layer.close(index);
                                }else {
                                    flowUtils.warning("请先填写函数");
                                }
                            }
                        });
                    }else if(id=="variable"){                   	
                    	new ProcessVariable({processId:_self.processId,id:treeNode.id,name:treeNode.text});
                    }else if(id=="intersection"){
                    	var option = {
                    			processId:_self.processId,
                    			id:treeNode.id,
                    			name:treeNode.text};
                         new IntersectionSelect(option);
                    }else{
                    	myUserExpand.click(id);
                    }

//	            	{ "id":"stepuser", "text":"某一节点处理人",parentId:"-1"},
//	            	{ "id":"customfunction", "text":"自定义函数",parentId:"-1"},
//	            	{ "id":"variable", "text":"流程变量",parentId:"-1"},
                }
            },
            onDblClick: function(event, treeId, treeNode) {
            	// clearTimeout(_self.onClickTimer);
                if (treeNode) {
                	var type = treeNode.nodeType;
                	var id = treeNode.id;
                    if(id == "alluser" || id == "allorguser" || id == "draftuser" || id == "currentusergroup") {
                    	addNodeIntoUserSelectView(treeNode.id, treeNode.id, treeNode.nodeType, treeNode.text)
                    } else if (id == "draftdept" || id == "currentdept"){
                    	layer.open({
                    	    type:  2,
                    	    area: [ "400px",  "350px"],
                    	    title: "部门级别、岗位或角色选择框",
                    	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                    	    shade:   0.3,
                            maxmin: false, //开启最大化最小化按钮
                    	    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/deptPositionSelectTree.jsp?id="+treeNode.id+"&name="+treeNode.text + "&showRoles=1" ,
                            btn: ['确定', '关闭'],
                            yes: function(index, layero){
                                var iframeWin = layero.find('iframe')[0].contentWindow;
                                var selectedNodes = iframeWin.tree.zTree.getSelectedNodes();
                                if(selectedNodes.length <= 0) {
                                } else {
                                    var node = selectedNodes[0];
                                    if(node.nodeType != "position") {
                                        addNodeIntoUserSelectView(treeNode.id,treeNode.id,"relation",treeNode.text, iframeWin.$("#select-deptlevel").val(), iframeWin.$("select[id='select-deptlevel'] option:selected").text(),"",{text:""});
                                        layer.close(index);
                                    } else {
                                        addNodeIntoUserSelectView(treeNode.id,treeNode.id,"relation",treeNode.text, iframeWin.$("#select-deptlevel").val(), iframeWin.$("select[id='select-deptlevel'] option:selected").text(),node.id,node.text);
                                        layer.close(index);
                                    }
                                }
                            }
                    	});
                    }else if( id == "stepuser"){
                    	layer.open({
                    	    type:  2,
                    	    area: [ "400px",  "350px"],
                    	    title: "流程节点选择框",
                    	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                    	    shade:   0.3,
                            maxmin: false, //开启最大化最小化按钮
                    	    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/TaskNodeSelect.jsp?id="+treeNode.id+"&name="+treeNode.text ,
                            btn: ['确定', '关闭'],
                            yes: function(index, layero){
                                var iframeWin = layero.find('iframe')[0].contentWindow;
                                if(flowUtils.notNull(iframeWin.stepId, iframeWin.stepName)){
                                    addStepNodeInfoUserSelectView(treeNode.id,treeNode.text,iframeWin.stepId,iframeWin.stepName);
                                    layer.close(index);
                                }else {
                                    flowUtils.warning("请先选择数据")
                                }
                            }
                    	});
                    } else if (id == "customfunction") {
                    	layer.open({
                    	    type:  2,
                    	    area: [ "400px",  "350px"],
                    	    title: "函数输入框",
                    	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                    	    shade:   0.3,
                            maxmin: false, //开启最大化最小化按钮
                    	    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/customFunctionSelect.jsp?id="+treeNode.id+"&name="+treeNode.text ,
                            btn: ['确定', '关闭'],
                            yes: function(index, layero){
                                var iframeWin = layero.find('iframe')[0].contentWindow;
                                if(flowUtils.notNull(iframeWin.$("#input-function-name").val())){
                                    addCustomNodeInfoUserSelectView(treeNode.id,treeNode.text,iframeWin.$("#input-function-name").val().replaceAll("/",".").replaceAll(":","：").replaceAll(",","，"),iframeWin.$("#input-function-name").val());
                                    layer.close(index);
                                }else {
                                    flowUtils.warning("请先填写函数");
                                }
                            }
                    	});
                    }else{
                    	myUserExpand.click(id);
                    }
       
//	            	{ "id":"stepuser", "text":"某一节点处理人",parentId:"-1"},
//	            	{ "id":"customfunction", "text":"自定义函数",parentId:"-1"},
//	            	{ "id":"variable", "text":"流程变量",parentId:"-1"},
                }
            }
        }
    };
};