/**
 * Created by xb on 2017/5/11.
 */
function EformFormInfo(formArea, formInfoDiv) {
    this.formArea = formArea;
    this.formInfoDiv = formInfoDiv;

    this.init.call(this);
}
//初始化操作
EformFormInfo.prototype.init = function () {
    var _this = this;

    var template = $(
        '<div class="eform-item" id="">'
        + '<div class="eform-item-title" title="" data-toggle="popover" data-container="body" data-placement="auto bottom">'
        + '<i class="glyphicon glyphicon-th eform-item-form"></i>'
        + '</div>'
        + '<div class="eform-item-bottom">'
        + '<span class="eform-item-bottom-name" title="表单">表单</span>'
        + '<span class="eform-item-bottom-btn">'
        + '<i class="glyphicon glyphicon-option-vertical"></i>'
        + '</span>'
        + '</div>'
        + '<div class="eform-item-tools" style="display: none;">'
        + '<div class="editFormInfo"><i class="glyphicon glyphicon-pencil"></i>编辑表单</div>'
        + '<div class="deleteFormInfo"><i class="glyphicon glyphicon-trash"></i>删除表单</div>'
        + '<div class="publishFormInfo"><i class="glyphicon glyphicon-upload"></i>发布表单</div>'
        + '<div class="enableFormInfo"><i class="glyphicon glyphicon-off"></i><span></span></div>'
        + '<div class="createjsp"><i class="glyphicon glyphicon-link"></i>重新生成页面</div>'
        + '<div class="reImportEformXml"><i class="glyphicon glyphicon-floppy-save"></i>覆盖导入</div>'
        + '<div class="exportEformXml"><i class="glyphicon glyphicon-floppy-open"></i>导出</div>'
        + '<div class="changeDirectory"><i class="glyphicon glyphicon-transfer"></i>切换目录</div>'
        + '<div class="checkTabVersion"><i class="glyphicon glyphicon-info-sign"></i>查看版本</div>'
        + '<div class="printTemplates"><i class="glyphicon glyphicon-print"></i>打印模板</div>'
        + '<div class="shareorg"><i class="glyphicon glyphicon-transfer"></i>共享到其他组织</div>'
        + '</div>'
//            + '<div class="eform-item-checkbox">'
//                + '<input type="checkbox">'
//            + '</div>'
        + '</div>'
    );

    this.template = template;
};
//页面新建一个EformFormInfo
EformFormInfo.prototype.setFormInfo = function (data, searchFormInfoDiv) {
    var _this = this;

    var formInfo = _this.template.clone();

    //相关属性
    formInfo.attr("id", data.id);
    formInfo.attr("sort", data.orderBy);

    //显示属性
    formInfo.find(".eform-item-bottom-name").attr("title", data.formName);
    if (data.formName.length > 7) {
        formInfo.find(".eform-item-bottom-name").text(data.formName.substring(0, 5)+"...");
    }
    else {
        formInfo.find(".eform-item-bottom-name").text(data.formName);
    }
    
    var _formContent = ''; 
    var isbpm = '';
    if(data.isBpm!=null&&data.isBpm=="Y"){
    	isbpm = '流程表单';
    }else{
    	isbpm = '普通表单';
    }
    var formState = '';
    if(data.publishStatus == "1"){
    	if(data.enabled!=null&&data.enabled=="Y"){
        	formState = '启用';
        }else{
        	formState = '停用';
        }
    }else{
    	formState = '未发布';
    }
    
    _formContent = '<table width="180px" border="0" style="font-size:12px;"  align="center">'
	    	+'<tr><td width="40%" height="25"><lable>表单名称:</lable></td><td><span class="eform-item-popover" title="'+data.formName+'">'+data.formName+'</span></td></tr>'
			+'<tr><td width="40%" height="25"><lable>表单编码:</lable></td><td><span class="eform-item-popover" title="'+data.formCode+'">'+data.formCode+'</span></td></tr>'
			+'<tr><td width="40%" height="25"><lable>表单样式:</lable></td><td>'+data.formStyle+'</td></tr>'
			+'<tr><td width="40%" height="25"><lable>表单状态:</lable></td><td>'+formState+'</td></tr>'
			+'<tr><td width="40%" height="25"><lable>表单类型:</lable></td><td>'+isbpm+'</td></tr>'
			+'<tr><td width="40%" height="25"><lable>当前版本:</lable></td><td>'+data.currentVersion+'</td></tr>'
/*			+'<tr><td width="40%" height="25"><lable>创建时间:</lable></td><td>'+data.creationDate+'</td></tr>'
			+'<tr><td width="40%" height="25"><lable>修改时间:</lable></td><td>'+data.lastUpdateDate+'</td></tr>'*/
			+'</table>';
    formInfo.find(".eform-item-title").attr("data-content", _formContent);
    //formInfo.find("[data-toggle='popover']").popover({html:true,trigger:'hover'});
    formInfo.find("[data-toggle='popover']").popover({ trigger: "manual" , html: true, animation:false})
    .on("mouseenter", function () {
        var _this = this;
        $(this).popover("show");
        $(".popover").on("mouseleave", function () {
            $(_this).popover('hide');
        });
    }).on("mouseleave", function () {
        var _this = this;
        setTimeout(function () {
            if (!$(".popover:hover").length) {
                $(_this).popover("hide");
            }
        }, 0);
    });
    
    //电子表单点击事件绑定
    formInfo.find(".eform-item-title").click(function () {
        //跳转到该电子表单设计器界面
    	_this.openDesigner(data.id);
        return false;
    });

    //显隐工具栏按钮事件绑定
    formInfo.find(".eform-item-bottom-btn").click(function () {
        $(".eform-item-tools").hide();
        formInfo.find('.eform-item-tools').hide();
        formInfo.find('.eform-item-tools').toggle(200);
        return false;
    });
    $('body').click(function () {
        formInfo.find('.eform-item-tools').hide();
    });

    //工具栏事件绑定
    formInfo.find(".deleteFormInfo").click(function () {
        _this.deleteData(data.id);
        return false;
    });
    formInfo.find(".editFormInfo").click(function () {
        _this.editData(data.id);
        return false;
    });
    if (data.publishStatus == "1") {
        formInfo.find(".publishFormInfo").remove();

        formInfo.find(".createjsp").click(function(){
        	_this.doCreate(data.id);
            return false;
        });
        if (data.enabled == "Y") {
            formInfo.find(".eform-item-form").css("color", "rgb(15, 157, 88)");
            formInfo.find(".enableFormInfo").find("span").text("停用表单");
        }
        else {
            formInfo.find(".eform-item-form").css("color", "#aabbaf");
            formInfo.find(".enableFormInfo").find("span").text("启用表单");
        }

        formInfo.find(".enableFormInfo").click(function () {
            _this.enable(data.enabled,data.id);
            return false;
        });
    }
    else {
        formInfo.find(".enableFormInfo").remove();
        formInfo.find(".createjsp").remove();
        formInfo.find(".checkTabVersion").remove();
        formInfo.find(".publishFormInfo").click(function () {
            _this.publish(data.id);
            return false;
        });
    }

    formInfo.find(".exportEformXml").click(function () {
        _this.exportEformXml(data);
        return false;
    });
    formInfo.find(".reImportEformXml").click(function () {
        _this.reImportEformXml(data);
        return false;
    });
    formInfo.find(".changeDirectory").click(function () {
        _this.changeDirectory(data.id);
        return false;
    });

    formInfo.find(".shareorg").click(function () {
        _this.shareorg(data.id);
        return false;
    });
    
    formInfo.find(".checkTabVersion").click(function () {
        _this.checkTabVersion(data.id);
        return false;
    });
    formInfo.find(".printTemplates").click(function () {
        _this.printTemplates(data.id);
        return false;
    });

    var formInfoDiv = _this.formInfoDiv;
    if(searchFormInfoDiv != null) {
        formInfoDiv = searchFormInfoDiv;
    }

    if ($('#' + formInfoDiv).find('.eform-item').length == 0) {
        $('#' + formInfoDiv).append(formInfo);
    }
    else {
        var idArray = [];
        var sortArray = [];
        $('#' + formInfoDiv).find('.eform-item').each(function (index, element) {
            var $element = $(element);

            var id = $element.attr("id");
            var sort = $element.attr("sort");

            idArray.push(id);
            sortArray.push(sort);
        });

        for (var i = 0; i < sortArray.length; i++) {
            if (data.orderBy <= sortArray[i]) {
                $('#' + formInfoDiv).find("#" + idArray[i]).before(formInfo);

                break;
            }

            if (i == sortArray.length - 1) {
                $('#' + formInfoDiv).append(formInfo);
            }
        }
    }
};

