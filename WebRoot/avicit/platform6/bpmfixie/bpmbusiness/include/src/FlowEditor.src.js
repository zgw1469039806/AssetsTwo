flowUtils.include("avicit/platform6/bpmreform/bpmbusiness/include/src/FlowIdeaBase.js");
flowUtils.include("avicit/platform6/bpmreform/bpmbusiness/include/src/FlowIdea.js");
/**
 * 流程操作
 */
function FlowEditor(defaultForm, flowIdea) {
	var defineId = _bpm_defineId, deploymentId = _bpm_deploymentId, firstTaskName = _bpm_firstTaskName, firstTaskAlias = _bpm_firstTaskAlias, entryId = _bpm_entryId, executionId = _bpm_executionId, taskId = _bpm_taskId, formId = _bpm_formId, ideaCompelManner = _bpm_ideaCompelManner;
	_flow_editor = this;
	var _self = this;
	this.simulation = _bpm_simulation;
	this.flowModel = new FlowModel(defineId, deploymentId, entryId, executionId, taskId);
	this.defaultForm = defaultForm;
	this.defaultForm.flowEditor = this;
	
	//加入流程意见对象flowIdea
	if(flowUtils.notNull(flowIdea)){
		this.flowIdea = flowIdea;
	}else{
		this.flowIdea = new FlowIdea();
	}
	this.flowIdea.flowEditor = this;
	
	//记录拟稿节点，是否需要强制表态
	this.ideaCompelManner = ideaCompelManner;
	// 初始化参数
	if (flowUtils.notNull(defineId)) {
		this.isStart = true;
		this.flowModel.setActivityname(firstTaskName);
		this.flowModel.setActivitylabel(firstTaskAlias);
		this.flowModel.setUserIdentityKey("6");
		this.flowModel.setUserIdentity("拟稿人");
	} else if (flowUtils.notNull(entryId, executionId, taskId, formId)) {
		this.defaultForm.setId(formId);
		this.defaultForm.initFormData();
		this.flowModel.defineId = this.getDefineIdByEntryId(entryId);
	} else {
		this.hideButtons();
		flowUtils.error("流程参数错误！无法初始化权限按钮！您可能是通过非法的途径进入了当前页面，例如重复刷新页面，拷贝链接到浏览器地址栏等操作。点击确定关闭表单", function() {
			flowUtils.closeWindowOnDialog();
		});
		return false;
	}
	var title = flowUtils.getUrlQuery("title");
	if (flowUtils.notNull(title)) {
		document.title = title;
	}
	// 初始化文档
	this.flowUploader = new FlowUploader(this);
	this.flowUploader.init();
	// 初始化流程图画布
	initFlowPic(this.flowModel.defineId);
	this.flowIdea.init();
	// 权限按钮
	this.createButtons();
};
/**
 * 表单对象
 */
FlowEditor.prototype.defaultForm = null;
/**
 * 数据模板
 */
FlowEditor.prototype.flowModel = null;
/**
 * 是否新建
 */
FlowEditor.prototype.isStart = false;
/**
 * 是否刷新流程图
 */
FlowEditor.prototype.needRefreshPic = false;
/**
 * 是否需要意见框
 */
FlowEditor.prototype.needIdeaText = false;
/**
 * 是否是模拟状态
 */
FlowEditor.prototype.simulation = "0";
/**
 * 自定义的加载后事件是否已经执行
 */
FlowEditor.prototype.afterInit = false;
/**
 * 隐藏按钮
 */
FlowEditor.prototype.hideButtons = function() {
	$(".bpmhide").hide();
	$("#bpm_buttons_default1").empty();
	$("#bpm_buttons_default2").empty();
};

/**
 * 权限按钮重置
 */
