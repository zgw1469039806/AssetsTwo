/**
 * Created by xb on 2017/5/11.
 */
function RestOrgManageTree(treeUL,afterInit) {
    this.treeUL = treeUL;//tree位置
    this.tree = null;//tree对象
    this.selectedNodeId = null;//tree点击选中的节点
    this.afterInit = afterInit;
    this.init.call(this);
};
//初始化操作
RestOrgManageTree.prototype.init = function () {
    var _this = this;
    var isInit=true;
    var setting = {
        async: {
            enable: true,
            url: "platform6/newrestmanage/controller/RestOrgTreeController/getRestSystemTree",//异步请求树子节点url
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
                _this.selectedNodeId = treeNode.id;
               
                	//********************************正文模板列表
                	restResourceManage.reLoad(_this.selectedNodeId);
                
            }
        }
    };

    //手动请求根节点数据
    $.ajax({
        url: "platform6/newrestmanage/controller/RestOrgTreeController/getRestOrgTree",
        data: "id=-1",
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var zNodes = backData;
            _this.afterInit("-9999");
            _this.tree = $.fn.zTree.init($("#" + _this.treeUL), setting, zNodes);

            _this.clickFirstRootNode();
        }
    });
};
//模拟点击二级第一个根节点
RestOrgManageTree.prototype.clickFirstRootNode = function () {
    var _this = this;

    //var spanId = _this.tree.getNodeByParam("pId", null, null).tId + "_span";
    var spanId = "sysWordCatalogTreeUL_2_span";
    $("#" + spanId + "").click();
}
//重新加载pId父节点的子节点（当父节点的子节点进行增、删、改后调用）
RestOrgManageTree.prototype.reAsyncChildNodes = function (pId) {
    var _this = this;

    var n = _this.tree.getNodeByParam("id", pId, null);
    if (!n.isParent)
        n.isParent = "true";
    _this.tree.reAsyncChildNodes(n, "refresh");
}
//删除id节点及其子节点（当父节点删除后调用）
RestOrgManageTree.prototype.removeNode = function (id) {
    var _this = this;

    _this.tree.removeNode(_this.tree.getNodeByParam("id", id, null));
}
//更新id节点自身数据（当父节点编辑后调用）
RestOrgManageTree.prototype.updateNode = function (id, name) {
    var _this = this;

    var node = _this.tree.getNodeByParam("id", id, null);
    node.name = name;

    _this.tree.updateNode(node);
}