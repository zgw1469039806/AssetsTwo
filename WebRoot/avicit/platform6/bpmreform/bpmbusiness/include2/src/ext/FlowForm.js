/**
 * 表单操作
 */
function FlowForm(flowEditor) {
    this.flowEditor = flowEditor;
};
/**
 * 流程操作对象
 */
FlowForm.prototype.flowEditor = null;

/**
 * 控制表单元素
 */
FlowForm.prototype.controlFormInput = function() {
    var _self = this;
    //是否电子表单
    var isEform = true;
    var userIdentityKey = this.flowEditor.flowModel.userIdentityKey;
    if(this.flowEditor.flowModel.userIdentityKey == "7" && this.flowEditor.bpmSave.isEnable()){
        //管理员允许编辑表单
    }else{
        // 全部只读，包括按钮
        $("#formTab").find("select").not(".bpm_nosec_class").not(".ui-pg-selbox").attr("disabled", "disabled");
        $("#formTab").find(':checkbox').not(".bpm_nosec_class").not(".bpm_nosec_class :checkbox").not(".eform_subtable_bpm_auth :checkbox").not(".customform_subtable_bpm_auth :checkbox").attr("disabled", "disabled");
        $("#formTab").find(':radio').not(".bpm_nosec_class").attr("disabled", "disabled");
        $("#formTab").find(':text').not(".bpm_nosec_class").not(".view-box :text").not(".ui-pg-input").attr("disabled", "disabled");
        //ie8以下textarea disabled之后滚动条没法用,改为readonly
        $("#formTab").find("textarea").not(".bpm_nosec_class").attr("readonly", "readonly");
		//非电子表单子表表头的checkbox处理
		var customform_subtable_bpm_auth = $(".panel-body").eq(0).find(".customform_subtable_bpm_auth");
		if(customform_subtable_bpm_auth && customform_subtable_bpm_auth.length){
			customform_subtable_bpm_auth.each(function () {
				var customTableId = $("this").attr("id");
				var headCheckBok = $("#cb_"+customTableId);
				if(headCheckBok){
					headCheckBok.removeAttr("disabled");
				}
			});
		}
        //禁用图标事件
        $("#formTab").find(".input-group-addon").not(".bpm_nosec_class").css('cursor',"not-allowed");
        $("#formTab").find(".input-group-addon").not(".bpm_nosec_class").bind('click', function(){return false;});
        $("#formTab").find(".input-group-addon").not(".bpm_nosec_class").off('click');
        //子表按钮隐藏
        $("#formTab").find(".eform_subtable_bpm_button_auth").hide();
		//电子表单子表所有元素禁用
		$("#formTab").find(".eform_subtable_bpm_auth").each(function(index,item){
			var subTableName = $(item).attr("title");
			if(undefined!=subTableName && ''!=subTableName){
				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						$('#'+subTableName).jqGrid('endEditCell');
						$("#"+subTableName).setColProp(colModel[m].name,{editable:false});
					}
				}
                $("#"+subTableName).jqGrid('setGridParam',{'altRows':false}).trigger('reloadGrid');
                $("#"+subTableName).hideCol("cb");
			}
		});

		//非电子表单子表所有元素禁用
		$("#formTab").find(".customform_subtable_bpm_auth").each(function(index,item){
			var subTableName = $(item).attr("id");
			if(undefined!=subTableName && ''!=subTableName){
				//子表添加按钮id
				var subTableButtonAddId = subTableName+"_insert";
				if($("#"+subTableButtonAddId)){
					$("#"+subTableButtonAddId).hide();
				}
				//子表删除按钮id
				var subTableButtonDelId = subTableName+"_del";
				if($("#"+subTableButtonDelId)){
					$("#"+subTableButtonDelId).hide();
				}
				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						$('#'+subTableName).jqGrid('endEditCell');
						$("#"+subTableName).setColProp(colModel[m].name,{editable:false,classes:'datatable-readonly'});
					}
				}
			}
		});

        //自定义元素置为只读
        $(".bpm_self_class").each(function(i){
            var id = $(this).attr("id");
            _self.flowEditor.defaultForm.controlSelfElement(id, false);
        });

        // 全部显示，包括按钮
        $("#formTab").find("select").not(".bpm_nosec_class").removeAttr("readonly");
        $("#formTab").find(':checkbox').not(".bpm_nosec_class").not(".bpm_nosec_class :checkbox").removeAttr("readonly");
        $("#formTab").find(':radio').not(".bpm_nosec_class").removeAttr("readonly");
        $("#formTab").find(':checkbox').parent("label").not(".bpm_nosec_class").not(".bpm_nosec_class :checkbox").removeAttr("readonly");
        $("#formTab").find(':radio').parent("label").not(".bpm_nosec_class").removeAttr("readonly");
        $("#formTab").find(':text').not(".bpm_nosec_class").removeAttr("readonly");
        //ie8及以下需要用readonly disabled滚动条没法用
        //$("#formTab").find("textarea").not(".bpm_nosec_class").removeAttr("readonly");
        //显示图标
        $("#formTab").find(".input-group-addon").not(".bpm_nosec_class").removeAttr("readonly");

        //自定义元素置为显示
       /* $(".bpm_self_class").each(function(i){
            var id = $(this).attr("id");
            _self.flowEditor.defaultForm.controlSelfElementForAccess(id, true);
        });*/
        //附件置为只读
        this.flowEditor.defaultForm.setAttachMagic(false);
		/**
		 * 多附件区域设置为只读
		 */
		$("#formTab").find(".eform_mutiattach_auth").each(function(){
			_self.flowEditor.defaultForm.setAttachCanAddOrDel($(this).attr("id"), false, null);
			//设置附件密级是否可修改
			_self.flowEditor.defaultForm.setAttachSecretLevelModify($(this).attr("id"),false,null);
		});

        // 允许编辑
        avicAjax.ajax({
            type : "POST",
            data : {
                defineId : this.flowEditor.flowModel.defineId,
                activityname : this.flowEditor.flowModel.activityname
            },
            url : "platform/bpm/business/getFormSecuritys",
            dataType : "JSON",
            success : function(msg) {
                if (flowUtils.notNull(msg.error)) {
                    flowUtils.error(msg.error);
                } else {
                    /**
                     * 获取字段关联权限控制，字段权限控制以关联权限为准
                     */
         	    var fieldRelationAuths = _self.getInitFieldGroupAuths(msg);
                    if (_self.flowEditor.bpmSave.isEnable()) {
                        	//控制附件权限 修改为先控制附件权限
						_self.controlAttachmentAuths(msg.attachMagic,msg.attachmentAuths);
						//控制表单字段是否可编辑
						_self.controlFormOperability(msg.result);
						//关联字段控制是否可编辑
            			_self.controlFormOperability(fieldRelationAuths);
						//控制表单字段是否必填
						_self.controlFormRequired(msg.result,isEform);
           				 //关联字段控制是否必填
						_self.controlFormRequired(fieldRelationAuths,isEform);

            			//绑定字段联动事件
            			_self.bindEventByFieldGroupAuth(msg,isEform);
                    }
                    //控制表单字段显隐
                    _self.controlFormAccessibility(msg.result);
			        //关联字段控制字段显隐
                    _self.controlFormAccessibility(fieldRelationAuths);
                    //已办 已阅 读者 未知 状态的隐藏子表按钮 禁用子表字段
                    if(userIdentityKey =="2" || userIdentityKey =="4"
                        || userIdentityKey =="5" || userIdentityKey =="0"){
                        //电子表单子表按钮
                        $("#formTab").find(".eform_subtable_bpm_button_auth").hide();

                    }
                    $(window).resize();
                }
                _self.flowEditor.defaultForm.afterControlFormInput();
            }
        });
    }
};

