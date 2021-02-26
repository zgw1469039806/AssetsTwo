/**
 * Created by xb on 2017/5/11.
 */
function DiggerTypeTree(treeUL) {
    this.treeUL = treeUL;//tree位置
    this.tree = null;//tree对象
    this.selectedNodeId = null;//tree点击选中的节点
    this.init.call(this);
}
//初始化操作
DiggerTypeTree.prototype.init = function () {
    var _this = this;

    var setting = {
        async: {
            enable: true,
            url: "platform/digger/diggerManageController/getModelTypeTree",//异步请求树子节点url
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
            selectedMulti: false//进制按住ctrl多选
        },
        callback: {
            //节点点击事件
            onClick: function (event, treeId, treeNode) {
            	moduleType = "1";
                _this.selectedNodeId = treeNode.id;
                $("." + diggerComponent.componentArea).css("display", "");
                $("." + diggerFormInfo.formArea).css("display", "none");

                diggerComponent.selectedEformComponentId = null;
                //获取该分类下的模块列表
                diggerComponent.getComponentList(_this.selectedNodeId);
            }
        }
    };

    //手动请求根节点数据
    $.ajax({
        url: "platform/digger/diggerManageController/getModelTypeTree",
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
DiggerTypeTree.prototype.clickFirstSubNodeOfFirstRootNode = function () {
    var _this = this;
    moduleType = "1";
    var firstRootNode = _this.tree.getNodeByParam("pId", null, null);
    var firstSubNodeOfFirstRootNode = _this.tree.getNodeByParam("pId", firstRootNode.id, null);
    if (firstSubNodeOfFirstRootNode) {
        var spanId = firstSubNodeOfFirstRootNode.tId + "_span";
        $("#" + spanId).click();
    }else{
        var spanId = firstRootNode.tId + "_span";
        $("#" + spanId).click();
    }
};

DiggerTypeTree.prototype.clickNode = function () {
	  var _this = this;
	  moduleType = "1";
	  var node = _this.tree.getNodeByParam("id", _this.selectedNodeId);
	  $("#"+node.tId+"_span").click();
};

//重新加载pId父节点的子节点
DiggerTypeTree.prototype.reAsyncChildNodes = function (pId) {
    var _this = this;

    var n = _this.tree.getNodeByParam("id", pId, null);
    if (!n.isParent)
        n.isParent = "true";
    _this.tree.reAsyncChildNodes(n, "refresh");
};
//删除id节点及其子节点
DiggerTypeTree.prototype.removeNode = function (id) {
    var _this = this;

    _this.tree.removeNode(_this.tree.getNodeByParam("id", id, null));
};
//更新id节点
DiggerTypeTree.prototype.updateNode = function (id) {
    var _this = this;

    var node = _this.tree.getNodeByParam("id", id, null);
    _this.reAsyncChildNodes(node.pId);

    var spanId = _this.tree.getNodeByParam("id", node.pId, null).tId + "_span";
    $("#" + spanId + "").click();
};