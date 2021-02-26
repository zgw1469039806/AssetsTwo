/**
 * Created by xb on 2017/5/11.  Modified By hangchao.you 2017/07/03
 */
function BpmsFormInfo(formArea, formInfoDiv) {
    this.formArea = formArea;
    this.formInfoDiv = formInfoDiv;
    this.init.call(this);
}

var openIndex;

//初始化操作
BpmsFormInfo.prototype.init = function () {
    var _this = this;

    _this.template = $(
        '<div class="eform-item" id="">' +
         '<div class="eform-item-title"  title="" data-toggle="popover" data-container="body" data-placement="auto bottom">' +
         '<i class="glyphicon glyphicon-th eform-item-form" style="color: rgb(15, 157, 88);"></i>'                                             +
         '</div>'                                                                                             +
         '<div class="eform-item-bottom">'                                                                    +
         '<span class="eform-item-bottom-name" title="表单">表单</span>'                                          +
         '<span class="eform-item-bottom-btn">'                                                               +
         '<i class="glyphicon glyphicon-option-vertical"></i>'                                                +
         '</span>'                                                                                            +
         '</div>'                                                                                             +
         '<div class="eform-item-tools" style="display: none;">'                                              +
         '<div class="editFormInfo"><i class="glyphicon glyphicon-pencil"></i>编辑表单</div>'                     +
         '<div class="deleteFormInfo"><i class="glyphicon glyphicon-trash"></i>删除表单</div>'                    +
         '</div>'                                                                                             +
         '</div>'                                                                                             
    );

};
//页面新建一个EformFormInfo
BpmsFormInfo.prototype.setFormInfo = function (data) {
    var _this = this;

    var formInfo = _this.template.clone();

    //相关属性
    formInfo.attr("id", data.id);
    //显示属性
    formInfo.find(".eform-item-bottom-name").attr("title", data.formName);

    if (data.formName.length > 7) {
        formInfo.find(".eform-item-bottom-name").text(data.formName.substring(0, 7));
    }
    else {
        formInfo.find(".eform-item-bottom-name").text(data.formName);
    }

    var formtype = "内部表单";
    if (data.isProxy == "Y"){
        formtype = "外部表单";
    }
    var _formContent = ''; 
    _formContent = '<table width="180px" border="0" style="font-size:12px;"  align="center">'
	    	+'<tr><td width="40%" height="25"><lable>表单名称:</lable></td><td><span class="eform-item-popover" title="'+data.formName+'">'+data.formName+'</span></td></tr>'
			+'<tr><td width="40%" height="25"><lable>表单编码:</lable></td><td><span class="eform-item-popover" title="'+data.formCode+'">'+data.formCode+'</span></td></tr>'
			+'<tr><td width="40%" height="25"><lable>表单类型:</lable></td><td>'+formtype+'</td></tr>'
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
        }, 300);
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
    $('#' + _this.formInfoDiv).append(formInfo);

};

//添加
BpmsFormInfo.prototype.addData = function () {
    var _this = this;

    if (eformComponent.selectedEformComponentId == null) {
        top.layer.msg('请选择模块！', {icon: 7});
    }
    else {
        openIndex =   layer.open({
            type: 2,
            title: '添加非电子表单',
            skin: 'bs-modal',
            area: ['100%', '100%'],
            maxmin: false,
            content: "platform/bpm/bpmsManageController/toAddBpmForm"
        });
    }
};
//编辑
BpmsFormInfo.prototype.editData = function (formInfoId) {
    var _this = this;

    openIndex =  layer.open({
        type: 2,
        title: '编辑非电子表单',
        skin: 'bs-modal',
        area: ['100%', '100%'],
        maxmin: false,
        content: "platform/bpm/bpmsManageController/toEditBpmForm?id=" + formInfoId
    });
};
//删除
BpmsFormInfo.prototype.deleteData = function (formInfoId) {
    var _this = this;

    top.layer.confirm('确定要删除该表单吗？',{icon : 3, title : '提示',closeBtn : 0,area : ['400px', '']}, function (index) {
        $.ajax({
            url: "platform/bpm/bpmsManageController/deleteBpmFormInfo",
            data: {id:formInfoId},
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                if (backData.status == 200) {
                    var formInfo = $('#' + _this.formInfoDiv).find("#" + formInfoId);
                    formInfo.remove();
                    if (bpmsformInfoModel!=null && typeof(bpmsformInfoModel)!="undefined")
                        bpmsformInfoModel.reLoad(eformComponent.selectedEformComponentId);
                    top.layer.msg('操作成功！', {icon: 1});
                }
                else {
                    top.layer.msg('操作失败！', {icon: 2});
                }
            }
        });
    });
};


