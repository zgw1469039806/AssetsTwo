/**
 * Created by xb on 2017/5/11.
 */
function EformType() {
    this.init.call(this);
}
//初始化操作
EformType.prototype.init = function () {
};
//添加
EformType.prototype.addData = function () {
    var _this = this;
    
    var selectedNode = eformTypeTree.tree.getNodeByParam("id", eformTypeTree.selectedNodeId, null);
    
    if (selectedNode.id=="undefined" || selectedNode.id.indexOf( "undefined")>-1) {
        top.layer.msg('不能在未分类节点下添加分类！',{icon: 7});
        return;
    }

    addDialog = layer.open({
        type: 2,
        title: '添加分类',
        closeBtn : 0,
        skin: 'bs-modal',
        area: ['60%', '60%'],
        maxmin: false,
        content: "platform/eform/bpmsManageController/addEformType"
    });
};
//编辑
EformType.prototype.editData = function () {
    var _this = this;

    var selectedNode = eformTypeTree.tree.getNodeByParam("id", eformTypeTree.selectedNodeId, null);

    if (selectedNode.pId == null || selectedNode.pId == "-1") {
        layer.msg('不能编辑根节点！',{icon: 7});
        return;
    }
    
    if (selectedNode.id=="undefined" || selectedNode.id.indexOf( "undefined")>-1) {
        top.layer.msg('不能编辑未分类节点！',{icon: 7});
        return;
    }

    editDialog = layer.open({
          type: 2,
          title: '编辑分类',
          closeBtn : 0,
          skin: 'bs-modal',
          area: ['60%', '60%'],
          maxmin: false,
          content: "platform/eform/bpmsManageController/editEformType?id=" + eformTypeTree.selectedNodeId
     });

};
//删除
EformType.prototype.deleteData = function () {
    var _this = this;

    var selectedNode = eformTypeTree.tree.getNodeByParam("id", eformTypeTree.selectedNodeId, null);
    
    if (selectedNode.id=="undefined" || selectedNode.id.indexOf( "undefined")>-1) {
        top.layer.msg('不能删除未分类节点！',{icon: 7});
        return;
    }
    
    if (selectedNode.pId == null || selectedNode.pId == "-1") {
        layer.msg('不能删除根节点！',{icon: 7});
    }
    else {
        layer.confirm('确定要删除分类吗？', {
			icon : 3,
			title : '提示',
			closeBtn : 0 ,
			area: ['400px', '']
		}, function (index) {
			layer.close(index);
            $.ajax({
                url: "platform/eform/bpmsManageController/deleteEformType",
                data: "id=" + eformTypeTree.selectedNodeId,
                type: "post",
                async: false,
                dataType: "json",
                success: function (backData) {
                    if(backData.status == "error") {
                    	top.layer.msg(backData.msg,{icon: 2});
                    }
                    else {
                        if (backData.result == "1") {
                            eformTypeTree.removeNode(eformTypeTree.selectedNodeId);
                            eformTypeTree.selectedNodeId = null;

                            //点击第一个根节点
                            eformTypeTree.clickFirstSubNodeOfFirstRootNode();

                            top.layer.msg('操作成功！',{icon: 1});
                        }
                        else {
                        	top.layer.msg('操作失败！',{icon: 2});
                        }
                    }
                }
            });
        });
    }
};
//表单验证
EformType.prototype.formValidate = function (form) {
    var _this = this;

    form.validate({
        rules: {
            name: {
                required: true,
                maxlength: 50
            },
            description: {
                required: true,
                maxlength: 200
            },
            sort: {
                required: true,
                maxlength: 6,
                integer: true
            }
        }
    });
};
//提交添加
EformType.prototype.subAdd = function (form) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    form.find("textarea").eq(0).val(form.find("textarea").eq(0).val().replace(/\n/g,""));//去掉回车换行

    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/eform/bpmsManageController/subAddEformType",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                eformTypeTree.reAsyncChildNodes(eformTypeTree.selectedNodeId);

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
EformType.prototype.subEdit = function (form) {
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
        url: "platform/eform/bpmsManageController/subEditEformType",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                eformTypeTree.updateNode(eformTypeTree.selectedNodeId);

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
EformType.prototype.closeDialog = function (type) {
    if (type == "add") {
        layer.close(addDialog);
    }
    if (type == "edit") {
        layer.close(editDialog);
    }
};