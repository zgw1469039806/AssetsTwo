/**
 * Created by rx on 2017/9/13.
 */
function ConnectType() {
    this.init.call(this);
}
//初始化操作
ConnectType.prototype.init = function () {
};
//添加
ConnectType.prototype.addData = function () {
    var _this = this;
    var selectedNode = connectTypeTree.tree.getNodeByParam("id", connectTypeTree.selectedNodeId, null);

    if (selectedNode.pId == null || selectedNode.pId == "-1"||selectedNode.id.length>20) {
        layer.msg('请选择连接类型！',{icon: 7});
    }else{
    	addDialog = layer.open({
            type: 2,
            title: '添加分类',
            skin: 'bs-modal',
            area: ['60%', '60%'],
            maxmin: false,
            content: "platform/connectcenter/connectCenterController/addConnectType"
        });
    }
    
};
//编辑
ConnectType.prototype.editData = function () {
    var _this = this;

    var selectedNode = connectTypeTree.tree.getNodeByParam("id", connectTypeTree.selectedNodeId, null);

    if (selectedNode.pId == null || selectedNode.pId == "-1"||selectedNode.id.length<20) {
        layer.msg('请选择分类！',{icon: 7});
    }
    else {
        editDialog = layer.open({
            type: 2,
            title: '编辑分类',
            skin: 'bs-modal',
            area: ['60%', '60%'],
            maxmin: false,
            content: "platform/connectcenter/connectCenterController/editConnectType?id=" + connectTypeTree.selectedNodeId
        });
    }
};
//删除
ConnectType.prototype.deleteData = function () {
    var _this = this;

    var selectedNode = connectTypeTree.tree.getNodeByParam("id", connectTypeTree.selectedNodeId, null);

    if (selectedNode.id == null || selectedNode.id.length < 20) {
        layer.msg('请选择分类！',{icon: 7});
    }
    else {
        layer.confirm('确定要删除分类吗？', {
			icon : 3,
			title : '提示'
		}, function (index) {
            $.ajax({
                url: "platform/connectcenter/connectCenterController/deleteConnectType",
                data: "id=" + connectTypeTree.selectedNodeId,
                type: "post",
                async: false,
                dataType: "json",
                success: function (backData) {
                    if(backData.status == "error") {
                        layer.msg('操作失败！'+backData.msg,{icon: 2});
                    }
                    else {
                        connectTypeTree.removeNode(connectTypeTree.selectedNodeId);
                        connectTypeTree.selectedNodeId = null;
                        //点击第一个根节点
                        connectTypeTree.clickFirstSubNodeOfFirstRootNode();
                        layer.msg('操作成功！',{icon: 1});
                        }
                    }
            });
        });
    }
};
//表单验证
ConnectType.prototype.formValidate = function (form) {
    var _this = this;

    form.validate({
        rules: {
            name: {
                required: true,
                maxlength: 50
            },
            description: {
                required: false,
                maxlength: 200
            },
            orderBy: {
                required: true,
                maxlength: 6,
                integer: true
            },
            code:{
            	required: true,
                maxlength: 200
            }
        }
    });
};
//提交添加
ConnectType.prototype.subAdd = function (form) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/connectcenter/connectCenterController/subAddConnectType",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                connectTypeTree.reAsyncChildNodes(connectTypeTree.selectedNodeId);

                layer.msg('操作成功！',{icon: 1});

                _this.closeDialog("add");
            }
            else {
                layer.msg('操作失败！',{icon: 2});
            }
        }
    });
};
//提交编辑
ConnectType.prototype.subEdit = function (form) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/connectcenter/connectCenterController/subEditConnectType",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                connectTypeTree.updateNode(connectTypeTree.selectedNodeId);

                layer.msg('操作成功！',{icon: 1});

                _this.closeDialog("edit");
            }
            else {
                layer.msg('操作失败！',{icon: 2});
            }
        }
    });
};
//关闭弹出框
ConnectType.prototype.closeDialog = function (type) {
    if (type == "add") {
        layer.close(addDialog);
    }
    if (type == "edit") {
        layer.close(editDialog);
    }
};