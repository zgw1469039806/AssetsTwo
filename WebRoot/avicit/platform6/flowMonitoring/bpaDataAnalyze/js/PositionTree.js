function PositionTree(treeUL,orgId,posID,indexPosDept) {
    this.treeUL = treeUL; //tree位置
    this.indexPosDept = indexPosDept; // 用于定位维度是部门选或岗位
    this.orgId = orgId;
    this.tree = null; //tree对象
    this.selectedNodeId = null; //tree点击选中的节点
    this.init.call(this);
};
var retdata = '';
var h5KadsView = null;
//初始化操作
PositionTree.prototype.init = function () {
	var data = '';
	
    var _this = this;
    var firstAsyncSuccessFlag2 = 0;
    var isShowChebox = false;
    var defaultLoadDeptId = "";
    var fileSecretLevel =  "";
    var viewScope = "";
    var defaultOrgId = "";
    var defaultDept = "";
    var secretLevel = "";
    var isShowVoid = false;
    var setting1 = {
        async: {
            enable: true,
            url: "h5/view/select/SelectController/getUserSelectList1",//异步请求树子节点url
            autoParam:["id","nodeType","orgId"],//父节点id
            otherParam: {
				"defaultLoadDeptId":  defaultLoadDeptId,
				"fileSecretLevel": fileSecretLevel,
				"viewScope" : viewScope,
				"defaultOrgId" : defaultOrgId,
				"defaultDept" : defaultDept,
				"secretLevel" : secretLevel
			},
        },
        data: {
        	key: {
				id: "id",
				name: "text",
				children: "children"
			},
			simpleData: {
				isParent: true,
				enable: true,
				idKey: "id",
				pIdKey: "parentId",
				rootPId: -1
			}
        },
        check: {
 			  enable: true,
 			  chkStyle: "checkbox",
			  chkboxType: { "Y": "s", "N": "ps" }
        },
        callback: {
        	onClick: function (event, treeId, treeNode){
				if(treeNode.nodeType == "position"){
					var tree = $.fn.zTree.getZTreeObj(treeId);
	                tree.expandNode(treeNode, true);
				}
			},
            onCheck:onPosDeptUsrCheck1
        }
    };

    var setting2 = {
        async: {
            enable: true,
            url: "h5/view/select/SelectController/getDefaultUserSelectList",//异步请求树子节点url
            autoParam:["id","nodeType","orgId"],//父节点id
            otherParam: {
				"defaultLoadDeptId":  defaultLoadDeptId,
				"fileSecretLevel": fileSecretLevel,
				"viewScope" : viewScope,
				"defaultOrgId" : defaultOrgId,
				"defaultDept" : defaultDept,
				"secretLevel" : secretLevel
			},
        },
        data: {
        	key: {
				id: "id",
				name: "text",
				children: "children"
			},
			simpleData: {
				isParent: true,
				enable: true,
				idKey: "id",
				pIdKey: "parentId",
				rootPId: -1
			}
        },
        check: {
 			  enable: true,
 			  chkStyle: "checkbox",
			  chkboxType: { "Y": "s", "N": "ps" }
        },
        callback: {
        	onClick: function (event, treeId, treeNode){
				if(treeNode.nodeType == "dept"){
					var tree = $.fn.zTree.getZTreeObj(treeId);
	                tree.expandNode(treeNode, true);
				}
			},
            onCheck:onPosDeptUsrCheck1
        }
    };

    var setting3 = {
        async: {
            enable: true,
            url: "h5/view/select/SelectController/getuserSelectBySelectedDeptId",//异步请求树子节点url
            autoParam:["id","nodeType","orgId"],//父节点id
            otherParam: {
				"defaultLoadDeptId":  defaultLoadDeptId,
				"fileSecretLevel": fileSecretLevel,
				"viewScope" : viewScope,
				"defaultOrgId" : defaultOrgId,
				"defaultDept" : defaultDept,
				"secretLevel" : secretLevel
			},
        },
        data: {
        	key: {
				id: "id",
				name: "text",
				children: "children"
			},
			simpleData: {
				isParent: true,
				enable: true,
				idKey: "id",
				pIdKey: "parentId",
				rootPId: -1
			}
        },
        check: {
 			  enable: true,
 			  chkStyle: "checkbox",
			  chkboxType: { "Y": "s", "N": "ps" }
        },
        callback: {
        	onClick: function (event, treeId, treeNode){
				if(treeNode.nodeType == "dept"){
					var tree = $.fn.zTree.getZTreeObj(treeId);
	                tree.expandNode(treeNode, true);
				}
			},
            onCheck:onPosDeptUsrCheck1
        }
    };
   
    // 手动请求根节点数据
    // 统一处理选部门和选岗位时
    if(indexPosDept==1){
        // 此时根据选定的岗位画树
        // 分两种情况，即选中岗位和未选中岗位时
        if(!posID || posID=="null"){
            $.ajax({
                url: "h5/view/select/SelectController/getUserSelectList1",
                data: {
                    id : "defaultOrgId",
                    orgId : _this.orgId
                },
                type: "post",
                async: false,
                dataType: "json",
                success: function (backData) {
                    var zNodes = backData;
                    _this.tree = $.fn.zTree.init($("#" + _this.treeUL), setting1, zNodes);
                }
            });
        }else{
            $.ajax({
                url: "h5/view/select/SelectController/getUserSelectByPosId",
                data: {
                    id : posID,
                    orgId : _this.orgId
                },
                type: "post",
                async: false,
                dataType: "json",
                success: function (backData) {
                    var zNodes = backData;
                    _this.tree = $.fn.zTree.init($("#" + _this.treeUL), setting1, zNodes);
                }
            });   
        }
    }else if(indexPosDept==2){ // 选择部门的人员时
        if(!posID || posID=="null"){
            $.ajax({
                url: "h5/view/select/SelectController/getDefaultUserSelectList",
                data: {
                    id : "defaultOrgId",
                    orgId : _this.orgId
                },
                type: "post",
                async: false,
                dataType: "json",
                success: function (backData) {
                    var zNodes = backData;
                    _this.tree = $.fn.zTree.init($("#" + _this.treeUL), setting2, zNodes);
                }
            });
        }else{
            $.ajax({
                url: "h5/view/select/SelectController/getUserSelectByDeptId",
                data: {
                    id : posID,
                    orgId : _this.orgId
                },
                type: "post",
                async: false,
                dataType: "json",
                success: function (backData) {
                    var zNodes = backData;
                    _this.tree = $.fn.zTree.init($("#" + _this.treeUL), setting3, zNodes);
                }
            });
        }
    }
};
var callbackdata = function () {
    return retdata;
}