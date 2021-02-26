var subTableData = {};

/**
 * 业务操作对象，需继承基础对象，重新必要的业务操作方法
 */
function EformFlow(form) {
	DefaultForm.call(this);
};
EformFlow.prototype = new DefaultForm();
/**
 * formcode
 */
EformFlow.prototype.formcode = "assetsStdempapply";
/**
 * 初始化表单数据
 */
EformFlow.prototype.initFormData = function() { var _self = this;
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
				_self.setForm($("#form"), result.assetsStdtempapplyProcDTO);
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
EformFlow.prototype.start = function(defineId, callback) {
    //遮罩
    var maskId = layer.load();
	//验证
	var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
         isValidate.showErrors();
	//去掉遮罩
	layer.close(maskId);
	         return false;
	    }
	//子表校验
	var msg = subValid('assetsSupplier');
	if (msg && msg != "") {
		//去掉遮罩
		layer.close(maskId);

		layer.alert(msg, {
			icon: 7,
			area: ['400px', ''], //宽高
			closeBtn: 0,
			btn: ['关闭'],
			title: "提示"
		});
		return false;
	}
	var _self = this;
	var dataVo = JSON.stringify(serializeObject($("#form")));
//子表数据
	$('#assetsSupplier').jqGrid('endEditCell');
	var dataSub = JSON.stringify($('#assetsSupplier').jqGrid('getRowData'));
    avicAjax.ajax({
        url : 'platform/assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController/operation/saveAndStartProcess',
        data : {
			processDefId : defineId,
			formCode : _self.formcode,
			data : dataVo,
			dataSub: dataSub
		},
        type : 'post',
        dataType : 'json',
        success : function(result){
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
						$('#assetsSupplier').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");

						// 启动成功后回调流程刷新按钮
						callback(result.startResult);
						_self.initFormData();
					};
					$('#attachment').uploaderExt('doUpload', result.startResult.formId);
				} else {
					$('#id').val(result.startResult.formId);
					//子表刷新,不然更新时会缺少子表ID
					var searchdata = {pid: result.startResult.formId};
					$('#assetsSupplier').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");

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
 * 
 * @param callback
 */
EformFlow.prototype.save = function(callback) {
	var _self = this;

	//主表表单校验
	var isValidate = $("#form").validate();
	if (!isValidate.checkForm()) {
		isValidate.showErrors();
		$(isValidate.errorList[0].element).focus();

		return false;
	}

	//子表校验
	var msg = subValid('assetsSupplier');
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

	//主表数据
	var dataVo = JSON.stringify(serializeObject($("#form")));

	//子表数据
	$('#assetsSupplier').jqGrid('endEditCell');
	var dataSub = JSON.stringify($('#assetsSupplier').jqGrid('getRowData'));

	avicAjax.ajax({
		url: 'platform/assets/device/assetsstdtempapplyproc/assetsStdtempapplyProcController/operation/save',
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
						$('#assetsSupplier').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");

						// 启动成功后回调流程刷新按钮
						callback();
						_self.initFormData();
					};
					$('#attachment').uploaderExt('doUpload', result.pid);
				} else {
					//子表刷新,不然更新时会缺少子表ID
					var searchdata = {pid: result.pid};
					$('#assetsSupplier').jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");

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
     	             	         
$(function(){
	//创建业务操作JS
    var eformFlow = new EformFlow();
    //创建流程操作JS
    var floweditor = new FlowEditor(eformFlow);
    floweditor.init();
});

/**
 * 表单重载json对象数据
 */
EformFlow.prototype.setForm=function(formObj, jsonValue){
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
/*子表数据校验——开始*/
var notnullFiled = [];//子表非空字段数组
var notnullFiledComment = [];//子表非空字段注释
var lengthValidFiled = ["name", "address", "contact", "contactNumber", "businessScope", "status"];//除时间,数字等类型长度校验字段
this.lengthValidFiledComment = ["供应商名称", "供应商地址", "联系人", "联系电话", "经验范围", "供应商状态"];//除时间,数字等类型长度校验字段注释
this.lengthValidFiledSize = [50, 50, 50, 50, 50, 50];//除时间,数字等类型长度

/*
 * 子表长度和非空校验
 */
function subValid(subTableId) {
	$('#'+subTableId).jqGrid('endEditCell');
	var isAddRow = false; //是否新增行
	var data = $('#'+subTableId).jqGrid('getChangedCells');
	var Rowdata = $('#'+subTableId).jqGrid('getRowData');
	if (Rowdata.length > 0) {
		for (var i = 0; i < Rowdata.length; i++) {
			if (Rowdata[i].id == "") {
				isAddRow = true;
			}
		}
	}

	var hasvalidate = true;
	var msg = "";
	if (data.length == 0 && isAddRow) {
		msg = "请修改子表数据";
	}
	else {
		$.each(notnullFiled, function (i, item) {
			msg = subNullvalid(Rowdata, item, notnullFiled, notnullFiledComment);
			if (msg && msg.length > 0) {
				hasvalidate = false;
				return false;
			}
		});
		$.each(lengthValidFiled, function (i, item) {
			if (hasvalidate) {
				msg = subLengthvalid(Rowdata, item, lengthValidFiled, lengthValidFiledComment, lengthValidFiledSize);
				if (msg && msg.length > 0) {
					hasvalidate = false;
					return false;
				}
			}
		});
	}
	return msg;
};

/**
 * 子表非空验证
 */
function subNullvalid(data, item, nullfiled, notnullFiledComment) {
	var msg = "";
	$.each(data, function (i, dataitem) {
		if (dataitem[item] == "") {
			temp = false;
			msg = notnullFiledComment[$.inArray(item, nullfiled)] + "为必填字段";
		}
	})
	return msg;
}

/**
 * 子表长度验证
 */
function subLengthvalid(data, item, lengthValidFiled, lengthValidFiledComment, lengthValidFiledSize) {
	var msg = "";
	$.each(data, function (i, dataitem) {
		if (dataitem[item] != "" && dataitem[item] != undefined && dataitem[item].replace(/[^\x00-\xff]/g, "**").length > lengthValidFiledSize[$.inArray(item, lengthValidFiled)]) {
			msg = lengthValidFiledComment[$.inArray(item, lengthValidFiled)] + "的输入长度超过预设长度" + lengthValidFiledSize[$.inArray(item, lengthValidFiled)];
		}
	})
	return msg;
}
/*子表数据校验——结束*/

/*
*子表添加数据
*/
var newRowIndex = 0;
var newRowStart = "new_row";
function insertAssetsSupplier() {
	$('#assetsSupplier').jqGrid('endEditCell');
	var newRowId = newRowStart + newRowIndex;
	var parameters = {
		rowID: newRowId,
		initdata: {},
		position: "first",
		useDefValues: true,
		useFormatter: true,
		addRowParams: {extraparam: {}}
	};
	$('#assetsSupplier').jqGrid('addRow', parameters);
	newRowIndex++;

	/*将子表的单元格置为可编辑——开始*/
	var columnArray = $('#assetsSupplier').jqGrid('getGridParam', 'colModel'); //获取colModel数组对象

	$.each(columnArray, function (i, item) { //给每个colModel属性列设置可编辑
		$('#assetsSupplier').setColProp(item.name, {editable: true});
	});
	/*将子表的单元格置为可编辑——结束*/

	// var newTrEle = document.getElementById(newRowId);
	// newTrEle.onmousedown = function myMousedown(event) {
	//     var currentEle = event.target;
	//
	//     //单元格点击事件
	//     var eleOuterHtml = currentEle.outerHTML;
	//     if(eleOuterHtml.indexOf('<td') == 0 && eleOuterHtml.indexOf('role="checkbox"') == -1){
	//         //判断其他单元格是否已经处于编辑状态
	//         var inputEle = document.getElementById('currentInput');
	//         if(inputEle != undefined && inputEle != null){
	//             var parentTd = inputEle.parentNode;
	//             parentTd.innerHTML = inputEle.value;
	//         }
	//
	//         //编辑状态
	//         if(eleOuterHtml.indexOf('edit-cell success') == -1){
	//             var currentValue = currentEle.innerHTML;
	//             currentValue = currentValue.replaceAll('&nbsp;','');
	//
	//             currentEle.innerHTML = '<input class="form-control input-sm" type="text" style="height:100%;" id="currentInput" value="' + currentValue + '">';
	//
	//             //新建子表数据输入事件完成监控
	//             $('#currentInput').on('keydown', function (e) {
	//                 if (e.keyCode == '13') {
	//                     var inputEle = document.getElementById('currentInput');
	//                     var parentTd = inputEle.parentNode;
	//                     parentTd.innerHTML = inputEle.value;
	//                 }
	//             });
	//         }
	//         //完成编辑
	//         else{
	//             currentEle.innerHTML = $('#currentInput').val();
	//         }
	//     }
	// }
}


$('#assetsSupplier_insert').bind('click', function () {	//子表添加按钮绑定事件
	insertAssetsSupplier();
});

