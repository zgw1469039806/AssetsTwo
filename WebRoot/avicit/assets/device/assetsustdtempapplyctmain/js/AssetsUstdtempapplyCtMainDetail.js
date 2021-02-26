/**
 * 业务操作对象，需继承基础对象，重写必要的业务操作方法
 */
var ef = new EformFlow();
var openChildFlag=0;
/*解绑原有添加事件，绑定新事件*/
$(function () {
$('#assetsUstdtempapplyCollect_insert').unbind();
$('#assetsUstdtempapplyCollect_insert').on('click',function (e) {
        var noticeName = $("#collectSelect").val();
        openChildFlag =1;
        if(noticeName==""||noticeName==null)
        {
            layer.msg("请选择关联的征集表单");
            return false;
        }
        ef.save();
        //openChildAdd("callBackFnList");
    })
})



var exportFlag=0;
//删除按钮绑定事件
$('#assetsUstdtempapplyCollect_excel').bind('click', function () {
    var noticeName = $("#collectSelect").val();
    if(noticeName==""||noticeName==null)
    {
        layer.msg("请选择关联的征集表单");
        return false;
    }
    exportFlag=1;
    ef.save();
});


function AssetsUstdtempapplyCtMainDetail(form, AssetsUstdtempapplyCollect) {
    this._formId = "#" + form;
    this.AssetsUstdtempapplyCollect = AssetsUstdtempapplyCollect;
    this._formId = "#" + form;
    DefaultForm.call(this);
};
AssetsUstdtempapplyCtMainDetail.prototype = new DefaultForm();
AssetsUstdtempapplyCtMainDetail.prototype.formcode = "assetsUstdtempapplyCtMain";
 /**
 * 初始化操作
 */
AssetsUstdtempapplyCtMainDetail.prototype.initFormData = function () {
    var _self = this;
    _self.isLoading = true;
    avicAjax.ajax({
        url: 'assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController/toDetailJsp.json',
        data: {
            id: _self.id
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                _self.setForm($(_self._formId), result.assetsUstdtempapplyCtMainDTO);
            } else {
                layer.msg('数据加载失败！');
            }
        }
    });
};
/**
 * 启动流程
 */
AssetsUstdtempapplyCtMainDetail.prototype.start = function (defineId, callback) {
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
    var msg = _self.AssetsUstdtempapplyCollect.valid();
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
        url: 'platform/assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController/operation/saveAndStartProcess',
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
                        _self.AssetsUstdtempapplyCollect.save(result.startResult.formId);
                        // 启动成功后回调流程刷新按钮
                        callback(result.startResult);
                        _self.initFormData();
                    };
                    $('#attachment').uploaderExt('doUpload', result.startResult.formId);
                } else {
                    $('#id').val(result.startResult.formId);
                    _self.AssetsUstdtempapplyCollect.save(result.startResult.formId);
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
AssetsUstdtempapplyCtMainDetail.prototype.save = function (callback) {
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
    var msg = _self.AssetsUstdtempapplyCollect.valid();
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
        url: 'platform/assets/device/assetsustdtempapplyctmain/assetsUstdtempapplyCtMainController/operation/save',
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
                        _self.AssetsUstdtempapplyCollect.save(result.pid);
                        // 启动成功后回调流程刷新按钮
                        callback();
                        _self.initFormData();
                    };
                    $('#attachment').uploaderExt('doUpload', result.pid);
                } else {
                    _self.AssetsUstdtempapplyCollect.save(result.pid);
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




/***导入模板表头定义***/
var templeteHeadersArray={
    headers:[
        {prop:"xuhao",name: "序号", rownum: "0", dropdown: false, lookupType: ""},
        {prop:"attribute05",name: "申请人", rownum: "1", dropdown: false, lookupType: ""},
        {prop:"createdByDeptAlias",name: "申请人部门", rownum: "2", dropdown: false, lookupType: ""},
        {prop:"attribute02",name: "申请人账号", rownum: "3", dropdown: false, lookupType: ""},
        {prop:"deviceName",name: "设备名称", rownum: "4", dropdown: false, lookupType: ""},
        {prop:"deviceCategory",name: "设备类别", rownum: "5", dropdown: true, lookupType: "DEVICE_CATEGORY"},
        {prop:"belongProject",name: "所属项目", rownum: "6", dropdown: false, lookupType: ""},
        {prop:"financialResourcesName",name: "经费来源", rownum: "7", dropdown: true, lookupType: "FINANCIAL_RESOURCES"},
        {prop:"financialEstimate",name: "经费概算", rownum: "8", dropdown: false, lookupType: ""},
        {prop:"replyName",name: "批复名称", rownum: "9", dropdown: false, lookupType: ""},
        {prop:"approvalFormNumber",name: "立项单号", rownum: "10", dropdown: false, lookupType: ""}
    ],
    fileName:"importUsdequipPlanDept"

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
        title: '征集上报导入',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: 'platform/excelImportController/excelimport/importUsdequipPlanDept/xlsx?extPara='+extPara,
        cancel: function(){
            var searchdata = {pid: parentId};
            $("#assetsUstdtempapplyCollect").jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
        }

    });
}



/**
 * 表单重载json对象数据
 */
