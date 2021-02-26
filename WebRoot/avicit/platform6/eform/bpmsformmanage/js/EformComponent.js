/**
 * Created by xb on 2017/5/11.
 */
function EformComponent(componentArea, componentDiv) {
    this.componentArea = componentArea;
    this.componentDiv = componentDiv;

    this.selectedEformComponentId = null;
    this.init.call(this);
}
//初始化操作
EformComponent.prototype.init = function () {
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
                + '<div class="exportLog"><i class="glyphicon glyphicon-book"></i>模块导出记录</div>'
            + '</div>'
//            + '<div class="eform-item-checkbox">'
//                + '<input type="checkbox">'
//            + '</div>'
        + '</div>'
    );

    this.template = template;
};
//页面新建一个EformComponent
EformComponent.prototype.setComponent = function (data) {
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

    component.find(".exportLog").click(function () {
        _this.exportLog(data.id);
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

EformComponent.prototype.clickTitle = function (id){
    $("#searchInput").val("");
	if (id != undefined)
		this.selectedEformComponentId = id;
	moduleType = "2";
    $("." + eformFormInfo.formArea).css("display", "");
    $("." + eformComponent.componentArea).css("display", "none");
    if(showType=="1"){	
	    //获取该模块下电子表单列表
	    eformFormInfo.getFormInfoList(this.selectedEformComponentId);
	    eformFormView.getViewInfoList(this.selectedEformComponentId);
	    bpmsFormInfo.getFormInfoList(this.selectedEformComponentId);
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
					name : 'name',
					width : 40,
					align : 'left',
					sortable : true,
					formatter:getformviewEdit
				}
				,{
					label : '编码',
					name : 'code',
					width : 30,
					align : 'left',
					sortable : true
				},
				{
					label : '样式',
					name : 'style',
					width : 30,
					align : 'left',
					sortable : true,
					hidden:true
				},
				{
					label : '状态',
					name : 'status',
					width : 30,
					align : 'left',
					sortable : true,
					formatter:getformviewStatus
				},
				{
					label : '类型',
					name : 'type',
					width : 30,
					align : 'left',
					sortable : true,
					formatter:getformviewType
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

			var url = "platform/eform/bpmsManageController/getFormViewByPage";
			eformFormViewModel = new EformFormViewModel('formViewModel', url, "formSub", module, 'searchDialogSub', this.selectedEformComponentId, 
					"", searchSubNames, "formViewModel_keyWord");
		}else{
			eformFormViewModel.reLoad(this.selectedEformComponentId);
		}


        if (bpmsformInfoModel==null || bpmsformInfoModel==undefined){
            var searchBpmNames = [];
            var searchBpmTips = [];
            searchBpmNames.push("formName");
            searchBpmTips.push("名称");
            $('#bpmFormModel_keyWord').attr('placeholder', '请输入' + searchBpmTips[0]);
            bpmsformInfoModel = new EformFormInfoModel('bpmFormModel', "bpmFormSub", 'searchBpmForm', this.selectedEformComponentId,
                "", searchBpmNames, "bpmFormModel_keyWord");
        }else{
            bpmsformInfoModel.reLoad(this.selectedEformComponentId);
        }
    }
    $('.nav-tabs>li').eq(0).trigger("click");
};


//添加
EformComponent.prototype.addData = function () {
    var _this = this;

    var selectedNode = eformTypeTree.tree.getNodeByParam("id", eformTypeTree.selectedNodeId, null);
    if (eformTypeTree.selectedNodeId=="undefined" || eformTypeTree.selectedNodeId.indexOf( "undefined")>-1) {
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
            content: "platform/eform/bpmsManageController/addEformComponent"
        });	
    }
};
//编辑
EformComponent.prototype.editData = function (eformComponentId) {
    var _this = this;

    if (eformTypeTree.selectedNodeId=="undefined" || eformTypeTree.selectedNodeId.indexOf( "undefined")>-1) {
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
        content: "platform/eform/bpmsManageController/editEformComponent?id=" + eformComponentId
    });
};
//删除
EformComponent.prototype.deleteData = function (eformComponentId) {
    var _this = this;
    if (eformTypeTree.selectedNodeId=="undefined" || eformTypeTree.selectedNodeId.indexOf( "undefined")>-1) {
        top.layer.msg('不能删除原有流程表单！',{icon: 7});
        return;
    }
    
    layer.confirm('确定要删除模块吗？该模块下所有表单将会被删除！', {
		icon : 3,
		title : '提示',
		closeBtn : 0 ,
		area: ['400px', '']
	},function (index) {
        $.ajax({
            url: "platform/eform/bpmsManageController/deleteEformComponent",
            data: "id=" + eformComponentId,
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                if (backData.result == "1") {
                    var component = $('#' + _this.componentDiv).find("#" + eformComponentId);
                    component.remove();
                    if (eformComponentModel!=null && typeof(eformComponentModel)!="undefined")
                    	eformComponentModel.reLoad(eformTypeTree.selectedNodeId);
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
EformComponent.prototype.exportData = function (eformComponentId) {
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


EformComponent.prototype.exportLog = function (eformComponentId) {
    var _this = this;
    /* if (eformTypeTree.selectedNodeId=="undefined" || eformTypeTree.selectedNodeId.indexOf( "undefined")>-1) {
         top.layer.msg('不能导出原有流程表单！',{icon: 7});
         return;
     }*/

    exportDialog = layer.open({
        type: 2,
        title: '模块导出日志',
        closeBtn : 1,
        skin: 'bs-modal',
        area: ['80%', '80%'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsformmanage/eformComponent/exportLog.jsp?id=" + eformComponentId
    });
};



//表单验证
EformComponent.prototype.formValidate = function (form) {
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
                required: true,
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
EformComponent.prototype.subAdd = function (form) {
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
        url: "platform/eform/bpmsManageController/subAddEformComponent",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                _this.setComponent(backData.data);
                if (eformComponentModel!=null && typeof(eformComponentModel)!="undefined")
                	eformComponentModel.reLoad(eformTypeTree.selectedNodeId);
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
EformComponent.prototype.subEdit = function (form) {
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
        url: "platform/eform/bpmsManageController/subEditEformComponent",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                var component = $('#' + _this.componentDiv).find("#" + backData.data.id);
                component.remove();
                _this.setComponent(backData.data);
                if (eformComponentModel!=null && typeof(eformComponentModel)!="undefined")
                	eformComponentModel.reLoad(eformTypeTree.selectedNodeId);
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
EformComponent.prototype.subExport = function (form) {
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
EformComponent.prototype.closeDialog = function (type) {
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
//获取电子表单模块列表
EformComponent.prototype.getComponentList = function (selectedNodeId) {
    var _this = this;
    if(showType=="2"){		
		if(eformComponentModel==null || eformComponentModel==undefined){
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

			var url = "platform/eform/bpmsManageController/getComponentByPage";
			eformComponentModel = new EformComponentModel('componentModel', url, "formSub", componentModelGridColModel, 'searchDialogSub', selectedNodeId, 
					"", searchSubNames, "componentModel_keyWord");
		}else{
			eformComponentModel.reLoad(selectedNodeId);
		}

        $(window).resize();
	}else{
	    $('#' + _this.componentDiv).empty();
	    $.ajax({
	        url: "platform/eform/bpmsManageController/getComponentList",
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
	if (rowObject.type == "view"){
		return '<a href="javascript:void(0)" '
		//+'  title="名称" onClick="eformFormView.openDesigner(\''+rowObject.id+'\')">'+cellvalue+'</a>';
		+'  title="'+cellvalue+'" onClick="eformFormView.openDesigner(\''+rowObject.id+'\')">'+cellvalue+'</a>';
	}else{
		return '<a href="javascript:void(0)" '
		//+'  title="名称" onClick="eformFormInfo.openDesigner(\''+rowObject.id+'\')">'+cellvalue+'</a>';
		+'  title="'+cellvalue+'" onClick="eformFormInfo.openDesigner(\''+rowObject.id+'\')">'+cellvalue+'</a>';
	}
}

function getformviewStatus(cellvalue, options, rowObject){
	if (rowObject.publishStatus == "0"){
		return '<font color="#FF9900">未发布</font>';
	}else if(rowObject.enabled == "Y"){
		return '<font color="#0F9D58">已发布/启用</font>';
	}else{
		return '<font color="#AABBAF">已发布/停用</font>';
	}
}

function getformviewType(cellvalue, options, rowObject){
	if (cellvalue == "bpmform"){
		return '<font color="DeepSkyBlue">流程表单</font>';
	}else if(cellvalue == "view"){
		return '<font color="Purple">视图</font>';
	}else{
		return '普通表单';
	}
}


function getformviewButtons(cellvalue, options, rowObject) {
	
	if (rowObject.type != "view"){
		if (rowObject.publishStatus == "0"){
			return '<a href="javascript:void(0)" class="glyphicon glyphicon-pencil"'
			+'  title="编辑表单" onClick="eformFormInfo.editData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
			+'   title="删除表单" onClick="eformFormInfo.deleteData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;' 
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-upload"'
			+'   title="发布表单" onClick="eformFormInfo.publish(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
            +'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-save"'
            +'   title="覆盖导入" onClick="eformFormInfo.reImportEformXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-open"'
			+'   title="导出" onClick="eformFormInfo.exportEformXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-transfer"'
			+'   title="切换目录" onClick="eformFormInfo.changeDirectory(\''+rowObject.id+'\')"></a>';
		}else if(rowObject.enabled == "Y"){
			return '<a href="javascript:void(0)" class="glyphicon glyphicon-pencil"'
			+'  title="编辑表单" onClick="eformFormInfo.editData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
			+'   title="删除表单" onClick="eformFormInfo.deleteData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'  
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-off"'
			+'   title="停用表单" onClick="eformFormInfo.enable(\''+rowObject.enabled+'\',\''+rowObject.id+'\')"></a>&nbsp;&nbsp;' 
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-link"'
			+'   title="重新生成页面" onClick="eformFormInfo.doCreate(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-info-sign"'
			+'   title="查看版本" onClick="eformFormInfo.checkTabVersion(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
            +'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-save"'
            +'   title="覆盖导入" onClick="eformFormInfo.reImportEformXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-open"'
			+'   title="导出" onClick="eformFormInfo.exportEformXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-transfer"'
			+'   title="切换目录" onClick="eformFormInfo.changeDirectory(\''+rowObject.id+'\')"></a>';
		}else{
			return '<a href="javascript:void(0)" class="glyphicon glyphicon-pencil"'
			+'  title="编辑表单" onClick="eformFormInfo.editData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
			+'   title="删除表单" onClick="eformFormInfo.deleteData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'  
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-off"'
			+'   title="启用表单" onClick="eformFormInfo.enable(\''+rowObject.enabled+'\',\''+rowObject.id+'\')"></a>&nbsp;&nbsp;' 
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-link"'
			+'   title="重新生成页面" onClick="eformFormInfo.doCreate(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-info-sign"'
			+'   title="查看版本" onClick="eformFormInfo.checkTabVersion(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
            +'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-save"'
            +'   title="覆盖导入" onClick="eformFormInfo.reImportEformXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-open"'
			+'   title="导出" onClick="eformFormInfo.exportEformXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-transfer"'
			+'   title="切换目录" onClick="eformFormInfo.changeDirectory(\''+rowObject.id+'\')"></a>';
		}
	}else{
		if (rowObject.publishStatus == "0"){
			return '<a href="javascript:void(0)" class="glyphicon glyphicon-pencil"'
			+'  title="编辑视图" onClick="eformFormView.editData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
			+'   title="删除视图" onClick="eformFormView.deleteData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;' 
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-upload"'
			+'   title="发布视图" onClick="eformFormView.publish(\''+rowObject.id+'\',\''+rowObject.name+'\',\''+rowObject.code+'\',\''+rowObject.style+'\',\''+rowObject.currentVersion+'\')"></a>&nbsp;&nbsp;'
            +'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-save"'
            +'   title="覆盖导入" onClick="eformFormView.reImportViewXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-open"'
			+'   title="导出" onClick="eformFormView.exportViewXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>';
		}else if(rowObject.enabled == "Y"){
			return '<a href="javascript:void(0)" class="glyphicon glyphicon-pencil"'
			+'  title="编辑视图" onClick="eformFormView.editData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
			+'   title="删除视图" onClick="eformFormView.deleteData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'  
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-off"'
			+'   title="停用视图" onClick="eformFormView.enable(\''+rowObject.enabled+'\',\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-link"'
			+'   title="重新生成页面" onClick="eformFormView.doCreate(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
            +'  <a href="javascript:void(0)" class="glyphicon glyphicon-list"'
            +'   title="挂载菜单" onClick="eformFormView.sendMenu(\''+rowObject.id+'\',\''+rowObject.name+'\',\''+rowObject.code+'\',\''+rowObject.style+'\')"></a>&nbsp;&nbsp;'
            +'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-save"'
            +'   title="覆盖导入" onClick="eformFormView.reImportViewXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-open"'
			+'   title="导出" onClick="eformFormView.exportViewXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>';
		}else{
			return '<a href="javascript:void(0)" class="glyphicon glyphicon-pencil"'
			+'  title="编辑视图" onClick="eformFormView.editData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
			+'   title="删除视图" onClick="eformFormView.deleteData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'  
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-off"'
			+'   title="启用视图" onClick="eformFormView.enable(\''+rowObject.enabled+'\',\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-link"'
			+'   title="重新生成页面" onClick="eformFormView.doCreate(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
            +'  <a href="javascript:void(0)" class="glyphicon glyphicon-list"'
            +'   title="挂载菜单" onClick="eformFormView.sendMenu(\''+rowObject.id+'\',\''+rowObject.viewName+'\',\''+rowObject.viewCode+'\',\''+rowObject.viewStyle+'\',\''+rowObject.currentVersion+'\')"></a>&nbsp;&nbsp;'
            +'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-save"'
            +'   title="覆盖导入" onClick="eformFormView.reImportViewXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>&nbsp;&nbsp;'
			+'  <a href="javascript:void(0)" class="glyphicon glyphicon-floppy-open"'
			+'   title="导出" onClick="eformFormView.exportViewXml('+JSON.stringify(rowObject).replace(/\"/g,"'")+')"></a>';
		}
	}
	
	
	
	
}

function getEdit(cellvalue, options, rowObject){
	return '<a href="javascript:void(0)" '
	//+'  title="模块名称" onClick="eformComponent.clickTitle(\''+rowObject.id+'\')">'+rowObject.componentName+'</a>';
	+'  title="'+rowObject.componentName+'" onClick="eformComponent.clickTitle(\''+rowObject.id+'\')">'+rowObject.componentName+'</a>';
}

function getOptButtons(cellvalue, options, rowObject) {
	
	return '<a href="javascript:void(0)" class="glyphicon glyphicon-pencil"'
		+'  title="编辑" onClick="eformComponent.editData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
		+'  <a href="javascript:void(0)" class="glyphicon glyphicon-trash"'
		+'   title="删除" onClick="eformComponent.deleteData(\''+rowObject.id+'\')"></a>&nbsp;&nbsp;'
		+'  <a href="javascript:void(0)" class="glyphicon glyphicon-export"'
		+'   title="导出模块" onClick="eformComponent.exportData(\''+rowObject.id+'\')"></a>';
	
	
}