FlowEditor.prototype.createButtons = function(flg) {
	var _self = this;
	// 隐藏所有按钮
	this.hideButtons();
	if(this.simulation == "1"){
		//模拟状态
		this.bpmSubmit = new BpmSubmit(this, this.defaultForm, new Object());
		// 默认保存
		this.bpmSave = new BpmSave(this, this.defaultForm, new Object());
		
		this.bpmSubmit.execute = function(){
			flowUtils.success("模拟提交");
		};
		
		this.bpmSave.execute = function(){
			flowUtils.success("模拟保存");
		};
		
		$("#bpm_buttons_title").html("当前节点：" + this.flowModel.activitylabel);
		$("#bpm_buttons_desc").html("当前身份：" +  this.flowModel.userIdentity);
		//当前节点描述
		this.hoverRemark();
		// 控制表单元素
		this.controlFormInput();
		// 刷新引用文档
		this.refreshFiles();
		// 流程图
		this.needRefreshPic = true;
		//刷新权限按钮后事件
		this.defaultForm.afterCreateButtons();
		//自定义的加载事件
		if(!this.afterInit){
			this.defaultForm.afterInit();
			this.afterInit = true;
		}
		//显隐
		this.flowIdea.show();
	}else{
		if (this.isStart) {
			// 默认提交
			this.bpmSubmit = new BpmSubmit(this, this.defaultForm, new Object());
			// 默认保存
			this.bpmSave = new BpmSave(this, this.defaultForm, new Object());
			
			$("#bpm_buttons_title").html("当前节点：" + this.flowModel.activitylabel);
			$("#bpm_buttons_desc").html("当前身份：" +  this.flowModel.userIdentity);
			//当前节点描述
			this.hoverRemark();
			// 控制表单元素
			this.controlFormInput();
			// 刷新引用文档
			this.refreshFiles();
			// 流程图
			this.needRefreshPic = true;
			//刷新权限按钮后事件
			this.defaultForm.afterCreateButtons();
			//自定义的加载事件
			if(!this.afterInit){
				this.defaultForm.afterInit();
				this.afterInit = true;
			}
			//显隐
			this.flowIdea.show();
		} else {
			// 流程图
			if (_avicTabIndex == 1) {
				this.refreshPic();
				this.refreshTracks();
			} else {
				this.needRefreshPic = true;
			}
			
			avicAjax.ajax({
				type : "POST",
				data : {
					processInstanceId : _self.flowModel.entryId,
					executionId : _self.flowModel.executionId,
					taskId : _self.flowModel.taskId
				},
				url : "platform/bpm/business/getoperateright",
				dataType : "JSON",
				success : function(msg) {
					if (flowUtils.notNull(msg.error)) {
						flowUtils.error(msg.error);
					} else {
						_self.drawButtons(msg);
						//调用正文模板的方法
						if (typeof word_oa_refresh != 'undefined' && flowUtils.notNull(word_oa_refresh)) {
							word_oa_refresh(_self);
						}
						// 默认点击提交
						if (flg) {
							_self.bpmSubmit.clickBut();
						}
						//刷新权限按钮后事件
						_self.defaultForm.afterCreateButtons();
						//自定义的加载事件
						if(!_self.afterInit){
							_self.defaultForm.afterInit();
							_self.afterInit = true;
						}
					}
				}
			});
		}
	}
};
/**
 * 画按钮
 * 
 * @param json
 */
