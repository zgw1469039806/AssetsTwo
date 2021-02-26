flowUtils.include("avicit/platform6/bpmreform/bpmbusiness/include/src/FlowIdeaBase.js");
flowUtils.include("avicit/platform6/bpmreform/bpmbusiness/include/src/FlowIdea.js");
/**
 * 流程操作
 */
function FlowEditor(defaultForm, flowIdea) {
	var defineId = _bpm_defineId, deploymentId = _bpm_deploymentId, firstTaskName = _bpm_firstTaskName, firstTaskAlias = _bpm_firstTaskAlias, entryId = _bpm_entryId, executionId = _bpm_executionId, taskId = _bpm_taskId, formId = _bpm_formId, ideaCompelManner = _bpm_ideaCompelManner, showTrackInForm = _bpm_showTrackInForm;
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

	this.createTrackInForm();
	if(showTrackInForm == "yes"){
		this.showTrackInForm();
	}
	// 初始化参数
	if (flowUtils.notNull(defineId)) {
		this.isStart = true;
		this.flowModel.setActivityname(firstTaskName);
		this.flowModel.setActivitylabel(firstTaskAlias);
		this.flowModel.setUserIdentityKey("6");
		this.flowModel.setUserIdentity("拟稿人");
		this.doInit();
	} else if (flowUtils.notNull(entryId, executionId, taskId, formId)) {
		this.defaultForm.setId(formId);

		//当检查到checkUserSecretLevel方法返回true，或存在checkUserSecretLevel的全局变量为true时，执行密级校验
		//管理员也需要符合密级要求
		if(this.defaultForm.checkUserSecretLevel()){
			avicAjax.ajax({
				type : "POST",
				data : {
					processInstanceId : entryId,
					secretLevelCode: _self.defaultForm.secretLevelCode()
				},
				url : "platform/bpm/clientbpmdisplayaction/isUserSecretLevel",
				dataType : "json",
				success : function(r) {
					var b = r.result;
					if (b) {
						_self.defaultForm.initFormData();
						_self.flowModel.defineId = _self.getDefineIdByEntryId(entryId);
						_self.doInit();
					} else {
						_self.hideBody();
						flowUtils.error("人员密级不符合要求", function () {
							flowUtils.closeWindowOnDialog();
						});
						return false;
					}
				}
			});
		}else {
			this.defaultForm.initFormData();
			this.flowModel.defineId = this.getDefineIdByEntryId(entryId);
			this.doInit();
		}
	} else {
		this.hideBody();
		flowUtils.error("流程参数错误！无法初始化权限按钮！您可能是通过非法的途径进入了当前页面，例如重复刷新页面，拷贝链接到浏览器地址栏等操作。点击确定关闭表单", function() {
			flowUtils.closeWindowOnDialog();
		});
		return false;
	}
	var title = flowUtils.getUrlQuery("title");
	if (flowUtils.notNull(title)) {
		document.title = unescape(title);
	}

};
FlowEditor.prototype.doInit = function(){
	var _self = this;
	// 初始化文档
	this.flowUploader = new FlowUploader(this);
	this.flowUploader.init();
	// 初始化流程图画布
	initFlowPic(this.flowModel.entryId, this.flowModel.deploymentId, function(designerEditor) {
		_self.designerEditor = designerEditor;
	});
	this.flowIdea.init();
	//初始化上下游流程页签
	this.initProcesslevelPage();
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
 * 隐藏页面，关闭页面
 */
FlowEditor.prototype.hideBody = function () {
	this.hideButtons();
	$(".main").hide();
};
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
FlowEditor.prototype.createButtons = function(flg, outcome) {
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
		//this.refreshPic();
		this.refreshTracks();
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
			//this.refreshPic();
			this.refreshTracks();
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
				//this.refreshTracks();
			} else {
				this.needRefreshPic = true;
			}
			//this.refreshPic();
			this.refreshTracks();

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
							_self.bpmSubmit.clickBut(outcome);
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
	this.flowModel.setIdeasBySelf(bpmContent.ideasBySelf);
	$("#bpm_buttons_title").html("当前节点：" + this.flowModel.activitylabel);
	$("#bpm_buttons_desc").html("当前身份：" +  this.flowModel.userIdentity);
	//当前节点描述
	this.hoverRemark();
	// 刷新引用文档
	this.refreshFiles();

	if(bpmContent.showTrackInForm == "yes"){
		this.showTrackInForm();
	}

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
	this.bpmStartsubflow = new BpmStartsubflow(this, this.defaultForm, buttonData);
	this.bpmRelationparentflow = new BpmRelationparentflow(this, this.defaultForm, buttonData);
	this.bpmRelationflow = new BpmRelationflow(this, this.defaultForm, buttonData);
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
	this.designerEditor.init(this.flowModel.entryId, this.flowModel.deploymentId);
	if(mxClient.IS_IE8){
		$("#graph").parent().height(500);
	}
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
FlowEditor.prototype.createTrackInForm = function() {
	var temp = $("#showTrackDiv").clone(true, true);
	temp.attr("id", "showTrackInForm");
	temp.hide();
	temp.find(".l").attr("for", "timer2");
	temp.find(".r").attr("for", "list2");
	temp.find(".timer").addClass("timer2");
	temp.find(".list").addClass("list2");
	temp.appendTo($(".panel-main").eq(0));
};
FlowEditor.prototype.showTrackInForm = function() {
	$("#showTrackInForm").show();
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
	var userIdentityKey = this.flowModel.userIdentityKey;
	if(this.flowModel.userIdentityKey == "7" && this.bpmSave.isEnable()){
		//管理员允许编辑表单
	}else{
		// 全部只读，包括按钮
		$(".panel-body").eq(0).find("select").not(".bpm_nosec_class").not(".ui-pg-selbox").attr("disabled", "disabled");
		$(".panel-body").eq(0).find(':checkbox').not(".bpm_nosec_class").not(".bpm_nosec_class :checkbox").not(".eform_subtable_bpm_auth :checkbox").not(".customform_subtable_bpm_auth :checkbox").attr("disabled", "disabled");
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
		$(".panel-body").eq(0).find(':radio').not(".bpm_nosec_class").attr("disabled", "disabled");
		$(".panel-body").eq(0).find(':text').not(".bpm_nosec_class").not(".view-box :text").not(".ui-pg-input").attr("disabled", "disabled");
		//ie8以下textarea disabled之后滚动条没法用,改为readonly
		$(".panel-body").eq(0).find("textarea").not(".bpm_nosec_class").attr("readonly", "readonly");
		//禁用图标事件
		$(".panel-body").eq(0).find(".input-group-addon").not(".bpm_nosec_class").css('cursor',"not-allowed");
		$(".panel-body").eq(0).find(".input-group-addon").not(".bpm_nosec_class").bind('click', function(){return false;});
		$(".panel-body").eq(0).find(".input-group-addon").not(".bpm_nosec_class").off('click');
		//电子表单子表按钮隐藏
		$(".panel-body").eq(0).find(".eform_subtable_bpm_button_auth").hide();
		//电子表单子表所有元素禁用
		$(".panel-body").eq(0).find(".eform_subtable_bpm_auth").each(function(index,item){
			var subTableName = $(item).attr("title");
			if(undefined!=subTableName && ''!=subTableName){
				var colModel = $("#"+subTableName).jqGrid('getGridParam','colModel');
				if(colModel!=null && colModel.length>0){
					for(var m=0;m<colModel.length;m++){
						$('#'+subTableName).jqGrid('endEditCell');
						$("#"+subTableName).setColProp(colModel[m].name,{editable:false,classes:'datatable-readonly'});
					}
				}
				$("#"+subTableName).jqGrid('setGridParam',{'altRows':false}).trigger('reloadGrid');
				$("#"+subTableName).hideCol("cb");
			}
		});

		//非电子表单子表所有元素禁用
		$(".panel-body").eq(0).find(".customform_subtable_bpm_auth").each(function(index,item){
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
			_self.defaultForm.controlSelfElement(id, false);
		});

		// 全部显示，包括按钮
		$(".panel-body").eq(0).find("select").not(".bpm_nosec_class").removeAttr("readonly");
		$(".panel-body").eq(0).find(':checkbox').not(".bpm_nosec_class").not(".bpm_nosec_class :checkbox").removeAttr("readonly");
		$(".panel-body").eq(0).find(':radio').not(".bpm_nosec_class").removeAttr("readonly");
        $(".panel-body").eq(0).find(':checkbox').parent("label").not(".bpm_nosec_class").not(".bpm_nosec_class :checkbox").removeAttr("readonly");
        $(".panel-body").eq(0).find(':radio').parent("label").not(".bpm_nosec_class").removeAttr("readonly");
		$(".panel-body").eq(0).find(':text').not(".bpm_nosec_class").removeAttr("readonly");
		//ie8及以下需要用readonly disabled滚动条没法用
		//$(".panel-body").eq(0).find("textarea").not(".bpm_nosec_class").removeAttr("readonly");
		//显示图标
		$(".panel-body").eq(0).find(".input-group-addon").not(".bpm_nosec_class").removeAttr("readonly");

		//自定义元素置为显示
		/*$(".bpm_self_class").each(function(i){
			var id = $(this).attr("id");
			_self.defaultForm.controlSelfElementForAccess(id, true);
		});*/
		//附件置为只读
		this.defaultForm.setAttachMagic(false);
		/**
		 * 多附件区域设置为只读
		 */
		$(".panel-body").eq(0).find(".eform_mutiattach_auth").each(function(){
			_self.defaultForm.setAttachCanAddOrDel($(this).attr("id"), false, null);
			//设置附件密级是否可修改
			_self.defaultForm.setAttachSecretLevelModify($(this).attr("id"),false,null);
		});
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
                    /**
                     * 获取字段关联权限控制，字段权限控制以关联权限为准
                     */
         			 var fieldRelationAuths = _self.getInitFieldGroupAuths(msg);
					if (_self.bpmSave.isEnable()) {
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
					$(window).resize();
				}
                _self.defaultForm.afterControlFormInput();
			}
		});
	}
};