/**
 * 控制表单字段是否可编辑
 * @param msg
 */
FlowForm.prototype.controlFormOperability = function(auths){
    var _self = this;
    var subtableMap = {};
    $.each(auths, function(i, n) {
		var operability = n.operability == "1";
		// 允许编辑
		if(operability){
			if(n.elementType == "bpm_self_class"
				|| n.elementType == "autocode-box"
				|| n.elementType == "waautocode-box"
				|| n.elementType == "bpmopinion-box"
				|| n.elementType == "waidea-box"
				|| n.elementType =="photo-box"){
				//自定义元素
                _self.flowEditor.defaultForm.controlSelfElement(n.tag, operability, n);
            }else if(n.elementType == "pt6:h5checkbox" || n.elementType == "pt6:h5radio" || n.elementType == "checkbox" || n.elementType == "radio"){
                var $tag = $('input[name="' + n.tag + '"]');
                $tag.removeAttr("disabled");
            }else if(n.elementType == "textarea"){
                var $tag = $('#' + n.tag);
                $tag.removeAttr("readonly");
            }else if(n.elementType == "eform_subtable_bpm_auth"){
                var tagArr = n.tag.split("__");
                var colName = tagArr[1];
                var subTableName = tagArr[0];
                var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
                var hasColNameName = false;
                var colNameName = colName+"Name";
                if(colModel!=null && colModel.length>0){
                    for(var m=0;m<colModel.length;m++){
                        if(colModel[m].name==colNameName){
                            hasColNameName = true;
                            break;
                        }
                    }
                }
				if(hasColNameName){
					$("#"+subTableName).setColProp(colName+"Name",{editable:true,classes:''});
					$("[aria-describedby='"+subTableName+"_"+colName+"Name']").removeClass("datatable-readonly");
				}else{
					$("#"+subTableName).setColProp(colName,{editable:true,classes:''});
					$("[aria-describedby='"+subTableName+"_"+colName+"']").removeClass("datatable-readonly");
				}
				subtableMap[subTableName] = true;

            }else if(n.elementType == "eform_subtable_bpm_button_auth"){
                //子表按钮不做处理
            }else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
                var tagArr = n.tag.split("__");
                var colName = tagArr[1];
                _self.flowEditor.defaultForm.controlCustomSubTableForOperability(colName, true, n);
            }else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				_self.flowEditor.defaultForm.setAttachCanAddOrDel(n.tag, operability, n);
	    }else{
                var $tag = $('#' + n.tag);
                $tag.removeAttr("disabled");
                //启用图标事件
                $tag.parent().find(".input-group-addon").css('cursor',"pointer");
                //杨勇删除
                //$tag.parent().find(".input-group-addon").off('click');
                if($tag.parent().find(".input-group-addon")){
					$tag.parent().find(".input-group-addon").unbind('click');
                    $tag.parent().find(".input-group-addon").click(function(){
                        $tag.trigger('focus');
                    });
                }
            }
        }else{
            if(n.elementType == "bpm_self_class"
				|| n.elementType == "autocode-box"
				|| n.elementType == "waautocode-box"
				|| n.elementType == "bpmopinion-box"
				|| n.elementType == "waidea-box"
				|| n.elementType =="photo-box"){
                //自定义元素
                _self.flowEditor.defaultForm.controlSelfElement(n.tag, operability, n);
            }else if(n.elementType == "pt6:h5checkbox" || n.elementType == "pt6:h5radio" || n.elementType == "checkbox" || n.elementType == "radio"){
                var $tag = $('input[name="' + n.tag + '"]');
                $tag.attr("disabled","disabled");
            }else if(n.elementType == "textarea"){
                var $tag = $('#' + n.tag);
                $tag.attr("readonly","readonly");
            }else if(n.elementType == "eform_subtable_bpm_auth"){
                var tagArr = n.tag.split("__");
                var colName = tagArr[1];
                var subTableName = tagArr[0];

                var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
                var hasColNameName = false;
                var colNameName = colName+"Name";
                if(colModel!=null && colModel.length>0){
                    for(var m=0;m<colModel.length;m++){
                        if(colModel[m].name==colNameName){
                            hasColNameName = true;
                        }
                    }
                }
				if(hasColNameName){
					$('#'+subTableName).jqGrid('endEditCell');
					$("#"+subTableName).setColProp(colName+"Name",{editable:false,classes:'datatable-readonly'});
					$("[aria-describedby='"+subTableName+"_"+colName+"Name']").addClass("datatable-readonly");
				}else{
					$('#'+subTableName).jqGrid('endEditCell');
					$("#"+subTableName).setColProp(colName,{editable:false,classes:'datatable-readonly'});
					$("[aria-describedby='"+subTableName+"_"+colName+"']").addClass("datatable-readonly");
				}



            }else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
                var tagArr = n.tag.split("__");
                var colName = tagArr[1];
                _self.flowEditor.defaultForm.controlCustomSubTableForOperability(colName, false, n);
			}else if(n.elementType == "eform_subtable_bpm_button_auth"){
				//子表按钮不做处理
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				_self.defaultForm.setAttachCanAddOrDel(n.tag, operability, n);
			}else{
                var $tag = $('#' + n.tag);
                $tag.attr("disabled","disabled");
                //启用图标事件
                $tag.parent().find(".input-group-addon").css('cursor',"");
                //杨勇删除
                /*$tag.parent().find(".input-group-addon").unbind('click');
                //$tag.parent().find(".input-group-addon").off('click');

                if($tag.parent().find(".input-group-addon")){
                    $tag.parent().find(".input-group-addon").click(function(){
                        $tag.trigger('focus');
                    });
                }*/
            }
        }
    });
    /**
     * 判断如果子表如果有可编辑的列则显示左侧复选框
     */
    for(var key in subtableMap){
		if (subtableMap[key]){
			$("#"+key).jqGrid('setGridParam',{'altRows':true}).trigger('reloadGrid');
			$("#"+key).showCol("cb");
		}
	}
};

