function CatalogTree(treeUL) {
    this.treeUL = treeUL;//tree位置
    this.tree = null;//tree对象
    this.selectedNodeId = null;//tree点击选中的节点
    this.init.call(this);
};
//初始化操作
CatalogTree.prototype.init = function (){
    var _this = this;

    var setting = {
        async: {
            enable: true,
            url: "bpm/deploy/getFlowTypeTree",//异步请求树子节点url
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
                var dbid = treeNode.id;
            	var name = treeNode.name;
            	if(!treeNode.pId){
            		return;
            	}
            	layer.confirm('确定要将流程模板移动到 '+name+' 下吗？', function (index) {
            	      $.ajax({
            	          url: "platform/bpm/bpmPublishAction/changeProcessCatalog",
            	          data: "dbId="+dbid+"&processDefId=" +processDefId,
            	          type: "post",
            	          async: false,
            	          dataType: "json",
            	          success: function (backData) {
            	          	if (backData.flag == "ok") {                  
            	                  layer.msg('操作成功！',{
            	                      icon: 1,
            	                      area: ['200px', ''],
            	                      closeBtn: 0
            	                  });
            	                  
            	                  parent.flowTypeTree.clickNode();
            	                  
            	                  parent.deployedFlow.closeDialog("changeCatalog");
            	              }
            	              else {
            	                  layer.msg('操作失败！',{
            	                      icon: 2,
            	                      area: ['200px', ''],
            	                      closeBtn: 0
            	                  });
            	              }               
            	          }
            	      });
            	  });
            }
        }
    };

    //手动请求根节点数据
    $.ajax({
        url: "bpm/deploy/getFlowTypeTree",
        data: "id=root",
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var zNodes = backData;
            _this.tree = $.fn.zTree.init($("#" + _this.treeUL), setting, zNodes);

            //_this.clickFirstRootNode();
        }
    });
};