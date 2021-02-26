/**
 * Created by xb on 2017/5/17.
 */
function EformFormView(formArea, formViewDiv) {
    this.formArea = formArea;
    this.formViewDiv = formViewDiv;

    this.init.call(this);
}
//初始化操作
EformFormView.prototype.init = function () {
    var _this = this;

    var template = $(
          '<div class="eform-item" id="">'
            + '<div class="eform-item-title" title="" data-toggle="popover" data-container="body" data-placement="auto bottom">'
                + '<i class="glyphicon glyphicon-list eform-item-view"></i>'
            + '</div>'
            + '<div class="eform-item-bottom">'
                + '<span class="eform-item-bottom-name" title="视图">视图</span>'
                + '<span class="eform-item-bottom-btn">'
                    + '<i class="glyphicon glyphicon-option-vertical"></i>'
                + '</span>'
            + '</div>'
            + '<div class="eform-item-tools" style="display: none;">'
                + '<div class="editViewInfo"><i class="glyphicon glyphicon-pencil"></i>编辑视图</div>'
                /*+ '<div class="viewinfourl"><i class="glyphicon glyphicon-pencil"></i>显示视图路径</div>'*/
                + '<div class="deleteViewInfo"><i class="glyphicon glyphicon-trash"></i>删除视图</div>'
                + '<div class="enableViewInfo"><i class="glyphicon glyphicon-off"></i><span></span></div>'
                + '<div class="publishViewInfo"><i class="glyphicon glyphicon-send"></i>发布视图</div>'
                + '<div class="createjsp"><i class="glyphicon glyphicon-link"></i>重新生成页面</div>'
                + '<div class="sendMenu"><i class="glyphicon glyphicon-list"></i>挂载菜单</div>'
                + '<div class="reImportViewXml"><i class="glyphicon glyphicon-floppy-save"></i>覆盖导入</div>'
                + '<div class="exportViewXml"><i class="glyphicon glyphicon-floppy-open"></i>导出</div>'
                + '<div class="checkTabVersion"><i class="glyphicon glyphicon-info-sign"></i>查看版本</div>'
            + '</div>'
//            + '<div class="eform-item-checkbox">'
//                + '<input type="checkbox">'
//            + '</div>'
        + '</div>'
    );

    this.template = template;
};
//页面新建一个EformFormView
EformFormView.prototype.setViewInfo = function (data, searchFormViewDiv) {
    var _this = this;
    var viewInfo = _this.template.clone();

    //唯一标识
    viewInfo.attr("id", data.id);
    viewInfo.attr("sort", data.orderBy);

    //显示属性
    viewInfo.find(".eform-item-bottom-name").attr("title", data.viewName);
    if(data.viewName.length > 7) {
    	viewInfo.find(".eform-item-bottom-name").text(data.viewName.substring(0, 5)+"...");
    }
    else {
    	viewInfo.find(".eform-item-bottom-name").text(data.viewName);
    }

    var _viewContent = ''; 
    var isbpm = '';
    if(data.isBpm!=null&&data.isBpm=="Y"){
    	isbpm = '流程表单';
    }else{
    	isbpm = '非流程表单';
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
    _viewContent = '<table width="180px" border="0" style="font-size:12px;"  align="center">'
	    	+'<tr><td width="40%" height="25"><lable>视图名称:</lable></td><td><span class="eform-item-popover" title="'+data.viewName+'">'+data.viewName+'</span></td></tr>'
			+'<tr><td width="40%" height="25"><lable>视图编码:</lable></td><td><span class="eform-item-popover" title="'+data.viewCode+'">'+data.viewCode+'</span></td></tr>'
			+'<tr><td width="40%" height="25"><lable>视图样式:</lable></td><td>'+data.viewStyle+'</td></tr>'
			+'<tr><td width="40%" height="25"><lable>视图状态:</lable></td><td>'+formState+'</td></tr>'
            +'<tr><td width="40%" height="25"><lable>视图版本:</lable></td><td>'+data.currentVersion+'</td></tr>'
/*			+'<tr><td width="40%" height="25"><lable>创建时间:</lable></td><td>'+data.creationDate+'</td></tr>'
			+'<tr><td width="40%" height="25"><lable>修改时间:</lable></td><td>'+data.lastUpdateDate+'</td></tr>'*/
			+'</table>';
    viewInfo.find(".eform-item-title").attr("data-content", _viewContent);
    //viewInfo.find("[data-toggle='popover']").popover({html:true,trigger:'hover'});
    viewInfo.find("[data-toggle='popover']").popover({ trigger: "manual" , html: true, animation:false})
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
    
    //显隐工具栏按钮事件绑定
    viewInfo.find(".eform-item-bottom-btn").click(function () {
        $(".eform-item-tools").hide();
        viewInfo.find('.eform-item-tools').hide();
    	viewInfo.find('.eform-item-tools').toggle(200);
        return false;
    });
    $('body').click(function () {
        viewInfo.find('.eform-item-tools').hide();
    });
    viewInfo.find(".exportViewXml").click(function () {
        _this.exportViewXml(data);
        return false;
    });
    viewInfo.find(".reImportViewXml").click(function () {
        _this.reImportViewXml(data);
        return false;
    });

    //工具栏事件绑定
    viewInfo.find(".deleteViewInfo").click(function () {
        _this.deleteData(data.id,data.viewCode);
        return false;
    });
    viewInfo.find(".editViewInfo").click(function () {
        _this.editData(data.id);
        return false;
    });
    
//    viewInfo.find(".viewinfourl").click(function () {
//        _this.viewUrl(data.viewCode,data.viewStyle);
//        return false;
//    });
    
  //视图图标击事件绑定
    viewInfo.find(".eform-item-title").click(function () {
        //跳转到该电子表单设计器界面
        _this.openDesigner(data.id);
        return false;
    });

    var formViewDiv = _this.formViewDiv;
    if (searchFormViewDiv != null) {
        formViewDiv = searchFormViewDiv;
    }
    
    
    if (data.publishStatus == "1") {
    	viewInfo.find(".publishViewInfo").remove();

    	viewInfo.find(".createjsp").click(function(){
        	_this.doCreate(data.id,data.currentVersion);
            return false;
        });
        viewInfo.find(".sendMenu").click(function(){
            _this.sendMenu(data.id,data.viewName,data.viewCode,data.viewStyle,data.currentVersion);
            return false;
        });
        viewInfo.find(".checkTabVersion").click(function(){
            _this.checkTabVersion(data.id);
            return false;
        });
        if (data.enabled == "Y") {
        	viewInfo.find(".eform-item-view").css("color", "rgb(15, 157, 88)");
        	viewInfo.find(".enableViewInfo").find("span").text("停用视图");
        }
        else {
        	viewInfo.find(".eform-item-view").css("color", "#aabbaf");
        	viewInfo.find(".enableViewInfo").find("span").text("启用视图");
        }

        viewInfo.find(".enableViewInfo").click(function () {
            _this.enable(data.enabled,data.id);
            return false;
        });
    }else {
    	viewInfo.find(".enableViewInfo").remove();
    	viewInfo.find(".createjsp").remove();
        viewInfo.find(".sendMenu").remove();
        viewInfo.find(".checkTabVersion").remove();
    	viewInfo.find(".publishViewInfo").click(function () {
        	 _this.publish(data.id,data.viewName,data.viewCode,data.viewStyle,data.currentVersion);
            return false;
        });
    }
    
    if ($('#' + formViewDiv).find('.eform-item').length == 0) {
        $('#' + formViewDiv).append(viewInfo);
    }
    else {
        var idArray = [];
        var sortArray = [];
        $('#' + formViewDiv).find('.eform-item').each(function (index, element) {
            var $element = $(element);

            var id = $element.attr("id");
            var sort = $element.attr("sort");

            idArray.push(id);
            sortArray.push(sort);
        });

        for (var i = 0; i < sortArray.length; i++) {
            if (data.orderBy <= sortArray[i]) {
                $('#' + formViewDiv).find("#" + idArray[i]).before(viewInfo);

                break;
            }

            if (i == sortArray.length - 1) {
                $('#' + formViewDiv).append(viewInfo);
            }
        }
    }
};


EformFormView.prototype.openDesigner = function(id,version){
    var url = baseUrl+"platform/eform/eformViewInfoController/designEformViewInfo/" + id;
    if (version != undefined){
        url = baseUrl+"platform/eform/eformViewInfoController/designEformViewInfo/" + id +"?version="+version;
    }
    window.open(url, "_blank");
};

//发布
EformFormView.prototype.publish = function (id,viewName,viewCode,viewStyle,viewVersion) {
    var _this = this;
    if (eformComponent.selectedEformComponentId == null) {
        layer.alert('请选择模块！');

    }
    else {
        publishDialog = top.layer.open({
            type: 2,
            title: '快速发布',
            skin: 'bs-modal',
            area: ['50%', '50%'],
            maxmin: false,
            content: "platform/eform/eformViewInfoController/publishViewMenu?id=" + id + "&viewName=" + encodeURIComponent(encodeURIComponent(viewName)) + "&viewCode=" + viewCode + "&type=both",
            btn: ['确定', '取消'],
            yes: function(index, layero){
            	var iframeWin = layero.find('iframe')[0].contentWindow;
            	if(iframeWin.getPublicType()!="0"){
                    if(iframeWin.getSelectMenu() === null || iframeWin.getSelectMenu() === ""){
                        top.layer.alert("菜单目录不能为空！");
                        return;
                    }
                    var arg = {
                        parentId: iframeWin.getSelectMenu(),
                        menuName: iframeWin.getViewName(),
                        menuCode: iframeWin.getViewCode(),
                        menuUrl: iframeWin.getUrl(),
                        menuView: "avicit/eformmodule/view/"+viewCode+"/"+viewVersion+"/"+viewStyle+"/view.jsp",
                        openType: iframeWin.getOpenType(),
                        menuOrder: "1",
                        menuStatus: "1",
                        isShow: "0"
                    };
                    var currentApplicationAndOrg = iframeWin.getCurrentApplicationAndOrg();
                    avicAjax.ajax({
                        url : "console/menu/console/" + currentApplicationAndOrg + "/save/insert",
                        data : {data :JSON.stringify(arg)},
                        type : 'post',
                        dataType : 'json',
                        success : function(msg) {
                            if (msg.flag == "success"){
                                top.layer.close(index);
                                _this.dopublish(id,msg.id,viewVersion);
                            }else{
                                top.layer.alert('发布失败！' + msg.e, {
                                    icon: 2,
                                    area: ['400px', ''],
                                    closeBtn: 0
                                });
                            }
//            			top.layer.msg("发布成功！");
//            			setViewInfo
                        }
                    });
            	}else{
                    _this.dopublish(id,'',viewVersion);
                    top.layer.close(index);
            	}
            	
            },
            no: function(index, layero){
            	layero.close(index);
            }
        });
    }
};

EformFormView.prototype.dopublish = function(viewid,menuid,version){
	var _this =this;
	avicAjax.ajax({
		url : "platform/eform/eformViewInfoController/publishViewInfo?id="+viewid+"&menuid="+menuid+"&version="+version,
		dataType : "JSON",
		type : "GET",
		success : function(r) {
			if (r.flag=="success"){
				var viewInfo = $('#' + _this.formViewDiv).find("#" + viewid);
				viewInfo.remove();
				_this.setViewInfo(r.data);
				if (eformFormViewModel!=null && typeof(eformFormViewModel)!="undefined")
					eformFormViewModel.reLoad(eformComponent.selectedEformComponentId);
				top.layer.msg("发布成功！");
			}else{
				layer.alert('发布失败！' + r.error, {
					icon: 2,
					area: ['400px', ''],
					closeBtn: 0
				});
			}
		},
		error : function(msg){
			top.layer.msg("发布失败！");
		}
	});
};


//启用、停用
EformFormView.prototype.enable = function (isenable,viewinfoid) {
    var _this = this;

    var comfirmMsg = "";
    if (isenable == "Y") {
        comfirmMsg = "确定要停用该视图吗？";
    }
    else {
        comfirmMsg = "确定要启用该视图吗？";
    }

    layer.confirm(comfirmMsg, {
		icon : 3,
		title : '提示',
		closeBtn : 0 ,
		area: ['400px', '']
	},function (index) {
        $.ajax({
        	url : "platform/eform/eformViewInfoController/enableEformViewInfo?id="+viewinfoid,
            type: "post",
            async: false,
            dataType: "json",
            success: function (r) {
                if (r.flag == "success") {
                	var viewInfos = $('#' + _this.formViewDiv).find("#" + viewinfoid);
                	viewInfos.remove();
    				_this.setViewInfo(r.data);
    				if (eformFormViewModel!=null && typeof(eformFormViewModel)!="undefined")
    					eformFormViewModel.reLoad(eformComponent.selectedEformComponentId);
                    layer.msg('操作成功！', {icon: 1});
                }
                else {
                	layer.alert('发布失败！' + r.e, {
    					icon: 2,
    					area: ['400px', ''],
    					closeBtn: 0
    				});
                }
            }
        });
    });
};

//添加
EformFormView.prototype.addData = function () {
    var _this = this;

    
    
    if (eformComponent.selectedEformComponentId == null) {
    	layer.msg('请选择模块！', {icon: 7});
    }else if (eformComponent.selectedEformComponentId=="undefined" || eformComponent.selectedEformComponentId.indexOf( "undefined")>-1) {
        top.layer.msg('不能在未分类节点下添加视图！',{icon: 7});

    }
    else {
        addDialog = layer.open({
            type: 2,
            title: '添加视图',
            skin: 'bs-modal',
            area: ['100%', '100%'],
            maxmin: false,
            content: "platform/eform/eformViewInfoController/toEformViewInfo"
        });
    }
};
EformFormView.prototype.viewUrl = function (code) {
    var _this = this;

    editDialog = layer.open({
        type: 2,
        title: '视图路径',
        skin: 'bs-modal',
        area: ['70%', '30%'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsformmanage/eformFormView/queryViewUrl.jsp?viewcode=" + code
    });
};

//编辑
EformFormView.prototype.editData = function (EformFormViewId) {
    var _this = this;

    editDialog = layer.open({
        type: 2,
        title: '编辑视图',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content: "platform/eform/eformViewInfoController/editEformViewInfo?id=" + EformFormViewId
    });
};
//删除
EformFormView.prototype.deleteData = function (EformFormViewId,code) {
    var _this = this;

    layer.confirm('确定要删除视图吗？', {
		icon : 3,
		title : '提示',
		closeBtn : 0 ,
		area: ['400px', '']
	},function (index) {
        $.ajax({
            url: "platform/eform/eformViewInfoController/deleteEformFormView",
            data: "id=" + EformFormViewId+"&code="+code,
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                if (backData.result == "1") {
                    var viewInfo = $('#' + _this.formViewDiv).find("#" + EformFormViewId);
                    viewInfo.remove();
                    if (eformFormViewModel!=null && typeof(eformFormViewModel)!="undefined")
    					eformFormViewModel.reLoad(eformComponent.selectedEformComponentId);
                    layer.msg('操作成功');
                }
                else {
                    layer.msg('操作失败');
                }
            }
        });
    });
};

//获取电子表单电子表单列表
EformFormView.prototype.getViewInfoList = function (eformComponentId) {
    var _this = this;
    
    $('#' + _this.formViewDiv).empty();
    $.ajax({
        url: "platform/eform/eformViewInfoController/getViewInfoList",
        data: "eformComponentId=" + eformComponentId,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var formViewList = backData.data;
            
            for (var i = 0; i < formViewList.length; i++) {
                _this.setViewInfo(formViewList[i]);
            }
        }
    });
};