/**
 * 控制表单附件权限
 * @param msg
 */
FlowForm.prototype.controlAttachmentAuths = function(attachMagic,attachmentAuths){
	var _self = this;
	var attachMagic = attachMagic || attachMagic == "true";
	if(attachMagic){
		_self.flowEditor.defaultForm.setAttachMagic(attachMagic);
	}

	//附件权限
	$.each(attachmentAuths, function(i, n) {
		var operability = n.operability == "1";
		var required = n.required == "1";
		var modifySecretLevel = n.modifySecretLevel == "1";

		_self.flowEditor.defaultForm.setAttachCanAddOrDel(n.tag, operability, n);
		if(operability && required){
			required = true;
		}else{
			required = false;
		}
		_self.flowEditor.defaultForm.setAttachRequired(n.tag,required,n);
		//设置附件密级是否可修改，改为调用表单接口
		_self.flowEditor.defaultForm.setAttachSecretLevelModify(n.tag,modifySecretLevel,n);
	});
};

/**
 * 控制表单字段必填
 * @param msg
 */
FlowForm.prototype.controlFormRequired = function(auths,isEform){
	var _self = this;
	/**
	 * 必填处理
	 */
	//删除错误提示信息
	$('.errDom').remove();
	$.each(auths, function(i, n) {
		//
		if(n.required == "0" ||
				(n.required == "1" && (n.accessibility == "0" || n.operability == "0"))){

			if(n.elementType == "bpm_self_class"
				|| n.elementType == "autocode-box"
				|| n.elementType == "waautocode-box"
				|| n.elementType == "bpmopinion-box"
				|| n.elementType == "waidea-box"
				|| n.elementType =="photo-box"){
				$("#"+n.tag).removeAttr("required");
				//自定义元素
				_self.flowEditor.defaultForm.controlSelfElementForRequired(n.tag, false, n);
                var $tagLabel = $('label[for="' + n.tag + '"]');
                var $i = $tagLabel.children("i[class=required]");
                $i.remove();
				var validator = $("form").validate();
				validator.removeRequiredError();
                /*if($i && $i.length>0){
                    for(var a=0;a<$i.length;a++){
                        $i[a].remove();
                    }
                }*/
			}else if(n.elementType == "pt6:h5checkbox" || n.elementType == "pt6:h5radio"
				|| n.elementType == "checkbox" || n.elementType == "radio"){
				var $tag = $('input[name="' + n.tag + '"]');
				if(isEform){
					$tag.removeAttr("required","required");
				}else{
					$tag.rules("remove");
				}

				var $tagLabel = $('label[for="' + n.tag + '"]');
				var $i = $tagLabel.children("i[class=required]");
                $i.remove();
				var validator = $("form").validate();
				validator.removeRequiredError();
				/*if($i && $i.length>0){
					for(var a=0;a<$i.length;a++){
						$i[a].remove();
					}
				}*/
			}else if(n.elementType == "textarea"){
				var $tag = $('#' + n.tag);
				if(isEform){
					$tag.removeAttr("required","required");
				}else{
					$tag.rules("remove");
				}
				var $tagLabel = $('label[for="' + n.tag + '"]');
				var $i = $tagLabel.children("i[class=required]");
                $i.remove();
				var validator = $("form").validate();
				//validator.prepareForm();
				validator.removeRequiredError();
				//validator.resetForm();
				/*if($i && $i.length>0){
					for(var a=0;a<$i.length;a++){
						$i[a].remove();
					}
				}*/
			}else if(n.elementType == "eform_subtable_bpm_auth"){
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				var subTableName = tagArr[0];
				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				var hasColNameName = false;
				var colNameName = colName+"Name";
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						if(colModel[m].name==colNameName){
							hasColNameName = true;
							break;
						}

					}
				}
				if(hasColNameName){
					$('#'+subTableName).validateJqGrid("deleteValidate",colName+"Name","required");
				}
				$('#'+subTableName).validateJqGrid("deleteValidate",colName,"required");
			}else if(n.elementType == "eform_subtable_bpm_button_auth"){
				//子表按钮不做处理
			}else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				_self.flowEditor.defaultForm.controlCustomSubTableForRequired(colName, false, n);
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				$("#"+n.tag).removeAttr("required");
				_self.flowEditor.defaultForm.setAttachRequired(n.tag,false,n);
			}else{
				var $tag = $('#' + n.tag);
				if(isEform){
					$tag.removeAttr("required","required");
				}else{
					$tag.rules("remove");
				}
				var $tagLabel = $('label[for="' + n.tag + '"]');
				var $i = $tagLabel.children("i[class=required]");
                $i.remove();
				var validator = $("form").validate();
				validator.removeRequiredError();
				/*if($i && $i.length>0){
					for(var a=0;a<$i.length;a++){
						$i[a].remove();
					}
				}*/
			}

		}else if(n.required == "1" && n.accessibility == "1" && n.operability == "1"){
			if(n.elementType == "bpm_self_class"
				|| n.elementType == "autocode-box"
				|| n.elementType == "waautocode-box"
				|| n.elementType == "bpmopinion-box"
				|| n.elementType == "waidea-box"
				|| n.elementType =="photo-box"){
				$("#"+n.tag).attr("required","required");
				//自定义元素
				_self.flowEditor.defaultForm.controlSelfElementForRequired(n.tag,true, n);
                var $tagLabel = $('label[for="' + n.tag + '"]');
                var $i = $tagLabel.children("i[class=required]");
                if(!$i || $i.length<1){
                    var requiredElement = $("<i class='required'>*</i>");
                    $tagLabel.prepend(requiredElement);
                }
			}else if(n.elementType == "pt6:h5checkbox" || n.elementType == "pt6:h5radio"
				|| n.elementType == "checkbox" || n.elementType == "radio"
			){
				var $tag = $('input[name="' + n.tag + '"]');
				if(isEform){
					$tag.attr("required","required");
				}else{
					$tag.rules("add",{required:true});
				}

				var $tagLabel = $('label[for="' + n.tag + '"]');
				var $i = $tagLabel.children("i[class=required]");
				if(!$i || $i.length<1){
					var requiredElement = $("<i class='required'>*</i>");
					$tagLabel.prepend(requiredElement);
				}
			}else if(n.elementType == "textarea"){
				var $tag = $('#' + n.tag);
				if(isEform){
					$tag.attr("required","required");
				}else{
					$tag.rules("add",{required:true});
				}
				var $tagLabel = $('label[for="' + n.tag + '"]');
				var $i = $tagLabel.children("i[class=required]");
				if(!$i || $i.length<1){
					var requiredElement = $("<i class='required'>*</i>");
					$tagLabel.prepend(requiredElement);
				}
			}else if(n.elementType == "eform_subtable_bpm_auth"){
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				var subTableName = tagArr[0];

				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				var hasColNameName = false;
				var colNameName = colName+"Name";
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						if(colModel[m].name==colNameName){
							hasColNameName = true;
							break;
						}
					}
				}
				if(hasColNameName){
					$('#'+subTableName).validateJqGrid("addValidate",colName+"Name","required");
				}else{
					$('#'+subTableName).validateJqGrid("addValidate",colName,"required");
				}
			}else if(n.elementType == "eform_subtable_bpm_button_auth"){
				//子表按钮不做处理
			}else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				_self.flowEditor.defaultForm.controlCustomSubTableForRequired(colName, true, n);
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				$("#"+n.tag).attr("required","required");
				_self.flowEditor.defaultForm.setAttachRequired(n.tag,true,n);
			}else{
				var $tag = $('#' + n.tag);
				if(isEform){
					$tag.attr("required","required");
				}else{
					$tag.rules("add",{required:true});
				}
				var $tagLabel = $('label[for="' + n.tag + '"]');
				var $i = $tagLabel.children("i[class=required]");
				if(!$i || $i.length<1){
					var requiredElement = $("<i class='required'>*</i>");
					$tagLabel.prepend(requiredElement);
				}
			}

		}
	});
};

