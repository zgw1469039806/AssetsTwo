/**
 * 业务操作对象，需继承基础对象，重写必要的业务操作方法
 */
function AssetsStdtempapplyProcDetail(form, AssetsSupplier) {
    this._formId = "#" + form;
    this.AssetsSupplier = AssetsSupplier;
    this._formId = "#" + form;
    DefaultForm.call(this);
};
AssetsStdtempapplyProcDetail.prototype = new DefaultForm();
AssetsStdtempapplyProcDetail.prototype.formcode = "assetsStdempapply";
/**
 * 初始化操作
 */
AssetsStdtempapplyProcDetail.prototype.initFormData = function () {
    var _self = this;
    _self.isLoading = true;
    avicAjax.ajax({
        url: 'platform/assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController/toDetailJsp.json',
        data: {
            id: _self.id
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                _self.setForm($(_self._formId), result.assetsStdtempapplyProcDTO);
            } else {
                layer.msg('数据加载失败！');
            }
        }
    });
};
/**
 * 启动流程
 */
AssetsStdtempapplyProcDetail.prototype.start = function (defineId, callback) {
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
    var msg = _self.AssetsSupplier.valid();
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
        url: 'platform/assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController/operation/saveAndStartProcess',
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
                        _self.AssetsSupplier.save(result.startResult.formId);
                        // 启动成功后回调流程刷新按钮
                        callback(result.startResult);
                        _self.initFormData();
                    };
                    $('#attachment').uploaderExt('doUpload', result.startResult.formId);
                } else {
                    $('#id').val(result.startResult.formId);
                    _self.AssetsSupplier.save(result.startResult.formId);
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
AssetsStdtempapplyProcDetail.prototype.save = function (callback) {
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
    var msg = _self.AssetsSupplier.valid();
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
        url: 'platform/assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController/operation/save',
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
                        _self.AssetsSupplier.save(result.pid);
                        // 启动成功后回调流程刷新按钮
                        callback();
                        _self.initFormData();
                    };
                    $('#attachment').uploaderExt('doUpload', result.pid);
                } else {
                    _self.AssetsSupplier.save(result.pid);
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
AssetsStdtempapplyProcDetail.prototype.setForm = function (formObj, jsonValue) {
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
AssetsStdtempapplyProcDetail.prototype.setAttachMagic = function (attachMagic) {
    //当流程节点配置是否允许附件功能时候，隐藏上传、下载按钮等
    if (attachMagic) {
        setTimeout(function () {
            $('.uploader-panel-heading').each(function (index, element) {
                $(element).css("display", "");
            });
            $('div.uploader-file-item').unbind("mouseover");
        }, 500);
    } else {
        setTimeout(function () {
            $('.uploader-panel-heading').each(function (index, element) {
                $(element).css("display", "block");
            });
            $('div.uploader-file-item').bind('mouseover', function () {
                $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "block");
            });
        }, 800);
    }
};
/**
 * 流程控制-多附件必填
 */
AssetsStdtempapplyProcDetail.prototype.setAttachRequired = function (tagId, required, obj) {
    eval("this.attachRequiredMap." + tagId + " = " + required);
};
AssetsStdtempapplyProcDetail.prototype.attachRequiredMap = {};
AssetsStdtempapplyProcDetail.prototype.validAttachRequired = function () {
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
AssetsStdtempapplyProcDetail.prototype.setAttachCanAddOrDel = function (tagId, operability, obj) {
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
AssetsStdtempapplyProcDetail.prototype.controlSelfElement = function (tagId, operability, obj) {
    if (operability) {
        if (tagId == "assetsSupplier_editable") {//判断是否允编辑子表数据
            //获取colModel数组对象
            var columnArray = $('#assetsSupplier').jqGrid('getGridParam', 'colModel');
            //给每个colModel属性列设置可编辑
            $.each(columnArray, function (i, item) {
                $('#assetsSupplier').setColProp(item.name, {editable: true});
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
AssetsStdtempapplyProcDetail.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            // stdId: {
            //     required: true,
            //     maxlength: 50
            // },
            createdByDept: {
                maxlength: 50
            },
            createdByTel: {
                maxlength: 20
            },
            formState: {
                maxlength: 10
            },
            deviceName: {
                maxlength: 30
            },
            deviceSpec: {
                maxlength: 50
            },
            deviceModel: {
                maxlength: 50
            },
            secretLevel: {
                maxlength: 10
            },
            referencePlant: {
                maxlength: 50
            },
            deviceNum: {
                number: true
            },
            unitPrice: {
                number: true
            },
            totalPrice: {
                number: true
            },
            deviceType: {
                maxlength: 10
            },
            deviceCategory: {
                maxlength: 10
            },
            isMetering: {
                maxlength: 10
            },
            isSceneMetering: {
                maxlength: 10
            },
            isMaintain: {
                maxlength: 10
            },
            isAccuracyCheck: {
                maxlength: 10
            },
            isRegularCheck: {
                maxlength: 10
            },
            isSpotCheck: {
                maxlength: 10
            },
            isSpecialDevice: {
                maxlength: 10
            },
            isPrecisionIndex: {
                maxlength: 10
            },
            isNeedInstall: {
                maxlength: 10
            },
            installPosition: {
                maxlength: 200
            },
            isFoundation: {
                maxlength: 10
            },
            isSafetyProduction: {
                maxlength: 10
            },
            financialResources: {
                maxlength: 10
            },
            toProject: {
                maxlength: 50
            },
            approvalName: {
                maxlength: 50
            },
            chiefEngineer: {
                maxlength: 50
            },
            projectNum: {
                maxlength: 50
            },
            projectDirector: {
                maxlength: 50
            },
            demandUrgencyDegree: {
                maxlength: 10
            },
            isTrain: {
                maxlength: 10
            },
            isPc: {
                maxlength: 10
            },
            planDeliveryTime: {
                dateISO: true
            },
            buyer: {
                maxlength: 50
            },
            planBuyer: {
                maxlength: 50
            },
            isWireless: {
                maxlength: 10
            },
            devicePurchaseType: {
                maxlength: 10
            },
            devicePurchaseCause: {
                maxlength: 255
            },
            technicalIndex: {
                maxlength: 1024
            },
            technicalIndex02: {
                maxlength: 1024
            },
            advancement: {
                maxlength: 1024
            },
            deviceReliability: {
                maxlength: 1024
            },
            isWeedOut: {
                maxlength: 10
            },
            notMeetDemand: {
                maxlength: 1024
            },
            useRatio: {
                maxlength: 1024
            },
            energyConsumption: {
                maxlength: 1024
            },
            consumableEconomics: {
                maxlength: 1024
            },
            universality: {
                maxlength: 1024
            },
            maintainCost: {
                maxlength: 1024
            },
            security: {
                maxlength: 1024
            },
            isBearingMeet: {
                maxlength: 10
            },
            isOutdoorUnit: {
                maxlength: 10
            },
            isAllowOutdoorUnit: {
                maxlength: 10
            },
            isNeedFoundation: {
                maxlength: 10
            },
            isFoundationCondition: {
                maxlength: 10
            },
            serviceVoltage: {
                maxlength: 10
            },
            isVoltageCondition: {
                maxlength: 10
            },
            isHumidityNeed: {
                maxlength: 10
            },
            humidityNeed: {
                maxlength: 50
            },
            isCleanlinessNeed: {
                maxlength: 10
            },
            cleanlinessNeed: {
                maxlength: 50
            },
            isWaterNeed: {
                maxlength: 10
            },
            waterNeed: {
                maxlength: 50
            },
            isGasNeed: {
                maxlength: 10
            },
            gasNeed: {
                maxlength: 50
            },
            isLet: {
                maxlength: 10
            },
            letNeed: {
                maxlength: 50
            },
            isOtherNeed: {
                maxlength: 10
            },
            otherNeed: {
                maxlength: 50
            },
            isNoise: {
                maxlength: 10
            },
            isNoiseInfluence: {
                maxlength: 10
            },
            aboveNeedHave: {
                maxlength: 50
            },
            largeDeviceType: {
                maxlength: 50
            },
            instituteOrCompany: {
                maxlength: 10
            },
            createdByPersion: {
                maxlength: 50
            },
        }
    });
}
