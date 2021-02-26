/**
 * 业务操作对象，需继承基础对象，重写必要的业务操作方法
 */
function DynSdCollecMainDetail(form, AssetsSdequipCollect) {
    this._formId = "#" + form;
    this.AssetsSdequipCollect = AssetsSdequipCollect;
    this._formId = "#" + form;
    DefaultForm.call(this);
};
DynSdCollecMainDetail.prototype = new DefaultForm();
DynSdCollecMainDetail.prototype.formcode = "dynSdCollecMain";
/**
 * 初始化操作
 */
DynSdCollecMainDetail.prototype.initFormData = function () {
    var _self = this;
    _self.isLoading = true;
    avicAjax.ajax({
        url: 'platform/assets/device/dynsdcollecmain/dynSdCollecMainController/toDetailJsp.json',
        data: {
            id: _self.id
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                _self.setForm($(_self._formId), result.dynSdCollecMainDTO);
            } else {
                layer.msg('数据加载失败！');
            }
        }
    });
};
/**
 * 启动流程
 */
DynSdCollecMainDetail.prototype.start = function (defineId, callback) {
    var _self = this;
    if (!_self.validAttachRequired()) {
        return false;
    }
    var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }
    //子表校验
    var msg = _self.AssetsSdequipCollect.valid();
    if (msg && msg != "") {
        layer.alert(msg, {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            btn: ['关闭'],
            title: "提示"
        });
        return false;
    }
    var dataVo = JSON.stringify(serializeObject($(_self._formId)));
    avicAjax.ajax({
        url: 'platform/assets/device/dynsdcollecmain/dynSdCollecMainController/operation/saveAndStartProcess',
        data: {
            processDefId: defineId,
            formCode: _self.formcode,
            data: dataVo
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                var files = $('#attachment').uploaderExt('getUploadFiles');
                //验证附件密级
                for (var i = 0; i < files.length; i++) {
                    var name = files[i].name;
                    var secretLevel = files[i].secretLevel;
                    //这里验证密级
                }
                if (files.length != 0) {
                    afterUploadEvent = function () {
                        $('#id').val(result.startResult.formId);
                        _self.AssetsSdequipCollect.save(result.startResult.formId);
                        // 启动成功后回调流程刷新按钮
                        callback(result.startResult);
                        _self.initFormData();
                    };
                    $('#attachment').uploaderExt('doUpload', result.startResult.formId);
                } else {
                    $('#id').val(result.startResult.formId);
                    _self.AssetsSdequipCollect.save(result.startResult.formId);
                    // 启动成功后回调流程刷新按钮
                    callback(result.startResult);
                    _self.initFormData();
                }
            } else {
                layer.msg('保存失败！');
            }
        }
    });
};
/**
 * 更新数据
 */
DynSdCollecMainDetail.prototype.save = function (callback) {
    var _self = this;
    if (!_self.validAttachRequired()) {
        return false;
    }
    var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }

    //子表校验
    var msg = _self.AssetsSdequipCollect.valid();
    if (msg && msg != "") {
        layer.alert(msg, {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            btn: ['关闭'],
            title: "提示"
        });
        return false;
    }
    var dataVo = JSON.stringify(serializeObject($(_self._formId)));
    avicAjax.ajax({
        url: 'platform/assets/device/dynsdcollecmain/dynSdCollecMainController/operation/save',
        data: {
            data: dataVo
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                var files = $('#attachment').uploaderExt('getUploadFiles');
                //验证附件密级
                for (var i = 0; i < files.length; i++) {
                    var name = files[i].name;
                    var secretLevel = files[i].secretLevel;
                    //这里验证密级
                }
                if (files.length != 0) {
                    afterUploadEvent = function () {
                        _self.AssetsSdequipCollect.save(result.pid);
                        // 启动成功后回调流程刷新按钮
                        callback();
                        _self.initFormData();
                    };
                    $('#attachment').uploaderExt('doUpload', result.pid);
                } else {
                    _self.AssetsSdequipCollect.save(result.pid);
                    // 启动成功后回调流程刷新按钮
                    callback();
                    _self.initFormData();
                }
            } else {
                layer.msg('保存失败！');
            }
        }
    });
};
/**
 * 表单重载json对象数据
 */