/**
 * 控制表单字段显隐
 * @param msg
 */
FlowForm.prototype.controlFormAccessibility = function(auths){
    var _self = this;
	$.each(auths, function(i, n) {
		var accessibility = n.accessibility == "1";
		//隐藏行
		var hideRow = false;
		if(flowUtils.notNull(n.hideRow) && n.hideRow=="1"){
            hideRow = true;
        }
		// 进行隐藏
		if(!accessibility){
			if(n.elementType == "bpm_self_class"
				|| n.elementType == "autocode-box"
				|| n.elementType == "waautocode-box"
				|| n.elementType == "bpmopinion-box"
				|| n.elementType == "waidea-box"
				|| n.elementType =="photo-box"){
				//自定义元素
				_self.flowEditor.defaultForm.controlSelfElementForAccess(n.tag, accessibility, n);
				var $tag = $("#"+n.tag);
                var $tagLabel = $('label[for="' + n.tag + '"]');
                if($tagLabel && $tagLabel.length){
					$tagLabel.hide();
				}
                if(hideRow){
                    _self.hideRow($tag);
                }
			}else if(n.elementType == "pt6:h5checkbox" || n.elementType == "pt6:h5radio" || n.elementType == "checkbox" || n.elementType == "radio"){
				var $tag = $('input[name="' + n.tag + '"]');
				$tag.hide();
                $tag.parent("label").hide();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.hide();
				}
                if(hideRow){
                    _self.hideRow($tag);
                }
			}else if(n.elementType == "textarea"){
				var $tag = $('#' + n.tag);
				$tag.hide();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.hide();
				}
                if(hideRow){
                    _self.hideRow($tag);
                }
			}else if(n.elementType == "eform_subtable_bpm_auth"){
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				var subTableName = tagArr[0];

				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				var hasColNameName = false;
				var colNameName = colName+"Name";
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						if(colModel[m].name==colNameName){
							hasColNameName = true;
							break;
						}
					}
				}
				if(hasColNameName){
					jQuery("#" + subTableName).setGridParam().hideCol(colName+"Name");
				}else{
					jQuery("#" + subTableName).setGridParam().hideCol(colName);
				}
				$(window).trigger("resize");

			}else if(n.elementType == "eform_subtable_bpm_button_auth"){
				_self.flowEditor.defaultForm.controlSubTableButtonForAccess(n.tag, accessibility, n);
			}else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				_self.flowEditor.defaultForm.controlCustomSubTableForAccess(colName, accessibility, n);

			}else if(n.elementType =="datatable"){//子表div
				var $tag = $('#' + n.tag + "_control");
				$tag.hide();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.hide();
				}
				if(hideRow){
					_self.hideRowForSubTable($tag);
				}
			}else if(n.elementType =="photo-box"){//上传图片
				var $tag = $('#' + n.tag+"photo");
				$tag.hide();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.hide();
				}
				if(hideRow){
					_self.hideRow($tag);
				}
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				var $tag = $('#' + n.tag);
				$tag.attr("style","display:none;");
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.hide();
				}
				if(hideRow){
					_self.hideRow($tag);
				}
			}else{
				var $tag = $('#' + n.tag);
				$tag.hide();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				$tagLabel.hide();
				//隐藏图标
				$tag.parent().find(".input-group-addon").hide();
                if(hideRow){
                    _self.hideRow($tag);
                }
			}
		}else{
            if(n.elementType == "bpm_self_class"
				|| n.elementType == "autocode-box"
				|| n.elementType == "waautocode-box"
				|| n.elementType == "bpmopinion-box"
				|| n.elementType == "waidea-box"
				|| n.elementType =="photo-box"){
                //自定义元素
                _self.flowEditor.defaultForm.controlSelfElementForAccess(n.tag, accessibility, n);
                var $tag = $("#"+n.tag);
                var $tagLabel = $('label[for="' + n.tag + '"]');
                if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}
				_self.showRow($tag);
            }else if(n.elementType == "pt6:h5checkbox" || n.elementType == "pt6:h5radio" || n.elementType == "checkbox" || n.elementType == "radio"){
                var $tag = $('input[name="' + n.tag + '"]');
                $tag.show();
                $tag.parent("label").show();
                var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}
				_self.showRow($tag);
            }else if(n.elementType == "textarea"){
                var $tag = $('#' + n.tag);
                $tag.show();
                var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}
				_self.showRow($tag);
            }else if(n.elementType == "eform_subtable_bpm_auth"){
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				var subTableName = tagArr[0];
				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				var hasColNameName = false;
				var colNameName = colName+"Name";
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						if(colModel[m].name==colNameName){
							hasColNameName = true;
							break;
						}
					}
				}
				if(hasColNameName){
					jQuery("#" + subTableName).setGridParam().showCol(colName+"Name");
				}else{
					jQuery("#" + subTableName).setGridParam().showCol(colName);
				}
				$(window).trigger("resize");

			}else if(n.elementType == "eform_subtable_bpm_button_auth"){
				_self.flowEditor.defaultForm.controlSubTableButtonForAccess(n.tag, accessibility, n);
			}else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				_self.flowEditor.defaultForm.controlCustomSubTableForAccess(colName, accessibility, n);

			}else if(n.elementType =="datatable"){//子表div
				var $tag = $('#' + n.tag + "_control");
				_self.showRowForSubTable($tag);
				$(window).resize();
				$tag.show();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}

			}else if(n.elementType =="photo-box"){//上传图片
				var $tag = $('#' + n.tag+"photo");
				$tag.show();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}
				_self.showRow($tag);
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				var $tag = $('#' + n.tag);
				$tag.show();
				var $tagLabel = $('label[for="' + n.tag + '"]');
				if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}
				_self.showRow($tag);
			}else{
                var $tag = $('#' + n.tag);
                $tag.show();
                var $tagLabel = $('label[for="' + n.tag + '"]');
                if($tagLabel && $tagLabel.length){
					$tagLabel.show();
				}
                //隐藏图标
                $tag.parent().find(".input-group-addon").show();
				_self.showRow($tag);
            }
		}
	});
};

