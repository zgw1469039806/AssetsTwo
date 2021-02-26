function DiggerFormInfo(formArea, formInfoDiv) {
    this.formArea = formArea;
    this.formInfoDiv = formInfoDiv;

    this.init.call(this);
}
//初始化操作
DiggerFormInfo.prototype.init = function () {
    var _this = this;

    var template = $(
        '<div class="eform-item" id="">'
        + '<div class="eform-item-title" title="" data-toggle="popover" data-container="body" data-placement="auto bottom">'
        + '<i class="glyphicon glyphicon-list eform-item-view" style="color:rgb(15, 157, 88);"></i>'
        + '</div>'
        + '<div class="eform-item-bottom">'
        + '<span class="eform-item-bottom-name" title="表单">表单</span>'
        + '<span class="eform-item-bottom-btn">'
        + '<i class="glyphicon glyphicon-option-vertical"></i>'
        + '</span>'
        + '</div>'
        + '<div class="eform-item-tools" style="display: none;">'
        + '<div class="deleteDiggerInfo"><i class="glyphicon glyphicon-trash"></i>删除</div>'
        + '<div class="enableFormInfo"><i class="glyphicon glyphicon-off"></i><span></span></div>'
        + '</div>'
        + '</div>'
    );

    this.template = template;
};
//页面新建一个EformFormInfo
DiggerFormInfo.prototype.setFormInfo = function (data, searchFormInfoDiv) {
    var _this = this;

    var formInfo = _this.template.clone();

    //相关属性
    formInfo.attr("id", data.id);
    formInfo.attr("sort", data.orderBy);

    //显示属性
    formInfo.find(".eform-item-bottom-name").attr("title", data.formName);
    if (data.diggername.length > 7) {
        formInfo.find(".eform-item-bottom-name").text(data.diggername.substring(0, 5)+"...");
    }
    else {
        formInfo.find(".eform-item-bottom-name").text(data.diggername);
    }

    var _diggerType = '';
    if(data.diggertype == "0"){
        _diggerType = '统计'
    } else if(data.diggertype == "1"){
        _diggerType = '图表'
    } else if(data.diggertype == "2"){
        _diggerType = '普通'
    } else if(data.diggertype == "3"){
        _diggerType = '交叉'
    }
    
    _formContent = '<table width="180px" border="0" style="font-size:12px;"  align="center">'
	    	+'<tr><td width="40%" height="25"><lable>名称:</lable></td><td><span class="eform-item-popover" title="'+data.diggername+'">' + data.diggername + '</span></td></tr>'
			+'<tr><td width="40%" height="25"><lable>编码:</lable></td><td><span class="eform-item-popover" title="'+data.diggercode+'">' + data.diggercode + '</span></td></tr>'
			+'<tr><td width="40%" height="25"><lable>类型:</lable></td><td><span class="eform-item-popover" title="'+data.diggercode+'">' + _diggerType + '</span></td></tr>'
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
    
    //点击事件绑定
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
    formInfo.find(".deleteDiggerInfo").click(function () {
        _this.deleteData(data.id);
        return false;
    });
    if (data.publishStatus == "1") {
        formInfo.find(".publishFormInfo").remove();

        formInfo.find(".createjsp").click(function(){
        	_this.doCreate(data.id);
            return false;
        });
        formInfo.find(".eform-item-form").css("color", "rgb(15, 157, 88)");
        formInfo.find(".enableFormInfo").find("span").text("启用表单");

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
    formInfo.find(".changeDirectory").click(function () {
        _this.changeDirectory(data.id);
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

DiggerFormInfo.prototype.openDesigner = function (id,version) {
    var url = baseUrl+"platform/digger/diggerManageController/designDiggerInfo/" + id;
    if (version != undefined){
        url = baseUrl+"platform/digger/diggerManageController/designDiggerInfo/" + id+"?version="+version;
    }
	window.open(url, "_blank");
};
//添加
DiggerFormInfo.prototype.addData = function () {
    var _this = this;
    
    if (diggerComponent.selectedEformComponentId == null) {
        layer.msg('请选择模块！', {icon: 7});
    }else if (diggerComponent.selectedEformComponentId=="undefined" || diggerComponent.selectedEformComponentId.indexOf( "undefined")>-1) {
        top.layer.msg('不能在未分类节点下添加报表！',{icon: 7});

    }
    else {
        addDialog = layer.open({
            type: 2,
            title: '添加',
            skin: 'bs-modal',
            area: ['60%', '50%'],
            maxmin: false,
            content: "platform/digger/diggerManageController/addDiggerFormInfo?id="+diggerComponent.selectedEformComponentId
        });
    }
};
//删除
DiggerFormInfo.prototype.deleteData = function (infoId) {
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
                    var formInfo = $('#' + _this.formInfoDiv).find("#" + infoId);
                    formInfo.remove();

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

};


//表单验证
DiggerFormInfo.prototype.formValidate = function (form) {
    var _this = this;
    form.validate({
        rules: {
            diggername: {
                required: true,
                maxlength: 200
            },
            diggercode: {
                required: true,
                maxlength: 200
            },
            graphictype:{
            	required: true
            },
            orderBy:{
                required: true,
                integer:true
            }
        }
    });
};
//提交添加
DiggerFormInfo.prototype.subAdd = function (form) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var diggerName = form.find("#diggername").val();
    if(diggerName.indexOf("\"") !== -1 || diggerName.indexOf("\\") !== -1 || diggerName.indexOf("&") !== -1) {
        layer.msg('名称不能含有特殊字符！', {icon: 7});
        return false;
    }

    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);
    var diggerType = form.find("input[name='diggertype']:checked").val();
    var parm = "diggerType=" + diggerType +"&formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/digger/diggerManageController/subAddDiggerFormInfo",
        data: parm,
        type: "post",
        dataType: "json",
        success: function (backData) {
            if (backData.flag == "sucess") {
                //暂时先注释这块具体逻辑是啥?返回值不否
                 _this.setFormInfo(backData.data);
                layer.msg('操作成功！', {icon: 1});
                _this.closeDialog("add");
                setTimeout(function () {//1秒后 打开设计器界面
                    //添加完默认跳转到该电子表单设计器界面
                    window.open(baseUrl+"platform/digger/diggerManageController/designDiggerInfo/" + backData.data.id, "_blank");
                 }, 1000);
            } else {
                layer.msg('操作失败！', {icon: 2});
            }
        },
        error: function(e){
            layer.msg('操作失败！', {icon: 2});
        }
    });
};
DiggerFormInfo.prototype.baseInfoSave = function (form) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var diggerName = form.find("#diggername").val();
    if(diggerName.indexOf("\"") !== -1 || diggerName.indexOf("\\") !== -1 || diggerName.indexOf("&") !== -1) {
        layer.msg('名称不能含有特殊字符！', {icon: 7});
        return false;
    }
    var diggerType = $("#diggerType").val();
    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "diggerType=" + diggerType +"&formDataJson=" + formDataJson;
    $.ajax({
        url: "platform/digger/diggerManageController/subAddDiggerFormInfo",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.flag == "sucess") {
                layer.msg('保存成功！', {icon: 1});
            } else {
                layer.alert('保存失败！',{
                        icon: 7,
                        title:'提示',
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                    }
                );
            }
        }
    });
}