//表单验证
EformFormView.prototype.formValidate = function (form) {
    var _this = this;
    form.validate({
        rules: {
            viewName: {
                required: true,
                maxlength: 200
            },
            viewCode: {
                required: true,
                maxlength: 200,
                codeFormat: true
            },
            viewDesc: {
                required: false,
                maxlength: 1000
            },
            viewStyle: {
                required: true
            },
            orderBy:{
                required: true,
                integer:true,
                maxlength: 6
            }
        }
    });
};

//提交添加
EformFormView.prototype.subAdd = function (form) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var viewName = form.find("#viewName").val();
    if(viewName.indexOf("\"") !== -1 || viewName.indexOf("\\") !== -1 || viewName.indexOf("&") !== -1) {
        layer.msg('视图名称不能含有特殊字符！', {icon: 7});
        return false;
    }

    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/eform/eformViewInfoController/addEformViewInfo",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                _this.setViewInfo(backData.data);
                if (eformFormViewModel!=null && typeof(eformFormViewModel)!="undefined")
					eformFormViewModel.reLoad(eformComponent.selectedEformComponentId);
              //  layer.msg('操作成功！',{icon: 1});
                _this.openDesigner(backData.data.id);

                _this.closeDialog("add");
            }
            else if(backData.result == "2") {
                layer.msg('视图编码已存在，请重新输入！', {icon: 7});
            }
            else {
                layer.msg('操作失败！',{icon: 2});
            }
        }
    });
};

