function FlowType() {
    this.init.call(this);
};
//初始化操作
FlowType.prototype.init = function () {
};
//添加
FlowType.prototype.add = function () {
    var _this = this;

    if (flowTypeTree.selectedNodeId == null) {
        layer.alert('请选择树节点！');
    }
    else {
        addDialog = layer.open({
            type: 2,
            title: '添加流程分类',
            skin: 'bs-modal',
            area: ['60%', '60%'],
            maxmin: false,
            content: "avicit/platform6/bpmreform/bpmdeploy/addFlowType.jsp"
        });
    }
};
//编辑
FlowType.prototype.edit = function () {
    var _this = this;

    if (flowTypeTree.selectedNodeId == null) {
        layer.alert('请选择树节点！');
    }
    var selectedNode = flowTypeTree.tree.getNodeByParam("id", flowTypeTree.selectedNodeId, null);

    /**
    if (selectedNode.id == null || selectedNode.id == "-1") {
    	flowUtils.warning('不能编辑根节点！');
    	return;
    }else if(!flowTypeTree.selectedNodePId){
	  flowUtils.warning('不能编辑根节点！');
      return;
   }else {
        editDialog = layer.open({
            type: 2,
            title: '编辑流程分类',
            skin: 'bs-modal',
            area: ['60%', '60%'],
            maxmin: false,
            content: "bpm/deploy/editFlowType?id=" + flowTypeTree.selectedNodeId
        });
    }*/
    editDialog = layer.open({
        type: 2,
        title: '编辑流程分类',
        skin: 'bs-modal',
        area: ['60%', '60%'],
        maxmin: false,
        content: "bpm/deploy/editFlowType?id=" + flowTypeTree.selectedNodeId
    });
};
//删除
FlowType.prototype.del = function () {
    var _this = this;

    if (flowTypeTree.selectedNodeId == null) {
    	flowUtils.warning('请选择树节点！');
    }
    else {
        var selectedNode = flowTypeTree.tree.getNodeByParam("id", flowTypeTree.selectedNodeId, null);

        if (selectedNode.id == null || selectedNode.id == "-1") {
        	flowUtils.warning('不能删除根节点！');
        }else if(!flowTypeTree.selectedNodePId){
		  flowUtils.warning('不能删除根节点！');
	      return;
	   } else {
        	flowUtils.confirm('确定要删除分类吗', function (index) {
        		avicAjax.ajax({
                    url: "bpm/deploy/deleteFlowType",
                    data: "id=" + flowTypeTree.selectedNodeId,
                    type: "post",
                    dataType: "json",
                    success: function (backData) {
                        if (backData.result == "0") {
                            flowTypeTree.removeNode(flowTypeTree.selectedNodeId);
                            flowTypeTree.selectedNodeId = null;

                            //点击第一个根节点
                            flowTypeTree.clickFirstRootNode();

                            layer.msg('操作成功');
                        }
                        else {
                            layer.msg('该分类下有子分类或流程模板，无法删除！');
                        }
                    }
                });
            });
        }
    }
};
//表单验证
FlowType.prototype.formValidate = function (form) {
    var _this = this;

    form.validate({
    	messages : {
    		name: {
                required: "必填",
                maxlength: "最大长度200"
            },
            /*code: {
                required: "必填",
                maxlength: "最大长度100"
            },*/
            orderBy: {
                required: "必填",
                maxlength: "最大长度6",
                integer: "请输入整数"
            }
    	},
        rules: {
            name: {
                required: true,
                maxlength: 200
            },
           /* code: {
                required: true,
                maxlength: 100
            },*/
            orderBy: {
                required: true,
                maxlength: 6,
                integer: true
            }
        }
    });
};
//提交添加
FlowType.prototype.subAdd = function (form) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }
    $.ajax({
        url: "bpm/deploy/addFlowType",
        data : {
			 data :JSON.stringify(serializeObject(form))
		 		},
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                flowTypeTree.reAsyncChildNodes(flowTypeTree.selectedNodeId);
                layer.msg('操作成功');

                _this.closeDialog("add");
            }
            else {
                layer.msg('操作失败');
            }
        }
    });
};
//提交编辑
FlowType.prototype.subEdit = function (form, nodeName) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }
    $.ajax({
        url: "bpm/deploy/subEditFlowType",
        data : {
			 data :JSON.stringify(serializeObject(form))
		 		},
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                flowTypeTree.updateNode(flowTypeTree.selectedNodeId, nodeName);
                layer.msg('操作成功');

                _this.closeDialog("edit");
            }
            else {
                layer.msg('操作失败');
            }
        }
    });
};
//关闭弹出框
FlowType.prototype.closeDialog = function (type) {
    if (type == "add") {
        layer.close(addDialog);
    }
    if (type == "edit") {
        layer.close(editDialog);
    }
};