/**
 * 控制表单字段是否可编辑
 * @param msg
 */
FlowEditor.prototype.controlFormOperability = function(auths){
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
				_self.defaultForm.controlSelfElement(n.tag, operability, n);
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
				_self.defaultForm.controlCustomSubTableForOperability(colName, true, n);
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				_self.defaultForm.setAttachCanAddOrDel(n.tag, operability, n);
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
                _self.defaultForm.controlSelfElement(n.tag, operability, n);
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
				_self.defaultForm.controlCustomSubTableForOperability(colName, false, n);
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
FlowEditor.prototype.controlAttachmentAuths = function(attachMagic,attachmentAuths){
	var _self = this;
	var attachMagic = attachMagic || attachMagic == "true";
	if(attachMagic){
		_self.defaultForm.setAttachMagic(attachMagic);
	}

	//附件权限
	$.each(attachmentAuths, function(i, n) {
		var operability = n.operability == "1";
		var required = n.required == "1";
		var modifySecretLevel = n.modifySecretLevel == "1";

		_self.defaultForm.setAttachCanAddOrDel(n.tag, operability, n);
		if(operability && required){
			required = true;
		}else{
			required = false;
		}
		_self.defaultForm.setAttachRequired(n.tag,required,n);
		//设置附件密级是否可修改，改为调用表单接口
		_self.defaultForm.setAttachSecretLevelModify(n.tag,modifySecretLevel,n);
	});
};

/**
 * 控制表单字段必填
 * @param msg
 */
FlowEditor.prototype.controlFormRequired = function(auths,isEform){
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
				_self.defaultForm.controlSelfElementForRequired(n.tag, false, n);
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
				_self.defaultForm.controlCustomSubTableForRequired(colName, false, n);
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				$("#"+n.tag).removeAttr("required");
				_self.defaultForm.setAttachRequired(n.tag,false,n);
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
				_self.defaultForm.controlSelfElementForRequired(n.tag,true, n);
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
				_self.defaultForm.controlCustomSubTableForRequired(colName, true, n);
			}else if(n.elementType == "fileupload" || n.elementType == "eform_mutiattach_auth"){//多附件
				$("#"+n.tag).attr("required","required");
				_self.defaultForm.setAttachRequired(n.tag,true,n);
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
FlowEditor.prototype.controlFormAccessibility = function(auths){
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
				_self.defaultForm.controlSelfElementForAccess(n.tag, accessibility, n);
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
				_self.defaultForm.controlSubTableButtonForAccess(n.tag, accessibility, n);
			}else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				_self.defaultForm.controlCustomSubTableForAccess(colName, accessibility, n);

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
                _self.defaultForm.controlSelfElementForAccess(n.tag, accessibility, n);
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
				_self.defaultForm.controlSubTableButtonForAccess(n.tag, accessibility, n);
			}else if(n.elementType == "customform_subtable_bpm_auth"){//非电子表单子表字段
				var tagArr = n.tag.split("__");
				var colName = tagArr[1];
				_self.defaultForm.controlCustomSubTableForAccess(colName, accessibility, n);

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
FlowEditor.prototype.hideRow = function(tagObj){
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
FlowEditor.prototype.hideRowForSubTable = function(tagObj){
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
FlowEditor.prototype.showRow = function(tagObj){
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
FlowEditor.prototype.showRowForSubTable = function(tagObj){
	if(flowUtils.notNull(tagObj)){
		var _row = tagObj.parents("table").parents("tr");
		if(_row){
			_row.show();
		}
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
					html = "<p>"+msg.result+"</p>";
				}else{
					html = "<p>当前节点无描述</p>";
				}
				$("#bpm_buttons_remark").popover({
					html : true,
					title : "节点描述",
					placement : "left",
					container : 'body',
					trigger : 'hover',
					template : '<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>',
					content : html
				});
			}
		}
	});
};
//初始化上下游流程页签
FlowEditor.prototype.initProcesslevelPage = function() {
   var id = this.flowModel.entryId;
   if($("#iframeCenter_processlevel_graph").length>0){
	   if(id!=undefined && id!=null && id!=''){
		   avicAjax.ajax({
	           url: "bpm/bpmdomain/getParentAndSubProcessses",
	           data: "procInstId=" + id,
	           type: "post",
	           dataType: "json",
	           success: function (backData) {
					var setting = {
							view: {
								fontCss: getFont
							},
							data: {
								key: {
									id: "id",
									name: "name",
									children: "children"
								},
								simpleData: {
									enable: true,
									idKey: "id",
									pIdKey: "parentId",
									rootPId: "-1"
								}
							},
							callback:{
								onClick: function(event, treeId, treeNode){
                                    if(treeNode.id == "-1" || treeNode.id == "-2"){
                                        return;
                                    }
									var url = "avicit/platform6/bpmreform/bpmdesigner/picture/pic.jsp?entryId="+treeNode.id.replace("relation_","");
							    	$("#iframeCenter_processlevel_graph").attr("src",url);
								}
							 }
							};
	           	var treeObj = $.fn.zTree.init($("#processLevelTree"), setting, backData.result);
	           }
	       });
	   }
   }

};
//刷新上下游流程页签
FlowEditor.prototype.reloadProcesslevelPage = function() {
   var id = this.flowModel.entryId;
   if($("#iframeCenter_processlevel_graph").length>0){
	   if(id!=undefined && id!=null && id!=''){
		   avicAjax.ajax({
	           url: "bpm/bpmdomain/getParentAndSubProcessses",
	           data: "procInstId=" + id,
	           type: "post",
	           dataType: "json",
	           success: function (backData) {
					var setting = {
							view: {
								fontCss: getFont
							},
							data: {
								key: {
									id: "id",
									name: "name",
									children: "children"
								},
								simpleData: {
									enable: true,
									idKey: "id",
									pIdKey: "parentId",
									rootPId: "-1"
								}
							},
							callback:{
								onClick: function(event, treeId, treeNode){
									if(treeNode.id == "-1" || treeNode.id == "-2"){
										return;
									}
									var url = "avicit/platform6/bpmreform/bpmdesigner/picture/pic.jsp?entryId="+treeNode.id.replace("relation_","");
							    	$("#iframeCenter_processlevel_graph").attr("src",url);
								}
							 }
							};
	           	var treeObj = $.fn.zTree.init($("#processLevelTree"), setting, backData.result);
	           }
	       });
	   }
   }

};

/**
 * 根据字段组关联权限给被控制字段绑定事件
 * @param msg
 * @param isEform
 */
FlowEditor.prototype.bindEventByFieldGroupAuth = function(msg,isEform){
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
FlowEditor.prototype.bindEventByFieldRelationAuth = function(fieldGroup,fieldGroupList,defaultAuths,defaultAttachmentAuths,isEform){
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
FlowEditor.prototype.bindFieldEvent = function(bindDomId,controlDomType,eventType,data,isEform){
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
FlowEditor.prototype.getInitFieldGroupAuths = function(msg){
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
FlowEditor.prototype.dealSameRowFields = function(_tagObj,_defaultAuths,_fieldRelationGroups){
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
FlowEditor.prototype.dealSameRowFieldsForRelation = function(_tagObj,_fieldRelationGroups){
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
FlowEditor.prototype.calculateFieldGroup = function(fieldGroup){
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

function getFont(treeId, node) {
    if(node.fontCss=="Y"){
        return {color:'#BA55D3'};
    }
}
// 暴漏的全局属性
var _flow_editor = null;
var _avicTabIndex = 0;
function avicTabOnSwitch(index) {
	_avicTabIndex = index;
	if(index == 0){
        $(".main").removeClass("noright");
	}else{
        $(".main").addClass("noright");
	}
    $(document).resize();
	if (index == 1) {
		if (_flow_editor.needRefreshPic) {
			_flow_editor.needRefreshPic = false;
			_flow_editor.refreshPic();
			//_flow_editor.refreshTracks();
		}
	} else if(index == 3){
		$("#processLevelLayout").layout('resize');
	}
}
