$(function () {
    /**
     * 业务操作对象，需继承基础对象，重写必要的业务操作方法
     */
    /*解绑原有添加事件，绑定新事件*/
    $('#ASSETS_SDEQUIP_COLLECT_insertBtn').unbind();
// document.getElementById('ASSETS_SDEQUIP_COLLECT_insertBtn').onclick=null;
    $('#ASSETS_SDEQUIP_COLLECT_insertBtn').on('click',function (e) {
        if($('#COLLECT_SELECT').val()==null||$('#COLLECT_SELECT').val()=='')
        {
            layer.msg("请选择关联的计划表单");
            return false;
        }
        $("#bpm_save").bind('click',function () {
            if($('#COLLECT_SELECT').val()==null||$('#COLLECT_SELECT').val()=='')
            {
                layer.msg("请选择关联的计划表单");
                return false;
            }

        });

        sessionStorage.setItem("comId",$("#comId").val());
        openChildAdd("callBackFnList");
    })

})

function DynSdCollecUpldDetail(form) {
    this._formId = "#" + form;
    DefaultForm.call(this);
};
DynSdCollecUpldDetail.prototype = new DefaultForm();
//formcode
DynSdCollecUpldDetail.prototype.formcode = "dynSdCollecUpld";
//初始化操作
DynSdCollecUpldDetail.prototype.initFormData = function () {
    var _self = this;
    avicAjax.ajax({
        url: 'platform/assets/device/dynsdcollecupld/dynSdCollecUpldController/toDetailJsp.json',
        data: {
            id: _self.id
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                _self.setForm($(_self._formId), result.dynSdCollecUpldDTO);
            } else {
                layer.msg('数据加载失败！');
            }
        }
    });
};
//启动流程
DynSdCollecUpldDetail.prototype.start = function (defineId, callback) {
    var _self = this;
    var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }
    var dataVo = JSON.stringify(serializeObject($(this._formId)));
    avicAjax.ajax({
        url: 'platform/assets/device/dynsdcollecupld/dynSdCollecUpldController/operation/saveAndStartProcess',
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
                    $("#id").val(result.startResult.formId);
                    afterUploadEvent = function () {
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
DynSdCollecUpldDetail.prototype.save = function (callback) {
    var _self = this;
    var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }
    var dataVo = JSON.stringify(serializeObject($(this._formId)));
    avicAjax.ajax({
        url: 'platform/assets/device/dynsdcollecupld/dynSdCollecUpldController/operation/save',
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
                    //附件上传完毕后执行该方法
                    afterUploadEvent = function () {
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
DynSdCollecUpldDetail.prototype.setForm = function (formObj, jsonValue) {
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
        } else if (oinput.attr("type") == "textarea") {
            obj.find("[name=" + name + "]").html(ival);
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
DynSdCollecUpldDetail.prototype.setAttachMagic = function (attachMagic) {
    //当流程节点配置是否允许附件功能时候，隐藏上传、下载按钮等
    if (attachMagic) {
        $('.uploader-panel-heading').each(function (index, element) {
            $(element).css("display", "");
        });
        $('body').unbind("DOMNodeInserted");
    }
    else {
        $('.uploader-panel-heading').each(function (index, element) {
            $(element).css("display", "none");
        });
        $('body').bind("DOMNodeInserted", function (event) {
            var obj = jQuery(event.target);
            if (obj[0].className == "uploader-file-infos") {
                obj.find(".uploader-file-infos-delete").css("display", "none");
            }
        });
    }
};

//控件校验   规则：表单字段name与rules对象保持一致
DynSdCollecUpldDetail.prototype.formValidate = function (form) {
    form.validate({
        rules: {
            author: {
                maxlength: 50
            },
            releasedate: {
                dateISO: true
            },
            dept: {
                maxlength: 50
            },
            tel: {
                maxlength: 50
            },
            collectSelect: {
                maxlength: 50
            },
            collectYear: {
                maxlength: 50
            },
        }
    });
}
function openNoticeList(){
    var param =  '';
    openProductModelLayer ("true", "", "callBackFn", param);
}
//弹框选择年度征集单的回调函数
var noticeId;
function callBackFn(rows, requestType) {
    var row = null;
    if(rows.length > 0){
        row = rows[0];
    }
    //switch (requestType) {
      //case "noticeSelect":

            $('#COLLECT_SELECT').val(row.formTitle);
            $('#COLLECT_YEAR').val(row.applyYear);
            noticeId = row.id

            sessionStorage.setItem("noticeId",row.id);

            $('#COLLECT_SELECT').removeClass("form-control input-sm error");
            $('#COLLECT_SELECT').addClass("form-control input-sm");

            $(".errDom").hide();
           // break;
   // }
    closeLayer(openIndex);
}

//弹窗关闭函数
function closeLayer(){
    layer.close(openIndex);
}

/**
 * 年度征集单选择框
 * param:
 *  singleSelect -是否单选（true-单选，false为多选；字符串）；
 *  requestType-页面请求标记，用于同一页面有多个相同弹出页时，调用回调函数赋值时使用，可为空字符串，代码默认取值‘productModelSelect’；
 *  callBackFn-回调函数名称，用户声明的“弹框选择设备台账的回调函数”的函数名字符串；
 */
function openProductModelLayer (singleSelect, requestType, callBackFn, param){
    sessionStorage.setItem("param",param);
    this.openIndex = layer.open({
        type: 2,
        area: ['60%', '70%'],
        title: '标准设备年度征集单选择',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/dynsdcollecmain/DynSdCollecMainSelect.jsp?singleSelect="+singleSelect+"&requestType="+requestType+"&callBackFn="+callBackFn
    });
};



//弹框选择年度征集单的回调函数
function callBackFnList() {
    $("#ASSETS_SDEQUIP_COLLECT").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
    // $("#bpm_save").click();
    // closeLayer(openIndex);
}

/**
 * 年度征集上报子表
 * param:
 *  singleSelect -是否单选（true-单选，false为多选；字符串）；
 *  requestType-页面请求标记，用于同一页面有多个相同弹出页时，调用回调函数赋值时使用，可为空字符串，代码默认取值‘productModelSelect’；
 *  callBackFn-回调函数名称，用户声明的“弹框选择设备台账的回调函数”的函数名字符串；
 */
function openChildAdd (callBackFnList){
    //sessionStorage.setItem("param",param);
    this.openIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '标准设备上报信息填写',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/assetssdequipcollect/AssetsSdequipCollectAdd.jsp?callBackFn="+callBackFnList
    });
};


/**
 * 编辑页面
 */
function modify(callBackFnList){
    var ids = $('#ASSETS_SDEQUIP_COLLECT').jqGrid('getGridParam', 'selarrrow');
    if (ids.length == 0) {
        layer.alert('请选择要编辑的数据！', {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            btn: ['关闭'],
            title: "提示"
        });
        return false;
    } else if (ids.length > 1) {
        layer.alert('只允许选择一条数据！', {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            btn: ['关闭'],
            title: "提示"
        });
        return false;
    }
    var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
    this.editIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '标准设备上报信息编辑',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "platform/assets/device/assetssdequipcollect/assetsSdequipCollectController/operation/" + 'Edit/' + ids[0]+"?callBackFn="+callBackFnList
    });
};


/***导入模板表头定义***/
var templeteHeadersArray={
    headers:[
        {prop:"xuhao",name: "序号", rownum: "0", dropdown: false, lookupType: ""},
        {prop:"createdByPersionAlias",name: "申请人", rownum: "1", dropdown: false, lookupType: ""},
        {prop:"createdByDeptAlias",name: "申请人部门", rownum: "2", dropdown: false, lookupType: ""},
        {prop:"attribute02",name: "申请人账号", rownum: "3", dropdown: false, lookupType: ""},
        {prop:"deviceName",name: "设备名称", rownum: "4", dropdown: false, lookupType: ""},
        {prop:"deviceType",name: "设备类型", rownum: "5", dropdown: true, lookupType: "DEVICE_TYPE"},
        {prop:"deviceSpec",name: "设备规格", rownum: "6", dropdown: false, lookupType: ""},
        {prop:"deviceModel",name: "设备型号", rownum: "7", dropdown: false, lookupType: ""},
        {prop:"referencePlant",name: "参考厂家", rownum: "8", dropdown: false, lookupType: ""},
        {prop:"deviceNum",name: "台（套）数", rownum: "9", dropdown: false, lookupType: ""},
        {prop:"unitPrice",name: "单价", rownum: "10", dropdown: false, lookupType: ""},
        {prop:"totalPrice",name: "总金额", rownum: "11", dropdown: false, lookupType: ""}
    ],
    fileName:"importSdequipPlanDept"

}

/*** 生成模板***/
function generateExcel () {

    avicAjax.ajax({
        url: 'assets/device/excelutil/controller/operation/generateExel',
        type: 'POST',
        data:JSON.stringify(templeteHeadersArray),
        dataType: 'JSON',
        contentType: 'application/json',


    });
};


/*** 导入数据 ****/
function importSdequipPlan() {
    //var rowid=$("#ASSETS_SDEQUIP_COLLECT").jqGrid("getGridParam","selrow");
    //var rowData=jQuery("#ASSETS_SDEQUIP_COLLECT").jqGrid("getRowData",rowid);
    var parentId = $("#comId").val();
    var extPara = parentId+";"+noticeId;
    importIndex = parent.layer.open({
        type: 2,
        area: ['70%', '70%'],
        title: '标准设备年度征集上报导入',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: 'platform/excelImportController/excelimport/importSdequipPlanDept/xlsx?extPara='+extPara,
        cancel: function(){
            var searchdata = {pid: parentId};
            $("#ASSETS_SDEQUIP_COLLECT").jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
        }

    });
}