/**
 * 隐藏行
 * @param tagObj
 */
FlowForm.prototype.hideRow = function(tagObj){
    if(flowUtils.notNull(tagObj)){
        //var _row = tagObj.parentsUntil("tr").parent();
		var _row = tagObj.parents("tr");
        if(_row){
            //_row.attr("style","display:none;");
			_row.hide();
        }
    }
};

/**
 * 隐藏行
 * @param tagObj
 */
FlowForm.prototype.hideRowForSubTable = function(tagObj){
	if(flowUtils.notNull(tagObj)){
		var _row = tagObj.parents("table").parents("tr");
		if(_row){
			//_row.attr("style","display:none;");
			_row.hide();
		}
	}
};

/**
 * 显示行
 * @param tagObj
 */
FlowForm.prototype.showRow = function(tagObj){
    if(flowUtils.notNull(tagObj)){
		//var _row = tagObj.parentsUntil("tr").parent();
		var _row = tagObj.parents("tr");
        if(_row){
            _row.show();
        }
    }
};
/**
 * 显示行
 * @param tagObj
 */
FlowForm.prototype.showRowForSubTable = function(tagObj){
	if(flowUtils.notNull(tagObj)){
		var _row = tagObj.parents("table").parents("tr");
		if(_row){
			_row.show();
		}
	}
};

