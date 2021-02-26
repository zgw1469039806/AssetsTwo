/**
 * 根据type的参数不同，呈现相应的树
 * 角色：role , 群组：group, 岗位：position
 * @param option
 */
function CommonSelectTree(option) {
	this.treeId = option.treeId || "selectUserTree";
	this.type = option.type;
	this.initUrl = this.getInitUrl(option.type);
	this.searchUrl = this.getSearchUrl(option.type);
	this.onClickTimer = null;
	this.activeFirst = false;
	this.search_input = option.search_input;
	this.search_but = option.search_but;
	this.init.call(this);
	
}

CommonSelectTree.prototype.getSearchUrl = function(type) {
	var searchUrl = "bpm/designeruser/getOrgPositionTreeSearch";
	if (type == "position") {
		searchUrl = "bpm/designeruser/getOrgPositionTreeSearch";
	} else if (type == "role") {
		searchUrl =  "bpm/designeruser/getOrgRoleTreeSearch";
	} else if (type == "group") {
		searchUrl =  "bpm/designeruser/getOrgGroupTreeSearch";
	}else if(type=="dept"){
		searchUrl =  "h5/view/common/select/SelectController/searchDept";
	}
	return searchUrl;
}

CommonSelectTree.prototype.getInitUrl = function(type) {
	var initUrl = "bpm/designeruser/getOrgPositionTree";
	if (type == "position") {
		initUrl = "bpm/designeruser/getOrgPositionTree";
	} else if (type == "role") {
		initUrl =  "bpm/designeruser/getOrgRoleTree";
	} else if (type == "group") {
		initUrl =  "bpm/designeruser/getOrgGroupTree";
	} else if(type=="dept"){
		initUrl =  "h5/view/common/select/SelectController/getDeptSelectList";
	}
	return initUrl;
}

CommonSelectTree.prototype.init = function() {
	var _self = this;
	if(this.search_input && this.search_but){
		$("#" + this.search_input).keydown(function(e) {
			if(e.keyCode==13){
				_self.search($("#" + _self.search_input).val());
			}
		});
	}
	if(this.search_but){
		$("#" + this.search_but).on("click",function() {
			_self.search($("#" + _self.search_input).val());
	 	});
	}
	_self.zTree =  $.fn.zTree.init($("#"+_self.treeId), _self.setting.call(_self));
}

CommonSelectTree.prototype.search = function(value) {
	var _self = this;
    if(value==null||value==""){
    	_self.zTree =  $.fn.zTree.init($("#"+_self.treeId), _self.setting.call(_self));
        return;
    }
    var data = {searchText:value};
    if("dept"==_self.type){
    	data = {search_text:value,selectedDept:"[]"};
    }
    $.ajax({
        cache: true,
        type: "post",
        url: _self.searchUrl,
        dataType:"json",
        data:data,
        async: false,
        error: function(request) {
            throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
        },
        success: function(data) {
        	_self.zTree =  $.fn.zTree.init($("#"+_self.treeId), {
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
                        enable: false,
                        idKey: "id",
                        pIdKey: "parentId",
                        rootPId: -1
                    }
                },callback: {
                    onClick: _self.zTreeOnClick,
                    onDblClick: _self.zTreeOnDblClick
                }
                
            }, data);
        }
    });
};
CommonSelectTree.prototype.zTreeOnClick = function(event, treeId, treeNode){
	if (treeNode) {
        var type = treeNode.nodeType;
        if(type == "user" || type == "position" || type == "group" || type == "role" || type=="dept") {
            addNodeIntoUserSelectView(treeNode.id, treeNode.id, treeNode.nodeType, treeNode.text)
        } else {
            //layer.msg("开发中");
        }
    }
};
CommonSelectTree.prototype.zTreeOnDblClick = function(event, treeId, treeNode){
	if (treeNode) {
    	var type = treeNode.nodeType;
        if(type == "user" || type == "position" || type == "group" || type == "role" || type=="dept") {
        	addNodeIntoUserSelectView(treeNode.id, treeNode.id, treeNode.nodeType, treeNode.text)
        } else {
        	//layer.msg("开发中");
        }
    }
};
CommonSelectTree.prototype.setting = function() {
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
        async: {
            enable: true,
            type: "post",
            url: _self.initUrl,
            autoParam:["id","nodeType","orgId"],
            dataFilter: function(treeId, parentNode, childNodes){
                 if (!childNodes)
                    return null;
                var childNodes = eval(childNodes);
                return childNodes;
            }
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
            onClick: _self.zTreeOnClick,
            onDblClick: _self.zTreeOnDblClick
        }
    };
};