//提交编辑
EformFormView.prototype.subEdit = function (form, oldViewCode) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var viewName = form.find("#viewName").val();
    if(viewName.indexOf("\"") !== -1 || viewName.indexOf("\\") !== -1 || viewName.indexOf("&") !== -1) {
        layer.msg('视图名称不能含有特殊字符！', {icon: 7});
        return false;
    }

    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "formDataJson=" + formDataJson + "&oldViewCode=" + oldViewCode;
    $.ajax({
        url: "platform/eform/eformViewInfoController/subEditEformViewInfo",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.result == "1") {
                var viewInfo = $('#' + _this.formViewDiv).find("#" + backData.data.id);
                viewInfo.remove();
                _this.setViewInfo(backData.data);
                if (eformFormViewModel!=null && typeof(eformFormViewModel)!="undefined")
					eformFormViewModel.reLoad(eformComponent.selectedEformComponentId);
                layer.msg('操作成功！', {icon: 1});

                _this.closeDialog("edit");
            }
            else if(backData.result == "2") {
                layer.msg('视图编码已存在，请重新输入！', {icon: 7});
            }
            else {
                layer.msg('操作失败！', {icon: 2});
            }
        }
    });
};

//关闭弹出框
EformFormView.prototype.closeDialog = function (type) {
    if (type == "add") {
        layer.close(addDialog);
    }
    if (type == "edit") {
        layer.close(editDialog);
    }
    if (type == "upload") {
        layer.close(uploadDialog);
    }
};

