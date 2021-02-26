
function DiggerComponent(componentArea, componentDiv) {
    this.componentArea = componentArea;
    this.componentDiv = componentDiv;

    this.selectedEformComponentId = null;
    this.init.call(this);
}
//初始化操作
DiggerComponent.prototype.init = function () {
    var _this = this;

    var template = $(
          '<div class="eform-item" id="">'
            + '<div class="eform-item-title">'
                + '<i class="glyphicon glyphicon-envelope eform-item-group"></i>'
            + '</div>'
            + '<div class="eform-item-bottom">'
                + '<span class="eform-item-bottom-name" title="模块">模块</span>'
                + '<span class="eform-item-bottom-btn">'
                    + '<i class="glyphicon glyphicon-option-vertical"></i>'
                + '</span>'
            + '</div>'
            + '<div class="eform-item-tools" style="display: none;">'
                + '<div class="editComponent"><i class="glyphicon glyphicon-pencil"></i>编辑模块</div>'
                + '<div class="deleteComponent"><i class="glyphicon glyphicon-trash"></i>删除模块</div>'
                + '<div class="exportComponent"><i class="glyphicon glyphicon-export"></i>导出模块</div>'
            + '</div>'
//            + '<div class="eform-item-checkbox">'
//                + '<input type="checkbox">'
//            + '</div>'
        + '</div>'
    );

    this.template = template;
};
//页面新建一个EformComponent
DiggerComponent.prototype.setComponent = function (data) {
    var _this = this;

    var component = _this.template.clone();

    //相关属性
    component.attr("id", data.id);
    component.attr("sort", data.orderBy);

    //显示属性
    component.find(".eform-item-bottom-name").attr("title", data.componentName);
    if(data.componentName.length > 7) {
        component.find(".eform-item-bottom-name").text(data.componentName.substring(0, 5)+"...");
    }
    else {
        component.find(".eform-item-bottom-name").text(data.componentName);
    }

    //模块点击事件绑定
    component.find(".eform-item-title").click(function () {
        _this.clickTitle(data.id);
        return false;
    });

    //显隐工具栏按钮事件绑定
    component.find(".eform-item-bottom-btn").click(function () {
        $(".eform-item-tools").hide();
        component.find('.eform-item-tools').hide();
        component.find('.eform-item-tools').toggle(200);
        return false;
    });
    $('body').click(function () {
        component.find('.eform-item-tools').hide();
    });

    //工具栏事件绑定
    component.find(".deleteComponent").click(function () {
        _this.deleteData(data.id);
        return false;
    });
    component.find(".editComponent").click(function () {
        _this.editData(data.id);
        return false;
    });
    component.find(".exportComponent").click(function () {
        _this.exportData(data.id);
    	return false;
    });

    if($('#' + _this.componentDiv).find('.eform-item').length == 0) {
        $('#' + _this.componentDiv).append(component);
    }
    else {
        var idArray = [];
        var sortArray = [];
        $('#' + _this.componentDiv).find('.eform-item').each(function (index, element) {
            var $element = $(element);

            var id = $element.attr("id");
            var sort = $element.attr("sort");

            idArray.push(id);
            sortArray.push(sort);
        });

        for(var i = 0; i < sortArray.length; i++) {
            if(data.orderBy <= sortArray[i]) {
                $('#' + _this.componentDiv).find("#" + idArray[i]).before(component);

                break;
            }

            if(i == sortArray.length - 1) {
                $('#' + _this.componentDiv).append(component);
            }
        }
    }
};

