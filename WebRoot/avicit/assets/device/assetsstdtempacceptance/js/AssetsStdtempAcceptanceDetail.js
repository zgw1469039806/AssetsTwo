/**
 * 业务操作对象，需继承基础对象，重写必要的业务操作方法
 */
function AssetsStdtempAcceptanceDetail(form, AttInventory){
	this._formId = "#" + form;
	this.AttInventory = AttInventory;
	this._formId = "#" + form;
	DefaultForm.call(this);
};
AssetsStdtempAcceptanceDetail.prototype = new DefaultForm();
AssetsStdtempAcceptanceDetail.prototype.formcode = "assetsStdempAcceptance";
/**
 * 初始化操作
 */
AssetsStdtempAcceptanceDetail.prototype.initFormData = function(){
	var _self = this;
	_self.isLoading = true;
	avicAjax.ajax({
		url : 'platform/assets/device/assetsstdtempacceptance/assetsStdtempAcceptanceController/toDetailJsp.json',
		data : {
			id : _self.id
		},
		type : 'POST',
		dataType : 'JSON',
		success : function(result) {
			if (result.flag == "success") {
				_self.setForm($(_self._formId),result.assetsStdtempAcceptanceDTO);
			} else {
				layer.msg('数据加载失败！');
			}
		}
	});
};
/**
 * 启动流程
 */