/**
 * 根据字段组关联权限给被控制字段绑定事件
 * @param msg
 * @param isEform
 */
FlowForm.prototype.bindEventByFieldGroupAuth = function(msg,isEform){
	var _self = this;
	var fieldGroupList = msg.fieldRelationAuthList;
	if(flowUtils.notNull(fieldGroupList)){
		for(var i=0;i<fieldGroupList.length;i++){
			var fieldGroup = fieldGroupList[i];
			_self.bindEventByFieldRelationAuth(fieldGroup,fieldGroupList,msg.result,msg.attachmentAuths,isEform);
		}
	}
}

/**
 * 根据字段关联权限给控制字段绑定事件
 * @param msg
 */
FlowForm.prototype.bindEventByFieldRelationAuth = function(fieldGroup,fieldGroupList,defaultAuths,defaultAttachmentAuths,isEform){
    var _self = this;
    if(flowUtils.notNull(fieldGroup)){
        $.each(fieldGroup.conditonValues, function(i, n) {
            var controlDomId = flowUtils.notNull(n.controlDomId)?n.controlDomId:n.controlTag;
            var controlElementType = n.controlElementType;
            var controlDomType = n.controlDomType;
            var data = {"fieldGroup":fieldGroup,"fieldGroupList":fieldGroupList,"defaultAuths":defaultAuths,"defaultAttachmentAuths":defaultAttachmentAuths};
            if (controlDomType == 'radio-box' || controlDomType == 'radio'
                || controlDomType == 'select-box' || controlDomType == 'select'
                || controlDomType == 'check-box' || controlDomType == 'check'
				|| controlDomType == 'secret-box' || controlDomType == 'secret'){
                _self.bindFieldEvent(controlDomId,controlDomType,"change",data,isEform);
            }else{
                _self.bindFieldEvent(controlDomId,controlDomType,"blur",data,isEform);
            }
        });
    }
};

/**
 * 给指定字段绑定事件
 * @param eventType
 * @param data
 */