DiggerComponent.prototype.clickTitle = function (id){
	if (id != undefined)
		this.selectedEformComponentId = id;
	moduleType = "2";
    $("." + diggerFormInfo.formArea).css("display", "");
    $("." + diggerComponent.componentArea).css("display", "none");
    if(showType=="1"){	
	    //获取该模块下电子表单列表
        diggerFormInfo.getFormInfoList(this.selectedEformComponentId);
	    // eformFormView.getViewInfoList(this.selectedEformComponentId);
	    // bpmsFormInfo.getFormInfoList(this.selectedEformComponentId);
    }else{
    	if(eformFormViewModel==null || eformFormViewModel==undefined){
			var searchSubNames = [];
			var searchSubTips = [];
			searchSubNames.push("name");
			searchSubTips.push("名称");
			$('#formViewModel_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
			var module = [
				{
					label : 'id',
					name : 'id',
					key : true,
					hidden : true
				}			
				, {
					label : '名称',
					name : 'diggername',
					width : 40,
					align : 'left',
					sortable : true,
					formatter:getformviewEdit
				}
				,{
					label : '编码',
					name : 'diggercode',
					width : 30,
					align : 'left',
					sortable : true
				},
				{
					label : '类型',
					name : 'diggertype',
					width : 30,
					align : 'left',
					sortable : true,
					formatter:getDiggerType
				}
				
				,  {
					label : '操作',
					name : 'opt',
					width : 35,
					align : 'left',
					sortable : false,
					formatter:getformviewButtons
				}
			];

			// var url = "platform/digger/bpmsManageController/getFormViewByPage";
			var url = "platform/digger/diggerManageController/getDiggerViewByPage";
			eformFormViewModel = new DiggerFormViewModel('formViewModel', url, "formSub", module, 'searchDialogSub', this.selectedEformComponentId,
					"", searchSubNames, "formViewModel_keyWord");
		}else{
			eformFormViewModel.reLoad(this.selectedEformComponentId);
            $(window).resize();
		}


        if (bpmsformInfoModel==null || bpmsformInfoModel==undefined){
            var searchBpmNames = [];
            var searchBpmTips = [];
            searchBpmNames.push("formName");
            searchBpmTips.push("名称");
            $('#bpmFormModel_keyWord').attr('placeholder', '请输入' + searchBpmTips[0]);
            bpmsformInfoModel = new DiggerFormViewModel('bpmFormModel', "bpmFormSub", 'searchBpmForm', this.selectedEformComponentId,
                "", searchBpmNames, "bpmFormModel_keyWord");
        }else{
            bpmsformInfoModel.reLoad(this.selectedEformComponentId);
        }
    }
    $('.nav-tabs>li').eq(0).trigger("click");
};


//添加
DiggerComponent.prototype.addData = function () {
    var _this = this;

    var selectedNode = diggerTypeTree.tree.getNodeByParam("id", diggerTypeTree.selectedNodeId, null);
    if (diggerTypeTree.selectedNodeId == "undefined" || diggerTypeTree.selectedNodeId.indexOf( "undefined")>-1) {
        top.layer.msg('不能在未分类节点下添加模块！',{icon: 7});
        return;
    }
    if (selectedNode.pId == null || selectedNode.pId == "-1") {
        layer.msg('不能在根目录添加模块！', {icon: 7});
    }else{
        addDialog = layer.open({
            type: 2,
            title: '添加模块',
            closeBtn : 0,
            skin: 'bs-modal',
            area: ['60%', '60%'],
            maxmin: false,
            content: "platform/digger/diggerManageController/addDiggerComponent?diggerTypeId=" + diggerTypeTree.selectedNodeId
        });	
    }
};
//编辑
DiggerComponent.prototype.editData = function (componentId) {
    var _this = this;

    if (diggerTypeTree.selectedNodeId=="undefined" || diggerTypeTree.selectedNodeId.indexOf( "undefined")>-1) {
        top.layer.msg('不能编辑原有流程表单！',{icon: 7});
        return;
    }
    
    editDialog = layer.open({
        type: 2,
        title: '编辑模块',
        closeBtn : 0,
        skin: 'bs-modal',
        area: ['60%', '60%'],
        maxmin: false,
        content: "platform/digger/diggerManageController/editDiggerComponent?id=" + componentId
    });
};
//删除
DiggerComponent.prototype.deleteData = function (eformComponentId) {
    var _this = this;
    if (diggerTypeTree.selectedNodeId=="undefined" || diggerTypeTree.selectedNodeId.indexOf( "undefined")>-1) {
        top.layer.msg('不能删除原有流程表单！',{icon: 7});
        return;
    }
    
    layer.confirm('确定要删除模块吗？该模块下所有报表将会被删除！', {
		icon : 3,
		title : '提示',
		closeBtn : 0 ,
		area: ['400px', '']
	},function (index) {
        $.ajax({
            url: "platform/digger/diggerManageController/deleteDiggerComponent",
            data: "id=" + eformComponentId,
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                if (backData.result == "1") {
                    var component = $('#' + _this.componentDiv).find("#" + eformComponentId);
                    component.remove();
                    if (diggerComponentModel!=null && typeof(diggerComponentModel)!="undefined")
                    	diggerComponentModel.reLoad(diggerTypeTree.selectedNodeId);
                    layer.msg('操作成功！',{icon: 1});
                }
                else {
                    layer.msg('操作失败！',{icon: 2});
                }
            }
        });
    });
};
//导出
DiggerComponent.prototype.exportData = function (eformComponentId) {
    var _this = this;
   /* if (eformTypeTree.selectedNodeId=="undefined" || eformTypeTree.selectedNodeId.indexOf( "undefined")>-1) {
        top.layer.msg('不能导出原有流程表单！',{icon: 7});
        return;
    }*/
    
    exportDialog = layer.open({
        type: 2,
        title: '导出模块',
        closeBtn : 0,
        skin: 'bs-modal',
        area: ['60%', '60%'],
        maxmin: false,
        content: "platform/eform/bpmsManageController/exportEformComponent?id=" + eformComponentId
    });
};