//重新生成页面
EformFormView.prototype.doCreate = function (eformViewInfoId,viewVersion){
	var _this = this;
	if (viewVersion==undefined){
        viewVersion = "";
    }
	layer.confirm('确定要重新生成页面吗？',{
		icon : 3,
		title : '提示',
		closeBtn : 0 ,
		area: ['400px', '']
	},function(index){
		layer.close(index);
		avicAjax.ajax({
            url: "platform/eform/eformViewInfoController/republishViewInfo",
            data: "id=" + eformViewInfoId+"&version="+viewVersion,
            type: "post",
            async: true,
            dataType: "json",
            success: function (backData) {
                if (backData.flag == "success") {

                    layer.msg('操作成功！', {icon: 1});
                }
                else {
                    layer.msg('操作失败！'+backData.error, {icon: 2});
                }
            }
        });
	});
};


//挂载菜单
EformFormView.prototype.sendMenu = function (id, viewName, viewCode, viewStyle,currentVersion) {
    var _this = this;
    top.layer.open({
        type: 2,
        title: '快速发布',
        skin: 'bs-modal',
        area: ['50%', '50%'],
        maxmin: false,
        content: "platform/eform/eformViewInfoController/publishViewMenu?id=" + id + "&viewName=" + encodeURIComponent(viewName) + "&viewCode=" + viewCode + "&type=menu",
        btn: ['确定', '取消'],
        yes: function (index, layero) {
            var iframeWin = layero.find('iframe')[0].contentWindow;
            var arg = {
                parentId: iframeWin.getSelectMenu(),
                menuName: iframeWin.getViewName(),
                menuCode: iframeWin.getViewCode(),
                menuUrl: iframeWin.getUrl(),
                openType: iframeWin.getOpenType(),
                menuView: "avicit/eformmodule/view/" + viewCode + "/" +currentVersion+"/"+ viewStyle + "/view.jsp",
                menuOrder: "1",
                menuStatus: "1",
                isShow: "0"
            };
            var currentApplicationAndOrg = iframeWin.getCurrentApplicationAndOrg();
            avicAjax.ajax({
                url: "console/menu/console/" + currentApplicationAndOrg + "/save/insert",
                data: {data: JSON.stringify(arg)},
                type: 'post',
                dataType: 'json',
                success: function (msg) {
                    if (msg.flag == "success") {
                        top.layer.close(index);
                        top.layer.msg("挂载成功！");
                    } else {
                        top.layer.alert('挂载失败！' + msg.e, {
                            icon: 2,
                            area: ['400px', ''],
                            closeBtn: 0
                        });
                    }
                }
            });

        },
        no: function (index, layero) {
            layero.close(index);
        }
    });
};

