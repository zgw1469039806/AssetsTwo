function ShareTypeTree(treeUL,orgId) {
    this.treeUL = treeUL;//tree位置
    this.orgId = orgId;
    this.tree = null;//tree对象
    this.selectedNodeId = null;//tree点击选中的节点
    this.init.call(this);
    retdata = '';
    retdataRoot = '';
};
var retdata = '';
var retdataRoot = '';//标记所选节点是否是根节点
//初始化操作
ShareTypeTree.prototype.init = function () {
	var data = '';
    var _this = this;
    
    var setting = {
        async: {
            enable: true,
            url: "bpm/deploy/getFlowTypeTree?orgId="+_this.orgId,//异步请求树子节点url
            autoParam: ["id"]//父节点id
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdkey: "pId"
            }
        },
        callback: {
            //节点点击事件
            onClick: function (event, treeId, treeNode) {
            	retdata = treeNode.id;
            	if(treeNode.parentTId == null && treeNode.level == 0){
                    //标记所选节点是根节点
            	    retdataRoot = true;
                }else {
            	    //标记所选节点不是根节点
                    retdataRoot = false;
                }
            }
        }
    };
   
    //手动请求根节点数据
    $.ajax({
        url: "bpm/deploy/getFlowTypeTree",
        data: {
        	id : "root",
        	orgId : _this.orgId
        },
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var zNodes = backData;
            _this.tree = $.fn.zTree.init($("#" + _this.treeUL), setting, zNodes);
        }
    });
};

var callbackdata = function () {
    return retdata;
};

//判断所选的节点是否是树的根节点（不能共享流程到组织根目录下！）
var iscallbackdataRoot = function () {
    return retdataRoot;
}