//表单验证
DiggerComponent.prototype.formValidate = function (form) {
    var _this = this;

    form.validate({
        rules: {
            componentName: {
                required: true,
                maxlength: 50
            },
            moduleName: {
                required: true,
                maxlength: 50
            },
            packagePath: {
                required: true,
                maxlength: 50
            },
            componentDesc: {
                required: false,
                maxlength: 200
            },
            orderBy: {
                required: true,
                maxlength: 6,
                integer: true
            }
        }
    });
};
//提交添加
DiggerComponent.prototype.subAdd = function (form) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var componentName = form.find("#componentName").val();
    var componentDesc = form.find("#componentDesc").val();
	if(componentName.indexOf("\"") !== -1 || componentName.indexOf("\\") !== -1
			||componentDesc.indexOf("\"") !== -1 || componentDesc.indexOf("\\") !== -1) {
        layer.msg('不允许输入特殊字符“"”和“\\”！', {icon: 7});
        return false;
    }

    
    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/digger/diggerManageController/subAddDiggerComponent",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                _this.setComponent(backData.data);
                if (diggerComponentModel != null && typeof(diggerComponentModel)!="undefined")
                	diggerComponentModel.reLoad(diggerTypeTree.selectedNodeId);
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
DiggerComponent.prototype.subEdit = function (form) {
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
        url: "platform/digger/diggerManageController/subEditDiggerComponent",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                var component = $('#' + _this.componentDiv).find("#" + backData.data.id);
                component.remove();
                _this.setComponent(backData.data);
                if (diggerComponentModel!=null && typeof(diggerComponentModel)!="undefined")
                    diggerComponentModel.reLoad(diggerTypeTree.selectedNodeId);
                layer.msg('操作成功！',{icon: 1});

                _this.closeDialog("edit");
            }
            else {
                layer.msg('操作失败！',{icon: 2});
            }
        }
    });
};

//提交导出
DiggerComponent.prototype.subExport = function (form) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var formSerializeValue = form.serialize();
    window.open(baseUrl+"platform/eform/BpmsExportController/subExportEformComponent?"+formSerializeValue,"_blank");
    _this.closeDialog("export");
    /*$.ajax({
        url: "platform/eform/BpmsExportController/subExportEformComponent",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData == true) {
                /!*var component = $('#' + _this.componentDiv).find("#" + backData.data.id);
                component.remove();
                _this.setComponent(backData.data);
                if (eformComponentModel!=null && typeof(eformComponentModel)!="undefined")
                	eformComponentModel.reLoad(eformTypeTree.selectedNodeId);*!/
            	layer.msg('操作成功！',{icon: 1});
                _this.closeDialog("export");
            }
            else {
                layer.msg('操作失败！',{icon: 2});
            }
        }
    });*/
};