FlowForm.prototype.bindFieldEvent = function(bindDomId,controlDomType,eventType,data,isEform){
    var _self = this;
    //选人、选部门等
    if (controlDomType == 'user-box' || controlDomType == 'user'
        || controlDomType == 'dept-box' || controlDomType == 'dept'
        || controlDomType == 'position-box' || controlDomType == 'position'
        || controlDomType == 'role-box' || controlDomType == 'role'
        || controlDomType == 'group-box' || controlDomType == 'group'
		|| controlDomType == 'org-box' || controlDomType == 'org'
		|| controlDomType == 'waorg-box'
		|| controlDomType =='custom-select-box'){
        bindDomId = bindDomId + "Name";
    }
    var controlObj = $("#"+bindDomId);
    if(controlDomType == 'radio-box' || controlDomType == 'radio'
		|| controlDomType == 'check-box' || controlDomType == 'check'){
		controlObj = $("input[name='"+bindDomId+"']");
	}
	controlObj.on(eventType,null,data,
        function(event){
			var _fieldGroup = event.data.fieldGroup;
			var _fieldGroupList = event.data.fieldGroupList;
			var _beControledField = _fieldGroup.beControledFields[0];
			_beControledField.domId = flowUtils.notNull(_beControledField.domId)?_beControledField.domId:_beControledField.tag;
            var _defaultAuths = event.data.defaultAuths;
            var _defaultAttachmentAuths = event.data.defaultAttachmentAuths;
            //该组条件计算结果
            var allExprTrue = _self.calculateFieldGroup(_fieldGroup,_fieldGroupList);
            //当条件不满足时是否执行默认显隐配置
            var isExecDefaultConfig = true;
            //判断被控制字段相同的其他组是否全部不满足条件，当所有都不满足条件时才按默认显隐控制处理
            if(!allExprTrue && _fieldGroup.repeatCount>0){
            	for(var k=0;k<_fieldGroupList.length;k++){
            		var _thisfieldGroup = _fieldGroupList[k];
            		//排除当前组
            		if(_thisfieldGroup.order!=_fieldGroup.order){
						var result = _self.calculateFieldGroup(_thisfieldGroup);
						if(result){
							isExecDefaultConfig = false;
						}
					}
				}

			}
            var _tag = _beControledField.tag;
			//选人、选部门等
			if (_beControledField.domType == 'user-box' || _beControledField.domType == 'user'
				|| _beControledField.domType == 'dept-box' || _beControledField.domType == 'dept'
				|| _beControledField.domType == 'position-box' || _beControledField.domType == 'position'
				|| _beControledField.domType == 'role-box' || _beControledField.domType == 'role'
				|| _beControledField.domType == 'group-box' || _beControledField.domType == 'group'
				|| _beControledField.domType == 'org-box' || _beControledField.domType == 'org'
				|| _beControledField.domType == 'waorg-box'
				|| _beControledField.domType =='custom-select-box'){
				_tag = _tag + "Name";
			}
            //满足控制条件
            if(allExprTrue){
                //组装被控制字段数据
                var beControlFieldAuths = [];
                var beControlFieldAuth = {};
                beControlFieldAuth.domId = _beControledField.domId;
                beControlFieldAuth.tag = _tag;
                beControlFieldAuth.tagName = _beControledField.tagName;
				beControlFieldAuth.elementType = _beControledField.elementType;
                beControlFieldAuth.accessibility = _beControledField.accessibility;
                beControlFieldAuth.operability = _beControledField.operability;
                beControlFieldAuth.required = _beControledField.required;
                beControlFieldAuth.hideRow = _beControledField.hideRow;
				/**
				 * 隐藏行时判断在默认显隐配置中的
				 * 必填字段（字段关联中没有该字段或者字段关联中有该字段但条件不成立），
				 * 是否是同一行
				 * 如果在同一行，则不设置隐藏行
				 */
				_self.dealSameRowFields(beControlFieldAuth,_defaultAuths,_fieldGroupList);//字段
				_self.dealSameRowFields(beControlFieldAuth,_defaultAttachmentAuths,_fieldGroupList);//附件
				_self.dealSameRowFieldsForRelation(beControlFieldAuth,_fieldGroupList);//字段关联配置
                beControlFieldAuths.push(beControlFieldAuth);
                //显隐
                _self.controlFormAccessibility(beControlFieldAuths);
                //可编辑
                _self.controlFormOperability(beControlFieldAuths);
                //必填
                _self.controlFormRequired(beControlFieldAuths,isEform);
            }else if(isExecDefaultConfig){//条件不成立,并且判断可以执行默认配置
				if(_defaultAuths && _defaultAuths.length){
					var tagObj;
					var tagArr = [];
					for(var m =0;m<_defaultAuths.length;m++){
						if(_tag==_defaultAuths[m].tag){
							tagObj = _defaultAuths[m];
							break;
						}
					}
					if(tagObj){
						tagArr.push(tagObj);
						//显隐
						_self.controlFormAccessibility(tagArr);
						//可编辑
						_self.controlFormOperability(tagArr);
						//必填
						_self.controlFormRequired(tagArr,isEform);
						return;
					}
				}
				/**
				 * 多附件的处理
				 */
				if(_defaultAttachmentAuths && _defaultAttachmentAuths.length){
					var tagObj;
					var tagArr = [];
					for(var m =0;m<_defaultAttachmentAuths.length;m++){
						if(_tag==_defaultAttachmentAuths[m].tag){
							tagObj = _defaultAttachmentAuths[m];
							tagObj.accessibility = "1";
							break;
						}
					}

					if(tagObj){
						tagArr.push(tagObj);
						//显隐
						_self.controlFormAccessibility(tagArr);
						//可编辑
						_self.controlFormOperability(tagArr);
						//必填
						_self.controlFormRequired(tagArr,isEform);
					}
				}

				/**
				 * 子表、流程意见默认值
				 */
				if(_beControledField.elementType == "datatable" || _beControledField.elementType == "bpmopinion-box"){
					var otherTagObj = {};
					var tagArr = [];
					otherTagObj.tag = _tag;
					otherTagObj.elementType = _beControledField.elementType;
					otherTagObj.accessibility = "1";
					otherTagObj.operability = "1";
					otherTagObj.required = "0";
					otherTagObj.hideRow = "0";
					tagArr.push(otherTagObj);
					//显隐
					_self.controlFormAccessibility(tagArr);
				}
			}
        });
};

/**
 * 页面初始化计算所有字段组关联权限控制
 */
FlowForm.prototype.getInitFieldGroupAuths = function(msg){
	var _self = this;
	var _fieldGroups = msg.fieldRelationAuthList;
	var _defaultAuths = msg.result;
	var _attachmentAuths = msg.attachmentAuths;
	var initFieldAuths = [];
	if(flowUtils.notNull(_fieldGroups)){
		for(var i=0;i<_fieldGroups.length;i++){
			var fieldGroup = _fieldGroups[i];
			var allResultTrue = _self.calculateFieldGroup(fieldGroup);
			if(allResultTrue){
				var tagObj = {};
				tagObj.domId = fieldGroup.beControledFields[0].domId;
				tagObj.tag = fieldGroup.beControledFields[0].tag;
				tagObj.elementType = fieldGroup.beControledFields[0].elementType;
				tagObj.tagName = fieldGroup.beControledFields[0].tagName;
				tagObj.accessibility = fieldGroup.beControledFields[0].accessibility;
				tagObj.operability = fieldGroup.beControledFields[0].operability;
				tagObj.required = fieldGroup.beControledFields[0].required;
				tagObj.hideRow = fieldGroup.beControledFields[0].hideRow;
				//选人、选部门等
				if (fieldGroup.beControledFields[0].domType == 'user-box' || fieldGroup.beControledFields[0].domType == 'user'
					|| fieldGroup.beControledFields[0].domType == 'dept-box' || fieldGroup.beControledFields[0].domType == 'dept'
					|| fieldGroup.beControledFields[0].domType == 'position-box' || fieldGroup.beControledFields[0].domType == 'position'
					|| fieldGroup.beControledFields[0].domType == 'role-box' || fieldGroup.beControledFields[0].domType == 'role'
					|| fieldGroup.beControledFields[0].domType == 'group-box' || fieldGroup.beControledFields[0].domType == 'group'
					|| fieldGroup.beControledFields[0].domType == 'org-box' || fieldGroup.beControledFields[0].domType == 'org'
					|| fieldGroup.beControledFields[0].domType == 'waorg-box'
					|| fieldGroup.beControledFields[0].domType =='custom-select-box'){
					tagObj.tag = tagObj.tag + "Name";
				}
				/**
				 * 隐藏行时判断在默认显隐配置中的
				 * 必填字段（字段关联中没有该字段或者字段关联中有该字段但条件不成立），
				 * 是否是同一行
				 * 如果在同一行，则不设置隐藏行
				 */
				_self.dealSameRowFields(tagObj,_defaultAuths,_fieldGroups);//字段
				_self.dealSameRowFields(tagObj,_attachmentAuths,_fieldGroups);//附件
				initFieldAuths.push(tagObj);
			}

		}
	}
	return initFieldAuths;
};

