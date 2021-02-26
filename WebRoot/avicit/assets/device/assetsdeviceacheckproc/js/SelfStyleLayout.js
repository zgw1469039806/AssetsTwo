var subTableData = {};

/**
 * 业务操作对象，需继承基础对象，重新必要的业务操作方法
 */
function EformFlow() {
    DefaultForm.call(this);
};
EformFlow.prototype = new DefaultForm();

/**
 * formcode
 */
EformFlow.prototype.formcode = "assetsDeviceAcheckProc";

/**
 * 初始化表单数据
 */
EformFlow.prototype.initFormData = function () {
    var _self = this;
    avicAjax.ajax({
        url: 'platform/assets/device/assetsdeviceacheckproc/assetsDeviceAcheckProcController/toDetailJsp.json',
        data: {
            id: _self.id
        },
        type: 'POST',
        dataType: 'JSON',
        success: function (result) {
            if (result.flag == "success") {
                _self.setForm($("#form"), result.assetsDeviceAcheckProcDTO);
            } else {
                layer.msg('数据加载失败！');
            }
        }
    });
};

/**
 * 启动流程
 *
 * @param defineId
 * @param callback
 */
EformFlow.prototype.start = function (defineId, callback) {
    //遮罩
    var maskId = layer.load();
	var _self = this;

	//主表表单校验
	var isValidate = $("#form").validate();
	if (!isValidate.checkForm()) {
		isValidate.showErrors();
		$(isValidate.errorList[0].element).focus();

		//去掉遮罩
		layer.close(maskId);
		return false;
	}

	//主表数据
    var dataVo = JSON.stringify(serializeObject($("#form")));

	//子表数据
	$('#assetsDeviceAcheckPlan').jqGrid('endEditCell');
	var dataSub = JSON.stringify($('#assetsDeviceAcheckPlan').jqGrid('getRowData'));

    avicAjax.ajax({
        url: 'platform/assets/device/assetsdeviceacheckproc/assetsDeviceAcheckProcController/operation/saveAndStartProcess',
        data: {
            processDefId: defineId,
            formCode: _self.formcode,
            data: dataVo,
			dataSub: dataSub
        },
        type: 'post',
        dataType: 'json',
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
					//遮罩
					var maskId = layer.load();
					afterUploadEvent = function () {
						//去掉遮罩
						layer.close(maskId);
						$('#id').val(result.startResult.formId);

						//子表刷新,不然更新时会缺少子表ID
						var searchdata = {pid: result.startResult.formId};
						$('#assetsDeviceAcheckPlan').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");

						// 启动成功后回调流程刷新按钮
						callback(result.startResult);
						_self.initFormData();
					};
					$('#attachment').uploaderExt('doUpload', result.startResult.formId);
				} else {
					$('#id').val(result.startResult.formId);

					//子表刷新,不然更新时会缺少子表ID
					var searchdata = {pid: result.startResult.formId};
					$('#assetsDeviceAcheckPlan').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");

					// 启动成功后回调流程刷新按钮
					callback(result.startResult);
					_self.initFormData();
				}
			} else {
				layer.msg('保存失败：'+result.msg);
			}
		}
    });
};

/**
 * 更新数据
 *
 * @param callback
 */
EformFlow.prototype.save = function (callback) {
    var _self = this;

	//主表表单校验
	var isValidate = $("#form").validate();
	if (!isValidate.checkForm()) {
		isValidate.showErrors();
		$(isValidate.errorList[0].element).focus();

		return false;
	}

	//主表数据
    var dataVo = JSON.stringify(serializeObject($("#form")));

	//子表数据
	$('#assetsDeviceAcheckPlan').jqGrid('endEditCell');
	var dataSub = JSON.stringify($('#assetsDeviceAcheckPlan').jqGrid('getRowData'));

    avicAjax.ajax({
        url: 'platform/assets/device/assetsdeviceacheckproc/assetsDeviceAcheckProcController/operation/save',
        data: {
            data: dataVo,
			dataSub: dataSub
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
					//遮罩
					var maskId = layer.load();
					afterUploadEvent = function () {
						//去掉遮罩
						layer.close(maskId);

						//子表刷新,不然更新时会缺少子表ID
						var searchdata = {pid: result.pid};
						$('#assetsDeviceAcheckPlan').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");

						// 启动成功后回调流程刷新按钮
						callback();
						_self.initFormData();
					};
					$('#attachment').uploaderExt('doUpload', result.pid);
				} else {
					//子表刷新,不然更新时会缺少子表ID
					var searchdata = {pid: result.pid};
					$('#assetsDeviceAcheckPlan').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");

					// 启动成功后回调流程刷新按钮
					callback();
					_self.initFormData();
				}
			} else {
				layer.msg('保存失败：'+result.msg);
			}
		}
    });
};

$(function () {
    //创建业务操作JS
    var eformFlow = new EformFlow();
    //创建流程操作JS
    var floweditor = new FlowEditor(eformFlow);
    floweditor.init();
});

/**
 * 表单重载json对象数据
 */
EformFlow.prototype.setForm = function (formObj, jsonValue) {
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


