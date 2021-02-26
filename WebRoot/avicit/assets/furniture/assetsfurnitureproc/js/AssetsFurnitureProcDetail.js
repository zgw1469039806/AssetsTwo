/**
 * 业务操作对象，需继承基础对象，重写必要的业务操作方法
 */
function AssetsFurnitureProcDetail(form, AssetsFurnitureProcRel){
	this._formId = "#" + form;
	this.AssetsFurnitureProcRel = AssetsFurnitureProcRel;
	this._formId = "#" + form;
	DefaultForm.call(this);
};
AssetsFurnitureProcDetail.prototype = new DefaultForm();
AssetsFurnitureProcDetail.prototype.formcode = "assetsFurnitureProc";
/**
 * 初始化操作
 */
AssetsFurnitureProcDetail.prototype.initFormData = function(){
	var _self = this;
	_self.isLoading = true;
	avicAjax.ajax({
		url : 'platform/assets/furniture/assetsfurnitureproc/assetsFurnitureProcController/toDetailJsp.json',
		data : {
			id : _self.id
		},
		type : 'POST',
		dataType : 'JSON',
		success : function(result) {
			if (result.flag == "success") {
				_self.setForm($(_self._formId),result.assetsFurnitureProcDTO);
			} else {
				layer.msg('数据加载失败！');
			}
		}
	});
};
/**
 * 启动流程
 */