EformFormInfo.prototype.openDesigner = function (id,version) {
    var url = baseUrl+"platform/eform/bpmsManageController/designEformFormInfo/" + id;
    if (version != undefined){
        url = baseUrl+"platform/eform/bpmsManageController/designEformFormInfo/" + id+"?version="+version;
    }
	window.open(url, "_blank");
};
//添加
EformFormInfo.prototype.addData = function () {
    var _this = this;
    
    if (eformComponent.selectedEformComponentId == null) {
        layer.msg('请选择模块！', {icon: 7});
    }else if (eformComponent.selectedEformComponentId=="undefined" || eformComponent.selectedEformComponentId.indexOf( "undefined")>-1) {
        top.layer.msg('不能在未分类节点下添加电子表单！',{icon: 7});

    }
    else {
        addDialog = layer.open({
            type: 2,
            title: '添加电子表单',
            skin: 'bs-modal',
            area: ['100%', '100%'],
            maxmin: false,
            content: "platform/eform/bpmsManageController/addEformFormInfo"
        });
    }
};
//编辑
EformFormInfo.prototype.editData = function (eformFormInfoId) {
    var _this = this;
    
    editDialog = layer.open({
        type: 2,
        title: '编辑电子表单',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content: "platform/eform/bpmsManageController/editEformFormInfo?id=" + eformFormInfoId
    });
};
//删除
EformFormInfo.prototype.deleteData = function (eformFormInfoId) {
    var _this = this;
    var flag = 0;

    $.ajax({
        url: "platform/eform/bpmsManageController/yNEformAndWfRelation",
        data: "id=" + eformFormInfoId,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var message = "确定要删除电子表单吗？";
            if(backData.flag != 0){
                message = "此表单有关联的流程，确定要删除电子表单吗？";
            }

            layer.confirm(message, {
                icon: 3,
                title: '提示',
                closeBtn: 0,
                area: ['400px', '']
            }, function (index) {
                $.ajax({
                    url: "platform/eform/bpmsManageController/deleteEformFormInfo",
                    data: "id=" + eformFormInfoId,
                    type: "post",
                    async: false,
                    dataType: "json",
                    success: function (backData) {
                        if (backData.result == "1") {
                            var formInfo = $('#' + _this.formInfoDiv).find("#" + eformFormInfoId);
                            formInfo.remove();
                            if (eformFormViewModel != null && typeof(eformFormViewModel) != "undefined")
                                eformFormViewModel.reLoad(eformComponent.selectedEformComponentId);
                            layer.msg('操作成功！', {icon: 1});
                        }
                        else {
                            layer.msg('操作失败！', {icon: 2});
                        }
                    }
                });
            });
        }
    });

};