DynSdCollecMainDetail.prototype.setForm = function (formObj, jsonValue) {
    var obj = formObj;
    $.each(jsonValue, function (name, ival) {
        var oinput = obj.find("input[name=" + name + "]");
        if (oinput.attr("type") == "checkbox") {
            if (ival !== null) {
                var checkboxObj = $("[name=" + name + "]");
                var checkArray = ival.length > 0 ? ival.split(",") : ival;
                for (var i = 0; i < checkboxObj.length; i++) {
                    checkboxObj[i].checked = false;
                    for (var j = 0; j < checkArray.length; j++) {
                        if (checkboxObj[i].value == checkArray[j]) {
                            checkboxObj[i].checked = true;
                        }
                    }
                }
            }
        } else if (oinput.attr("type") == "radio") {
            oinput.each(function () {
                var radioObj = $("[name=" + name + "]");
                for (var i = 0; i < radioObj.length; i++) {
                    if (radioObj[i].value == ival) {
                        radioObj[i].checked = true;
                    }
                }
            });
        } else if ($(oinput).attr('class') == "form-control date-picker hasDatepicker") {
            if (ival != "" && ival != null) {
                obj.find("[name=" + name + "]").datepicker("setDate", new Date(ival));
            }
        } else if ($(oinput).attr('class') == "form-control time-picker hasDatepicker") {
            obj.find("[name=" + name + "]").val(ival);
        } else {
            obj.find("[name=" + name + "]").val(ival);
        }
    });
};
/**
 * 控制附件
 */
DynSdCollecMainDetail.prototype.setAttachMagic = function (attachMagic) {
    //当流程节点配置是否允许附件功能时候，隐藏上传、下载按钮等
    if (attachMagic) {
        setTimeout(function () {
            $('.uploader-panel-heading').each(function (index, element) {
                $(element).css("display", "");
            });
            $('div.uploader-file-item').unbind("mouseover");
        }, 500);
    }
    else {
        setTimeout(function () {
            $('.uploader-panel-heading').each(function (index, element) {
                $(element).css("display", "none");
            });
            $('div.uploader-file-item').bind('mouseover', function () {
                $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
            });
        }, 800);
    }
};
/**
 * 流程控制-多附件必填
 */
DynSdCollecMainDetail.prototype.setAttachRequired = function (tagId, required, obj) {
    eval("this.attachRequiredMap." + tagId + " = " + required);
};
DynSdCollecMainDetail.prototype.attachRequiredMap = {};
DynSdCollecMainDetail.prototype.validAttachRequired = function () {
    for (var tagId in this.attachRequiredMap) {
        if (this.attachRequiredMap[tagId]) {
            var itemListNum = $('#' + tagId).find('.uploader-file-item').size();
            if (itemListNum == 0) {
                layer.alert("附件不能为空！", {
                    title: "提示",
                    icon: 7
                });
                return false;
            }
        }
    }
    return true;
};

/**
 * 多附件增删控制
 */
DynSdCollecMainDetail.prototype.setAttachCanAddOrDel = function (tagId, operability, obj) {
    if (operability) {
        setTimeout(function () {
            $('#' + tagId).children('.uploader-panel-heading').each(function (index, element) {
                $(element).css("display", "");
            });
            $('#' + tagId).find('div.uploader-file-item').unbind("mouseover");
        }, 500);
    } else {
        setTimeout(function () {
            $('#' + tagId).children('.uploader-panel-heading').each(function (index, element) {
                $(element).css("display", "none");
            });
            $('#' + tagId).find('div.uploader-file-item').bind('mouseover', function () {
                $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
            });
        }, 800);
    }
};
/**
 * 控制子表toolbar是否可用和子表数据是否可编辑
 */
DynSdCollecMainDetail.prototype.controlSelfElement = function (tagId, operability, obj) {
    if (operability) {
        if (tagId == "assetsSdequipCollect_editable") {//判断是否允编辑子表数据
            //获取colModel数组对象
            var columnArray = $('#assetsSdequipCollect').jqGrid('getGridParam', 'colModel');
            //给每个colModel属性列设置可编辑
            $.each(columnArray, function (i, item) {
                $('#assetsSdequipCollect').setColProp(item.name, {editable: true});
            });
        } else {
            $("#" + tagId).show();
        }
    } else {
        $("#" + tagId).hide();
    }
}
/**
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
DynSdCollecMainDetail.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            author: {
                maxlength: -1
            },
            releasedate: {
                dateISO: true
            },
            telephone: {
                maxlength: 50
            },
            dept: {
                maxlength: -1
            },
            formRemarks: {
                maxlength: 4000
            },
            formTitle: {
                maxlength: 50
            },
            applyYear: {
                maxlength: 50
            },
            deptDeadline: {
                dateISO: true
            },
            personDeadline: {
                dateISO: true
            },
        }
    });
}
