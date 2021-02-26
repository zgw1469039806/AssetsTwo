/**
 * 业务操作对象，需继承基础对象，重写必要的业务操作方法
 */
function AssetsAccidentProcDetail(form) {
    this._formId = "#" + form;
    DefaultForm.call(this);
};
AssetsAccidentProcDetail.prototype = new DefaultForm();
//formcode
AssetsAccidentProcDetail.prototype.formcode = "assetsAccidentProc";
//初始化操作
AssetsAccidentProcDetail.prototype.initFormData = function () {
    var _self = this;
    avicAjax.ajax({
        url: 'platform/assets/device/assetsaccidentproc/assetsAccidentProcController/toDetailJsp.json',
        data: {
            id: _self.id
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                _self.setForm($(_self._formId), result.assetsAccidentProcDTO);
            } else {
                layer.msg('数据加载失败！');
            }
        }
    });
};
//启动流程
AssetsAccidentProcDetail.prototype.start = function (defineId, callback) {
    var _self = this;
    //表单校验
    var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        $(isValidate.errorList[0].element).focus();
        return false;
    }
    //附件权限校验
    if (!_self.validAttachRequired()) {
        return false;
    }
    var dataVo = JSON.stringify(serializeObject($(_self._formId)));
    avicAjax.ajax({
        url: 'platform/assets/device/assetsaccidentproc/assetsAccidentProcController/operation/saveAndStartProcess',
        data: {
            processDefId: defineId,
            formCode: _self.formcode,
            data: dataVo
        },
        type: 'POST',
        async: false,
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                var files = $('#attachment').uploaderExt('getUploadFiles');
                if (files != 0) {
                    //遮罩
                    var maskId = layer.load();
                    $("#id").val(result.startResult.formId);
                    afterUploadEvent = function () {
                        //去掉遮罩
                        layer.close(maskId);
                        // 启动成功后回调流程刷新按钮
                        callback(result.startResult);
                        //刷新页面
                        _self.initFormData();
                    };
                    $('#attachment').uploaderExt('doUpload', result.startResult.formId);
                } else {
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
//更新数据
AssetsAccidentProcDetail.prototype.save = function (callback) {
    var _self = this;
    //表单校验
    var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        $(isValidate.errorList[0].element).focus();
        return false;
    }
    //附件权限校验
    if (!_self.validAttachRequired()) {
        return false;
    }
    var dataVo = JSON.stringify(serializeObject($(_self._formId)));
    avicAjax.ajax({
        url: 'platform/assets/device/assetsaccidentproc/assetsAccidentProcController/operation/save',
        data: {
            data: dataVo
        },
        type: 'POST',
        async: false,
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                var files = $('#attachment').uploaderExt('getUploadFiles');
                if (files != 0) {
                    $("#id").val(result.id);
                    //遮罩
                    var maskId = layer.load();
                    //附件上传完毕后执行该方法
                    afterUploadEvent = function () {
                        //去掉遮罩
                        layer.close(maskId);
                        // 启动成功后回调流程刷新按钮
                        callback();
                        //刷新页面
                        _self.initFormData();
                    };
                    $('#attachment').uploaderExt('doUpload', result.id);
                } else {
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
//表单重载json对象数据
AssetsAccidentProcDetail.prototype.setForm = function (formObj, jsonValue) {
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
//控制附件
AssetsAccidentProcDetail.prototype.setAttachMagic = function (attachMagic) {
    //当流程节点配置是否允许附件功能时候，隐藏上传、下载按钮等
    if (attachMagic) {
        $('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "");
        });
        $('div.uploader-file-item').unbind("mouseover");
    } else {
        $('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "none");
        });
        $('div.uploader-file-item').bind('mouseover', function () {
            $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
        });
    }
};
//流程控制-多附件必填
AssetsAccidentProcDetail.prototype.setAttachRequired = function (tagId, required, obj) {
    eval("this.attachRequiredMap." + tagId + " = " + required);
};

AssetsAccidentProcDetail.prototype.attachRequiredMap = {};
AssetsAccidentProcDetail.prototype.validAttachRequired = function () {
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

//多附件增删控制
AssetsAccidentProcDetail.prototype.setAttachCanAddOrDel = function (tagId, operability, obj) {
    if (operability) {
        $('#' + tagId).children('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "");
        });
        $('#' + tagId).find('div.uploader-file-item').unbind("mouseover");
    } else {
        $('#' + tagId).children('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "none");
        });
        $('#' + tagId).find('div.uploader-file-item').bind('mouseover', function () {
            $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
        });
    }
};
//控件校验   规则：表单字段name与rules对象保持一致
AssetsAccidentProcDetail.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            accidentNo: {
                required: true,
                maxlength: 50
            },
            createdByDept: {
                maxlength: 50
            },
            createdByTel: {
                maxlength: 50
            },
            formState: {
                maxlength: 10
            },
            assetsOperator: {
                maxlength: 50
            },
            operatorDept: {
                maxlength: 50
            },
            unifiedId: {
                required: true,
                maxlength: 50
            },
            deviceName: {
                maxlength: 50
            },
            deviceModel: {
                maxlength: 50
            },
            deviceSpec: {
                maxlength: 50
            },
            occurTime: {
                dateISO: false
            },
            reportLeaderTime: {
                dateISO: false
            },
            reportTime: {
                dateISO: false
            },
            accidentProcess: {
                maxlength: 1024
            },
            accidentConsequence: {
                maxlength: 1024
            },
            reasonAnalysis: {
                maxlength: 1024
            },
            preventionMeasures: {
                maxlength: 1024
            },
            repairTime: {
                dateISO: false
            },
            stopWorkDays: {
                number: true
            },
            directEconomicLoss: {
                number: true
            },
            accidentProperty: {
                maxlength: 50
            },
            assetsMan: {
                maxlength: 50
            },
        }
    });
}

//弹框选择设备台账的回调函数
function callBackFn(rows, requestType) {
    var row = null;
    if (rows.length > 0) {
        row = rows[0];
    }
    switch (requestType) {
        case "productModelSelect":
            $('#unifiedId').val(row.unifiedId);
            $('#deviceName').val(row.deviceName);
            $('#deviceModel').val(row.deviceModel);
            $('#deviceSpec').val(row.deviceSpec);
            break;
        case "productSerySelect":
            $('#seryCode').val(row.seryCode);
            $('#seriesId').val(row.id);
            break;
    }
    closeLayer(openIndex);
}

//弹窗关闭函数
function closeLayer() {
    layer.close(openIndex);
}

/**
 * 设备台账信息选择框
 * param:
 *  singleSelect -是否单选（true-单选，false为多选；字符串）；
 *  requestType-页面请求标记，用于同一页面有多个相同弹出页时，调用回调函数赋值时使用，可为空字符串，代码默认取值‘productModelSelect’；
 *  callBackFn-回调函数名称，用户声明的“弹框选择设备台账的回调函数”的函数名字符串；
 */
function openProductModelLayer(singleSelect, requestType, callBackFn, param) {
    sessionStorage.setItem("param", param);
    this.openIndex = layer.open({
        type: 2,
        area: ['60%', '70%'],
        title: '台账信息选择',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/assetsdeviceaccount/AssetsDeviceAccountSelect.jsp?singleSelect=" + singleSelect + "&requestType=" + requestType + "&callBackFn=" + callBackFn

    });
};