AssetsUstdtempapplyCtMainDetail.prototype.setForm = function (formObj, jsonValue) {
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
AssetsUstdtempapplyCtMainDetail.prototype.setAttachMagic = function (attachMagic) {
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
        }, 500);
    }
};
/**
 * 流程控制-多附件必填
 */
AssetsUstdtempapplyCtMainDetail.prototype.setAttachRequired = function (tagId, required, obj) {
    eval("this.attachRequiredMap." + tagId + " = " + required);
};
AssetsUstdtempapplyCtMainDetail.prototype.attachRequiredMap = {};
AssetsUstdtempapplyCtMainDetail.prototype.validAttachRequired = function () {
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
AssetsUstdtempapplyCtMainDetail.prototype.setAttachCanAddOrDel = function (tagId, operability, obj) {
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
/*AssetsUstdtempapplyCtMainDetail.prototype.controlSelfElement = function (tagId, operability, obj) {
    debugger
    if (operability) {
        if (tagId == "assetsUstdtempapplyCollect_editable") {//判断是否允编辑子表数据
            //获取colModel数组对象
            var columnArray = $('#assetsUstdtempapplyCollect').jqGrid('getGridParam', 'colModel');
            //给每个colModel属性列设置可编辑
            $.each(columnArray, function (i, item) {
                $('#assetsUstdtempapplyCollect').setColProp(item.name, {editable: true});
            });
        } else {
            $("#" + tagId).show();
        }
    } else {
        $("#" + tagId).hide();
    }
}*/


AssetsUstdtempapplyCtMainDetail.prototype.controlSelfElement = function (tagId, operability, obj) {
    if (true) {
        if (true) {//判断是否允编辑子表数据
            //获取colModel数组对象
            var columnArray = $('#assetsUstdtempapplyCollect').jqGrid('getGridParam', 'colModel');
            //给每个colModel属性列设置可编辑

            $.each(columnArray, function (i, item) {
                if(i==0)
                {
                    $('#assetsUstdtempapplyCollect').setColProp(item.name, {editable: true});
                }

            });
        } else {
            $("#" + tagId).show();
        }
    } else {
        $("#" + tagId).hide();
    }
}



/*子表添加页面提交后的回调函数，调取暂存按钮事件来刷新子表，欠妥，暂定方案。*/
function callBackFnList() {
   // $("#bpm_save").click();
    //closeLayer(openIndex);
    var comId = $("#comId").val();
    var searchdata = {pid: comId};

    $("#assetsUstdtempapplyCollect").jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
    var closewindow = window.parent.document.getElementsByClassName("layui-layer-ico layui-layer-close layui-layer-close1");
    closewindow[0].click();
}

/*后开发：子表添加按钮事件*/
function openChildAdd (callBackFnList){
    this.openIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '非标设备上报信息填写',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/assetsustdtempapplycollect/AssetsUstdtempapplyCollectAdd.jsp?callBackFn="+callBackFnList
    });
};


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

    $('#collectSelect').val(row.formTitle);
    $('#collectYear').val(row.applyYear);
    noticeId = row.id
    // sessionStorage.setItem("noticeId",row.id);
    // sessionStorage.setItem("comId",row.id);

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
        title: '非标设备年度征集单选择',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/assets/device/dynusdassetsntc/DynUsdassetsNtcSelect.jsp?singleSelect="+singleSelect+"&requestType="+requestType+"&callBackFn="+callBackFn
    });
};

/**
 * 编辑页面
 */
// function modify(callBackFnList){
//     var ids = $('#assetsUstdtempapplyCollect').jqGrid('getGridParam', 'selarrrow');
//     if (ids.length == 0) {
//         layer.alert('请选择要编辑的数据！', {
//             icon: 7,
//             area: ['400px', ''], //宽高
//             closeBtn: 0,
//             btn: ['关闭'],
//             title: "提示"
//         });
//         return false;
//     } else if (ids.length > 1) {
//         layer.alert('只允许选择一条数据！', {
//             icon: 7,
//             area: ['400px', ''], //宽高
//             closeBtn: 0,
//             btn: ['关闭'],
//             title: "提示"
//         });
//         return false;
//     }
//     var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
//     this.editIndex = layer.open({
//         type: 2,
//         area: ['100%', '100%'],
//         title: '编辑',
//         skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
//         maxmin: false, //开启最大化最小化按钮
//         content: "assets/device/assetsustdtempapplycollect/assetsUstdtempapplyCollectController/operation/Edit/" + ids[0]+"?callBackFn="+callBackFnList
//     });
// };


























/**
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
AssetsUstdtempapplyCtMainDetail.prototype.formValidate = function (form) {
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
            stdId: {
                required: true,
                maxlength: 50
            },
        }
    });
}

/**
 * 编辑页面
 */
function modify() {
    var ids = $("#assetsUstdtempapplyCollect").jqGrid('getGridParam', 'selarrrow');
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
    var rowData = $("#assetsUstdtempapplyCollect").jqGrid('getRowData', ids[0]);
    this.editIndex = layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '编辑',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: 'assets/device/assetsustdtempapplycollect/assetsUstdtempapplyCollectController/operation/' + 'Edit/' + rowData.id,
        cancel:function(index){
            var comId = $("#comId").val();
            var searchdata = {pid: comId};

            $("#assetsUstdtempapplyCollect").jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");

        }

    });
};