FlowEditor.prototype.drawButtons = function(json) {
	var bpmContent = json.bpmContent;
	this.flowModel.setActivityname(bpmContent.processActivityName);
	this.flowModel.setActivitylabel(bpmContent.processActivityLabel);
	this.flowModel.setUserIdentityKey(bpmContent.userIdentityKey);
	this.flowModel.setUserIdentity(bpmContent.userIdentity);
	$("#bpm_buttons_title").html("当前节点：" + this.flowModel.activitylabel);
	$("#bpm_buttons_desc").html("当前身份：" +  this.flowModel.userIdentity);
	//当前节点描述
	this.hoverRemark();
	// 刷新引用文档
	this.refreshFiles();
	
	var buttonArray = json.operateRight;
	if (buttonArray == null) {
		return;
	}
	var buttonData = {};
	$.each(buttonArray, function(i, button) {
		if (button.event == "dosubmit") {
			if (buttonData.dosubmit == null) {
				buttonData.dosubmit = [];
			}
			buttonData.dosubmit.push(button);
		} else {
			eval("buttonData." + button.event + "= button");
		}
	});
	
	this.needIdeaText = false;
	
	this.bpmSave = new BpmSave(this, this.defaultForm, buttonData);
	this.bpmRetreat = new BpmRetreat(this, this.defaultForm, buttonData);
	this.bpmSubmit = new BpmSubmit(this, this.defaultForm, buttonData);
	this.bpmWithdraw = new BpmWithdraw(this, this.defaultForm, buttonData);
	this.bpmSupplement = new BpmSupplement(this, this.defaultForm, buttonData);
	if (!this.bpmRetreat.enable && !this.bpmSubmit.enable) {
		this.bpmWithdraw.getHtmlForDefaultBar();
		this.bpmSupplement.getHtmlForDefaultBar();
	} else {
		this.bpmWithdraw.getHtml();
		this.bpmSupplement.getHtml();
	}
	this.bpmAdduser = new BpmAdduser(this, this.defaultForm, buttonData);
	this.bpmSupersede = new BpmSupersede(this, this.defaultForm, buttonData);
	this.bpmTransmit = new BpmTransmit(this, this.defaultForm, buttonData);
	this.bpmWithdrawassignee = new BpmWithdrawassignee(this, this.defaultForm, buttonData);
	this.bpmFocus = new BpmFocus(this, this.defaultForm, buttonData);
	this.bpmGlobalend = new BpmGlobalend(this, this.defaultForm, buttonData);
	this.bpmGlobalidea = new BpmGlobalidea(this, this.defaultForm, buttonData);
	this.bpmGlobaljump = new BpmGlobaljump(this, this.defaultForm, buttonData);
	this.bpmGlobalresume = new BpmGlobalresume(this, this.defaultForm, buttonData);
	this.bpmGlobalsuspend = new BpmGlobalsuspend(this, this.defaultForm, buttonData);
	this.bpmStepuserdefined = new BpmStepuserdefined(this, this.defaultForm, buttonData);
	this.bpmTaskreader = new BpmTaskreader(this, this.defaultForm, buttonData);
	this.bpmPresstodo = new BpmPresstodo(this, this.defaultForm, buttonData);
	if(this.needIdeaText){
		this.flowIdea.readonly(false);
		//显隐
		this.flowIdea.show();
	}else{
		this.flowIdea.clear();
		this.flowIdea.readonly(true);
		//显隐
		this.flowIdea.hide();
	}
	// 控制表单元素
	this.controlFormInput();
};
/**
 * 流程启动后
 * 
 * @param result
 */
FlowEditor.prototype.afterStart = function(result) {
	this.isStart = false;
	this.flowModel.setDefineId(result.defineId);
	this.flowModel.setEntryId(result.entryId);
	this.flowModel.setExecutionId(result.executionId);
	this.flowModel.setTaskId(result.taskId);
	this.defaultForm.setId(result.formId);
};
/**
 * 刷新流程图
 */
FlowEditor.prototype.refreshPic = function() {
	bpm_RefreshPic(this.flowModel.entryId);
};
/**
 * 刷新文字跟踪
 */
FlowEditor.prototype.refreshTracks = function() {
	bpm_RefreshTracks(this.flowModel.entryId);
};
/**
 * 刷新引用文档
 */
FlowEditor.prototype.refreshFiles = function() {
	this.flowUploader.refresh();
};
/**
 * 需要获取定义文件id
 * 
 * @param entryId
 */
FlowEditor.prototype.getDefineIdByEntryId = function(entryId) {
	var defineId = null;
	$.ajax({
		type : "POST",
		async : false,// 同步请求
		data : {
			entryId : entryId
		},
		url : "platform/bpm/business/getDefineIdByEntryId",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				defineId = msg.defineId;
			}
		}
	});
	return defineId;
};
/**
 * 控制表单元素
 */