/**
 * 获取digger type radio value
 */
function getDiggerTypeRadioValue(){

}
//图形配置渲染数据
DiggerFormInfo.prototype.graphicalreRendering = function(form){
    var diggerId = $(form).find('#diggerId').val();
    $.ajax({
        url: "platform/digger/diggerManageController/getGraphicalConfigJsonData?diggerId=" + diggerId,
        type: "GET",
        dataType: "json",
        success: function (data) {
            $(form).find('#id').val(data.id);
            $(form).find('#titleName').val(data.titleName);
            $(form).find('#link').val(data.link);
            $(form).find('#subtext').val(data.subtext);
            $(form).find('#subLink').val(data.subLink);
            $(form).find('#titleTop').val(data.titleTop);
            $(form).find('#titleTextSize').val(data.titleTextSize);
            $(form).find('#titleTextColor').val(data.titleTextColor);
            $(form).find('#backgroundColor').val(data.backgroundColor);

            $(form).find('#tipformatter').val(data.tipFormater);
            $(form).find('#arrayType').val(data.arrayType);
            $(form).find('#legendAlign').val(data.legendAlign);
            //设置标题checkbox选中,区域显示
            if(data.titleShow){
                $(form).find('#titleShow').prop('checked',true);
                $(form).find('#titleShowDiv').css('display','block');
            }
            //设置标注checkbox选中,区域显示
            if(data.calloutShow){
                $(form).find('#calloutShow').prop('checked',true);
                $(form).find('#calloutShowDiv').css('display','block');
            }

            $("#titleAlign ").get(0).value = data.titleAlign;
            $("#titleUnit ").get(0).value = data.titleUnit;
            $("#legendAlign ").get(0).value = data.legendAlign;
            $(":radio[name='tipBoxType'][value='" + data.tipBoxType + "']").prop("checked", "checked");
            $(":radio[name='arrayType'][value='" + data.arrayType + "']").prop("checked", "checked");
            $(":radio[name='tipBoxType'][value='" + data.tipBoxType + "']").prop("checked", "checked");

        }
    });
}

