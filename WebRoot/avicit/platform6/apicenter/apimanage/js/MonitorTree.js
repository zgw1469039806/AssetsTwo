/**
 * 单表树
 * @param ztreeId
 * @param url
 * @param form
 * @param searchD
 * @param searchbtn
 * @returns
 */
function MonitorTree(ztreeId, url, orgEditDialog, editTreeId, searchD, searchbtn){
    if(!ztreeId || typeof(ztreeId)!=='string'&&ztreeId.trim()!==''){
        throw new Error("datagrid不能为空！");
    }
    var	_url = url;
    this.getUrl = function(){
        return _url;
    }

    var selectTreeNode = {};

    var _onSelect=function(){};//单击node事件

    this.getOnSelect=function(){
        return _onSelect;
    };
    this.setOnSelect=function(func){
        _onSelect=func;
        return _self;
    };

    this.addRetIdFlag = null; //初始化添加节点标记
    this.firstAsyncSuccessFlag = 0; //第一次加载
    this.tree = null;
    this.ztreeId = ztreeId;
    this._ztreeId="#"+ztreeId;
    this.setting = {};
    this._doc = document;
    // this._formId="#"+form; //formId
    this._searchId ="#"+searchD;
    this._searchbtnId ="#"+searchbtn;
    this.param = [];
    this._orgEditDialog = "#"+orgEditDialog;
    this.editTreeId = editTreeId;
};

function getFont(treeId, node) {
    if(node.fontCss=="Y"){
        return {color:'#BA55D3'};
    }

}


//初始化树节点
MonitorTree.prototype.init=function(){
    var _self = this;
    $(_self._searchId).on('keyup',function(e){
        if(e.keyCode == 13){
            _self.onSearch(13,$(_self._searchId).val());
        }
    });
    $(_self._searchbtnId).on('click',function(e){
        _self.onSearch(13,$(_self._searchId).val());
    });
    _self.setting = {
        view: {
            selectedMulti: false,
            fontCss: getFont
        },
        data: {
            keep:{
                parent: true,
                leaf: true
            },
            key: {
                id: "id",
                name: "name",
                parentId: "parentId",
                children: "children"
            },
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "parentId",
                rootPId: "0"
            }
        },
        async: {
            enable: true,
            url: "platform/monitor/tree"+"/getServiceList",
            autoParam:["id","nodeType","orgId"],
            dataFilter: function(treeId, parentNode, childNodes){
            	debugger;
                if (!childNodes)
                    return null;
                childNodes = eval(childNodes);
                return childNodes;
            }
        },
        callback: {
            onClick: function(event, treeId, treeNode){ //绑定左右联动事件
            	debugger;
            	console.info(treeNode);
            	if(treeNode.applicationCode){
            		var data = {
        					"appCode":treeNode.applicationCode
    				};
            		var searchdata = {
            				keyWord : null,
            				param : JSON.stringify(data)
            			}
            			$("#monitorApiInfojqGrid").jqGrid('setGridParam', {
            				datatype : 'json',
            				postData : searchdata
            			}).trigger("reloadGrid");
            	}else if(treeNode.organizationCode=="root"){
            		
            		$("#monitorApiInfojqGrid").jqGrid('setGridParam', {
        				datatype : 'json',
        				postData : ""
        			}).trigger("reloadGrid");
            	}else{
            		var data = {
            				"businessDomain":treeNode.organizationCode
    				};
            		
            		var searchdata = {
            				keyWord : null,
            				param : JSON.stringify(data)
            			}
            		
            		$("#monitorApiInfojqGrid").jqGrid('setGridParam', {
        				datatype : 'json',
        				postData :searchdata
        			}).trigger("reloadGrid");
            	}
                _self._selectNode = treeNode;
                _self.selectTreeNode(treeNode);
            },
            onAsyncError:  function(){alert("加载失败！");},
            onAsyncSuccess:  function(data){
                if (_self.firstAsyncSuccessFlag == 0) {
                    var node = _self.tree.getNodes()[0];
                    _self.tree.expandNode(node, true);
                    $("#" + node.tId + "_span").click();
                    _self.firstAsyncSuccessFlag = 1;
                }
                // var node = _self.tree.getNodeByParam("id", "1");
                // _self.tree.selectNode(node);

                //未包含子节点的业务域节点需要设定父节点属性
                var AllNodes = _self.tree.transformToArray(_self.tree.getNodes());
                for (var i in AllNodes){
                    if(AllNodes[i].isParent == false && AllNodes[i].parentAttribute == true){
                        var orgNode = _self.tree.getNodeByParam("id", AllNodes[i].id);
                        orgNode.isParent = true;
                        _self.tree.updateNode(orgNode);
                    }
                }
            }
        }
    };
    _self.tree = $.fn.zTree.init($(_self._ztreeId),_self.setting, []);
    
}

