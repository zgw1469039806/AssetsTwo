/**
 * Created by xb on 2017/5/11.
 */
function EformType() {
    this.init.call(this);
};
//初始化操作
EformType.prototype.init = function () {
};
//添加
EformType.prototype.add = function () {
    var _this = this;

    if (dbTableTypeTree.selectedNodeId == null) {
        layer.alert('请选择树节点！');
    }
    else {
        addDialog = layer.open({
            type: 2,
            title: '添加模型分类',
            closeBtn : 0,
            skin: 'bs-modal',
            area: ['60%', '60%'],
            maxmin: false,
            content: "platform/db/dbTableManageController/toAddDbTableType"
        });
    }
};
//编辑
EformType.prototype.edit = function () {
    var _this = this;

    if (dbTableTypeTree.selectedNodeId == null) {
        layer.alert('请选择树节点！');
    }
    else if(dbTableTypeTree.selectedNodeId == "1"){
    	layer.msg('不能编辑根节点！', {icon: 7});
    }
    else {
        editDialog = layer.open({
            type: 2,
            title: '编辑模型分类',
            closeBtn : 0,
            skin: 'bs-modal',
            area: ['60%', '60%'],
            maxmin: false,
            content: "platform/db/dbTableManageController/editDbTableType?id=" + dbTableTypeTree.selectedNodeId
        });
    }
};
//删除
EformType.prototype.deleteType = function () {
    var _this = this;

    if (dbTableTypeTree.selectedNodeId == null) {
        layer.alert('请选择树节点！');
    }
    else {
        var selectedNode = dbTableTypeTree.tree.getNodeByParam("id", dbTableTypeTree.selectedNodeId, null);

        if (selectedNode.pId == null || selectedNode.pId == "-1") {
            layer.msg('不能删除根节点！', {icon: 7});
        }
        else {
            layer.confirm('确认删除分类吗？', {title: '提示',icon : 3,area: ['400px', '']},function (index) {
                $.ajax({
                    url: "platform/db/dbTableManageController/deleteDbTableType",
                    data: "id=" + dbTableTypeTree.selectedNodeId,
                    type: "post",
                    async: false,
                    dataType: "json",
                    success: function (backData) {
                        if (backData.result == "1") {
                            dbTableTypeTree.removeNode(dbTableTypeTree.selectedNodeId);
                            dbTableTypeTree.selectedNodeId = null;

                            //点击第一个根节点
                            dbTableTypeTree.clickFirstRootNode();

                            layer.msg('操作成功');
                        }else if(backData.result == "-1"){
                        	layer.alert('当前节点存在子节点，请先删除子节点！', {
                        		title: '提示',
    							icon : 7,
    							area : [ '400px', '' ],                       
    							closeBtn : 0
    						});
                        }else if(backData.result == "-2"){
                        	layer.alert('该分类下存在数据模型，不允许删除！', {
                        		title: '提示',
    							icon : 7,
    							area : [ '400px', '' ],
    							closeBtn : 0
    						});
                        }
                        else {
                            layer.msg('操作失败');
                        }
                    }
                });
            });
        }
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

    var name = form.find("#name").val();
    if(name.indexOf("\"") !== -1 || name.indexOf("\\") !== -1) {
        layer.msg('名称不能含有特殊字符！', {icon: 7});
        return false;
    }
    
    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/db/dbTableManageController/addDbTableType",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                dbTableTypeTree.reAsyncChildNodes(dbTableTypeTree.selectedNodeId);
                layer.msg('操作成功');

                _this.closeDialog("add");
            }else if (backData.result == "2"){
            	layer.msg('名称重复，请检查！');
            }
            else {
                layer.msg('操作失败');
            }
        }
    });
};
//提交编辑
EformType.prototype.subEdit = function (form, nodeName) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var name = form.find("#name").val();
    if(name.indexOf("\"") !== -1 || name.indexOf("\\") !== -1) {
        layer.msg('名称不能含有特殊字符！', {icon: 7});
        return false;
    }
    
    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/db/dbTableManageController/subEditDbTableType",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                dbTableTypeTree.updateNode(dbTableTypeTree.selectedNodeId, nodeName);
                layer.msg('操作成功');

                _this.closeDialog("edit");
            }else if (backData.result == "2"){
            	layer.msg('名称重复，请检查！');
            }
            else {
                layer.msg('操作失败');
            }
        }
    });
};

EformType.prototype.importTable = function(){
	 var _this = this;

	    if (dbTableTypeTree.selectedNodeId == null) {
	        layer.alert('请选择树节点！');
	    }
	    else if (dbTableTypeTree.selectedNodeId == "1") {
	        layer.msg('不能在根节点导入表模型！', {icon: 7});
	    }
	    else {
	        importDialog = layer.open({
	            type: 2,
	            title: '导入本地数据表',
	            skin: 'bs-modal',
	            area: ['60%', '60%'],
	            maxmin: false,
	            content: "platform/db/dbTableManageController/toImportJsp"
	        });
	    }
};
EformType.prototype.importOutTable = function(){
	 var _this = this;

	    if (dbTableTypeTree.selectedNodeId == null) {
	        layer.alert('请选择树节点！');
	    }
	    else if (dbTableTypeTree.selectedNodeId == "1") {
	        layer.msg('不能在根节点导入表模型！', {icon: 7});
	    }
	    else {
	    	importOutDialog = layer.open({
	            type: 2,
	            title: '选择数据源',
	            skin: 'bs-modal',
	            area: ['60%', '60%'],
	            maxmin: false,
	            content: "platform/db/dbTableManageController/toImportOutJsp"
	        });
	    }
};
//关闭弹出框
EformType.prototype.closeDialog = function (type) {
    if (type == "add") {
        layer.close(addDialog);
    }
    if (type == "edit") {
        layer.close(editDialog);
    }
    if (type =="import"){
    	layer.close(importDialog);
    }
    if (type =="importOut"){
    	layer.close(importOutDialog);
    }
};