//关闭弹出框
DiggerComponent.prototype.closeDialog = function (type) {
    if (type == "add") {
        layer.close(addDialog);
    }
    if (type == "edit") {
        layer.close(editDialog);
    }
    if (type=="export"){
    	layer.close(exportDialog)
    }
};
//获取模型模块列表
DiggerComponent.prototype.getComponentList = function (selectedNodeId) {
    var _this = this;
    if(showType=="2"){		
		if(diggerComponentModel==null || diggerComponentModel==undefined){
			var searchSubNames = [];
			var searchSubTips = [];
			searchSubNames.push("componentName");
			searchSubTips.push("模块名称");
			$('#componentModel_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
			var componentModelGridColModel = [
				{
					label : 'id',
					name : 'id',
					key : true,
					hidden : true
				}			
				, {
					label : '模块名称',
					name : 'componentName',
					width : 40,
					align : 'left',
					sortable : true,
					formatter:getEdit
				}
				,{
					label : '排序',
					name : 'orderBy',
					width : 30,
					align : 'left',
					sortable : true
				},
				{
					label : '描述',
					name : 'componentDesc',
					width : 50,
					align : 'left',
					sortable : true
				}
				
				,  {
					label : '操作',
					name : 'opt',
					width : 35,
					align : 'center',
					sortable : false,
					formatter:getOptButtons
				}
			];

			var url = "platform/digger/diggerManageController/getComponentByPage";
			diggerComponentModel = new DiggerComponentModel('componentModel', url, "formSub", componentModelGridColModel, 'searchDialogSub', selectedNodeId,
					"", searchSubNames, "componentModel_keyWord");
		}else{
            diggerComponentModel.reLoad(selectedNodeId);
		}

        $(window).resize();
	}else{
	    $('#' + _this.componentDiv).empty();
	    $.ajax({
	        url: "platform/digger/diggerManageController/getComponentList",
	        data: "selectedNodeId=" + selectedNodeId,
	        type: "post",
	        async: false,
	        dataType: "json",
	        success: function (backData) {
	            var componentList = backData.data;
	
	            for (var i = 0; i < componentList.length; i++) {
	                _this.setComponent(componentList[i]);
	            }
	        }
	    });
	}
};

function getformviewEdit(cellvalue, options, rowObject){
		return '<a href="javascript:void(0)" '
		+'  title="'+cellvalue+'" onClick="openDesigner(\'' + rowObject.id + '\');return false;">'+cellvalue+'</a>';
}

function openDesigner(id){
        var url = baseUrl+"platform/digger/diggerManageController/designDiggerInfo/" + id;
        window.open(url, "_blank");
}


function getDiggerType(cellvalue, options, rowObject){
	if(cellvalue == "0"){
		return '统计';
	} else if(cellvalue == "1"){
		return '图表';
	} else if(cellvalue == "2"){
        return '普通';
    } else if(cellvalue == "3"){
        return '交叉';
    }
}


function getformviewButtons(cellvalue, options, rowObject) {
    return '<a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
        +'   title="删除" onClick="deleteData(\''+rowObject.id+'\')"></a>';
}

function deleteData(infoId){
    var _this = this;
    var message = "确定要删除吗？";
    layer.confirm(message, {
        icon: 3,
        title: '提示',
        closeBtn: 0,
        area: ['400px', '']
    }, function (index) {
        $.ajax({
            type: "get",
            dataType:"text",
            url: "platform/digger/diggerManageController/deleteDiggerFormInfo?id=" + infoId,
            success: function(data) {
                if (data == "1") {
                    $('#formViewModel').jqGrid().trigger("reloadGrid");
                    layer.msg('操作成功！', {icon: 1});
                }
                else {
                    layer.msg('操作失败！', {icon: 2});
                }
            },
            error : function(e){
                alert(e);
            }
        });
    });
}

function getEdit(cellvalue, options, rowObject){
	return '<a href="javascript:void(0)" '
	//+'  title="模块名称" onClick="eformComponent.clickTitle(\''+rowObject.id+'\')">'+rowObject.componentName+'</a>';
	+'  title="'+rowObject.componentName+'" onClick="diggerComponent.clickTitle(\''+rowObject.id+'\')">'+rowObject.componentName+'</a>';
}

function getOptButtons(cellvalue, options, rowObject) {
	
	return '<a href="javascript:void(0)" class="glyphicon glyphicon-pencil"'
		+'  title="编辑" onClick="diggerComponent.editData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
		+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
		+'   title="删除" onClick="diggerComponent.deleteData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
		;
	
	
}