//表单验证
BpmsFormInfo.prototype.formValidate = function (form) {
    var _this = this;

    form.validate({
        rules: {
            formType:{
                required: true,
                maxlength: 10
            },
            formUrl: {
                required: true,
                maxlength: 200
            },
            formName: {
                required: true,
                maxlength: 200
            },
            formCode: {
                required: true,
                maxlength: 200
            }
        }
    });
};
//提交添加
BpmsFormInfo.prototype.subAdd = function (form) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var formSerializeValue = form.serialize();
    var formDataJson = convertFormSerializeValueToJson(formSerializeValue);

    $.ajax({
        url: "platform/bpm/bpmsManageController/addBpmFormInfo",
        data: {formDataJson:formDataJson},
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.status === 200) {
                _this.setFormInfo(backData.data);
                if (bpmsformInfoModel!=null && typeof(bpmsformInfoModel)!="undefined")
                    bpmsformInfoModel.reLoad(eformComponent.selectedEformComponentId);
                top.layer.msg('操作成功！', {icon: 1});
                form.find("input").val("");
                _this.closeDialog(window.name);
            }
            else {
                top.layer.msg('操作失败！'+backData.err, {icon: 2});
            }
        }
    });
};
//提交编辑
BpmsFormInfo.prototype.subEdit = function (form) {
    var _this = this;

    var isValidate = form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    var formSerializeValue = form.serialize();
    var formDataJson =convertFormSerializeValueToJson(formSerializeValue)
    $.ajax({
        url: "platform/bpm/bpmsManageController/subEditBpmsFormInfo",
        data: {formDataJson:formDataJson},
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if (backData.status == 200) {
                var formInfo = $('#' + _this.formInfoDiv).find("#" + backData.data.id);
                formInfo.remove();
                _this.setFormInfo(backData.data);
                if (bpmsformInfoModel!=null && typeof(bpmsformInfoModel)!="undefined")
                    bpmsformInfoModel.reLoad(eformComponent.selectedEformComponentId);
                top.layer.msg('操作成功！', {icon: 1});
                layer.close(openIndex);
            }
            else {
                top.layer.msg('操作失败！'+backData.err, {icon: 2});
            }
        }
    });
};
//关闭弹出框
BpmsFormInfo.prototype.closeDialog = function (windowName) {
    // var index = layer.getFrameIndex(windowName); //先得到当前iframe层的索引
    layer.close(openIndex);
};

// 获取流程
BpmsFormInfo.prototype.getFormInfoList = function (componentId,name) {
    var _this = this;

    $('#' + _this.formInfoDiv).empty();
    $.ajax({
        url: "platform/bpm/bpmsManageController/getBpmFormInfoList",
        data: {
               componentId : componentId,
                formname:name
        },
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            if(backData.status == 200) {
                var formInfoList = backData.data;
                for (var i = 0; i < formInfoList.length; i++) {
                    _this.setFormInfo(formInfoList[i]);
                }
            } else {
                top.layer.msg('发生了一个错误！', {icon: 2});
                // alert(backData.err);
            }

        }
    });
};