/**
 * Created by lianch on 2018/3/5.
 */
function SearchType() {
    this.init.call(this);
}
//初始化操作
SearchType.prototype.init = function () {
};
//添加
SearchType.prototype.addData = function () {
    var _this = this;
    var ids = [];
    
    if (searchTypeTree.selectedNodeId == null) {
        layer.msg('请选择分类！',{icon: 7});
    }else{
    	 //判断树节点是否绑定索引信息
    	ids.push(searchTypeTree.selectedNodeId);
    	avicAjax.ajax({
			url : 'FulltextSearchInfoController/operation/judgeHaveInfo',
			data : JSON.stringify(ids),
			contentType : 'application/json',
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag== "no") {
    				addDialog = layer.open({
    		            type: 2,
    		            title: '添加分类',
    		            skin: 'bs-modal',
    		            area: ['60%', '60%'],
    		            maxmin: false,
    		            content: "platform/fulltextSearch/fulltextSearchController/addFulltextSearchType"
    		        });
    			} else {
    				layer.alert('此分类已存在索引配置信息，不能添加分类！', {
    					icon : 7,
    					area : [ '400px', '' ],
    					closeBtn : 0
    				});
    			}
			}
		});
    }
    
};
//编辑
SearchType.prototype.editData = function () {
    var _this = this;

    var selectedNode = searchTypeTree.tree.getNodeByParam("id", searchTypeTree.selectedNodeId, null);

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
            content: "platform/fulltextSearch/fulltextSearchController/editFulltextSearchType?id=" + searchTypeTree.selectedNodeId
        });
    }
};
//删除
SearchType.prototype.deleteData = function () {
    var _this = this;
    var ids = [];
    var selectedNode = searchTypeTree.tree.getNodeByParam("id", searchTypeTree.selectedNodeId, null);
    //非末级分类不能被删除
    if(selectedNode != null && selectedNode != '' && selectedNode != undefined){
        if(selectedNode.isParent){
            layer.msg("请先删除当前分类下的子分类！",{time:3000});
            return false;
        }
    }
    if (selectedNode.id == null || selectedNode.id.length < 20) {
        layer.msg('请选择分类！',{icon: 7});
    }
    else {
    	ids.push(selectedNode.id);
    	avicAjax.ajax({
			url : 'FulltextSearchInfoController/operation/judgeHaveInfo',
			data : JSON.stringify(ids),
			contentType : 'application/json',
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.flag== "no") {
					layer.confirm('确定要删除分类吗？', {
						icon : 3,
						title : '提示'
					}, function (index) {
			            $.ajax({
			                url: "platform/fulltextSearch/fulltextSearchController/deleteFulltextSearchType",
			                data: "id=" + searchTypeTree.selectedNodeId,
			                type: "post",
			                async: false,
			                dataType: "json",
			                success: function (backData) {
			                    if(backData.status == "error") {
			                        layer.msg('操作失败！'+backData.msg,{icon: 2});
			                    }
			                    else {
			                        searchTypeTree.removeNode(searchTypeTree.selectedNodeId);
			                        searchTypeTree.selectedNodeId = null;
			                        //点击第一个根节点
			                        searchTypeTree.clickFirstSubNodeOfFirstRootNode();
			                        layer.msg('操作成功！',{icon: 1});
			                        }
			                    }
			            });
			        });
    			} else {
    				layer.alert('此分类已存在索引配置信息，不能删除分类！', {
    					icon : 7,
    					area : [ '400px', '' ],
    					closeBtn : 0
    				});
    			}
			}
		});
        
    }
};
//表单验证
SearchType.prototype.formValidate = function (form) {
    var _this = this;

    form.validate({
        rules: {
            name: {
                required: true,
                maxlength: 1000
            },
            description: {
                required: false,
                maxlength: 1000
            },
            orderBy: {
                required: true,
                maxlength: 16,
                integer: true
            },
            code:{
            	required: true,
                maxlength: 50
            }
        }
    });
};
//提交添加
SearchType.prototype.subAdd = function (form) {
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
        url: "platform/fulltextSearch/fulltextSearchController/subAddFulltextSearchType",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                searchTypeTree.reAsyncChildNodes(searchTypeTree.selectedNodeId);

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
SearchType.prototype.subEdit = function (form) {
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
        url: "platform/fulltextSearch/fulltextSearchController/subEditFulltextSearchType",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                searchTypeTree.updateNode(searchTypeTree.selectedNodeId);

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
SearchType.prototype.closeDialog = function (type) {
    if (type == "add") {
        layer.close(addDialog);
    }
    if (type == "edit") {
        layer.close(editDialog);
    }
};