//图形配置保存
DiggerFormInfo.prototype.graphicalSave = function(form){
    var _this = this;
    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var titleShow = getCheckBoxValue($(form).find('#titleShow'));
    $(form).find('#titleShow').val(titleShow);

    var calloutShow = getCheckBoxValue($(form).find('#calloutShow'));
    $(form).find('#calloutShow').val(calloutShow);

    var titleAlign = getSelectedValue($(form).find('#titleAlign'));
    $(form).find('#titleAlign').val(titleAlign);
    var legendAlign = getSelectedValue($(form).find('#legendAlign'));
    $(form).find('#legendAlign').val(legendAlign);

    var titleUnit = getSelectedValue($(form).find('#titleUnit'));
    $(form).find('#titleUnit').val(titleUnit);

    var tipBoxType = $('input[name="tipBoxType"]:checked').val();
    $(form).find('#tipBoxType').val(tipBoxType);

    var arrayType = $('input[name="arrayType"]:checked').val();
    $(form).find('#arrayType').val(arrayType);

    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    var parm = "formDataJson=" + formDataJson ;
    $.ajax({
        url: "platform/digger/diggerManageController/saveGraphicalConfig",
        data: parm,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData == "1") {
                layer.msg('保存成功！', {icon: 1});
            } else {
                layer.msg('保存失败！', {icon: 2});
            }
        }
    });
}

function getCheckBoxValue(obj){
    if(obj.prop('checked')){
        return 1;
    } else {
        return 0;
    }
}

function getSelectedValue(obj){
    return obj.val();
}

function getRadioValue(obj){

}
//提交编辑
DiggerFormInfo.prototype.subEdit = function (form, oldFormCode) {
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
DiggerFormInfo.prototype.closeDialog = function (type) {
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
DiggerFormInfo.prototype.getFormInfoList = function (componentId) {
    var _this = this;

    $('#' + _this.formInfoDiv).empty();
    $.ajax({
        url: "platform/digger/diggerManageController/getDiggerInfoList",
        data: "componentId=" + componentId,
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

$(function(){
    $('#titleShow').click(function(){//标题
        if($('#titleShow').prop('checked')){
            $('#titleShowDiv').css('display','block');
        } else {
            $('#titleShowDiv').css('display','none');
        }
    });

    $('#calloutShow').click(function(){//标注
        if($('#calloutShow').prop('checked')){
            $('#calloutShowDiv').css('display','block');
        } else {
            $('#calloutShowDiv').css('display','none');
        }
    });
});

function getValue(){
    return $("#diggersql").val();
}
(function($) {
    $.fn.extend({
        insertAtCaret: function(myValue) {
            var $t = $(this)[0];
            //ie
            if (document.selection) {
                this.focus();
                sel = document.selection.createRange();
                sel.text = myValue;
                this.focus();
            } else if ($t.selectionStart || $t.selectionStart == "0") {  // !ie
                var startPos = $t.selectionStart;
                var endPos = $t.selectionEnd;
                var scrollTop = $t.scrollTop;
                if($t.value.length > 0 && $t.value.substring(startPos - 1, startPos) == '@'){
                    $t.value = $t.value.substring(0, startPos - 1) + myValue + $t.value.substring(endPos, $t.value.length);
                } else {
                    $t.value = $t.value.substring(0, startPos) + myValue + $t.value.substring(endPos, $t.value.length);
                }
                this.focus();
                $t.selectionStart = startPos + myValue.length;
                $t.selectionEnd = startPos + myValue.length;
                $t.scrollTop = scrollTop;
            } else {
                this.value += myValue;
                this.focus();
            }
        }
    });
})(jQuery);

/**
 * 设置高度
 */
function setHeight() {
    var navTabs = $('#nav-tabs'),navbar = $('#navbar'),body = $('body')
        diggerDatasourceConfigFrame = $('#diggerDatasourceConfigFrame')
        mutilTableHeaderConfigFrame = $('#mutilTableHeaderConfigFrame')
        diggerQueryConfigFrame = $('#diggerQueryConfigFrame');
    var headHeight = navTabs.height() + navbar.height() + 5;//头高度
    diggerDatasourceConfigFrame.height(window.innerHeight - headHeight);
    mutilTableHeaderConfigFrame.height(window.innerHeight - headHeight);
    diggerQueryConfigFrame.height(window.innerHeight - headHeight);
    body.height(window.innerHeight);
    $(window).on('resize', function() {
        diggerDatasourceConfigFrame.height(window.innerHeight - headHeight);
        mutilTableHeaderConfigFrame.height(window.innerHeight - headHeight);
        diggerQueryConfigFrame.height(window.innerHeight - headHeight);
        body.height(window.innerHeight);
    });
}