/*切换应用*/
MonitorTree.prototype.selectTreeNode = function(currentNode){
    function filterCondition(node){
        return (node.applicationCode != "" && !node.isHidden);
    }

    var nodesParam = [];
    if(currentNode.applicationCode != ""){
        nodesParam.push(currentNode.applicationCode);
    }else{
        var nodes = this.tree.getNodesByFilter(filterCondition, false, currentNode);
        for (var i in nodes){
            nodesParam.push(nodes[i].applicationCode);
        }
    }

    var searchdata = {
        param: JSON.stringify(nodesParam)
    }

    $('#jqGrid').jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
}

//表单验证
MonitorTree.prototype.formValidate = function (form) {
    form.validate({
        messages : {
            organizationCode: {
                required: "必填",
                maxlength: "最大长度100"
            },
            organizationName: {
                required: "必填",
                maxlength: "最大长度200"
            }
        },
        rules: {
            organizationCode: {
                required: true,
                maxlength: 100
            },
            organizationName: {
                 required: true,
                 maxlength: 200
             }
        }
    });
};

//添加业务域节点
MonitorTree.prototype.addOrgNode = function(){
    var node = this._selectNode;
    if (node == null || node == undefined){
        layer.alert('请先选择一个业务域节点！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }else if(node.organizationCode == "other"){
        layer.alert('业务域节点“其他”不可进行添加操作！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    } else if (node.applicationCode != ""){
        layer.alert('应用节点不可进行添加操作！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }

    addDialog = layer.open({
        type: 2,
        title: "添加业务域节点",
        skin: 'bs-modal',
        area: ['60%', '40%'],
        maxmin: false,
        content: "platform/monitor/tree/toAddOrganizationDialog?parentId="+node.id
    });
}

MonitorTree.prototype.submitAdd = function(form){
    var _self = this;
    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    //验证业务域节点是否已存在
    var insertData = serializeObject(form);
    function filterCondition(node, invokeParam){
        return (node.name == invokeParam.organizationName || node.organizationCode == invokeParam.organizationCode);
    }
    var nodes = this.tree.getNodesByFilter(filterCondition, false, null, insertData);
    if(nodes.length > 0){
        layer.alert('业务域编码或名称已存在!', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }

    $.ajax({
        url: "platform/monitor/tree/addOrganizationNode",
        data : {
            param:  JSON.stringify(serializeObject(form))
        },
        type: "post",
        async: false,
        dataType: "json",
        success: function (data){
            if(data.result == 1 && data.newNode != null){
                var newNodes = [];
                newNodes.push(data.newNode);
                var newList = _self.tree.addNodes(_self._selectNode, newNodes);
                //需要设置父节点属性
                for(var i in newList){
                    orgNode = newList[i];
                    orgNode.isParent = true;
                    _self.tree.updateNode(orgNode);
                }
                layer.msg('添加成功!');
                _self.closeDialog("add");
            }
        }
    });
}

//编辑业务域节点
MonitorTree.prototype.editOrgNode = function(){
    var node = this._selectNode;
    if (node == null || node == undefined){
        layer.alert('请先选择一个业务域节点！', {
            title : '提示',
            icon : 0,
            area: ['400px', ''], //宽高
            closeBtn: 0
            }
        );
        return false;
    } else if(node.id == "1"){
        layer.alert('业务域根节点不可进行编辑操作！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }else if(node.organizationCode == "other"){
        layer.alert('业务域节点“其他”不可进行编辑操作！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    } else if (node.applicationCode != ""){
        layer.alert('应用节点不可进行编辑操作！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }

    editDialog = layer.open({
        type: 2,
        title: "编辑业务域节点信息",
        skin: 'bs-modal',
        area: ['60%', '40%'],
        maxmin: false,
        content: "platform/monitor/tree/toEditOrganizationDialog?id="+node.id
    });

}

MonitorTree.prototype.submitEdit = function(form){
    var _self = this;
    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    $.ajax({
        url: "platform/monitor/tree/editOrganizationNode",
        data : {
            param :JSON.stringify(serializeObject(form))
        },
        type: "post",
        async: false,
        dataType: "json",
        success: function (data){
            if(data.result == 1 && data.newNode != null){
                _self._selectNode.name = data.newNode.organizationName;
                _self._selectNode.organizationName = data.newNode.organizationName;
                _self.tree.updateNode(_self._selectNode);

                layer.msg('修改成功!');
                _self.closeDialog("edit");
            }
            else{
                layer.msg('修改失败!');
            }
        }
    });
}

//删除业务域节点
MonitorTree.prototype.deleteOrgNode = function(){
    var _self = this;
    var node = this._selectNode;
    if (node == null || node == undefined){
        layer.alert('请先选择一个业务域节点！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }else if(node.organizationCode == "root"){
        layer.alert('业务域根节点不可删除！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }else if(node.organizationCode == "other"){
        layer.alert('业务域节点“其他”不可删除！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }else if(node.applicationCode != ""){
        layer.alert('应用节点不可进行删除操作！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }else if(this.checkNode(node)){
        layer.alert('业务域节点包含应用，不可删除！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
        return false;
    }

    layer.confirm('确认要删除此业务域节点吗?', {
        title : '提示',
        icon : 3,
        closeBtn:0,
        area: ['400px', ''],
        btn: ['确定','取消']
    }, function(index){
        var parentNode = node.getParentNode();

        var nodeIds = [];
        nodeIds.push(node.id);

        function filterCondition(node){
            return (node.applicationCode == "");
        }
        var childrenNodes = _self.tree.getNodesByFilter(filterCondition, false, node);
        for(var i in childrenNodes){
            nodeIds.push(childrenNodes[i].id);
        }
        $.ajax({
            url: "platform/monitor/tree/deleteOrganizationNode",
            data: {
                nodeIds: JSON.stringify(nodeIds)
            },
            type: "post",
            async: false,
            dataType: "json",
            success: function (data) {
                if(data.result > 0){
                    layer.msg('删除成功!');
                    _self.tree.removeNode(node);
                    $("#" + parentNode.tId + "_span").click();
                    layer.close(index);
                }else{
                    layer.msg('删除失败!');
                }
            }
        });
    });
}

// 验证节点是否包含应用
MonitorTree.prototype.checkNode = function(node){
    function filterCondition(node){
        return (node.applicationCode != "");
    }
    var nodes = this.tree.getNodesByFilter(filterCondition, false, node);
    if (nodes.length>0){
        return true;
    }
    return false;
}

MonitorTree.prototype.closeDialog = function(type){
    if(type == "edit"){
        layer.close(editDialog);
    }
    else if(type == "add"){
        layer.close(addDialog);
    }
}

/*关键字查询*/
MonitorTree.prototype.onSearch = function(ecode, value){
    var _self = this;
    _self.tree.expandAll(false);
    var rootNode = _self.tree.getNodeByParam("id", "1", null);
    _self.tree.expandNode(rootNode,true,false,false);

    var allNodes = _self.tree.getNodesByParamFuzzy("name", value, null);
    for(var i in allNodes){
        this.expandParent(allNodes[i]);
    }
}

MonitorTree.prototype.expandParent = function(node){
    var parent = node.getParentNode();
    if( parent != null){
        this.tree.expandNode(parent,true,false,false);
        this.expandParent(parent);
    }
    // else{
    //     //根节点
    //     this.tree.expandNode(node,true,false,false);
    // }
}

// /*关键字查询*/
// MonitorTree.prototype.onSearch = function(ecode, value){
//     var _self = this;
//     var allNodes = _self.tree.getNodes();
//     var rootNode = allNodes[0];
//
//     for (var i in rootNode.children){
//         this.filterNode(rootNode.children[i], value);
//     }
//
//     _self.tree.selectNode(rootNode);
//     _self.tree.expandNode(rootNode, true);
//     _self.setting.callback.onClick(null, _self.tree.treeId, rootNode);//调用点击事件 ;
// }
//
// MonitorTree.prototype.filterNode = function(node, value){
//     if(!node.isParent){
//         if(node.name.indexOf(value) > -1){
//             this.tree.showNode(node);
//             return true;
//         }else{
//             this.tree.hideNode(node);
//             return false;
//         }
//
//     }
//     else{
//         if(node.name.indexOf(value) > -1){
//             this.showChildrenNodes(node);
//             return true;
//         }else{
//             var result = false;
//             for(var i in node.children){
//                 if (this.filterNode(node.children[i], value)){
//                     result = true;
//                 }
//             }
//             if (result == true){
//                 this.tree.showNode(node);
//             }else{
//                 this.tree.hideNode(node);
//             }
//             return result;
//         }
//     }
// }
//
// MonitorTree.prototype.showChildrenNodes = function(node){
//     this.tree.showNode(node);
//     for(var i in node.children){
//         this.showChildrenNodes(node.children[i]);
//     }
// }
