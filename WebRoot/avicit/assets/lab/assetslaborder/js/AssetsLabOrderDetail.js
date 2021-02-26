/**
 * 业务操作对象，需继承基础对象，重写必要的业务操作方法
 */
function AssetsLabOrderDetail(form) {
    this._formId = "#" + form;
    DefaultForm.call(this);
};
AssetsLabOrderDetail.prototype = new DefaultForm();
//formcode
AssetsLabOrderDetail.prototype.formcode = "labDeviceOrder";
//初始化操作
AssetsLabOrderDetail.prototype.initFormData = function () {
    var _self = this;
    avicAjax.ajax({
        url: 'platform/assets/lab/assetslaborder/assetsLabOrderController/toDetailJsp.json',
        data: {
            id: _self.id
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                _self.setForm($(_self._formId), result.assetsLabOrderDTO);
            } else {
                layer.msg('数据加载失败！');
            }
        }
    });
};
//启动流程
AssetsLabOrderDetail.prototype.start = function (defineId, callback) {
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
        url: 'platform/assets/lab/assetslaborder/assetsLabOrderController/operation/saveAndStartProcess',
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
AssetsLabOrderDetail.prototype.save = function (callback) {
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
        url: 'platform/assets/lab/assetslaborder/assetsLabOrderController/operation/save',
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
AssetsLabOrderDetail.prototype.setForm = function (formObj, jsonValue) {
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
AssetsLabOrderDetail.prototype.setAttachMagic = function (attachMagic) {
    //当流程节点配置是否允许附件功能时候，隐藏上传、下载按钮等
    if (attachMagic) {
        $('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "");
        });
        $('div.uploader-file-item').unbind("mouseover");
    }
    else {
        $('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "none");
        });
        $('div.uploader-file-item').bind('mouseover', function () {
            $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
        });
    }
};
//流程控制-多附件必填
AssetsLabOrderDetail.prototype.setAttachRequired = function (tagId, required, obj) {
    eval("this.attachRequiredMap." + tagId + " = " + required);
};

AssetsLabOrderDetail.prototype.attachRequiredMap = {};
AssetsLabOrderDetail.prototype.validAttachRequired = function () {
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
AssetsLabOrderDetail.prototype.setAttachCanAddOrDel = function (tagId, operability, obj) {
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
AssetsLabOrderDetail.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            orderNumber: {
                maxlength: 255
            },
            applyId: {
                maxlength: 64
            },
            applyDept: {
                maxlength: 64
            },
            telephone: {
                maxlength: 32
            },
            tdeviceName: {
                maxlength: 255
            },
            tdeviceCode: {
                maxlength: 255
            },
            tdeviceModel: {
                maxlength: 255
            },
            tdeviceNum: {
                maxlength: 255
            },
            belongModel: {
                maxlength: 255
            },
            testType: {
                maxlength: 255
            },
            testNature: {
                maxlength: 255
            },
            testCondition: {
                maxlength: 4000
            },
            supportTool: {
                maxlength: 255
            },
            orderStartTime: {
                dateISO: false
            },
            orderFinishTime: {
                dateISO: false
            },
            labDeviceId: {
                maxlength: 64
            },
            labDeviceUid: {
                maxlength: 255
            },
            labDeviceName: {
                maxlength: 255
            },
            approvalStartTime: {
                dateISO: false
            },
            approvalFinishTime: {
                dateISO: false
            },
            actualStartTime: {
                dateISO: false
            },
            actualFinishTime: {
                dateISO: false
            },
        }
    });
}

/* 设备通用选择框选择回填 */
function addAssetsRow(rowJson) {
    //获取列表中的数据
    var allData = $('#assetsLabDevicejqGrid').jqGrid('getRowData');
    //判断列表中的数据是否为空
    if((allData != null) && (allData != undefined) && (allData.length>0)){
        for(j=0; j<allData.length; j++){
            //判断是否已添加
            if(allData[j].unifiedId == rowJson.unifiedId){
                layer.msg('编号' + rowJson.unifiedId +'的设备已添加！');
                return;
            }
        }
    }
    var newRowId = newRowStart + newRowIndex;
    var parameters = {
        rowID: newRowId,
        initdata: rowJson,
        position: "first",
        useDefValues: true,
        useFormatter: true,
        addRowParams: {extraparam: {}}
    };
    $('#assetsLabDevicejqGrid').jqGrid('addRow', parameters);

    newRowIndex++;
};

//弹框选择设备台账的回调函数
function callBackFn(rows, requestType) {
    switch (requestType) {
        case "productModelSelect":
            for(i=0; i<rows.length; i++){
                var row = rows[i];
                var rowJson = {};
                debugger;
                /*获取session的筛选数据-begin*/
                var labInfo = sessionStorage.getItem("labDeviceData");
                if(sessionStorage.getItem("labDeviceData")!=""){
                    //sessionStorage.removeItem("labDeviceData");
                }
                /*获取session的筛选数据-end*/

                var obj = JSON.parse(labInfo);
                var labId = obj.labId;
                var labName = obj.labName;
                if(labId == null || labId.length == 0){
                    //实验室id为空则提示
                    layer.alert('请选择实验室！', {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0,
                        btn: ['关闭'],
                        title:"提示"
                    });
                    break;
                }

                rowJson.labId = labId;      //使用当前选中实验室的id
                rowJson.labName = labName;  //使用当前选中实验室的名称
                rowJson.deviceName = row.deviceName;
                rowJson.unifiedId = row.unifiedId;
                rowJson.deviceId = row.id;

                rowJson.ownerId = row.ownerId;
                rowJson.ownerIdAlias = row.ownerIdAlias;
                rowJson.ownerDept = row.ownerDept;
                rowJson.ownerDeptAlias = row.ownerDeptAlias;

                addAssetsRow(rowJson);
            }
            break;
        case "productSerySelect":
            $('#seryCode').val(row.seryCode);
            $('#seriesId').val(row.id);
            break;
    }

    closeLayer(openIndex);

}

//弹窗关闭函数
function closeLayer(){
    layer.close(openIndex);
}

/**
 * 设备台账信息选择框
 * param:
 *  singleSelect -是否单选（true-单选，false为多选；字符串）；
 *  requestType-页面请求标记，用于同一页面有多个相同弹出页时，调用回调函数赋值时使用，可为空字符串，代码默认取值‘productModelSelect’；
 *  callBackFn-回调函数名称，用户声明的“弹框选择设备台账的回调函数”的函数名字符串；
 */
function openProductModelLayer (singleSelect, requestType, callBackFn, param){
    sessionStorage.setItem("labSelectParam",param);
    this.openIndex = layer.open({
        type: 2,
        area: ['85%', '75%'],
        title: '实验室设备选择',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/lab/assetslabaccount/AssetsLabAccountSelect.jsp"

    });
};

/**
 * 预约详情页面数据回填
 */
AssetsLabOrderDetail.prototype.relateLabDevice = function (rowData) {
    document.getElementById('labDeviceId').value = rowData.deviceId;
    document.getElementById('labDeviceUid').value = rowData.unifiedId;
    document.getElementById('labDeviceName').value = rowData.deviceName;

    closeLayer();
};