//发布
EformFormInfo.prototype.publish = function (eformFormInfoId) {
    var _this = this;

    layer.confirm('确定要发布电子表单吗？',{
		icon : 3,
		title : '提示',
		closeBtn : 0 ,
		area: ['400px', '']
	}, function (index) {
        $.ajax({
            url: "platform/eform/bpmsManageController/publishEformFormInfo",
            data: "id=" + eformFormInfoId,
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                if (backData.result == "1") {
                	var formInfo = $('#' + _this.formInfoDiv).find("#" + eformFormInfoId);
                    formInfo.remove();
                    _this.setFormInfo(backData.data);
                    if (eformFormViewModel!=null && typeof(eformFormViewModel)!="undefined")
                    	eformFormViewModel.reLoad(eformComponent.selectedEformComponentId);
                    layer.msg('操作成功！', {icon: 1});
                }
                else {
                    layer.msg('操作失败！'+backData.msg, {icon: 2});
                }
            }
        });
    });
};
//生成实体代码
EformFormInfo.prototype.doCreate= function (eformFormInfoId) {
    var _this = this;

    layer.confirm('确定要重新生成页面吗？', {
		icon : 3,
		title : '提示',
		closeBtn : 0 ,
		area: ['400px', '']
	},function (index) {
    	layer.close(index);
        avicAjax.ajax({
            url: "platform/eform/bpmsManageController/doCreateJsp",
            data: "id=" + eformFormInfoId,
            type: "post",
            async: true,
            dataType: "json",
            success: function (backData) {
                if (backData.result == "1") {

                    layer.msg('操作成功！', {icon: 1});
                }
                else {
                    layer.msg('操作失败！'+backData.msg, {icon: 2});
                }
            }
        });
    });
};
//生成实体代码
EformFormInfo.prototype.doAllCreate= function () {
    var _this = this;

    layer.confirm('确定要重新生成页面吗？',{
		icon : 3,
		title : '提示',
		closeBtn : 0 ,
		area: ['400px', '']
	}, function (index) {
    	layer.close(index);
        avicAjax.ajax({
            url: "platform/eform/bpmsManageController/doCreateAllJsp",
            data: {},
            type: "post",
            async: true,
            dataType: "json",
            success: function (backData) {
                if (backData.result == "1") {

                    layer.msg('操作成功！', {icon: 1});
                }
                else {
                    layer.msg('操作失败！'+backData.msg, {icon: 2});
                }
            }
        });
    });
};
//启用、停用
EformFormInfo.prototype.enable = function (isennabled,infoid) {
    var _this = this;

    var comfirmMsg = "";
    if (  isennabled == "Y") {
        comfirmMsg = "确定要停用电子表单吗？";
    }
    else {
        comfirmMsg = "确定要启用电子表单吗？";
    }

    layer.confirm(comfirmMsg, {
		icon : 3,
		title : '提示',
		closeBtn : 0 ,
		area: ['400px', '']
	},function (index) {
        $.ajax({
            url: "platform/eform/bpmsManageController/enableEformFormInfo",
            data: "id=" + infoid,
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                if (backData.result == "1") {
                    var formInfo = $('#' + _this.formInfoDiv).find("#" + infoid);
                    formInfo.remove();
                    _this.setFormInfo(backData.data);
                    if (eformFormViewModel!=null && typeof(eformFormViewModel)!="undefined")
                    	eformFormViewModel.reLoad(eformComponent.selectedEformComponentId);
                    layer.msg('操作成功！', {icon: 1});
                }
                else {
                    layer.msg('操作失败！', {icon: 2});
                }
            }
        });
    });
};
//导入表单xml
EformFormInfo.prototype.importEformXml = function () {
    var selectedNode = eformTypeTree.tree.getNodeByParam("id", eformTypeTree.selectedNodeId, null);

    if (selectedNode.pId == null || selectedNode.pId == "-1") {
        layer.msg('不能在根目录导入表单！',{icon: 7});
    }
    else if (eformComponent.selectedEformComponentId == null) {
        layer.msg('请选择模块！', {icon: 7});
    }
    else {
        uploadDialog = layer.open({
            type: 2,
            closeBtn : 0 ,
            title: '导入表单xml',
            skin: 'bs-modal',
            area: ['400px', '200px'],
            maxmin: false,
            content: "avicit/platform6/eform/bpmsformmanage/eformFormInfo/importEform.jsp"
        });
    }
};
//导出表单xml
EformFormInfo.prototype.exportEformXml = function (data) {
    var flag = true;
    $.ajax({
        url: "platform/eform/bpmsManageController/doCheckFormExport",
        data: {
            id: data.id
        },
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.flag == "1"){
                layer.msg('该表单未经过设计，无法导出！', {icon: 7});
                flag = false;
            }
        }
    });
    if (!flag){
        return false;
    }


    var downloadUrl = "platform/eform/bpmsManageController/exportEformXml/" + data.id;
    new DownLoad4URL('downloadIFrame_eform', 'downloadForm_eform', null, downloadUrl).downLoad();

    if(data.dataSourceId != null) {
        downloadUrl = "platform/eform/bpmsManageController/exportDbXml/" + data.dataSourceId;
        new DownLoad4URL('downloadIFrame_db', 'downloadForm_db', null, downloadUrl).downLoad();

        $.ajax({
            url: "platform/eform/bpmsManageController/getAllEformSubTableIdList",
            data: {
                id: data.id
            },
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                var subTableIdList = backData;
                for(var i = 0; i < subTableIdList.length; i++) {
                    downloadUrl = "platform/eform/bpmsManageController/exportDbXml/" + subTableIdList[i];
                    new DownLoad4URL('downloadIFrame_db_sub_' + i, 'downloadForm_db_sub_' + i, null, downloadUrl).downLoad();
                }
            }
        });

        //引用表单导出
        $.ajax({
            url: "platform/eform/bpmsManageController/getAllEformFormList",
            data: {
                id: data.id,
                version: data.currentVersion
            },
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                var formTableList = backData;
                for(var i = 0; i < formTableList.length; i++) {
                    downloadUrl = "platform/eform/bpmsManageController/exportEformXml/" + formTableList[i].id;
                    new DownLoad4URL('downloadIFrame_eform_form' + i, 'downloadForm_eform_form' + i, null, downloadUrl).downLoad();

                    if(formTableList[i].dataSourceId != null){
                        downloadUrl = "platform/eform/bpmsManageController/exportDbXml/" + formTableList[i].dataSourceId;
                        new DownLoad4URL('downloadIFrame_db_form_' + i, 'downloadForm_db_form_' + i, null, downloadUrl).downLoad();
                    }

                }
            }
        });
    }
};
//覆盖导入表单xml
EformFormInfo.prototype.reImportEformXml = function (data) {
    var _this = this;
    if(data.dataSourceId==null||data.dataSourceId==""){
        layer.alert('表单无对应存储模型，无法导入！', {
            icon : 7,
            area : [ '400px', '' ], //宽高
            closeBtn : 0,
            btn : [ '关闭' ],
            title : "提示"
        });
        return false;
    }
    uploadDialog = layer.open({
        type: 2,
        closeBtn : 0 ,
        title: '覆盖导入表单xml',
        skin: 'bs-modal',
        area: ['400px', '200px'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsformmanage/eformFormInfo/reImportEform.jsp?formId=" + data.id+"&currentVersion=" + data.currentVersion+"&eformComponentId=" + data.eformComponentId
    });
};
//切换目录
EformFormInfo.prototype.changeDirectory = function (eformFormInfoId) {
    var _this = this;

    changeDirectoryDialog = layer.open({
        type: 2,
        title: '切换目录',
        skin: 'bs-modal',
        area: ['30%', '60%'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsformmanage/eformFormInfo/changeFormDirectory.jsp?eformFormInfoId=" + eformFormInfoId
    });
};

EformFormInfo.prototype.shareorg = function(eformFormInfoId) {
    var _this = this;
    layer.confirm("提示1：共享到其他组织后，其他组织对该表单具有同等支配权；<br/>提示2：共享模板不区分版本，即同一表单的各个版本将一并共享出去。<br/>确定继续共享？", function(index){
        _this.doShare(eformFormInfoId);
        layer.close(index);
    });
};


EformFormInfo.prototype.doShare = function (eformFormInfoId) {
    var _this = this;

    changeDirectoryDialog = layer.open({
        type: 2,
        title: '共享到其他组织',
        skin: 'bs-modal',
        area : ['35%', '70%'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsformmanage/multiorgshare/eformsharepage.jsp",
        btn : ['确定','返回'],
        yes :function(index){
            //先获取所选的组织目录节点是否为根节点，是根节点则不能共享
            var isRoot = window["layui-layer-iframe" + index].iscallbackdataRoot();
            if(!isRoot){
                layer.msg('请重新选择模块类型节点！', {icon: 7});
                return false;
            }
            var Id = window["layui-layer-iframe" + index].callbackdata();//模块id
            var orgId = window["layui-layer-iframe" + index].callbackorgid();
            if(Id == ""){
                layer.alert('请选择要共享到的模块目录！', {
                    icon : 7,
                    area : [ '400px', '' ], //宽高
                    closeBtn : 0,
                    btn : [ '关闭' ],
                    title : "提示"
                });
                return false;
            }
            avicAjax.ajax({
                url: "platform/eform/bpmsManageController/addEformOrgMap",
                data: {
                    id : Id,
                    key : eformFormInfoId,
                    orgId:orgId
                },
                type: "post",
                dataType: "json",
                success : function(r) {
                    if (r.flag == "success") {
                        layer.msg('操作成功！');
                        layer.close(index);
                    }else if(r.flag == "error"){
                        layer.alert('操作失败！' + r.error, {
                            icon : 7,
                            area : [ '400px', '' ], //宽高
                            closeBtn : 0,
                            btn : [ '关闭' ],
                            title : "提示"
                        });
                    }
                }
            });
        }
    });
};
//查看预设版本号
EformFormInfo.prototype.checkTabVersion = function (eformFormInfoId) {
    var _this = this;

    checkTabVersionDialog = layer.open({
        type: 2,
        title: '查看预设版本号',
        skin: 'bs-modal',
        area: ['60%', '60%'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsformmanage/eformFormInfo/checkTabVersion.jsp?eformFormInfoId=" + eformFormInfoId
    });
};

EformFormInfo.prototype.printTemplates = function (resourceId) {
    var _this = this;

    printTemplatesDialog = layer.open({
        type: 2,
        title: '打印模板',
        skin: 'bs-modal',
        area: ['60%', '60%'],
        maxmin: false,
        // content: "avicit/platform6/eform/bpmsformmanage/eformFormInfo/checkTabVersion.jsp?eformFormInfoId=" + eformFormInfoId
        content: "print/sysPrintController/toSysPrintManage?resourceId=" + resourceId
    });
};
//表单验证
EformFormInfo.prototype.formValidate = function (form) {
    var _this = this;

    form.validate({
        rules: {
            orderBy: {
                required: true,
                maxlength: 6,
                integer: true
            },
            formStyle: {
                required: true,
                maxlength: 200
            },
            formName: {
                required: true,
                maxlength: 200
            },
            formCode: {
                required: true,
                maxlength: 200,
                codeFormat: true
            },
            isBpm:{
            	required: true
            }
        }
    });
};
//提交添加
EformFormInfo.prototype.subAdd = function (form,colData,labelCount) {
    var _this = this;
    _this.colData = null;
    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var formName = form.find("#formName").val();
    if(formName.indexOf("\"") !== -1 || formName.indexOf("\\") !== -1 || formName.indexOf("&") !== -1) {
        layer.msg('表单名称不能含有特殊字符！', {icon: 7});
        return false;
    }

    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/eform/bpmsManageController/subAddEformFormInfo",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                _this.setFormInfo(backData.data);
                if (eformFormViewModel!=null && typeof(eformFormViewModel)!="undefined")
                	eformFormViewModel.reLoad(eformComponent.selectedEformComponentId);
                layer.msg('操作成功！', {icon: 1});
                _this.closeDialog("add");
                if(colData!=null){
                    _this.colData = {"infoId":backData.data.id,"labelCount":labelCount,"colData":colData, "formName": backData.data.formName};
                }
                setTimeout(function () {
                    //添加完默认跳转到该电子表单设计器界面
                    window.open(baseUrl+"platform/eform/bpmsManageController/designEformFormInfo/" + backData.data.id, "_blank");
                }, 1000);
            }
            else if(backData.result == "2") {
                layer.msg('表单编码已存在，请重新输入！', {icon: 7});
            }
            else {
                layer.msg('操作失败！', {icon: 2});
            }
        }
    });
};
//提交编辑
EformFormInfo.prototype.subEdit = function (form, oldFormCode) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var formName = form.find("#formName").val();
    if(formName.indexOf("\"") !== -1 || formName.indexOf("\\") !== -1 || formName.indexOf("&") !== -1) {
        layer.msg('表单名称不能含有特殊字符！', {icon: 7});
        return false;
    }

    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "formDataJson=" + formDataJson + "&oldFormCode=" + oldFormCode;
    $.ajax({
        url: "platform/eform/bpmsManageController/subEditEformFormInfo",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                var formInfo = $('#' + _this.formInfoDiv).find("#" + backData.data.id);
                formInfo.remove();
                _this.setFormInfo(backData.data);
                if (eformFormViewModel!=null && typeof(eformFormViewModel)!="undefined")
                	eformFormViewModel.reLoad(eformComponent.selectedEformComponentId);
                layer.msg('操作成功！', {icon: 1});

                _this.closeDialog("edit");
            }
            else if(backData.result == "2") {
                layer.msg('表单编码已存在，请重新输入！', {icon: 7});
            }
            else {
                layer.msg('操作失败！', {icon: 2});
            }
        }
    });
};
//关闭弹出框
EformFormInfo.prototype.closeDialog = function (type) {
    if (type == "add") {
        layer.close(addDialog);
    }
    if (type == "edit") {
        layer.close(editDialog);
    }
    if (type == "upload") {
        layer.close(uploadDialog);
    }
    if(type == "changeDirectory"){
        layer.close(changeDirectoryDialog);
    }
    if(type == "checkTabVersion"){
        layer.close(checkTabVersionDialog);
    }
};
//获取电子表单电子表单列表
EformFormInfo.prototype.getFormInfoList = function (eformComponentId) {
    var _this = this;

    $('#' + _this.formInfoDiv).empty();
    $.ajax({
        url: "platform/eform/bpmsManageController/getFormInfoList",
        data: "eformComponentId=" + eformComponentId,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var formInfoList = backData.data;

            for (var i = 0; i < formInfoList.length; i++) {
                _this.setFormInfo(formInfoList[i]);
            }
        }
    });
};