//覆盖导入视图xml
EformFormView.prototype.reImportViewXml = function (data) {
    var _this = this;
    uploadDialog = layer.open({
        type: 2,
        closeBtn : 0 ,
        title: '覆盖导入视图xml',
        skin: 'bs-modal',
        area: ['400px', '200px'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsformmanage/eformFormView/reImportView.jsp?formId=" + data.id+"&currentVersion=" + data.currentVersion+"&eformComponentId=" + data.eformComponentId
    });
};

EformFormView.prototype.exportViewXml = function(data){
	var downloadUrl = "platform/eform/bpmsManageController/exportViewXml/" + data.id;
    new DownLoad4URL('downloadIFrame_view', 'downloadForm_view', null, downloadUrl).downLoad();
    $.ajax({
        url: "platform/eform/bpmsManageController/getAllViewTableIdList",
        data: {
            id: data.id
        },
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var tableIdList = backData;
            for(var i = 0; i < tableIdList.length; i++) {
                downloadUrl = "platform/eform/bpmsManageController/exportDbXml/" + tableIdList[i];
                new DownLoad4URL('downloadIFrame_db_sub_' + i, 'downloadForm_db_sub_' + i, null, downloadUrl).downLoad();
            }
        }
    });
};

//电子表单统计
EformFormView.prototype.formChart = function(){
    var url = baseUrl + "avicit/platform6/eform/bpmsformstatistics/bpmsFormChart.jsp"
    window.open(url, "_blank");
}

