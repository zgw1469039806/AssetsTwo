/**
 * 单表树
 * @param ztreeId
 * @param url
 * @param form
 * @param searchD
 * @param searchbtn
 * @returns
 */
function ServiceAuthTree(ztreeId, url, form, searchD, searchbtn){
	debugger;
    if(!ztreeId || typeof(ztreeId)!=='string'&&ztreeId.trim()!==''){
        throw new Error("datagrid不能为空！");
    }
    var	_url = url;
    this.getUrl = function(){
        return _url;
    }
    var selectTreeNode = {};

    this.addRetIdFlag = null; //初始化添加节点标记
    this.firstAsyncSuccessFlag = 0; //第一次加载
    this.tree = null;
    this.ztreeId  = ztreeId;
    this._ztreeId="#"+ztreeId;
    this.setting = {};
    this._doc = document;
    this._formId="#"+form; //formId
    this._searchId ="#"+searchD;
    this._searchbtnId ="#"+searchbtn;
    this.param = {
        applicationCode: "",
        applicationName: ""
    };
};

/*关键字查询*/
ServiceAuthTree.prototype.onSearch = function(ecode, value){
    var _self = this;
    var allNodes = _self.tree.getNodes();
    var rootNode = allNodes[0];

    for (var i in rootNode.children){
        this.filterNode(rootNode.children[i], value);
    }
 
    _self.tree.selectNode(rootNode);
    _self.tree.expandNode(rootNode, true);
    _self.setting.callback.onClick(null, _self.tree.treeId, rootNode);//调用点击事件 ;
}

ServiceAuthTree.prototype.filterNode = function(node, value){
    if(!node.isParent){
        if(node.name.indexOf(value) > -1){
            this.tree.showNode(node);
            return true;
        }else{
            this.tree.hideNode(node);
            return false;
        }

    }
    else{
        if(node.name.indexOf(value) > -1){
            this.showChildrenNodes(node);
            return true;
        }else{
            var result = false;
            for(var i in node.children){
                if (this.filterNode(node.children[i], value)){
                    result = true;
                }
            }
            if (result == true){
                this.tree.showNode(node);
            }else{
                this.tree.hideNode(node);
            }
            return result;
        }
    }
}
//初始化树节点
ServiceAuthTree.prototype.init=function(){
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
        },
        data: {
            key: {
                id: "id",
                name: "name",
                children: "children"
            },
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "parentId",
                rootPId: -1
            }
        },
        async: {
            enable: true,
            url: "platform/monitor/main/getConsumerTree",
            autoParam:["id","nodeType","orgId"],
            dataFilter: function(treeId, parentNode, childNodes){
                if (!childNodes)
                    return null;
                childNodes = eval(childNodes);
                return childNodes;
            }
        },
        callback: {
            onClick: function(event, treeId, treeNode){ //绑定左右联动事件
            	 var searchdata = {
    				param : JSON.stringify({
         				"businessDomain":treeNode.id == '1' ? '' : treeNode.name
         			})
    			}
    			$("#monitorApiInfojqGrid").jqGrid('setGridParam', {
    				datatype : 'json',
    				postData : searchdata
    			}).trigger("reloadGrid");
            },
            onAsyncError:  function(){alert("加载失败！");},
            onAsyncSuccess:  function(data){
                if (_self.firstAsyncSuccessFlag == 0) {
                    var node = _self.tree.getNodes()[0];
                    _self.tree.expandNode(node, true);
                    $("#" + node.tId + "_span").click();
                    _self.firstAsyncSuccessFlag = 1;
                }
                var node = _self.tree.getNodeByParam("id", $('#id').val());
                _self.tree.selectNode(node);
                var treeObj = $.fn.zTree.getZTreeObj(_self.ztreeId);
                var pnode = treeObj.getNodes(); //可以获取所有的父节点
                var nodes = treeObj.transformToArray(pnode); //获取树所有节点
                for(var i=0;i<nodes.length;i++) {
                    var node=nodes[i];
                    if(node.applicationName!="")
                        node.name=node.applicationName;
                }

                //未包含子节点的业务域节点需要设定父节点属性
                for (var i in nodes){
                    if(nodes[i].isParent == false && nodes[i].parentAttribute == true){
                        var orgNode = _self.tree.getNodeByParam("id", nodes[i].id);
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
ServiceAuthTree.prototype.selectApplication = function(currentNode){
    if(currentNode.applicationCode=="") {
        this.param.applicationCode = "";
        this.param.organization = currentNode.organization;
    } else {
        this.param.applicationCode = currentNode.applicationCode;
        this.param.organization = currentNode.organization;
    }

    var searchdata = {
        param: JSON.stringify(this.param)
    }

    ServiceAuthList.param=this.param;
    $('#jqGrid').jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
}

/*返回当前点击的节点应用名称和所属业务域*/
ServiceAuthTree.prototype.getParam = function(){
    return this.param;
}












