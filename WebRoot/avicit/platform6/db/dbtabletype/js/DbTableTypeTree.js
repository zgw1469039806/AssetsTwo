/**
 * Created by xb on 2017/5/11.
 */
function EformTypeTree(treeUL) {
    this.treeUL = treeUL;//tree位置
    this.tree = null;//tree对象
    this.selectedNodeId = null;//tree点击选中的节点
    this.init.call(this);
}
//初始化操作
EformTypeTree.prototype.init = function () {
    var _this = this;

    var setting = {
        async: {
            enable: true,
            url: "platform/db/dbTableManageController/getDbTableTypeTree",//异步请求树子节点url
            autoParam: ["id"]//父节点id
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdkey: "pId"
            }
        },
        view:{
            selectedMulti: false
        },
        callback: {
            //节点点击事件
            onClick: function (event, treeId, treeNode) {
                _this.selectedNodeId = treeNode.id;
                $("#" + dbTableSearch.searchArea).css("display", "none");
                //获取该分类下电子表单模块列表
                dbTable.getComponentList(_this.selectedNodeId);
            }
        }
    };

    //手动请求根节点数据
    $.ajax({
        url: "platform/db/dbTableManageController/getDbTableTypeTree",
        data: "id=-1",
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var zNodes = backData;
            _this.tree = $.fn.zTree.init($("#" + _this.treeUL), setting, zNodes);

            _this.clickFirstSubNodeOfFirstRootNode();
        }
    });
};

//模拟点击第一个根节点的第一个子节点
EformTypeTree.prototype.clickFirstSubNodeOfFirstRootNode = function () {
    var _this = this;

    var firstRootNode = _this.tree.getNodeByParam("pId", null, null);
    var firstSubNodeOfFirstRootNode = _this.tree.getNodeByParam("pId", firstRootNode.id, null);
    if (firstSubNodeOfFirstRootNode){
	    var spanId = firstSubNodeOfFirstRootNode.tId + "_span";
	    $("#" + spanId).click();
    }
};

EformTypeTree.prototype.clickNode = function () {
	  var _this = this;
	  var node = _this.tree.getNodeByParam("id", _this.selectedNodeId);
	  $("#"+node.tId+"_span").click();
};

//模拟点击第一个根节点
EformTypeTree.prototype.clickFirstRootNode = function () {
    var _this = this;

    var spanId = _this.tree.getNodeByParam("pId", null, null).tId + "_span";
    $("#" + spanId + "").click();
};

EformTypeTree.prototype.clickCurrentNode = function(){
	var _this = this;
	var node = this.tree.getNodeByParam("id", this.selectedNodeId, null);
	var spanId = node.tId + "_span";
	$("#" + spanId + "").click();
};
//重新加载pId父节点的子节点（当父节点的子节点进行增、删、改后调用）
EformTypeTree.prototype.reAsyncChildNodes = function (pId) {
    var _this = this;

    var n = _this.tree.getNodeByParam("id", pId, null);
    if (!n.isParent)
        n.isParent = "true";
    _this.tree.reAsyncChildNodes(n, "refresh");
};
//删除id节点及其子节点（当父节点删除后调用）
EformTypeTree.prototype.removeNode = function (id) {
    var _this = this;

    _this.tree.removeNode(_this.tree.getNodeByParam("id", id, null));
};
//更新id节点自身数据（当父节点编辑后调用）
EformTypeTree.prototype.updateNode = function (id, name) {
    var _this = this;

    var node = _this.tree.getNodeByParam("id", id, null);
    node.name = name;

    _this.tree.updateNode(node);
};