AssetsStdtempAcceptanceDetail.prototype.start = function(defineId, callback){
	var _self = this;
	if(!_self.validAttachRequired()){
        return false;
    }
	var isValidate = $("#form").validate();
	if (!isValidate.checkForm()) {
		isValidate.showErrors();
		return false;
	}
	//子表校验
	var msg = _self.AttInventory.valid();
	if(msg && msg != ""){
		layer.alert(msg, {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
		return false;
	}
	var dataVo = JSON.stringify(serializeObject($(_self._formId)));
	avicAjax.ajax({
		url : 'platform/assets/device/assetsstdtempacceptance/assetsStdtempAcceptanceController/operation/saveAndStartProcess',
		data : {
			processDefId : defineId,
			formCode : _self.formcode,
			data : dataVo
		},
		type : 'POST',
		dataType : 'JSON',
		success : function(result) {
			if (result.flag == "success") {
				var files = $('#attachment').uploaderExt('getUploadFiles');
				//验证附件密级
				for(var i = 0; i < files.length; i++){
					var name = files[i].name;
					var secretLevel = files[i].secretLevel;
					//这里验证密级
				}
				if(files.length != 0){
					afterUploadEvent = function(){
						$('#id').val(result.startResult.formId);
						_self.AttInventory.save(result.startResult.formId);
						// 启动成功后回调流程刷新按钮
						callback(result.startResult);
						_self.initFormData();
					};
					$('#attachment').uploaderExt('doUpload', result.startResult.formId);
				}else{
					$('#id').val(result.startResult.formId);
					_self.AttInventory.save(result.startResult.formId);
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
AssetsStdtempAcceptanceDetail.prototype.save=function(callback){
	var _self = this;
	if(!_self.validAttachRequired()){
        return false;
    }
	var isValidate = $("#form").validate();
	if (!isValidate.checkForm()) {
		isValidate.showErrors();
		return false;
	}
	
	//子表校验
	var msg = _self.AttInventory.valid();
	if(msg && msg != ""){
		layer.alert(msg, {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			btn : [ '关闭' ],
			title : "提示"
		});
		return false;
	}
	var dataVo = JSON.stringify(serializeObject($(_self._formId)));
	avicAjax.ajax({
		url : 'platform/assets/device/assetsstdtempacceptance/assetsStdtempAcceptanceController/operation/save',
		data : {
			data : dataVo
		},
		type : 'POST',
		dataType : 'JSON',
		success : function(result) {
			if (result.flag == "success") {
				var files = $('#attachment').uploaderExt('getUploadFiles');
						//验证附件密级
						for(var i = 0; i < files.length; i++){
							var name = files[i].name;
							var secretLevel = files[i].secretLevel;
							//这里验证密级
						}
						if(files.length != 0){
							afterUploadEvent = function(){
								_self.AttInventory.save(result.pid);
								// 启动成功后回调流程刷新按钮
								callback();
								_self.initFormData();
							};
							$('#attachment').uploaderExt('doUpload', result.pid);
						}else{
							_self.AttInventory.save(result.pid);
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
AssetsStdtempAcceptanceDetail.prototype.setForm = function(formObj, jsonValue){
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
/**
 * 控制附件
 */
AssetsStdtempAcceptanceDetail.prototype.setAttachMagic = function(attachMagic) {
    //当流程节点配置是否允许附件功能时候，隐藏上传、下载按钮等
	 if(attachMagic) {
		 setTimeout(function(){
		    $('.uploader-panel-heading').each(function (index, element) {
		        $(element).css("display", "");
		    });
		    $('div.uploader-file-item').unbind("mouseover");
		}, 500);
	}
	else {
	    setTimeout(function(){
	        $('.uploader-panel-heading').each(function (index, element) {
		        $(element).css("display", "none");
		    });
	        $('div.uploader-file-item').bind('mouseover',function(){
	        	$('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
	        });
	    }, 800);
	}
};
/**
 * 流程控制-多附件必填
 */
AssetsStdtempAcceptanceDetail.prototype.setAttachRequired = function(tagId,required,obj){
    eval("this.attachRequiredMap." + tagId + " = " + required);
};
AssetsStdtempAcceptanceDetail.prototype.attachRequiredMap = {};
AssetsStdtempAcceptanceDetail.prototype.validAttachRequired = function(){
	for(var tagId in this.attachRequiredMap){
			if(this.attachRequiredMap[tagId]){
	            var itemListNum = $('#' + tagId).find('.uploader-file-item').size();
	            if(itemListNum==0){
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
AssetsStdtempAcceptanceDetail.prototype.setAttachCanAddOrDel = function(tagId,operability,obj){
    if(operability) {
        setTimeout(function(){
            $('#' + tagId).children('.uploader-panel-heading').each(function (index, element) {
                $(element).css("display", "");
            });
            $('#' + tagId).find('div.uploader-file-item').unbind("mouseover");
        }, 500);
    }else {
        setTimeout(function(){
            $('#' + tagId).children('.uploader-panel-heading').each(function (index, element) {
                $(element).css("display", "none");
            });
            $('#' + tagId).find('div.uploader-file-item').bind('mouseover',function(){
                $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
            });
        }, 800);
    }
};
/**
 * 控制子表toolbar是否可用和子表数据是否可编辑
 */
AssetsStdtempAcceptanceDetail.prototype.controlSelfElement = function(tagId, operability, obj){
	 if(operability){
		if(tagId == "attInventory_editable"){//判断是否允编辑子表数据
			//获取colModel数组对象
			var columnArray = $('#attInventory').jqGrid('getGridParam','colModel'); 
			//给每个colModel属性列设置可编辑
			$.each(columnArray,function(i,item){
				$('#attInventory').setColProp(item.name,{editable:true});
			});
		}else{
			$("#" + tagId).show();
		}
	}else{
		$("#" + tagId).hide();
	}     	
}
/**
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
AssetsStdtempAcceptanceDetail.prototype.formValidate=function(form){
	form.validate({
		rules: {
						  		     			 		  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  		     			    				   					acceptanceId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					createdByPersion:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					createdByDept:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					formState:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					contractNum:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					buyerDept:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					buyer:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					stdId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					chargePerson:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					chargeDept:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					chargePersonTel:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					deviceName:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					unifyId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					deviceType:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					deviceCategory:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					deviceModel:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					deviceSpec:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					manufacturingNumber:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					producingCountries:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					productionManufacturer:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   			       deliveryTime:{
						dateISO:true
				   },
				   							 		  				  		     			    				   					contractSupplier:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   				   unitPrice:{
						number:true
				   },
				   							 		  				  		     			    				   				   totalPrice:{
						number:true
				   },
				   							 		  				  		     			    				   					isAccuracyCheck:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					isRegularCheck:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					isInstall:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					employUser:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					employDept:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					measuringTag:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					measuringUser:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					planMeasuring:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   			       measuringTime:{
						dateISO:true
				   },
				   							 		  				  		     			    				   				   measuringPeriod:{
						number:true
				   },
				   							 		  				  		     			    				   					isMeasuring:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					isSceneMeasuring:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					isSpotCheck:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					isPc:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					secretLevel:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					isSafetyProduction:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					isMaintain:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					accuracyCheckResult:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					maintainResult:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					installResult:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					qualityResult:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					abarbeitungResult:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					createdByTel:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					fid:{
						maxlength: 50
				    },
				    							 		  			  }
	});
}