/**
 * 同一行字段处理
 * 隐藏行时判断在默认显隐配置中的
 * 必填字段（字段关联中没有该字段或者字段关联中有该字段但条件不成立），
 * 是否是同一行
 * 如果在同一行，则不设置隐藏行
 */
FlowForm.prototype.dealSameRowFields = function(_tagObj,_defaultAuths,_fieldRelationGroups){
	var _self = this;
	if(_tagObj.hideRow == "1"){
		for(var i=0;i<_defaultAuths.length;i++){
			if(_defaultAuths[i].tag!=_tagObj.tag
				&&_defaultAuths[i].required=='1'){
				//是否是同一行
				var rowObj = $("#"+_tagObj.tag).parents("tr").find("#"+_defaultAuths[i].tag);
				if(rowObj && rowObj.attr("id") == _defaultAuths[i].tag){
					var isRelationTrue = false;
					for(var j=0;j<_fieldRelationGroups.length;j++){
						if(_fieldRelationGroups[j].beControledFields[0].tag
							== _defaultAuths[i].tag){
							if(_self.calculateFieldGroup(_fieldRelationGroups[j])){
								isRelationTrue = true;
								break;
							}

						}
					}
					if(!isRelationTrue){
						_tagObj.hideRow = "0";
					}
				}
			}
		}

	}
};

/**
 * 同一行字段处理
 * 隐藏行时判断在字段关联显隐配置中的
 * 必填字段，
 * 是否是同一行
 * 如果在同一行，则不设置隐藏行
 */
FlowForm.prototype.dealSameRowFieldsForRelation = function(_tagObj,_fieldRelationGroups){
	var _self = this;
	if(_tagObj.hideRow == "1"){
		for(var i=0;i<_fieldRelationGroups.length;i++){
			var beControledField = _fieldRelationGroups[i].beControledFields[0];
			if(beControledField.tag!=_tagObj.tag
				&&beControledField.required=='1'){
				//是否是同一行
				var rowObj;
				//当前控件为子表
				if(_tagObj.elementType == 'datatable'){
					rowObj = $("#"+_tagObj.tag).parents("table").parents("tr").find("#"+beControledField.tag);
				}else{
					rowObj = $("#"+_tagObj.tag).parents("tr").find("#"+beControledField.tag);
				}
				if(rowObj && rowObj.attr("id") == beControledField.tag){
					if(_self.calculateFieldGroup(_fieldRelationGroups[i])){
						_tagObj.hideRow = "0";
						break;
					}
				}
			}
		}

	}
};

/**
 * 计算字段组中所有条件是否都满足
 * @param fieldGroup
 */
FlowForm.prototype.calculateFieldGroup = function(fieldGroup){
	var _self = this;
	var _fieldAuths = fieldGroup.conditonValues;
	var allExprTrue = true;
	if(!_fieldAuths || _fieldAuths.length<1){
		allExprTrue = false;
	}else{
		for(var m = 0;m<_fieldAuths.length;m++){
			var _controlDomId = flowUtils.notNull(_fieldAuths[m].controlDomId)?_fieldAuths[m].controlDomId:_fieldAuths[m].controlTag;
			var _controlValue = $("#"+_controlDomId).val();
			var _controlDomType = _fieldAuths[m].controlDomType;
			//自动编码控件和网安 编号控件
			if(_controlDomType == 'waautocode-box' || _controlDomType =='autocode-box'){
				_controlValue = $("#"+_controlDomId).attr("initvalue");
			}
			if(_controlDomType == 'radio-box' || _controlDomType == 'radio'){
				_controlValue = $("input[name='"+_controlDomId+"']:checked").val();
			}
			if(_controlDomType == 'check-box' || _controlDomType == 'check'){
				_controlValue = "";
				var checkboxs = $("input[type=checkbox][name="+_controlDomId+"]:checked");

				if(checkboxs && checkboxs.length){
					var i = 0;
					checkboxs.each(function(){
						if(i==(checkboxs.length-1)){
							_controlValue += $(this).val();
						}else{
							_controlValue += $(this).val()+"@@@";
						}
						i++;
					});
				}
			}
			var _oper = _fieldAuths[m].oper;
			var _compareValue = _fieldAuths[m].compareValue;
			var _exprValue = flowUtils.calculateExpr(_controlDomType,_controlValue,_oper,_compareValue);
			if(!_exprValue){
				allExprTrue = false;
				break;
			}
		}
	}
	return allExprTrue;
};