EformFormView.prototype.importViewXml = function(){
	var selectedNode = eformTypeTree.tree.getNodeByParam("id", eformTypeTree.selectedNodeId, null);
    if (selectedNode.pId == null || selectedNode.pId == "-1") {
        layer.msg('不能在根目录导入视图！',{icon: 7});
    }
    else if (eformComponent.selectedEformComponentId == null) {
        layer.msg('请选择模块！', {icon: 7});
    }
    else {
        uploadDialog = layer.open({
            type: 2,
            closeBtn : 0 ,
            title: '导入视图xml',
            skin: 'bs-modal',
            area: ['400px', '200px'],
            maxmin: false,
            content: "avicit/platform6/eform/bpmsformmanage/eformFormView/importView.jsp"
        });
    }
};

EformFormView.prototype.doAllCreate= function () {
    var _this = this;

    layer.confirm('确定要重新生成页面吗?', {
		icon : 3,
		title : '提示',
		closeBtn : 0 ,
		area: ['400px', '']
	},function (index) {
    	layer.close(index);
        avicAjax.ajax({
            url: "platform/eform/eformViewInfoController/republishAllViewInfo",
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

//查看预设版本号
EformFormView.prototype.checkTabVersion = function (eformFormViewId) {
    var _this = this;

    checkTabVersionDialog = layer.open({
        type: 2,
        title: '查看预设版本号',
        skin: 'bs-modal',
        area: ['60%', '60%'],
        maxmin: false,
        content: "avicit/platform6/eform/bpmsformmanage/eformFormView/checkTabVersion.jsp?eformFormViewId=" + eformFormViewId
    });
};