AssetsFurnitureProcDetail.prototype.start = function(defineId, callback){
	var _self = this;
	if(!_self.validAttachRequired()){
        return false;
    }
    //主表表单校验
	var isValidate = $("#form").validate();
	if (!isValidate.checkForm()) {
		isValidate.showErrors();
		$(isValidate.errorList[0].element).focus();
		return false;
	}
	//子表校验
	var msg = _self.AssetsFurnitureProcRel.valid();
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
	//主表数据
	var dataVo = JSON.stringify(serializeObject($(_self._formId)));
	//子表数据
	var dataSub = _self.AssetsFurnitureProcRel.getSubData();
	avicAjax.ajax({
		url : 'platform/assets/furniture/assetsfurnitureproc/assetsFurnitureProcController/operation/saveAndStartProcess',
		data : {
			processDefId : defineId,
			formCode : _self.formcode,
			data : dataVo,
			dataSub : dataSub
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
					//遮罩
					var maskId = layer.load();
					afterUploadEvent = function(){
						//去掉遮罩
						layer.close(maskId);
						$('#id').val(result.startResult.formId);
						//子表刷新,不然更新时会缺少子表ID
						_self.AssetsFurnitureProcRel.reLoad(result.startResult.formId);
						// 启动成功后回调流程刷新按钮
						callback(result.startResult);
						_self.initFormData();
					};
					$('#attachment').uploaderExt('doUpload', result.startResult.formId);
				}else{
					$('#id').val(result.startResult.formId);
					//子表刷新,不然更新时会缺少子表ID
					_self.AssetsFurnitureProcRel.reLoad(result.startResult.formId);
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
AssetsFurnitureProcDetail.prototype.save=function(callback){
	var _self = this;
    //表单校验
	var isValidate = $("#form").validate();
	if (!isValidate.checkForm()) {
		isValidate.showErrors();
		$(isValidate.errorList[0].element).focus();
		return false;
	}
	//附件权限校验
	if(!_self.validAttachRequired()){
        return false;
    }
	//子表校验
	var msg = _self.AssetsFurnitureProcRel.valid();
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
	//主表数据
	var dataVo = JSON.stringify(serializeObject($(_self._formId)));
	//子表数据
	var dataSub = _self.AssetsFurnitureProcRel.getSubData();
	avicAjax.ajax({
		url : 'platform/assets/furniture/assetsfurnitureproc/assetsFurnitureProcController/operation/save',
		data : {
			data : dataVo,
			dataSub : dataSub
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
							//遮罩
						    var maskId = layer.load();
							afterUploadEvent = function(){
								//去掉遮罩
								layer.close(maskId);
								//子表刷新,不然更新时会缺少子表ID
								_self.AssetsFurnitureProcRel.reLoad(result.pid);
								// 启动成功后回调流程刷新按钮
								callback();
								_self.initFormData();
							};
							$('#attachment').uploaderExt('doUpload', result.pid);
						}else{
							//子表刷新,不然更新时会缺少子表ID
							_self.AssetsFurnitureProcRel.reLoad(result.pid);
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
AssetsFurnitureProcDetail.prototype.setForm = function(formObj, jsonValue){
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
AssetsFurnitureProcDetail.prototype.setAttachMagic = function(attachMagic) {
    //当流程节点配置是否允许附件功能时候，隐藏上传、下载按钮等
	if(attachMagic) {
        $('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "");
        });
        $('div.uploader-file-item').unbind("mouseover");
    }
    else {
        $('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "none");
        });
        $('div.uploader-file-item').bind('mouseover',function(){
            $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
        });
    }
};
/**
 * 流程控制-多附件必填
 */
AssetsFurnitureProcDetail.prototype.setAttachRequired = function(tagId,required,obj){
    eval("this.attachRequiredMap." + tagId + " = " + required);
};
AssetsFurnitureProcDetail.prototype.attachRequiredMap = {};
AssetsFurnitureProcDetail.prototype.validAttachRequired = function(){
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
AssetsFurnitureProcDetail.prototype.setAttachCanAddOrDel = function(tagId,operability,obj){
    if(operability) {
        $('#' + tagId).children('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "");
        });
        $('#' + tagId).find('div.uploader-file-item').unbind("mouseover");
    }else {
        $('#' + tagId).children('.uploader-panel-heading').each(function (index, element) {
            $(element).find(".uploader-file-picker").css("display", "none");
        });
        $('#' + tagId).find('div.uploader-file-item').bind('mouseover',function(){
            $('div.uploader-file-infos').find(".uploader-file-infos-delete").css("display", "none");
        });
    }
};
/**
 * 控制子表toolbar是否可用和子表数据是否可编辑
 */
AssetsFurnitureProcDetail.prototype.controlSelfElement = function(tagId, operability, obj){
	 if(operability){
		if(tagId == "assetsFurnitureProcRel_editable"){//判断是否允编辑子表数据
			//获取colModel数组对象
			var columnArray = $('#assetsFurnitureProcRel').jqGrid('getGridParam','colModel'); 
			//给每个colModel属性列设置可编辑
			$.each(columnArray,function(i,item){
				$('#assetsFurnitureProcRel').setColProp(item.name,{editable:true});
			});
		}else{
			$("#" + tagId).show();
		}
	}else{
		$("#" + tagId).hide();
	}     	
}
/**
 * 非电子表单子表字段的显隐控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param operability 是否可显示
 * @param obj 参数对象
 */
AssetsFurnitureProcDetail.prototype.controlCustomSubTableForAccess = function(tagId, operability, obj){
	var tagArr = obj.tag.split("__");
	var subTableName = tagArr[0];
	var subTableId = $("table[name="+subTableName+"]")[0].id
	var tag = "#"+subTableId;
	if(operability){
		$(tag).showCol(tagId);
	}else{
		$(tag).hideCol(tagId);
	}
}
/**
 * 非电子表单子表字段的可编辑控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 * @param obj 参数对象
 */
AssetsFurnitureProcDetail.prototype.controlCustomSubTableForOperability = function(tagId, operability, obj){
	var tagArr = obj.tag.split("__");
	var subTableName = tagArr[0];
	var subTableId = $("table[name="+subTableName+"]")[0].id
	var tag = "#"+subTableId;
	if(operability){
		$(tag).setColProp(tagId,{editable:true});
	}else{
		$(tag).setColProp(tagId,{editable:false});
	}
}
/**
 * 非电子表单子表字段的必填控制，子表字段元素定义通过".customform_subtable_bpm_auth"来实现
 * @param tagId 元素id
 * @param accessibility 是否可显示
 * @param obj 参数对象
 */
AssetsFurnitureProcDetail.prototype.controlCustomSubTableForRequired = function(tagId, operability, obj){
	//获取必填字段数组
	var notnullFiledArr = this.AssetsFurnitureProcRel.notnullFiled;
	var notnullFiledCommentArr = this.AssetsFurnitureProcRel.notnullFiledComment;
	var tagValue = tagId;
	if(tagValue.lastIndexOf("Alias") > -1){
		tagValue = tagValue.substring(0,tagId.lastIndexOf("Alias"));
	}else if(tagId.lastIndexOf("Name") > -1){
		tagValue = tagValue.substring(0,tagId.lastIndexOf("Name"));
	}
	if(notnullFiledArr.indexOf(tagValue) > -1 && !operability){
		//配置错误
		layer.alert("流程建模必填项配置错误!");
		return false;
	}
	if(operability){
		//添加必填
		var tagArr = obj.tag.split("__");
		var subTableName = tagArr[0];
		var subTableId = $("table[name="+subTableName+"]")[0].id
		var tag = "#"+subTableId;
		$(tag).setLabel(tagId,'<span style="color:red;">*</span>' + obj.tagName,'');
		notnullFiledArr.push(tagId);
		notnullFiledCommentArr.push(obj.tagName);
	}
}
/**
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
AssetsFurnitureProcDetail.prototype.formValidate=function(form){
	form.validate({
		rules: {
						  		     			 		  				  		     			    				   				   furNo:{
						required:true,
						maxlength: 50
				   },  
				   							 		  				  				  		     			    				   					createdByDept:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					createdByTel:{
						maxlength: 20
				    },
				    							 		  				  				  				  				  				  				  		     			    				   					applyReason:{
						maxlength: 1024
				    },
				    							 		  				  		     			    				   			       arrivalDate:{
						dateISO:true
				   },
				   							 		  				  		     			    				   				   formPrice:{
						number:true
				   },
				   							 		  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  			  }
	});
}
