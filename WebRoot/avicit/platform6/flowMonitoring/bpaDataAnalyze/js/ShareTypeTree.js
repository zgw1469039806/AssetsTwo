function ShareTypeTree(treeUL,orgId) {
    this.treeUL = treeUL;//tree位置
    this.orgId = orgId;
    this.tree = null;//tree对象
    this.selectedNodeId = null;//tree点击选中的节点
    this.init.call(this);
};
var retdata = '';
//初始化操作
ShareTypeTree.prototype.init = function () {
	var data = '';
    var _this = this;
    
    var setting = {
        
        async: {
            enable: true,
            url: "h5/view/select/SelectController/getProcessNodeTree1",//异步请求树子节点url
            autoParam: ["id"]//父节点id
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
                pIdkey: "pId"
            }
        },
        check: {
 			  enable: true,
 			  chkStyle: "checkbox",
			  chkboxType: { "Y": "s", "N": "ps" }
        },
        callback: {
        	onCheck:onCheck1
        }
    };
   
    //手动请求根节点数据
    $.ajax({
        url: "h5/view/select/SelectController/getProcessNodeTree1",
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
}