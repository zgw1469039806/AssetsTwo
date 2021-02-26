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
EformFlow.prototype.formcode = "assetsUstdtempAcceptance";
/**
 * 初始化表单数据
 */
EformFlow.prototype.initFormData = function() {
	var _self = this;
	avicAjax.ajax({
		url : 'platform/assets/device/assetsreconstructionproc/assetsReconstructionProcController/toDetailJsp.json',
		data : {
			id : _self.id
		},
		type : 'POST',
		dataType : 'JSON',
		success : function(result) {
			if (result.flag == "success") {
				_self.setForm($("#form"),result.assetsUstdtempAcceptanceDTO);
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
	var _self = this;
	var dataVo = JSON.stringify(serializeObject($("#form")));
    avicAjax.ajax({
		url : 'platform/assets/device/assetsreconstructionproc/assetsReconstructionProcController/operation/saveAndStartProcess',
        data : {
			processDefId : defineId,
			formCode : _self.formcode,
			data : dataVo
		},
        type : 'post',
        dataType : 'json',
        success : function(result){
           if (result.flag == "success") {var files = $('#attachment').uploaderExt('getUploadFiles');
			   if(files != 0){
				   //遮罩
				   var maskId = layer.load();
				   $("#id").val(result.startResult.formId);
				   afterUploadEvent = function(){
					   //去掉遮罩
					   layer.close(maskId);
					   // 启动成功后回调流程刷新按钮
					   callback(result.startResult);
					   //刷新页面
					   _self.initFormData();
				   };
				   $('#attachment').uploaderExt('doUpload', result.startResult.formId);
			   }else{
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
	var isValidate = $("#form").validate();
	if (!isValidate.checkForm()) {
		isValidate.showErrors();
		$(isValidate.errorList[0].element).focus();
		return false;
	}
	var dataVo = JSON.stringify(serializeObject($("#form")));
	avicAjax.ajax({
		url : 'platform/assets/device/assetsreconstructionproc/assetsReconstructionProcController/operation/save',
		data : {
			data : dataVo
		},
		type : 'POST',
		dataType : 'JSON',
		success : function(result) {
			if (result.flag == "success") {
				var files = $('#attachment').uploaderExt('getUploadFiles');
				if(files != 0){
					$("#id").val(result.id);
					//遮罩
					var maskId = layer.load();
					//附件上传完毕后执行该方法
					afterUploadEvent = function(){
						//去掉遮罩
						layer.close(maskId);
						// 启动成功后回调流程刷新按钮
						callback();
						//刷新页面
						_self.initFormData();
					};
					$('#attachment').uploaderExt('doUpload', result.id);
				}else{
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
                var checkArray = ival.length > 0 ?ival.split(",") : ival;
                for (var i = 0; i < checkboxObj.length; i++) {
             	    checkboxObj[i].checked = false;
                    for (var j = 0; j < checkArray.length; j++) {
                        if (checkboxObj[i].value == checkArray[j]) {
                     	   checkboxObj[i].checked=true;
                        }
                    }
                } 
            }
        }else if (oinput.attr("type") == "radio") {
            oinput.each(function () {
                var radioObj = $("[name=" + name + "]");
                for (var i = 0; i < radioObj.length; i++) {
                    if (radioObj[i].value == ival) {
                 	   radioObj[i].checked=true;
                    }
                }
            });
        }else if ($(oinput).attr('class') == "form-control date-picker hasDatepicker"){
        	if(ival !="" && ival !=null){
        		obj.find("[name=" + name + "]").datepicker("setDate", new Date(ival));
        	}
        }else if ($(oinput).attr('class') == "form-control time-picker hasDatepicker"){
     	   obj.find("[name=" + name + "]").val(ival);
        }else {
            obj.find("[name=" + name + "]").val(ival);
        }
    });
};