FlowEditor.prototype.controlFormInput = function() {
	var _self = this;
	//是否电子表单
	var isEform = true;
	if(this.flowModel.userIdentityKey == "7" && this.bpmSave.isEnable()){
		//管理员允许编辑表单
	}else{
		// 全部只读，包括按钮
		$(".panel-body").eq(0).find("select").attr("disabled", "disabled");
		$(".panel-body").eq(0).find(':checkbox').attr("disabled", "disabled");
		$(".panel-body").eq(0).find(':radio').attr("disabled", "disabled");
		$(".panel-body").eq(0).find(':text').attr("disabled", "disabled");
		$(".panel-body").eq(0).find("textarea").attr("disabled", "disabled");
		//禁用图标事件
        $(".panel-body").eq(0).find(".easyui-datebox").datebox({disabled:true});
        $(".panel-body").eq(0).find(".easyui-datetimebox").datetimebox({disabled:true});
        $(".panel-body").eq(0).find(".easyui-combobox").combobox({disabled:true});
		$(".panel-body").eq(0).find(".ext-input-right-icon").hide();
		
		//自定义元素置为只读
		$(".bpm_self_class").each(function(i){
			var id = $(this).attr("id");
			_self.defaultForm.controlSelfElement(id, false);
		});

		// 全部显示，包括按钮
//		$(".panel-body").eq(0).find("select").show();
//		$(".panel-body").eq(0).find(':checkbox').show();
//		$(".panel-body").eq(0).find(':radio').show();
//		$(".panel-body").eq(0).find(':text').show();
//		$(".panel-body").eq(0).find("textarea").show();
		
		//自定义元素置为显示
		$(".bpm_self_class").each(function(i){
//			var id = $(this).attr("id");
//			_self.defaultForm.controlSelfElementForAccess(id, true);
		});
		//附件置为只读
		this.defaultForm.setAttachMagic(false);
		
		// 允许编辑
		avicAjax.ajax({
			type : "POST",
			data : {
				defineId : this.flowModel.defineId,
				activityname : this.flowModel.activityname
			},
			url : "platform/bpm/business/getFormSecuritys",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					if (_self.bpmSave.isEnable()) {
						$.each(msg.result, function(i, n) {
							var operability = n.operability == "1";
							// 允许编辑
							if(operability){
								if(n.elementType == "bpm_self_class"){
									//自定义元素
									_self.defaultForm.controlSelfElement(n.tag, operability, n);
								}else if(n.elementType == "pt6:JigsawCheckBox" || n.elementType == "pt6:JigsawRadio" || n.elementType == "checkbox" || n.elementType == "radio"){
									var $tag = $('input[name="' + n.tag + '"]');
									$tag.removeAttr("disabled");
								}else if(n.elementType == "textarea"){
									var $tag = $('#' + n.tag);
									$tag.removeAttr("disabled");
								}else if(n.elementType == "eform_subtable_bpm_auth"){
									var tagArr = n.tag.split("__");
									var colName = tagArr[1];
									var subTableName = tagArr[0];
									var colModel = $("#"+subTableName).datagrid('getColumnFields');
									var hasColNameName = false;
									var colNameName = colName+"Name";
									if(colModel!=null && colModel.length>0){
										for(var m=0;m<colModel.length;m++){
											if(colModel[m]==colNameName){
												hasColNameName = true;
												break;
											}
										}
									}
									if(hasColNameName){
										$("#"+subTableName).datagridex("readonly",colName+"Name",false);
										//$("#"+subTableName).jqGrid('setCell', colName+"Name", 'colLength', '', 'editable-cell');
									}else{
										//$("#"+subTableName).jqGrid('setCell', colName, 'colLength', '', 'editable-cell');
										$("#"+subTableName).datagridex("readonly",colName,false);
									}
									
								}else if(n.elementType == "eform_subtable_bpm_button_auth"){
									//子表按钮不做处理
								}else{
									var $tag = $('#' + n.tag);
									if($tag.hasClass("easyui-datebox")){
										$tag.datebox({disabled:false});
									}else if($tag.hasClass("easyui-datetimebox")){
										$tag.datetimebox({disabled:false});
									}else if($tag.hasClass("easyui-combobox")){
										$tag.combobox({disabled:false});
									}else{
										$tag.removeAttr("disabled");
										//启用图标事件
										if($tag.parent().find(".ext-input-right-icon")){
											$tag.parent().find(".ext-input-right-icon").show();
										}
									}
									
								}
							}else{
								if(n.elementType == "eform_subtable_bpm_auth"){
									var tagArr = n.tag.split("__");
									var colName = tagArr[1];
									var subTableName = tagArr[0];
									
									var colModel = $("#"+subTableName).datagrid('getColumnFields');
									var hasColNameName = false;
									var colNameName = colName+"Name";
									if(colModel!=null && colModel.length>0){
										for(var m=0;m<colModel.length;m++){
											if(colModel[m]==colNameName){
												hasColNameName = true;
												break;
											}
										}
									}
									if(hasColNameName){
										$("#"+subTableName).datagridex("readonly",colName+"Name");
										//$("#"+subTableName).setColProp(colName+"Name",{editable:false});
									}else{
										//$("#"+subTableName).setColProp(colName,{editable:false});
										$("#"+subTableName).datagridex("readonly",colName);
									}
									
								}
							}
						});
						var attachMagic = msg.attachMagic || msg.attachMagic == "true";
						if(attachMagic){
							_self.defaultForm.setAttachMagic(attachMagic);
						}						
						
						//附件权限
						$.each(msg.attachmentAuths, function(i, n) {
							var operability = n.operability == "1";
							var required = n.required == "1";
							
							_self.defaultForm.setAttachCanAddOrDel(n.tag, operability, n);
							if(operability && required){
								required = true;
							}else{
								required = false;
							}
							_self.defaultForm.setAttachRequired(n.tag,required,n);
							
						});
						
						/**
						 * 必填处理
						 */
						$.each(msg.result, function(i, n) {
							// 
							if(n.required == "0" || 
									(n.required == "1" && (n.accessibility == "0" || n.operability == "0"))){
								if(n.elementType == "bpm_self_class"){
									//自定义元素
									_self.defaultForm.controlSelfElementForRequired(n.tag, false, n);
								}else if(n.elementType == "checkbox" || n.elementType == "radio"){
									var $tag = $('input[name="' + n.tag + '"]');

									if(isEform){
                                        var parentTd = $tag.closest("td");
                                        if (parentTd){
                                            parentTd.attr('data-isnull',"true");
                                        }
									}else{
										$tag.rules("remove");
									}
									
									var $tagLabel = $('label[for="' + n.tag + '"]');
									var $i = $tagLabel.children("i[class=required]");
									if($i && $i.length>0){
										for(var a=0;a<$i.length;a++){
											$i[a].remove();
										}
									}
								}else if(n.elementType == "textarea"){
									var $tag = $('#' + n.tag);
									if(isEform){
										$tag.validatebox({    
										    required: false
										});
									}else{
										$tag.rules("remove");
									}
									var $tagLabel = $('label[for="' + n.tag + '"]');
									var $i = $tagLabel.children("i[class=required]");
									if($i && $i.length>0){
										for(var a=0;a<$i.length;a++){
											$i[a].remove();
										}
									}
								}else if(n.elementType == "eform_subtable_bpm_auth"){
									var tagArr = n.tag.split("__");
									var colName = tagArr[1];
									var subTableName = tagArr[0];
									var colModel = $("#"+subTableName).datagrid('getColumnFields');
									var hasColNameName = false;
									var colNameName = colName+"Name";
									if(colModel!=null && colModel.length>0){
										for(var m=0;m<colModel.length;m++){
											if(colModel[m]==colNameName){
												hasColNameName = true;
												break;
											}
											
										}
									}
									if(hasColNameName){
										$('#'+subTableName).datagridex("deleteValidate",colName+"Name","required");
										//$('#'+subTableName).validateJqGrid("deleteValidate",colName+"Name","required");
									}else{
										$('#'+subTableName).datagridex("deleteValidate",colName,"required");
										//$('#'+subTableName).validateJqGrid("deleteValidate",colName,"required");
									}
									
								}else if(n.elementType == "eform_subtable_bpm_button_auth"){
									//子表按钮不做处理
								}else{
									var $tag = $('#' + n.tag);
									if($tag.hasClass("easyui-datebox")){
										var comValue = $tag.datebox('getValue');
										$tag.datebox({
											required: false
										});
                                        $tag.datebox('setValue', comValue);
									}else if($tag.hasClass("easyui-datetimebox")){
										var comValue = $tag.datetimebox('getValue');
										$tag.datetimebox({
											required: false
										});
                                        $tag.datetimebox('setValue', comValue);
									}else if($tag.hasClass("easyui-combobox")){
										var comValue = $tag.combobox('getValue');
										$tag.combobox({
											required: false,
                                            validType:null
										});
                                        $tag.combobox('setValue', comValue);
									}else{
										if(isEform){
											$tag.validatebox({    
											    required: false
											});
										}else{
											$tag.rules("remove");
										}
									}
									var $tagLabel = $('label[for="' + n.tag + '"]');
									var $i = $tagLabel.children("i[style='color:red']");
									if($i && $i.length>0){
										for(var a=0;a<$i.length;a++){
											$i[a].remove();
										}
									}
                                    var $tagLabelName = $('label[for="' + n.tag + 'Name"]');
                                    var $ii = $tagLabelName.children("i[style='color:red']");
                                    if($ii && $ii.length>0){
                                        for(var a=0;a<$ii.length;a++){
                                            $ii[a].remove();
                                        }
                                    }
								}
							}else if(n.required == "1" && n.accessibility == "1" && n.operability == "1"){
								if(n.elementType == "bpm_self_class"){
									//自定义元素
									_self.defaultForm.controlSelfElementForRequired(n.tag, n.required == "1", n);
								}else if(n.elementType == "checkbox" || n.elementType == "radio"){
									var $tag = $('input[name="' + n.tag + '"]');
									if(isEform){
                                        var parentTd = $tag.closest("td");
                                        if (parentTd){
                                            parentTd.attr('data-isnull',"false");
                                        }
									}else{
										$tag.rules("add",{required:true}); 
									}
									
									var $tagLabel = $('label[for="' + n.tag + '"]');
									var $i = $tagLabel.children("i[class=required]");
									if(!$i || $i.length<1){
										var requiredElement = $("<i style='color:red'>*</i>");
										$tagLabel.prepend(requiredElement);
									}
								}else if(n.elementType == "textarea"){
									var $tag = $('#' + n.tag);
									if(isEform){
										$tag.validatebox({    
										    required: true
										});
									}else{
										$tag.rules("add",{required:true}); 
									}
									var $tagLabel = $('label[for="' + n.tag + '"]');
									var $i = $tagLabel.children("i[class=required]");
									if(!$i || $i.length<1){
										var requiredElement = $("<i style='color:red'>*</i>");
										$tagLabel.prepend(requiredElement);
									}
								}else if(n.elementType == "eform_subtable_bpm_auth"){
									var tagArr = n.tag.split("__");
									var colName = tagArr[1];
									var subTableName = tagArr[0];
									
									var colModel = $("#"+subTableName).datagrid('getColumnFields');
									var hasColNameName = false;
									var colNameName = colName+"Name";
									if(colModel!=null && colModel.length>0){
										for(var m=0;m<colModel.length;m++){
											if(colModel[m]==colNameName){
												hasColNameName = true;
												break;
											}
										}
									}
									if(hasColNameName){
										//$('#'+subTableName).datagridex("deleteValidate",colName+"Name","required");
										$('#'+subTableName).datagridex("addValidate",colName+"Name","required");
									}else{
										//$('#'+subTableName).datagridex("deleteValidate",colName,"required");
										$('#'+subTableName).datagridex("addValidate",colName,"required");
									}
								}else if(n.elementType == "eform_subtable_bpm_button_auth"){
									//子表按钮不做处理
								}else{
									var $tag = $('#' + n.tag);
									if($tag.hasClass("easyui-datebox")){
										var comValue = $tag.datebox('getValue');
										$tag.datebox({
											required: true
										});
                                        $tag.datebox('setValue', comValue);
									}else if($tag.hasClass("easyui-datetimebox")){
										var comValue = $tag.datetimebox('getValue');
										$tag.datetimebox({
											required: true
										});
                                        $tag.datetimebox('setValue', comValue);
									}else if($tag.hasClass("easyui-combobox")){
										var comValue = $tag.combobox('getValue');
										$tag.combobox({
											required: true,
                                            validType:'extendsIsNull'
										});
                                        $tag.combobox('setValue', comValue);
									}else{
										if(isEform){
											$tag.validatebox({    
											    required: true
											});
										}else{
											$tag.rules("add",{required:true}); 
										}
									}
									
									var $tagLabel = $('label[for="' + n.tag + '"]');
                                    var $tagLabelName = $('label[for="' + n.tag + 'Name"]');
									var $i = $tagLabel.children("i[style='color:red']");
									if(!$i || $i.length<1){
										var requiredElement = $("<i style='color:red'>*</i>");
										$tagLabel.prepend(requiredElement);
									}
                                    var $ii = $tagLabelName.children("i[style='color:red']");
                                    if(!$ii || $ii.length<1){
                                        var requiredElement = $("<i style='color:red'>*</i>");
                                        $tagLabelName.prepend(requiredElement);
                                    }
								}
								
							}
						});
					}
					$.each(msg.result, function(i, n) {
						var accessibility = n.accessibility == "1";
						// 进行隐藏
						if(!accessibility){
							if(n.elementType == "bpm_self_class"){
								//自定义元素
								_self.defaultForm.controlSelfElementForAccess(n.tag, accessibility, n);
							}else if(n.elementType == "checkbox" || n.elementType == "radio"){
								var $tag = $('input[name="' + n.tag + '"]');
								$tag.hide();
								var $tagLabel = $('label[for="' + n.tag + '"]');
								$tagLabel.hide();
							}else if(n.elementType == "textarea"){
								var $tag = $('#' + n.tag);
								$tag.hide();
								var $tagLabel = $('label[for="' + n.tag + '"]');
								$tagLabel.hide();
							}else if(n.elementType == "eform_subtable_bpm_auth"){
								var tagArr = n.tag.split("__");
								var colName = tagArr[1];
								var subTableName = tagArr[0];
								
								var colModel = $("#"+subTableName).datagrid('getColumnFields');
								var hasColNameName = false;
								var colNameName = colName+"Name";
								if(colModel!=null && colModel.length>0){
									for(var m=0;m<colModel.length;m++){
										if(colModel[m]==colNameName){
											hasColNameName = true;
											break;
										}
									}
								}
								if(hasColNameName){
									jQuery("#" + subTableName).datagrid("hideColumn",colName+"Name");
								}else{
									jQuery("#" + subTableName).datagrid("hideColumn",colName);
								}
								
							}else if(n.elementType == "eform_subtable_bpm_button_auth"){
								_self.defaultForm.controlSubTableButtonForAccess(n.tag, accessibility, n);
							}else{
								var $tag = $('#' + n.tag);
								if($tag.hasClass("easyui-datebox")){
									$tag.datebox("destroy");
								}else if($tag.hasClass("easyui-numberbox")){
									$tag.numberbox("destroy");
								}else if($tag.hasClass("easyui-combobox")){
									$tag.combobox("destroy");
								}else if($tag.hasClass("easyui-datetimebox")){
									$tag.datetimebox("destroy");
								}else if($tag.hasClass("easyui-coding")){
									$tag.coding("destroy");
								}else if($tag.hasClass("groupCtrlSpan")){
									$tag.remove();
								}else if($tag.parent() && $tag.parent().hasClass("ext-selector-div")){
									$tag.parent().hide();
								}else{
									$tag.hide();
								}
								var $tagLabel = $('label[for="' + n.tag + '"]');
                                var $tagLabelName = $('label[for="' + n.tag + 'Name"]');
								$tagLabel.hide();
                                $tagLabelName.hide();
							}
						}else{
							if(n.elementType == "eform_subtable_bpm_auth"){
								var tagArr = n.tag.split("__");
								var colName = tagArr[1];
								var subTableName = tagArr[0];
								
								var colModel = $("#"+subTableName).datagrid('getColumnFields');
								var hasColNameName = false;
								var colNameName = colName+"Name";
								if(colModel!=null && colModel.length>0){
									for(var m=0;m<colModel.length;m++){
										if(colModel[m]==colNameName){
											hasColNameName = true;
											break;
										}
									}
								}
								if(hasColNameName){
									jQuery("#" + subTableName).datagrid("showColumn",colName+"Name");
								}else{
									jQuery("#" + subTableName).datagrid("showColumn",colName);
								}
								
							}else if(n.elementType == "eform_subtable_bpm_button_auth"){
								_self.defaultForm.controlSubTableButtonForAccess(n.tag, accessibility, n);
							}
						}
					});
				}
			}
		});
	}

};
/**
 * 初始化节点描述
 */
FlowEditor.prototype.hoverRemark = function() {
	if($("#bpm_buttons_remark").attr("isload") == "true"){
		return;
	}
	$("#bpm_buttons_remark").attr("isload","true");
	$.ajax({
		type : "POST",
		data : {
			defineId : this.flowModel.defineId,
			activityname : this.flowModel.activityname
		},
		url : "platform/bpm/business/getTaskRemark",
		dataType : "JSON",
		success : function(msg) {
			if (flowUtils.notNull(msg.error)) {
				flowUtils.error(msg.error);
			} else {
				var html = "";
				if(flowUtils.notNull(msg.result)){
					html = ""+msg.result+"";
				}else{
					html = "当前节点无描述";
				}
				$("#bpm_buttons_remark").attr("title", html);
			}
		}
	});
};
// 暴漏的全局属性
var _flow_editor = null;
var _avicTabIndex = 0;
function avicTabOnSwitch(index) {
	_avicTabIndex = index;
	if (index == 1) {
		if (typeof _flow_editor.needRefreshPic != "undefined" && _flow_editor.needRefreshPic) {
			_flow_editor.needRefreshPic = false;
			_flow_editor.refreshPic();
			_flow_editor.refreshTracks();
		}
	} else if (index == 2) {

	}
};