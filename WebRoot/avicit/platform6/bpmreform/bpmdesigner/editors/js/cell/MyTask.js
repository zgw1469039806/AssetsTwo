/**
 * task extends MyBase
 */
function MyTask(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "task");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_human.png;";
}
MyTask.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyTask.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getTask();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	this.initEvent(); //
	// 初始化文档上传对象
	this.bpmDocUploader = new BpmDocUploader({id:this.id,defineId:this.defineId,activityName:this.name,uploaderId:"bpm-designer-upload"});
	// 初始化节点事件
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-human-task-event");

	var _self = this;
	// 节点关联表单
	this.selectPublishBpmEform1 = new SelectPublishEform("task_guan_lian_biao_dan", "task_formName", this.id, "Y", "");
	this.selectPublishBpmEform1.init( function(data) {
		$('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type", "task");
		$("#"+_self.id +" input[type='checkbox'][name='formSave']").trigger("click");
 	});
	var process = this.designerEditor.myCellMap.get(this.designerEditor.processKey)
    var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
    var globalformname = $.trim($('#' + process.id).find('#formName').val());
    if(flowUtils.notNull(globalformid)){
    	this.syncTaskForm(globalformid, globalformname);
    }
    //网安需求，拿回默认选中
	$('#' + _self.id).find('input[name="input_liu_cheng_na_hui"]').trigger('click');
};
//临时扩展用
MyTask.prototype.setUserSelectDomText = "";
MyTask.prototype.initTracks = function(xmlValue, rootXml) {
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell

	var candidateId = this.getAttr(xmlValue, "candidate-users");
	if (candidateId.length > 0) {
		var actors = this.getUserSelectObjFromXml(candidateId, xmlValue);
		this.setUserSelectDomText = this.getUserSelectTextFieldValue(actors);
	}

	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyTask.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setTask(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	this.initEvent(); //
	// 初始化文档上传对象
	this.bpmDocUploader = new BpmDocUploader({id:this.id,defineId:this.defineId,activityName:this.name,uploaderId:"bpm-designer-upload"});
	var _self =this;
	// 节点关联表单
	this.selectPublishBpmEform1 = new SelectPublishEform("task_guan_lian_biao_dan", "task_formName", _self.id, "Y", "");
	this.selectPublishBpmEform1.init( function(data) {
		$('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type", "task");
	//	$("#"+_self.id +" input[type='checkbox'][name='formSave']").trigger("click");
 	});
	this.SelectNonEform = new SelectPublishEform("task_wai_bu_url_form", "task_wai_bu_url", _self.id, "Y", "");
	this.SelectNonEform.init( function(data) {
		// $('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type", "task");
		// $("#"+_self.id +" input[type='checkbox'][name='formSave']").trigger("click");

 	});

	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	// 人工节点 tab1 基本信息开始
	//待办标题
	this.setDomValByMeta("dai_ban_biao_ti", xmlValue, "todo");
	this.setDomValByMeta("formName_biaoTi", xmlValue, "todo");
	// 移动审批属性
	this.setDomCheckByMeta("task_yi_dong_shen_pi", xmlValue, "taskMobileApproval", "no");
	// 短信通知
	this.setDomCheckByMeta("duan_xin_tong_zhi", xmlValue, "phoneInfo", "no");
	// 工作移交
	this.setDomCheckByMeta("gong_zuo_yi_jiao", xmlValue, "isWorkHandUser", "yes");
	// 密级控制
	this.setDomCheckByMeta("mi_ji_kong_zhi", xmlValue, "isSecret", "no");
	if($("#" + this.id).find("#mi_ji_kong_zhi").is(":checked")){
		$("#"+this.id).find("div[name='mi_ji_bian_liang_show']").removeClass("hidden");
		this.setDomValByMeta("mi_ji_bian_liang", xmlValue, "secretVar");
	}


    // 读者需发待阅
    this.setDomCheckByMeta("input_isSendReaderTodo", xmlValue, "isSendReaderTodo", "no");


	// 备注信息
	this.createRemarkDom(xmlValue);

    //附件下载配置
    var down_yes = this.getMeta(xmlValue, "down_yes");
    if(down_yes == "no"){
        $("#" + this.id).find("#down_yes").prop("checked", false);
	}
    this.setDomCheckByMeta("down_yes_secret", xmlValue, "down_yes_secret", "no");
    $("#" + this.id).find(".down_yes_class input").each(function(i, n){
        _self.setDomCheckByMeta($(n).attr("id"), xmlValue, $(n).attr("id"), "yes");
    });
    if($("#" + this.id).find("#down_yes_secret").is(":checked")){
        $("#" + this.id).find(".down_yes_class").show();
        $("#" + this.id).find('input[class^=down_yes_secret_class_]').each(function(i, n){
        	var secretLevel = $(this).attr("secretLevel");
        	if(this.checked){
        		$(this).parents("form").find(".down_yes_userSecret_class_"+secretLevel).show();
            }else{
            	$('input[id^=down_yes_secret_'+secretLevel+'_]').removeAttr("checked");
            	$(this).parents("form").find(".down_yes_userSecret_class_"+secretLevel).hide();
            }
        });

	}

	// 意见
	var metaValue = this.getMeta(xmlValue, "ideaType");
	$("#" + this.id).find("#task_bi_xu_tian_xie_yi_jian").prop("checked", metaValue == undefined ? false
			: (metaValue =="must" ? true :false) );
	this.setDomValByMeta("zi_ding_yi_yi_jian_kuang", xmlValue, "ideaElementIdBySelf");
	// 强制表态
	this.setDomCheckByMeta("task_yun_xu_qiang_zhi_biao_tai", xmlValue, "ideaCompelManner", "no");
	// 必须退回
	this.setDomCheckByMeta("tast_tui_hui_yi_jian", xmlValue, "isNeedIdea", "yes");

	this.setDomCheckByMeta("wen_zi_gen_zong", xmlValue, "showTrackInForm", "yes");
	// 意见显示方式
	var xianshiValue = this.getMeta(xmlValue, "ideaDisplayStyle");
	$("#" + this.id).find("input[name='task-yi-jian-xian-shi'][value='"+xianshiValue+"']").prop("checked","checked");

	// 人工节点 tab1 基本信息结束


	// 人工节点-参与者-候选人
	this.setUserSelectDom({userSelectContainer :'draft-candidate-container' ,dataField:'draft-candidate-data-field',textField:'draft-candidate-text-field'}, xmlValue);
	//成飞自定义选人 后台获取部门接口地址
	this.setDomValByMeta("zu_zhi_jie_kou", xmlValue, "deptImpl");
	// 自动选人
	// 兼容旧数据处理
	// 如果都选中或者都没选中，则默认选中自动选人
	this.setDomCheckByMeta("candidate-auto-polling", xmlValue, "isAutoGetUser", "yes");
	//组织机构树展开到部门
	this.setDomCheckByMeta("orgTreeOpenToDept", xmlValue, "orgTreeOpenToDept", "no");
	//组织机构树默认展开
	this.setDomCheckByMeta("orgTreeDefaultOpen", xmlValue, "orgTreeDefaultOpen", "no");
	//部门树隐藏组织层级
	this.setDomCheckByMeta("deptTreeHideOrg", xmlValue, "deptTreeHideOrg", "no");
	 // 显示选人框
	this.setDomCheckByMeta("show-selection-box", xmlValue, "isSelectUser", "no");

	this.setDomCheckByMeta("candidate-necessary", xmlValue, "isMustUser", "no"); // 必须选人
	// 选人方式：自动或手动
	$("#" + this.id).find("#person-automatic-selection").prop("checked",this.getMeta(xmlValue, "userSelectType") == "auto"? true : false);

	// 人工节点-参与者-处理方式
	var dealtype = this.getAttr(xmlValue, "dealtype");
	$("#" + this.id).find("select[name='select-human-task-process-mode']").val(dealtype);
	$("#" + this.id).find("select[name='select-human-task-process-mode']").trigger('change');
	if(dealtype == "4"){
		//this.setDomCheckByMeta("input-user-multiple-choose", xmlValue, "single", "yes");
		$(xmlValue).children("meta[name='number']").each(function(){
			$("#" + _self.id).find("input[type=radio][name=input-radio-human-task-select-task]").eq(1).trigger('click');
			$("#" + _self.id).find("input[name=input-num]").eq(1).val($.trim($(this).text()));
		});
		$(xmlValue).children("meta[name='percent']").each(function(){
			$("#" + _self.id).find("input[type=radio][name=input-radio-human-task-select-task]").eq(2).trigger('click');
			$("#" + _self.id).find("input[name=input-num]").eq(2).val($.trim($(this).text()));
		});
        $(xmlValue).children("meta[name='role_number']").each(function(){
            $("#" + _self.id).find("input[type=radio][name=input-radio-human-task-select-task]").eq(3).trigger('click');
            $("#" + _self.id).find("input[name=input-num]").eq(3).val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='position_number']").each(function(){
            $("#" + _self.id).find("input[type=radio][name=input-radio-human-task-select-task]").eq(4).trigger('click');
            $("#" + _self.id).find("input[name=input-num]").eq(4).val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='group_number']").each(function(){
            $("#" + _self.id).find("input[type=radio][name=input-radio-human-task-select-task]").eq(5).trigger('click');
            $("#" + _self.id).find("input[name=input-num]").eq(5).val($.trim($(this).text()));
        });

		$(xmlValue).children("meta[name='dept_one']").each(function(){
			$("#" + _self.id).find("input[type=radio][name=input-radio-human-task-select-task]").eq(6).trigger('click');
		});

        $(xmlValue).children("meta[name='dealtype_4_roleId']").each(function(){
            $("#" + _self.id).find("#dealtype_4_roleId").val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='dealtype_4_roleName']").each(function(){
            $("#" + _self.id).find("#dealtype_4_roleName").val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='dealtype_4_positionId']").each(function(){
            $("#" + _self.id).find("#dealtype_4_positionId").val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='dealtype_4_positionName']").each(function(){
            $("#" + _self.id).find("#dealtype_4_positionName").val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='dealtype_4_groupId']").each(function(){
            $("#" + _self.id).find("#dealtype_4_groupId").val($.trim($(this).text()));
        });
        $(xmlValue).children("meta[name='dealtype_4_groupName']").each(function(){
            $("#" + _self.id).find("#dealtype_4_groupName").val($.trim($(this).text()));
        });
	}


    // 先判断节点表单是否存在，如果存在则显示节点表单，如果不存在，则从全局表单中取值并将data-type配置成global，如果全局表单也不存在，那就这样吧
    // 如果选择了节点表单，将data-type配置成task
    // 如果修改全局表单，根据data-type值判断是否更新人工节点的表单
    // 如果勾选了“可编辑”，则将该节点的data-type配置成task
    var taskFormId = $.trim(xmlValue.getAttribute("taskFormId"));
    var taskFormName = $.trim(xmlValue.getAttribute("taskFormName"));
    var urlParam = $.trim(xmlValue.getAttribute("urlParam"));
    if(flowUtils.notNull(urlParam)){
		$('#' + this.id).find('#urlParam').val(urlParam);
	}
    if(flowUtils.notNull(taskFormId)) {
        $('#' + this.id).find('#task_guan_lian_biao_dan').val(taskFormId);
        $('#' + this.id).find('#task_guan_lian_biao_dan').attr("data-type", "task");
        $('#' + this.id).find('#task_formName').val(taskFormName);
    } else {
        var process = this.designerEditor.myCellMap.get(this.designerEditor.processKey)
        var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
        var globalformname = $.trim($('#' + process.id).find('#formName').val());
        this.syncTaskForm(globalformid, globalformname);
    }
	// 保存表单
	$(xmlValue).children("docRights").children("docRight[type='formSave']").each(function() {
	    // 如果勾选了可编辑，则需要将xml中的权限字段输出到前端，并根据内容决定是否选中
		var $formSave = $("#" + _self.id).find("input[name='formSave']");
        $formSave.prop("checked", true)
		$("#" + _self.id).find(".basic-form-save-area").removeClass("hidden");
		// 如果勾选了保存保单，则将节点置data-type为task
		$('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type", "task");
		// 同步属性权限
		if($(xmlValue).children("attrsAuth").length>0){
			$(xmlValue).children("attrsAuth").children().each(function() {
				var isModified = $.trim($(this).text()) == "yes" ? true:false;
				var accessibility = true;
				var required = false;
				 $("#" + _self.id).find("table[name='table-attr-auth'] tbody").append(_self.syncFormAttrTr(this.nodeName,_self.getAttr(this,"attrName"),isModified,accessibility,_self.getAttr(this,"elementType"),required));
			});
		}else{
			$(xmlValue).children("fieldsAuth").children().each(function() {
				var id = _self.getAttr(this,"id");
				var name = _self.getAttr(this,"name");
				var isModified = _self.getAttr(this,"isModified")=="yes"?true:false;
				var accessibility = _self.getAttr(this,"accessibility")=="yes"?true:false;
				var required = _self.getAttr(this,"required")=="yes"?true:false;
				var type = _self.getAttr(this,"type");
				if(type=='eform_subtable_bpm_button_auth'){
					$("#" + _self.id).find("table[name='table-attr-auth'] tbody").append(_self.syncSubFormButtonAttrTr(id,name,isModified,accessibility,type,required));
				}else{
					$("#" + _self.id).find("table[name='table-attr-auth'] tbody").append(_self.syncFormAttrTr(id,name,isModified,accessibility,type,required));
				}
			});
		}

		//同步附件权限
		$(xmlValue).children("attachmentAuth").children().each(function() {
			var id = _self.getAttr(this,"id");
			var name = _self.getAttr(this,"name");
			var isModified = _self.getAttr(this,"isModified")=="yes"?true:false;
			var required = _self.getAttr(this,"required")=="yes"?true:false;
			var type = _self.getAttr(this,"type");
			var modifySecretLevel = _self.getAttr(this,"modifySecretLevel")=="yes"?true:false;
			 $("#" + _self.id).find("table[name='table-attachment-auth'] tbody").append(_self.syncFormAttachmentAttrTr(id,name,isModified,type,required,modifySecretLevel));
		});
		//字段关联权限
		$(xmlValue).children("fieldsRelationAuth").each(function() {
			var fieldsRelationAuth = $(this).text();
			if(flowUtils.notNull(fieldsRelationAuth)){
				_self.getFieldRelationAuthFromXml(fieldsRelationAuth);
			}
		});
	});
	// 正文权限 这部分代码需要排除可编辑按钮
    $(xmlValue).children("docRights").children("docRight").each(function(){
        var docThis = this;
        var domId = $(docThis).attr("type");
        if(domId != 'formSave' && domId != 'attachCreate') {
            $("#" + _self.id).find("input[name='" + domId+"']").trigger("click");
            $(docThis).children("subDocRight").each(function(){
                var subDomId = $(this).attr("type");
                var subValue = $(this).attr("value");
                if(domId == "wordRead" || domId == "wordEdit") {
                    // 如果子节点是checkbox,则根据值勾选相应的内容
                    $("#" + _self.id).find("input[type='checkbox'][name='"+subDomId+"']").prop("checked", true);
                } else if (domId == "wordRedTemplet" || domId ==  "wordCreate") {
                    // 正文模板、套红模板回写
                    var show = $(this).attr("name");
                    var data = $(this).attr("value");
                    var dataInput = $("#" + _self.id).find("input[name='"+(domId ==  "wordCreate"?"taskFormValueWordCreate":"taskFormValueWordRedTemplet")+"']");
                    var textInput = $("#" + _self.id).find("input[name='"+(domId ==  "wordCreate"?"taskFormTextWordCreate":"taskFormTextWordRedTemplet")+"']");
                    dataInput.val(data);
                    textInput.val(show);
                    textInput.attr("title",show);
                } else if(domId == "wordPrint"){
                    var ownerId = subValue;
                    if(flowUtils.notNull(ownerId)){
                        var dataArea = $("#" + _self.id).find("input[name='taskFormValue"+subDomId+"']");
                        var textArea = $("#" + _self.id).find("input[name='taskFormText"+subDomId+"']");
                        dataArea.attr("actorsId", ownerId);
                        var actors = _self.getUserSelectObjFromXml(ownerId, xmlValue);
                        dataArea.val(JSON.stringify(actors));
                        var actorsText = _self.getUserSelectTextFieldValue(actors);
                        textArea.val(actorsText);
                        textArea.attr("title", actorsText);
                    }
                } else if(domId == "wordValue"){
                    // 域值同步回写
                    var show = $(this).attr("name");
                    var data = $(this).attr("value");
                    if(data) {
                        var dataInput = $("#" + _self.id).find("input[name='taskFormValueWordValue']");
                        var textInput = $("#" + _self.id).find("input[name='taskFormTextWordValue']");
                        dataInput.val(data);
                        textInput.val(show);
                        textInput.attr("title",show);
                    }
                } else {
                }
            });
        }
    });

	// 人工节点-权限回写
	this.createQXDom(xmlValue, "input_tui_hui_ni_gao_ren", "reTreatToDraft");
	this.createQXDom(xmlValue, "input_tui_hui_shang_yi_bu", "reTreatToPrev");
	this.createQXDom(xmlValue, "input_ren_yi_tui_hui", "reTreatToWant");
	this.createQXDom(xmlValue, "input_kua_jie_dian_tui_hui", "reTreatToActivity");
	this.createQXDom(xmlValue, "input_liu_cheng_na_hui", "withdraw");
	this.createQXDom(xmlValue, "input_liu_cheng_bu_fa", "supplement");

	this.createQXDom(xmlValue, "input_fa_song_yue_zhi", "transmit");
	this.createQXDom(xmlValue, "input_chao_song", "carbonCopy");

	this.createQXDom(xmlValue, "input_liu_cheng_wei_tuo", "supersede");
    this.setDomCheckByMeta("input_liu_cheng_wei_tuo_multi", xmlValue, "supersede_multi", "yes");
	this.createQXDom(xmlValue, "input_liu_cheng_jia_qian", "addUser");

	//this.createQXDom(xmlValue, "liu_cheng_zeng_fa_submit", "addUserAndSubmit");
	this.createQXDom(xmlValue, "input_liu_cheng_jian_qian", "withdrawAssignee");
	this.createQXDom(xmlValue, "input_pei_zhi_xuan_ren", "stepUserDefined");

	this.createQXDom(xmlValue, "input_zengjiaduzhe", "taskreader");
	this.createQXDom(xmlValue, "input_morenduzhe", "defaultreader");

	this.createQXDom(xmlValue, "input_faqiziliucheng", "startsubprocess");

	$("#"+_self.id).find("input[_type='bpm_but_attribute']").each(function (i, n) {
		_self.createQXDom(xmlValue, $(n).attr("name"), $(n).attr("name"));
	});

	// 人工节点-回写事件
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-human-task-event");
	this.nodeEvent.setEventDom(xmlValue);

	/**
	 * 催办信息
	 */
	//手动催办
	this.setDomCheckByMeta("task_cuiban_sd", xmlValue, "handHastenTask", "no");
	//自动催办
	this.setDomCheckByMeta("task_cuiban_zd", xmlValue, "autoHastenTask", "no");

	var handHastenTask = this.getMeta(xmlValue, "handHastenTask");

	var autoHastenTask = this.getMeta(xmlValue, "autoHastenTask");

	if(handHastenTask=='yes' || autoHastenTask=='yes'){

		this.showOrHiddenCuiban(true, true);
		//提醒方式-待阅
		this.setDomCheckByMeta("task_cuiban_txfs_dy", xmlValue, "toReadRemind", "no");
		//提醒方式-系统消息
		this.setDomCheckByMeta("task_cuiban_txfs_xt", xmlValue, "sysMessageRemind", "no");
		//提醒方式-邮件
		this.setDomCheckByMeta("task_cuiban_txfs_yj", xmlValue, "mailRemind", "no");
		//提醒方式-短信
		this.setDomCheckByMeta("task_cuiban_txfs_dx", xmlValue, "smsRemind", "no");
		//提醒方式-自定义
		this.setDomCheckByMeta("task_cuiban_txfs_zdy", xmlValue, "zdyRemind", "no");
		//催办实现类
		this.setDomValByMeta("task_cuiban_sxl", xmlValue, "hastenTaskClass");
	}

	if(autoHastenTask=='yes'){
		this.showOrHiddenCuiban(true, false);
		//办理期限
		this.setDomValByMeta("task_cuiban_blqx", xmlValue, "timeLimit");
		//最大催办次数
		this.setDomValByMeta("task_cuiban_cbcs", xmlValue, "maxHastenTimes");
		//警告时限
		this.setDomValByMeta("task_cuiban_jgsx", xmlValue, "warningTimeLimit");
		//催办频率
		this.setDomValByMeta("task_cuiban_cbpl", xmlValue, "hastenFrequency");
	}

	/**kpi设置*/
	this.setDomValByMeta("kpi_task_reasonable_day", xmlValue, "kpiTaskReasonableDay");
	this.setDomValByMeta("kpi_task_reasonable_hour", xmlValue, "kpiTaskReasonableHour");
	this.setDomValByMeta("kpi_task_reasonable_minute", xmlValue, "kpiTaskReasonableMinute");
	this.setDomValByMeta("kpi_task_warning_day", xmlValue, "kpiTaskWarningDay");
	this.setDomValByMeta("kpi_task_warning_hour", xmlValue, "kpiTaskWarningHour");
	this.setDomValByMeta("kpi_task_warning_minute", xmlValue, "kpiTaskWarningMinute");

	/**子流程*/
	this.getSubFromDom(xmlValue);

	var event_auto_start = this.getMeta(xmlValue, "event_auto_start");
	if(event_auto_start == "yes"){
		$("#" + this.id).find("#event_auto_start").trigger('click');
		this.setDomValByMeta("event_auto_start_defaultFlow_text", xmlValue, "event_auto_start_defaultFlow_text");
		this.setDomValByMeta("event_auto_start_defaultFlow_id", xmlValue, "event_auto_start_defaultFlow_id");
		this.setDomValByMeta("event_auto_start_defaultFlow_id2", xmlValue, "event_auto_start_defaultFlow_id2");
		this.setDomValByMeta("event_auto_start_table_text", xmlValue, "event_auto_start_table_text");
		this.setDomValByMeta("event_auto_start_table_id", xmlValue, "event_auto_start_table_id");
		this.setDomValByMeta("event_auto_start_table_name", xmlValue, "event_auto_start_table_name");
		this.setDomValByMeta("event_auto_start_fk_text", xmlValue, "event_auto_start_fk_text");
		this.setDomValByMeta("event_auto_start_fk_id", xmlValue, "event_auto_start_fk_id");
		this.setDomValByMeta("event_auto_start_user_text", xmlValue, "event_auto_start_user_text");
		this.setDomValByMeta("event_auto_start_user_id", xmlValue, "event_auto_start_user_id");
		this.setDomValByMeta("event_auto_start_flow_text", xmlValue, "event_auto_start_flow_text");
		this.setDomValByMeta("event_auto_start_flow_id", xmlValue, "event_auto_start_flow_id");
	}

	this.setDomCheckByMeta("event_auto_deleteSubProcess", xmlValue, "event_auto_deleteSubProcess");

	var task_zi_ding_yi_jian = this.getMeta(xmlValue, "task_zi_ding_yi_jian");
	if(task_zi_ding_yi_jian == "yes") {
		$("#" + this.id).find("#task_zi_ding_yi_jian").trigger('click');
		var $table = $("#" + this.id).find("#table_task_zi_ding_yi_jian tbody");
		$(xmlValue).children("ideasBySelf").children().each(function(i, n) {
			var content = $(this).text();
			var outcome = $(this).attr("outcome");
			var outcome_name = $(this).attr("outcome_name");
			addZiDingYiJiangTr($table, content, outcome, outcome_name)
		});
	}

	/**
	 * 流程数据同步
	 */
	if(flowUtils.notNull(_processDataSynJs)){
		this.getDataSynFromXml(xmlValue);
	}

	/**
	 * 表单字段关联控制
	 */
};
/**
 * 组装processXML的自定义信息
 *
 * @param node
 */
MyTask.prototype.getOtherAttr = function(node) {
	var _self = this;
	// 人工节点 tab1 基本信息开始
	//待办标题
	this.setXmlMetaByVal("dai_ban_biao_ti", node, "todo");
		// 移动审批属性
	this.setXmlMetaByCheck("task_yi_dong_shen_pi", node, "taskMobileApproval");
	// 短信通知
	this.setXmlMetaByCheck("duan_xin_tong_zhi", node, "phoneInfo");
	// 工作移交
	this.setXmlMetaByCheck("gong_zuo_yi_jiao", node, "isWorkHandUser");
	// 密级控制
	this.setXmlMetaByCheck("mi_ji_kong_zhi", node, "isSecret");
	this.addMeta("secretVar", "<![CDATA[" + $("#"+this.id).find("input[name='mi_ji_bian_liang']").val() + "]]>", node);

    // 读者需发待阅
    this.setXmlMetaByCheck("input_isSendReaderTodo", node, "isSendReaderTodo");

	// 备注信息
	this.createRemarkXml(node);

	//附件下载配置
    this.setXmlMetaByCheck("down_yes", node, "down_yes");
    this.setXmlMetaByCheck("down_yes_secret", node, "down_yes_secret");
    $("#" + this.id).find(".down_yes_class input:checked").each(function(i, n){
        _self.setXmlMetaByCheck($(n).attr("id"), node, $(n).attr("id"));
	});


	// 意见
	var content = $("#" + this.id).find("input[name='task_bi_xu_tian_xie_yi_jian']").is(":checked") ?
			"must" : "can";
	this.addMeta("ideaType", "<![CDATA[" + content + "]]>", node);
    this.setXmlMetaByVal("zi_ding_yi_yi_jian_kuang", node, "ideaElementIdBySelf");
	// 强制表态
	this.setXmlMetaByCheck("task_yun_xu_qiang_zhi_biao_tai", node, "ideaCompelManner");
	// 必须退回
	this.setXmlMetaByCheck("tast_tui_hui_yi_jian", node, "isNeedIdea");

	this.setXmlMetaByCheck("wen_zi_gen_zong", node, "showTrackInForm");
	// 意见显示方式
	var content = $("#" + this.id).find("input[type='radio'][name='task-yi-jian-xian-shi']:checked");
	this.addMeta("ideaDisplayStyle", content.val(), node);

	// 人工节点 tab1 基本信息结束

	// 人工节点-参与者-处理人
	// 选人
	this.setUserSelectXml({userSelectContainer :'draft-candidate-container' ,dataField:'draft-candidate-data-field',textField:'draft-candidate-text-field'}, node);
	//成飞自定义选人 后台获取部门接口
	this.setXmlMetaByVal("zu_zhi_jie_kou", node, "deptImpl");
	// 自动获取用户
	this.setXmlMetaByCheck("candidate-auto-polling", node, "isAutoGetUser");

	//组织机构树展开到部门
	this.setXmlMetaByCheck("orgTreeOpenToDept", node, "orgTreeOpenToDept");
	//组织机构树默认展开
	this.setXmlMetaByCheck("orgTreeDefaultOpen", node, "orgTreeDefaultOpen");
	//部门树隐藏组织层级
	this.setXmlMetaByCheck("deptTreeHideOrg", node, "deptTreeHideOrg");

	// 选人方式：自动或手动
	this.addMeta("userSelectType", $("#" + this.id).find("input[name='person-automatic-selection']").is(":checked") ? "auto":"manual", node);
	// 显示选人框
	this.setXmlMetaByCheck("show-selection-box", node, "isSelectUser");
	// 必须选人
	this.setXmlMetaByCheck("candidate-necessary", node, "isMustUser");

	// 人工节点-参与者-处理方式
	var dealtype = $("#" + this.id).find("select[name='select-human-task-process-mode']").val();
	this.putAttr("dealtype", dealtype, node);
	if(dealtype == "4"){
		// 完成个数或者百分率
		var t = $("#" + this.id).find("input[type='radio'][name='input-radio-human-task-select-task']:checked");
		// 设置完成个数或完成百分率
		var $base = t.parents(".multiple-task");
		if (t != undefined && t.val() != 'none' && t.val() != 'dept_one') {
			var index = t.parent().parent().index();
			this.addMeta(t.val() , $base.find("input[name=input-num]").eq(index).val(), node);
			if(t.val() == "role_number"){
                this.addMeta("dealtype_4_roleId" , $base.find("#dealtype_4_roleId").val(), node);
                this.addMeta("dealtype_4_roleName" , $base.find("#dealtype_4_roleName").val(), node);
			}else if(t.val() == "position_number"){
                this.addMeta("dealtype_4_positionId" , $base.find("#dealtype_4_positionId").val(), node);
                this.addMeta("dealtype_4_positionName" , $base.find("#dealtype_4_positionName").val(), node);
			}else if(t.val() == "group_number"){
                this.addMeta("dealtype_4_groupId" , $base.find("#dealtype_4_groupId").val(), node);
                this.addMeta("dealtype_4_groupName" , $base.find("#dealtype_4_groupName").val(), node);
            }
		}else if(t != undefined && t.val() == 'dept_one'){
			this.addMeta("dept_one" , "true", node);
		}
		//this.setXmlMetaByCheck("input-user-multiple-choose", node, "single");
	}

	// 人工节点 - 表单
	// 如果用户选择了节点表单，那么就将数据保存到xml
	// 正文权限不受可编辑属性的控制
	var formChoose = $("#" + this.id).find("input[name='input-radio-platform-form']:checked").val();
	if(formChoose == "form") { // 用户选择了内部表单
		var urlParam = $('#' + this.id).find('#urlParam').val();
		if(flowUtils.notNull(urlParam)){
			this.putAttr("urlParam", urlParam, node);
		}
		var dataType = $("#" + this.id).find("input[name='task_guan_lian_biao_dan']").attr("data-type");
		var taskFormId = null;
		var taskFormName = null;
		if ((flowUtils.notNull(dataType) && dataType !== "global") || flowUtils.notNull(urlParam)) {
			// 节点表单
			if(flowUtils.notNull(dataType) && dataType !== "global"){
				taskFormId = $('#' + this.id).find('#task_guan_lian_biao_dan').val();
				taskFormName = $('#' + this.id).find('#task_formName').val();
			}else{
				var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
				taskFormId = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
				taskFormName = $.trim($('#' + process.id).find('#formName').val());
			}
			this.putAttr("taskFormId", taskFormId, node);
			this.putAttr("taskFormName",taskFormName, node);

			if($("#" + this.id).find("input[name='formSave']").is(':checked')) {

				// 获取属性编辑权限
			/*	<attrsAuth formId="xxxxxx">
					<xxx attrAuth=xxx elementType=xxxx>yes</xxx>
					<xxx>yes</xxx>
					<xxx>no</xxx>
				</attrsAuth>*/
				/**
				if(taskFormId != null) { // 表示用户手动选择了表单
					var attrsAuth = flowUtils.createElement("attrsAuth");
					// this.putAttr("formId", taskFormId, attrsAuth);
					$("#" + _self.id).find("table[name='table-attr-auth']").find("tbody > tr").each(function(){
						var tag = $(this).find("input[name='tag']").val();
						var tagName = $(this).find("input[name='tagName']").val();
						var isModified = $(this).find("input[name='isModified']").is(":checked");
						var attr = flowUtils.createElement(tag);
                        var elementType = $(this).find("input[name='elementType']").val();
						_self.putAttr("attrName", tagName, attr);
                        _self.putAttr("elementType", elementType, attr);
						attr.appendChild(flowUtils.createTextNode(isModified?"yes":"no"));
						attrsAuth.appendChild(attr);
					});
					node.appendChild(attrsAuth);
				}*/

				if(taskFormId != null) { // 表示用户手动选择了表单
					var fieldsAuth = flowUtils.createElement("fieldsAuth");
					// this.putAttr("formId", taskFormId, attrsAuth);
					$("#" + _self.id).find("table[name='table-attr-auth']").find("tbody > tr").each(function(){
						var tag = $(this).find("input[name='tag']").val();
						var tagName = $(this).find("input[name='tagName']").val();
						var isModified = $(this).find("input[name='isModified']").is(":checked");
						var accessibility = $(this).find("input[name='accessibility']").is(":checked");
						var required = $(this).find("input[name='required']").is(":checked");
						var type = $(this).find("input[name='elementType']").val();
						var field = flowUtils.createElement("field");
						field.setAttribute("id",tag);
						field.setAttribute("name",tagName);
						field.setAttribute("isModified",isModified?"yes":"no");
						field.setAttribute("accessibility",accessibility?"yes":"no");
						field.setAttribute("required",required?"yes":"no");
						field.setAttribute("type",type);
						fieldsAuth.appendChild(field);
					});
					node.appendChild(fieldsAuth);

					//附件权限
					var attachmentAuth = flowUtils.createElement("attachmentAuth");
					$("#" + _self.id).find("table[name='table-attachment-auth']").find("tbody > tr").each(function(){
						var tag = $(this).find("input[name='tag']").val();
						var tagName = $(this).find("input[name='tagName']").val();
						var isModified = $(this).find("input[name='isModified']").is(":checked");
						var required = $(this).find("input[name='required']").is(":checked");
						var type = $(this).find("input[name='elementType']").val();
						var modifySecretLevel = $(this).find("input[name='modifySecretLevel']").is(":checked");
						var attachment = flowUtils.createElement("attachment");
						attachment.setAttribute("id",tag);
						attachment.setAttribute("name",tagName);
						attachment.setAttribute("isModified",isModified?"yes":"no");
						attachment.setAttribute("required",required?"yes":"no");
						attachment.setAttribute("type",type);
						attachment.setAttribute("modifySecretLevel",modifySecretLevel?"yes":"no");
						attachmentAuth.appendChild(attachment);
					});
					node.appendChild(attachmentAuth);
					/**
					 * 字段关联权限
					 */
					var fieldRelationControlConfigValue = $("#" + _self.id+" #fieldRelationControlConfigValue").val();
					if(flowUtils.notNull(fieldRelationControlConfigValue)){
						var fieldsRelationAuth = flowUtils.createElement("fieldsRelationAuth");
						fieldsRelationAuth.appendChild(flowUtils.createTextNode("<![CDATA[" + fieldRelationControlConfigValue + "]]>"));
						node.appendChild(fieldsRelationAuth);
					}

				}
			}
		}

        //文档权限
        var docRights = flowUtils.createElement("docRights");
        _self.createFormSaveXml("formSave","保存表单", docRights);
        _self.createFormSaveXml("attachCreate","增删附件", docRights);
		/*_self.createFormSaveXml("attachShowByNode","按节点过滤", docRights);*/
        if(docRights.childNodes.length > 0){
            node.appendChild(docRights);
        }
	} else {

	}



	// 人工节点 - 权限
	var magicsNode = flowUtils.createElement("magics");
	this.createQXXml(magicsNode, "input_tui_hui_ni_gao_ren", "reTreatToDraft", "退回拟稿人", node);
	this.createQXXml(magicsNode, "input_tui_hui_shang_yi_bu", "reTreatToPrev", "退回上一步", node);
	this.createQXXml(magicsNode, "input_ren_yi_tui_hui", "reTreatToWant", "任意退回", node);
	this.createQXXml(magicsNode, "input_kua_jie_dian_tui_hui", "reTreatToActivity", "跨节点退回", node);
	this.createQXXml(magicsNode, "input_liu_cheng_na_hui", "withdraw", "拿回", node);
	this.createQXXml(magicsNode, "input_liu_cheng_bu_fa", "supplement", "补发", node);
	this.createQXXml(magicsNode, "input_fa_song_yue_zhi", "transmit", "发送阅知", node);
	this.createQXXml(magicsNode, "input_chao_song", "carbonCopy", "抄送", node);
	this.createQXXml(magicsNode, "input_liu_cheng_wei_tuo", "supersede", "流程转办", node);
    this.setXmlMetaByCheck("input_liu_cheng_wei_tuo_multi", node, "supersede_multi");
	this.createQXXml(magicsNode, "input_liu_cheng_jia_qian", "addUser", "加签", node);
	//this.createQXXml(magicsNode, "liu_cheng_zeng_fa_submit", "addUserAndSubmit", "增发并提交", node);
	this.createQXXml(magicsNode, "input_liu_cheng_jian_qian", "withdrawAssignee", "减签", node);
	this.createQXXml(magicsNode, "input_pei_zhi_xuan_ren", "stepUserDefined", "配置选人", node);
	this.createQXXml(magicsNode, "input_zengjiaduzhe", "taskreader", "增加读者", node);
	this.createQXXml(magicsNode, "input_morenduzhe", "defaultreader", "增加读者", node);
	this.createQXXml(magicsNode, "input_faqiziliucheng", "startsubprocess", "发起子流程", node);

	$("#"+_self.id).find("input[_type='bpm_but_attribute']").each(function (i, n) {
		_self.createQXXml(magicsNode, $(n).attr("name"), $(n).attr("name"),  $(n).attr("_name"), node);
	});

	if(magicsNode.childNodes.length > 0){
		node.appendChild(magicsNode);
	}

	// 人工节点 - 获取事件xml
	this.nodeEvent.setEventXml(node, "start");//event


	/**
	 * 催办信息开始
	 */
	//手动催办
	this.setXmlMetaByCheck("task_cuiban_sd", node, "handHastenTask");
	//自动催办
	this.setXmlMetaByCheck("task_cuiban_zd", node, "autoHastenTask");
	if($("#" + this.id).find("input[name='task_cuiban_sd']").is(':checked')
			|| $("#" + this.id).find("input[name='task_cuiban_zd']").is(':checked')){
		//提醒方式-待阅
		this.setXmlMetaByCheck("task_cuiban_txfs_dy", node, "toReadRemind");
		//提醒方式-系统消息
		this.setXmlMetaByCheck("task_cuiban_txfs_xt", node, "sysMessageRemind");
		//提醒方式-邮件
		this.setXmlMetaByCheck("task_cuiban_txfs_yj", node, "mailRemind");
		//提醒方式-短信
		this.setXmlMetaByCheck("task_cuiban_txfs_dx", node, "smsRemind");
		//提醒方式-自定义
		this.setXmlMetaByCheck("task_cuiban_txfs_zdy", node, "zdyRemind");
		//催办实现类
		this.addMeta("hastenTaskClass",$("#" + _self.id).find("#task_cuiban_sxl").val(),node);
	}
	if($("#" + this.id).find("input[name='task_cuiban_zd']").is(':checked')){
		var timeLimit = $("#" + _self.id).find("#task_cuiban_blqx").val();
		var maxHastenTimes = $("#" + _self.id).find("#task_cuiban_cbcs").val();
		var warningTimeLimit = $("#" + _self.id).find("#task_cuiban_jgsx").val();
		var hastenFrequency = $("#" + _self.id).find("#task_cuiban_cbpl").val();
		//办理期限
		this.addMeta("timeLimit",timeLimit,node);
		//最大催办次数
		this.addMeta("maxHastenTimes",maxHastenTimes,node);
		//警告时限
		this.addMeta("warningTimeLimit",warningTimeLimit,node);
		//催办频率
		this.addMeta("hastenFrequency",hastenFrequency,node);
		//组装 on元素
		if(flowUtils.notNull(timeLimit)){
			var timeLimitInt = parseInt(timeLimit);
			if(timeLimitInt>0){
				var warningTimeLimitInt = 0;
				if(flowUtils.notNull(warningTimeLimit)){
					warningTimeLimitInt = parseInt(warningTimeLimit);
					if(warningTimeLimitInt<0){
						warningTimeLimitInt = 0;
					}
				}
				var duedate = timeLimitInt-warningTimeLimitInt;
				if(duedate<0){
					duedate = 0;
				}
				var timeEventNode = flowUtils.createElement('on');
				timeEventNode.setAttribute("event", "timeout");
				var timerNode = flowUtils.createElement("timer");
				timerNode.setAttribute("duedate",duedate+" business days");
				var repeat = 0;
				if(flowUtils.notNull(hastenFrequency)){
					repeat = parseInt(hastenFrequency);
					if(repeat<0){
						repeat = 0;
					}
				}
				if(repeat>0){
					timerNode.setAttribute("repeat",repeat+" business hours");
				}

				timeEventNode.appendChild(timerNode);

				var eventClassNode = flowUtils.createElement('event-listener');
				eventClassNode.setAttribute("name","pressTodoTimer");
				eventClassNode.setAttribute("class","avicit.platform6.bpm.bpmreform.event.PressTodoTimer");
				timeEventNode.appendChild(eventClassNode);
				node.appendChild(timeEventNode);
			}
		}
	}

	/** KPI设置*/
	this.setXmlMetaByVal("kpi_task_reasonable_day", node, "kpiTaskReasonableDay");
	this.setXmlMetaByVal("kpi_task_reasonable_hour", node, "kpiTaskReasonableHour");
	this.setXmlMetaByVal("kpi_task_reasonable_minute", node, "kpiTaskReasonableMinute");
	this.setXmlMetaByVal("kpi_task_warning_day", node, "kpiTaskWarningDay");
	this.setXmlMetaByVal("kpi_task_warning_hour", node, "kpiTaskWarningHour");
	this.setXmlMetaByVal("kpi_task_warning_minute", node, "kpiTaskWarningMinute");

	/**子流程*/
	this.getSubXml(node);

	this.setXmlMetaByCheck("event_auto_start", node, "event_auto_start");

	if($("#" + this.id).find("input[name='event_auto_start']").is(":checked")){
		var eventListener = flowUtils.createElement('event-listener');
		eventListener.setAttribute('name', "结束后根据子表数据自动发起子流程");
		eventListener.setAttribute('class', "avicit.platform6.bpm.bpmreform.event.AutoStartSubProcess");
		eventListener.setAttribute('display', "no");
		var endListenerList = $(node).children("on[event='end']");
		if(endListenerList.length == 0){
			var conditionEndNode =   flowUtils.createElement('on');
			conditionEndNode.setAttribute('event', 'end');
			conditionEndNode.appendChild(eventListener)
			node.appendChild(conditionEndNode);
		}else{
			endListenerList.append(eventListener);
		}
		this.setXmlMetaByVal("event_auto_start_defaultFlow_text", node, "event_auto_start_defaultFlow_text");
		this.setXmlMetaByVal("event_auto_start_defaultFlow_id", node, "event_auto_start_defaultFlow_id");
		this.setXmlMetaByVal("event_auto_start_defaultFlow_id2", node, "event_auto_start_defaultFlow_id2");
		this.setXmlMetaByVal("event_auto_start_table_text", node, "event_auto_start_table_text");
		this.setXmlMetaByVal("event_auto_start_table_id", node, "event_auto_start_table_id");
		this.setXmlMetaByVal("event_auto_start_table_name", node, "event_auto_start_table_name");
		this.setXmlMetaByVal("event_auto_start_fk_text", node, "event_auto_start_fk_text");
		this.setXmlMetaByVal("event_auto_start_fk_id", node, "event_auto_start_fk_id");
		this.setXmlMetaByVal("event_auto_start_user_text", node, "event_auto_start_user_text");
		this.setXmlMetaByVal("event_auto_start_user_id", node, "event_auto_start_user_id");
		this.setXmlMetaByVal("event_auto_start_flow_text", node, "event_auto_start_flow_text");
		this.setXmlMetaByVal("event_auto_start_flow_id", node, "event_auto_start_flow_id");
	}

	this.setXmlMetaByCheck("event_auto_deleteSubProcess", node, "event_auto_deleteSubProcess");

	this.setXmlMetaByCheck("task_zi_ding_yi_jian", node, "task_zi_ding_yi_jian");

	if($("#" + this.id).find("input[name='task_zi_ding_yi_jian']").is(":checked")){
		var ideasBySelf = flowUtils.createElement("ideasBySelf");
		$("#" + this.id).find("#table_task_zi_ding_yi_jian tbody tr").each(function (i, n) {
			var content = $(n).find("td").eq(0).text();
			var outcome = $(n).find("td").eq("1").find("input").val();
			var outcome_name = $(n).find("td").eq("1").text();
			var sub = flowUtils.createElement("sub");
			sub.appendChild(flowUtils.createTextNode("<![CDATA[" + $.trim(content) + "]]>"));
			sub.setAttribute('outcome', $.trim(outcome));
			sub.setAttribute('outcome_name', $.trim(outcome_name));
			ideasBySelf.appendChild(sub);
		});
		if(ideasBySelf.children.length > 0){
			node.appendChild(ideasBySelf);
		}
	}

	if($("#" + this.id).find("input[name='event_auto_deleteSubProcess']").is(":checked")){
		var eventListener = flowUtils.createElement('event-listener');
		eventListener.setAttribute('name', "再次启动时删除子流程");
		eventListener.setAttribute('class', "avicit.platform6.bpm.bpmreform.event.AutoDeleteSubProcess");
		eventListener.setAttribute('display', "no");
		var endListenerList = $(node).children("on[event='start']");
		if(endListenerList.length == 0){
			var conditionEndNode =   flowUtils.createElement('on');
			conditionEndNode.setAttribute('event', 'start');
			conditionEndNode.appendChild(eventListener)
			node.appendChild(conditionEndNode);
		}else{
			endListenerList.append(eventListener);
		}
	}

	//表单复制
	if(true) {
		var eventListener2 = flowUtils.createElement('event-listener');
		eventListener2.setAttribute('name', "表单复制");
		eventListener2.setAttribute('class', "avicit.platform6.bpm.bpmreform.event.AutoCopyFormData");
		eventListener2.setAttribute('display', "no");
		var endListenerList2 = $(node).children("on[event='end']");
		if (endListenerList2.length == 0) {
			var conditionEndNode2 = flowUtils.createElement('on');
			conditionEndNode2.setAttribute('event', 'end');
			conditionEndNode2.appendChild(eventListener2)
			node.appendChild(conditionEndNode2);
		} else {
			endListenerList2.append(eventListener2);
		}
	}

	/**
	 * 流程数据同步
	 */
	if(flowUtils.notNull(_processDataSynJs)){
		this.saveDataSynToXml(node);
	}
};

MyTask.prototype.createFormSaveXml = function (type, name, docRights, rootNode) {
	var _self = this;
	if($("#" + _self.id).find("input[name='"+type+"']").prop('checked')) {
		var docRight = flowUtils.createElement("docRight");
		docRight.setAttribute("type", type);
		docRight.setAttribute("name", name);
		// 子节点
		if(type == "wordEdit") {
			var wordRevisions = $("#" + _self.id).find("input[type='checkbox'][name='wordRevisions']");
			if(wordRevisions.prop('checked')) {
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", "wordRevisions");
				subDocRight.setAttribute("name", "编辑时留痕");
				subDocRight.setAttribute("value", "wordRevisions");
				docRight.appendChild(subDocRight);
			}
			var wordShowRevisions = $("#" + _self.id).find("input[type='checkbox'][name='wordShowRevisions']");
			if(wordShowRevisions.prop('checked')) {
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", "wordShowRevisions");
				subDocRight.setAttribute("name", "显示留痕");
				subDocRight.setAttribute("value", "wordShowRevisions");
				docRight.appendChild(subDocRight);
			}
		}
		if(type == "wordRead") {
			var read1 = $("#" + _self.id).find("input[type='checkbox'][name='read1']");
			if(read1.prop('checked')) {
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", "read1");
				subDocRight.setAttribute("name", "显示清稿");
				subDocRight.setAttribute("value", "read1");
				docRight.appendChild(subDocRight);
			}
			var read2 = $("#" + _self.id).find("input[type='checkbox'][name='read2']");
			if(read2.prop('checked')) {
				var subDocRight = flowUtils.createElement("subDocRight");
				subDocRight.setAttribute("type", "read2");
				subDocRight.setAttribute("name", "显示清稿");
				subDocRight.setAttribute("value", "read2");
				docRight.appendChild(subDocRight);
			}
		}

		if(type == "wordCreate" || type == "wordRedTemplet") {
			var data = $("#" + _self.id).find("input[name='taskFormValue"+(type.toString()[0].toUpperCase() + type.toString().slice(1))+"']");
			var show = $("#" + _self.id).find("input[name='taskFormText"+(type.toString()[0].toUpperCase() + type.toString().slice(1))+"']");
			var subDocRight = flowUtils.createElement("subDocRight");
			subDocRight.setAttribute("type", type == "wordCreate" ? "wordTemplates":"wordRedTemplates");
			subDocRight.setAttribute("name", show.val());
			subDocRight.setAttribute("value", data.val());
			docRight.appendChild(subDocRight);
		}

		// 勾选了打印正文
		if(type == "wordPrint") {
			// 找到所有人员信息
			$("#" + _self.id).find("input[name^='taskFormValuewordSecret']").each(function(){
				var id = $(this).attr("id");
				var ownerId = $(this).attr("actorsid");
				var value = $(this).val();
				if(value) {
					_self.createUserSelectXml(ownerId, value, rootNode);
					var subDocRight = flowUtils.createElement("subDocRight");
					subDocRight.setAttribute("type", id.slice("taskFormValue".length));
					subDocRight.setAttribute("name", $(this).parent().parent().parent().find("label").text());
					subDocRight.setAttribute("value", ownerId);
					docRight.appendChild(subDocRight);
				}
			});
		}
		if(type == "wordValue") {
			//  阈值同步
			var data = $("#" + _self.id).find("input[name='taskFormValueWordValue']");
			var show = $("#" + _self.id).find("input[name='taskFormTextWordValue']");
			var subDocRight = flowUtils.createElement("subDocRight");
			subDocRight.setAttribute("type", "wordFieldName");
			subDocRight.setAttribute("name", show.val());
			subDocRight.setAttribute("value", data.val());
			docRight.appendChild(subDocRight);
		}
		docRights.appendChild(docRight);
	}
}

/**
 * 自动选人、显示选人框只能勾选一个
 * obj 当前勾选的选择框
 */
MyTask.prototype.toggleAutoSelectUserOrShowBoxEvent = function(obj) {
	var _self = this;
	var showBox = $("#"+_self.id).find("input[name='show-selection-box']");
	var selectUser = $("#"+_self.id).find("input[name='person-automatic-selection']");
	if(obj.attr("name") == "person-automatic-selection"){
		selectUser.prop("checked") ? "" : showBox.prop("checked",true)
	} else {
		showBox.prop("checked") ? "" : selectUser.prop("checked",true);
	}
}
/**
 * 组织结构树展开到部门、组织结构树默认展开只能勾选一个
 * @param obj
 */
MyTask.prototype.toggleOrgTreeOpenToDeptOrorgTreeDefaultOpen = function(obj) {
	var _self = this;
	var orgTreeDefaultOpen = $("#"+_self.id).find("input[name='orgTreeDefaultOpen']");
	var orgTreeOpenToDept = $("#"+_self.id).find("input[name='orgTreeOpenToDept']");
	if(obj.attr("name") == "orgTreeDefaultOpen"){
		if(orgTreeDefaultOpen.prop("checked")){
			orgTreeOpenToDept.prop("checked",false)
		}
	} else {
		if(orgTreeOpenToDept.prop("checked")){
			orgTreeDefaultOpen.prop("checked",false)
		}
	}
}

MyTask.prototype.initEvent = function() {
	var _self = this;
	//配置待办标题
	$("#"+this.id+" #formName_biaoTi").click(function(){
		_self.configTaskTitle();
	});
	// 人工节点 候选人事件
	 $("#"+this.id+" button[name=btn-add-candidate]").on("click",function(){
		 var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
         var option = {type:'userSelect',
			 userSelectContainer :'draft-candidate-container' ,
			 dataField:'draft-candidate-data-field',
			 textField:'draft-candidate-text-field',
			 topId:_self.id,
			 processId:process.id,
		 	callback:function(data){
         	//console.log("-----------");
         	//console.log(data);
         	//console.log("=============");
		 }};
         _self.candidateSelect = new UserSelect(option);
     });

	 $("#"+this.id+" select[name='select-human-task-process-mode']").on("change", function() {
         var selected = $(this).val();
         if (selected == 4) {
             $(this).parent().parent().next().removeClass("hidden");
         } else {
             $(this).parent().parent().next().addClass("hidden");
         }
     });

	 $("#"+this.id+" input[type='radio'][name='input-radio-human-task-select-task']").on("click", function() {
         var index = $(this).parent().parent().index();
         var $target = $(this).parent().parent().parent().next().children().eq(index);
         $target.removeClass("hidden").siblings().addClass("hidden");
     });

	 $("#"+this.id+" input[type='checkbox'][name='person-automatic-selection'],input[type='checkbox'][name='show-selection-box']").on("change", function() {
		_self.toggleAutoSelectUserOrShowBoxEvent($(this));
	 });

	$("#"+this.id+" input[type='checkbox'][name='orgTreeDefaultOpen'],input[type='checkbox'][name='orgTreeOpenToDept']").on("change", function() {
		_self.toggleOrgTreeOpenToDeptOrorgTreeDefaultOpen($(this));
	});

	 $("#"+this.id+" input[type='checkbox'][name='mi_ji_kong_zhi']").on("click",function() {
		 $(this).is(":checked")? $("#"+_self.id).find("div[name='mi_ji_bian_liang_show']").removeClass("hidden"):
			 $("#"+_self.id).find("div[name='mi_ji_bian_liang_show']").addClass("hidden");
	 });

	 $("#"+_self.id +" div[class^='div-auth-checkbox'] input[type='checkbox']").on("click",function() {
		  var selfCheckbox = this;
		  if(selfCheckbox.checked) {
			 var $divAuth =  $(selfCheckbox).parentsUntil(".form-group").parent().siblings("div[class^='div-auth-box']");
			 $divAuth.removeClass("hidden");
			 var divAuthClassName = $divAuth.attr("class");
			 // 存在操作人选择
			 if($divAuth.find("input[name='operator-data-field']").get(0)) {
				 // 增加按钮事件
				 $divAuth.find("button[name='button-auth-operator']").off("click").on("click",function() {
                     var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
					 var option = {processId:process.id,type:'userSelect', userSelectContainer :divAuthClassName ,dataField:'operator-data-field',textField:'operator-text-field',topId:_self.id};
					 new UserSelect(option);
				 });
			 }
			 if($divAuth.find("input[name='candidate-data-field']").get(0)) {
				 // 增加按钮事件
				 $divAuth.find("button[name='button-auth-candidate']").off("click").on("click",function() {
                     var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
					 var option = {processId:process.id,type:'userSelect', userSelectContainer :divAuthClassName ,dataField:'candidate-data-field',textField:'candidate-text-field',topId:_self.id};
					 new UserSelect(option);
				 });
			 }
			 if($divAuth.find("input[name='preprocess-data-field']").get(0)) {
				 // 预处理按钮事件
				 $divAuth.find("button[name='button-auth-preprocess']").off("click").on("click",function() {
					 layer.open({
                   	    type:  2,
                   	    area: [ "400px",  "350px"],
                   	    title: "函数输入框",
                   	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
                   	    shade:   0.3,
                           maxmin: false, //开启最大化最小化按钮
                   	    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/AuthProcessTpl/authProcessTpl.jsp?id="+_self.id+"&name=preprocess-data-field&className="+divAuthClassName,
                   	});
				 });
			 }
			 if($divAuth.find("input[name='postprocess-data-field']").get(0)) {
				 // 预处理按钮事件
				 $divAuth.find("button[name='button-auth-postprocess']").off("click").on("click",function() {
					 layer.open({
						 type:  2,
						 area: [ "400px",  "350px"],
						 title: "函数输入框",
						 skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
						 shade:   0.3,
						 maxmin: false, //开启最大化最小化按钮
						 content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/AuthProcessTpl/authProcessTpl.jsp?id="+_self.id+"&name=postprocess-data-field&className="+divAuthClassName,
					 });
				 });
			 }
			 if($divAuth.find("input[name='input_kua_jie_dian_tui_hui_activity']").get(0)) {
				 $divAuth.find("button[name='button-kua_jie_dian_tui_hui_activity']").off("click").on("click",function() {
					 layer.open({
						    type:  1,
						    area: [ "800px",  "450px"],
						    title: "节点选择",
						    content: "<table id='activityGrid'></table>",
						    btn: ['确定', '关闭'],
							 success : function(layero, index) {
								 var vArr = [];
								 var values = _self.designerEditor.myCellMap.values();
								$.each(values, function(i, n){
									if(n.tagName == "task"){
										var o = {};
										o.name = n.name;
										o.alias = n.alias;
										vArr.push(o);
									}
								});
								$("#activityGrid").jqGrid({
									datastr : JSON.stringify(vArr),
									datatype : "jsonstring",
									colModel : [{
										label : '逻辑标识',
										name : 'name',
										key : true,
										align : 'center'
									}, {
										label : '节点名称',
										name : 'alias',
										align : 'center'
									} ],
									rownumbers : true,
									altRows : true,
									styleUI : 'Bootstrap',
									autowidth : true,
									height : '100%',
									multiselect : true
								});
							},
							yes: function(index, layero){
								var nameArr = [];
								var aliasArr = [];
								var selectedRowIds = $("#activityGrid").getGridParam("selarrrow");
								if (selectedRowIds != "") {
									var len = selectedRowIds.length;
									for ( var i = 0; i < len; i++) {
										var rowData = $("#activityGrid").getRowData(selectedRowIds[i]);
										nameArr.push(rowData.name);
										aliasArr.push(rowData.alias);
									}
								} else{
									layer.msg("请选择数据");
									return;
								}

								var v = "";
								for(var i = 0; i < nameArr.length; i++){
									if(i > 0){
										v += ",";
									}
									v += aliasArr[i] + "【" + nameArr[i] + "】";
								}
								$("#" + _self.id + " input[name='input_kua_jie_dian_tui_hui_activity']").val(v);
								$("#" + _self.id + " input[name='input_kua_jie_dian_tui_hui_activity']").attr("title",v);
								layer.close(index);
							}
						});
				 });
			 }

		  } else {
			  var $divAuthBox = $(selfCheckbox).parentsUntil(".form-group").parent().siblings("div[class^='div-auth-box']");
			  $divAuthBox.addClass("hidden").find("input").val("");
			  var $subprocesstable =  $divAuthBox.find("#table_subprocess tbody");
			  $subprocesstable.empty();
		  }
	  });

	 // 节点表单配置
	 $("#"+_self.id +" input[type='checkbox'][name='formSave']").on("click",function() {
		 var selfCheckbox = this;
		 if(selfCheckbox.checked) {
			$("#" + _self.id).find(".basic-form-save-area").removeClass("hidden");
			_self.syncFormAttrs();
		 } else {
			 $("#" + _self.id).find(".basic-form-save-area").addClass("hidden");
			 $("#" + _self.id).find(".basic-form-save-area input[type='checkbox']").prop("checked",false);
			 $("#" + _self.id).find("table[name='table-attr-auth'] tbody>tr").remove();
			 $("#" + _self.id).find("table[name='table-attachment-auth'] tbody>tr").remove();
		 }
		// 如果勾选了保存保单，则将节点置data-type为task
		$('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type", "task");
	 });

	// 节点表单配置
	 $("#"+_self.id +" #refreshForm").on("click",function() {
		 var selfCheckbox = $("#"+_self.id +" input[type='checkbox'][name='formSave']");
		 if(selfCheckbox.prop("checked")) {
			 _self.syncFormAttrs(true);
		 }
	 });

	 $("#"+_self.id +" input[type='checkbox'][name='formCheckAll']").on('click',function () {
         var selfCheckbox = this;
         if(selfCheckbox.checked) {
             $("#"+_self.id +" table[name='table-attr-auth']").find("input[name=isModified]").prop("checked",true);
         } else {
             $("#"+_self.id +" table[name='table-attr-auth']").find("input[name=isModified]").prop("checked",false);
         }
     });

	 $("#"+_self.id +" input[type='checkbox'][name='formAccessibilityCheckAll']").on('click',function () {
         var selfCheckbox = this;
         if(selfCheckbox.checked) {
             $("#"+_self.id +" table[name='table-attr-auth']").find("input[name=accessibility]").prop("checked",true);
         } else {
             $("#"+_self.id +" table[name='table-attr-auth']").find("input[name=accessibility]").prop("checked",false);
         }
     });

	 $("#"+_self.id +" input[type='checkbox'][name='formRequiredCheckAll']").on('click',function () {
         var selfCheckbox = this;
         if(selfCheckbox.checked) {
             $("#"+_self.id +" table[name='table-attr-auth']").find("input[name=required]").prop("checked",true);
         } else {
             $("#"+_self.id +" table[name='table-attr-auth']").find("input[name=required]").prop("checked",false);
         }
     });

	 $("#"+_self.id +" input[type='checkbox'][name='formAttachmentAddCheckAll']").on('click',function () {
         var selfCheckbox = this;
         if(selfCheckbox.checked) {
             $("#"+_self.id +" table[name='table-attachment-auth']").find("input[name=isModified]").prop("checked",true);
         } else {
             $("#"+_self.id +" table[name='table-attachment-auth']").find("input[name=isModified]").prop("checked",false);
         }
     });

	 $("#"+_self.id +" input[type='checkbox'][name='formAttachmentRequiredCheckAll']").on('click',function () {
         var selfCheckbox = this;
         if(selfCheckbox.checked) {
             $("#"+_self.id +" table[name='table-attachment-auth']").find("input[name=required]").prop("checked",true);
         } else {
             $("#"+_self.id +" table[name='table-attachment-auth']").find("input[name=required]").prop("checked",false);
         }
     });

	 $("#"+_self.id +" input[type='checkbox'][name='formAttachmentModifySecretLevelCheckAll']").on('click',function () {
         var selfCheckbox = this;
         if(selfCheckbox.checked) {
             $("#"+_self.id +" table[name='table-attachment-auth']").find("input[name=modifySecretLevel]").prop("checked",true);
         } else {
             $("#"+_self.id +" table[name='table-attachment-auth']").find("input[name=modifySecretLevel]").prop("checked",false);
         }
     });

	// 切换表单配置项的时候，如果选择非平台表单，则清空所选内容
	 $("#" + this.id + " input[name='input-radio-platform-form']").on("click",function() {
		 var selfRadio = this;
		 if(selfRadio.value == "url") {
		    // flowUtils.warning("功能开发中");
			 $("#" + _self.id).find(".div-formSave-area").addClass("hidden");
			 $("#" + _self.id).find(".basic-form-save-area").addClass("hidden");
			 $("#" + _self.id).find("input[type='checkbox']").prop("checked",false);
			 $("#" + _self.id).find("table[name='table-attr-auth'] tbody>tr").remove();

			 // 将表单重置为全局
			 $('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type","global");
			 var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
			 var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
			 var globalformname = $.trim($('#' + process.id).find('#formName').val());
			 _self.syncTaskForm(globalformid, globalformname);
		 }  else {
			 $("#" + _self.id).find(".div-formSave-area").removeClass("hidden");
		 }

	 });


	 //	 正文相关权限
	 $("#"+_self.id+" div[name^='div-word']").find("input[type='checkbox']").on("click", function(){
 		var checkbox = this;
 		var checkboxName = $(checkbox).attr("name");
 		var container = $("#"+_self.id+" div[name='container-"+checkboxName+"']");
 		if(checkbox.checked) {
 			if(container.hasClass("hidden")) {
 				container.removeClass("hidden");
 			}
 		} else {
 			container.addClass("hidden");
 			// 清空选择表单
 			container.find("input").val("");
 			container.find("input[type='checkbox']").prop("checked",false);
 		}
 	});

	 // 创建正文
	 $("#"+_self.id+" button[name='btnTaskFormWordCreate']").on("click", function(){
		 new FormAuth({dataDomId:_self.id+" #taskFormValueWordCreate",showDomId:_self.id+" #taskFormTextWordCreate", callback:"",type:"wordCreate"});
	 });
	 //	 套红功能
	 $("#"+_self.id+" button[name='btnTaskFormWordRedTemplet']").on("click", function(){
		 new FormAuth({dataDomId:_self.id+" #taskFormValueWordRedTemplet",showDomId:_self.id+" #taskFormTextWordRedTemplet", callback:"",type:"redTemplate"});
	 });

//	 域值同步
	 $("#"+_self.id+" button[name='btnTaskFormWordValue']").on("click", function(){
		 var process = null;
		 var values = _self.designerEditor.myCellMap.values();
			$.each(values, function(i, n){
				if(n.tagName == "process"){
					process = n;
				}
		 });
		 new ProcessVariable({dataDomId:_self.id+" #taskFormValueWordValue",showDomId:_self.id+" #taskFormTextWordValue", callback:"",process:process});
	 });

	 // 各种打印级别选人
	 $("#"+_self.id).find("button[name^='btnTaskFormwordSecret']").off("click").on("click",function() {
		 var containerDiv = "";
         var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
		 var dataField = $(this).parent().siblings("div").find("input[name^='taskFormValuewordSecret']").attr("name");
		 var textField = $(this).parent().siblings("div").find("input[name^='taskFormTextwordSecret']").attr("name");
		 var option = {processId:process.id,type:'userSelect', userSelectContainer :containerDiv ,dataField:dataField,textField:textField,topId:_self.id};
		 new UserSelect(option);
	 });

	 //密级变量按钮事件
	 $("#"+_self.id+" button[name='button-mi_ji_bian_liang']").on("click", function(){
	        var process = null;
	        var values = _self.designerEditor.myCellMap.values();
	        $.each(values, function(i, n){
	            if(n.tagName == "process"){
	                process = n;
	            }
	        });
	        new ProcessVariable({dataDomId:_self.id+" #mi_ji_bian_liang",showDomId:_self.id+" #mi_ji_bian_liang", callback:function(data){
	            var d = data[0];
	            var mjblVal = "\#{"+d.name+"}";
	            $("#"+_self.id+" #mi_ji_bian_liang").val(mjblVal);
	        },process:process,
	            multiple:false});
	    });


	 //手动催办
	 $("#"+_self.id+" input[type='checkbox'][name='task_cuiban_sd']").on("click",function() {
		 if($(this).is(":checked")){
			 _self.showOrHiddenCuiban(true, true);
		 }else{
			 if(!$("#"+_self.id+" input[type='checkbox'][name='task_cuiban_zd']").is(":checked")){
				 _self.showOrHiddenCuiban(false, true);
			 }
		 }
	 });
	//自动催办
	 $("#"+_self.id+" input[type='checkbox'][name='task_cuiban_zd']").on("click",function() {
		 if($(this).is(":checked")){
			 _self.showOrHiddenCuiban(true, false);
		 }else{
			 if( $("#"+_self.id+" input[type='checkbox'][name='task_cuiban_sd']").is(":checked")){
				 _self.showOrHiddenCuiban(false, false);
				 _self.showOrHiddenCuiban(true, true);
			 }else{
				 _self.showOrHiddenCuiban(false, false);
			 }

		 }
	 });


	 //添加子流程
	 $("#"+_self.id+" button[name='addSubProcess']").on("click", function(){
	        new SubProcess({dataDomId:_self.id+" #inputValueSubFlowName",showDomId:_self.id+" #inputTextSubFlowName", callback:function(data){
	        	var $table =  $("#"+_self.id+" #table_subprocess tbody");
	        	if(data!=null && data.length>0){
	        		for(var i=0;i<data.length;i++){
	        			var obj = data[i];
	        			var $tr = $("<tr></tr>");
	        			var $td1 = $("<td></td>");
	        			$td1.append(obj.displayName);
	        			var $hidden1 = $("<input type='hidden' id='subflowid_"+obj.id+"' value='"+obj.id+"'/>");
	        			var $hidden_name = $("<input type='hidden' id='subflowname_"+obj.id+"' value='"+obj.displayName+"'/>");
	        			var $hidden_key = $("<input type='hidden' id='subflowkey_"+obj.id+"' value='"+obj.key+"'/>");
	        			$td1.append($hidden1);
	        			$td1.append($hidden_name);
	        			$td1.append($hidden_key);

	        			var op = "<td><a href='javascript:void(0)' name='deleteData'><i class='iconfont icon-delete'></i></a>" +
	        			   "<a href='javascript:void(0)' name='modifyData' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
        			   var $td2 = $(op);
        			   $td2.find("a[name='deleteData']").off("click").on("click",function() {
        				   $(this).parent().parent().siblings("div").remove();
        			  	 $(this).parent().parent().remove();
        			   });
        			   $td2.find("a[name='modifyData']").off("click").on("click",function() {
        				   var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
        					var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
        			        var subProcessKey = obj.key;
        			        var subProcessId = obj.id;
        			        if(!flowUtils.notNull(subProcessId) && !flowUtils.notNull(subProcessKey)){
        			        	layer.msg("您还没选择子流程");
        			        	return false;
        			        }

        			        new FormFieldParameter({id:_self.id,dataDomId1:_self.id+" #formInData_"+obj.id,dataDomId2:_self.id+" #formOutData_"+obj.id,callback:function(data){

        			        },process:process,mainProcessFormId:globalformid,
        			        subProcessKey:subProcessKey,hiddenVarParameter:'1'});
        			   });
	        			var $hidden2 = $("<input type='hidden' id='formInData_"+obj.id+"'/>");
	        			var $hidden3 = $("<input type='hidden' id='formOutData_"+obj.id+"'/>");
	        			$td2.append($hidden2);
	        			$td2.append($hidden3);

	        			$tr.append($td1).append($td2);
	        			$table.append($tr);
	        		}
	        	}
	        }, multiple:false, dataDomId2:_self.id+" #inputValueSubFlowId"});
	  });

	 if(flowUtils.notNull(_processDataSynJs)){
		 var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
		 var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
		 var processDataSynchronization = new ProcessDataSynchronization({id:_self.id,dataDomId:_self.id+" #shujutongbu",callback:function(data){
			 },process:process,task:_self,formId:globalformid,tableId:"table-shujutongbu-value"});

		 $("#"+_self.id+" button[name='btn-shujutongbu-add']").on("click", function(){
			 var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
			 processDataSynchronization.formId = globalformid;
			 processDataSynchronization.add();
		 });
		 $("#"+_self.id+" button[name='btn-shujutongbu-viewLog']").on("click", function(){
			 var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
			 processDataSynchronization.formId = globalformid;
			 processDataSynchronization.viewLog();
		 });

	 }
	$("#"+_self.id+" button[name='btn-fieldRelationControlConfig']").on("click", function(){
		var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
		var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
		new FieldRelationControl({id:_self.id,dataDomId:_self.id+" #fieldRelationControlConfigValue",callback:function(data){

			},process:process,formId:globalformid,tableId:"table-field-relation-control"});
	});


};

MyTask.prototype.syncFormAttrTr = function(tag, tagName, isModified,accessibility,elementType,required) {
	 var html = " <tr>" +
		' <td title="'+ tagName + '('+tag+')">'+tagName+'('+tag+')</td>' +
		'  <td>' +
		'   <input type="hidden" name="tag" value="'+tag+'"/>' +
		'    <input type="hidden" name="tagName" value="'+tagName+'"/>' +
         '    <input type="hidden" name="elementType" value="'+elementType+'"/>' +
		'    <input type="checkbox" name="isModified" '+(isModified?'checked':'')+'/>' +
		'  </td>' +
		'  <td>' +
		'    <input type="checkbox" name="accessibility" '+(accessibility?'checked':'')+'/>' +
		'  </td>' +
		'  <td>' +
		'    <input type="checkbox" name="required" '+(required?'checked':'')+'/>' +
		'  </td>' +
		'  </tr>';
	 return html;
}

MyTask.prototype.syncSubFormButtonAttrTr = function(tag, tagName, isModified,accessibility,elementType,required) {
	 var html = " <tr>" +
		' <td title="'+ tagName + '('+tag+')">'+tagName+'('+tag+')</td>' +
		'  <td>' +
		'   <input type="hidden" name="tag" value="'+tag+'"/>' +
		'    <input type="hidden" name="tagName" value="'+tagName+'"/>' +
        '    <input type="hidden" name="elementType" value="'+elementType+'"/>' +
		'  </td>' +
		'  <td>' +
		'    <input type="checkbox" name="accessibility" '+(accessibility?'checked':'')+'/>' +
		'  </td>' +
		'  <td>' +
		'  </td>' +
		'  </tr>';
	 return html;
}

MyTask.prototype.syncFormAttachmentAttrTr = function(tag, tagName, isModified,elementType,required,modifySecretLevel) {
	 var html = " <tr>" +
		' <td title="'+ tagName + '('+tag+')">'+tagName+'('+tag+')</td>' +
		'  <td>' +
		'   <input type="hidden" name="tag" value="'+tag+'"/>' +
		'    <input type="hidden" name="tagName" value="'+tagName+'"/>' +
        '    <input type="hidden" name="elementType" value="'+elementType+'"/>' +
		'    <input type="checkbox" name="isModified" '+(isModified?'checked':'')+'/>' +
		'  </td>' +
		'  <td>' +
		'    <input type="checkbox" name="required" '+(required?'checked':'')+'/>' +
		'  </td>' +
		'  <td>' +
		'    <input type="checkbox" name="modifySecretLevel" '+(modifySecretLevel?'checked':'')+'/>' +
		'  </td>' +
		'  </tr>';
	 return html;
}

MyTask.prototype.syncFormAttrs = function(refresh) {
	 var _self = this;
/*	 var html = " <tr>" +
	' <td>aaaaaa(字段名称)</td>' +
	'  <td>' +
	'   <input type="hidden" name="tag" value="tag123"/>' +
	'    <input type="hidden" name="tagName" value="属性名称"/>' +
	'    <input type="checkbox" name="isModified"/>' +
	'  </td>' +
	'  </tr>';*/
	//var modifiedData = {};
	//var accessibilityData = {};
	//var requiredData = {};
	var formElementData = [];
	var attachmentData = [];
	if(refresh){
		$("#" + _self.id).find("table[name='table-attr-auth'] tbody>tr").each(function(i, n){
			var tag = $(n).find("input[name='tag']").val();
			var isModified = $(n).find("input[name='isModified']").prop("checked");
			var accessibility = $(n).find("input[name='accessibility']").prop("checked");
			var required = $(n).find("input[name='required']").prop("checked");
			var formElement = {};
            formElement.tag = tag;
            formElement.isModified = isModified;
            formElement.accessibility = accessibility;
            formElement.required = required;
            formElementData.push(formElement);
			//eval("modifiedData." + tag + " = isModified");
			//eval("accessibilityData." + tag + " = accessibility");
			//eval("requiredData." + tag + " = required");
		});
		$("#" + _self.id).find("table[name='table-attr-auth'] tbody>tr").remove();

		$("#" + _self.id).find("table[name='table-attachment-auth'] tbody>tr").each(function(i, n){
			var tag = $(n).find("input[name='tag']").val();
			var isModified = $(n).find("input[name='isModified']").prop("checked");
			var required = $(n).find("input[name='required']").prop("checked");
			var modifySecretLevel = $(n).find("input[name='modifySecretLevel']").prop("checked");
			var attachment = {};
			attachment.tag = tag;
			attachment.isModified = isModified;
			attachment.required = required;
			attachment.modifySecretLevel = modifySecretLevel;
			attachmentData.push(attachment);
			//eval("attachmentModifiedData." + tag + " = isModified");
			//eval("attachmentRequiredData." + tag + " = required");
		});
		$("#" + _self.id).find("table[name='table-attachment-auth'] tbody>tr").remove();
	}
	 var formid =  $('#' + _self.id).find('#task_guan_lian_biao_dan').val();
	 $.ajax({
			type : "POST",
			url : "platform/bpm/designer/getFormElement",
			data : {
				id :  formid,
				/*modifiedData : JSON.stringify(modifiedData),
				accessibilityData : JSON.stringify(accessibilityData),
				requiredData : JSON.stringify(requiredData),*/
                formElementData : JSON.stringify(formElementData),
				attachmentData : JSON.stringify(attachmentData)
			},
			dataType : "json",
			success : function(result) {
				var datas = result.result;
				if(datas) {
					$.each(datas, function(i,v){
						if(v.elementType=='eform_mutiattach_auth'){
							$("#" + _self.id).find("table[name='table-attachment-auth'] tbody").append(_self.syncFormAttachmentAttrTr(v.tag,v.tagName,v.operability,v.elementType,v.required,v.modifySecretLevel));
						}else if(v.elementType=='eform_subtable_bpm_button_auth'){
							$("#" + _self.id).find("table[name='table-attr-auth'] tbody").append(_self.syncSubFormButtonAttrTr(v.tag,v.tagName,v.operability,v.accessibility,v.elementType,v.required));
						}else{
							$("#" + _self.id).find("table[name='table-attr-auth'] tbody").append(_self.syncFormAttrTr(v.tag,v.tagName,v.operability,v.accessibility,v.elementType,v.required));
						}
					})
				} else {
					flowUtils.error( result.error);
				}
			}
	});
}

MyTask.prototype.syncTaskForm = function (globalformid, globalformname) {
		var _self = this;
		// 先取全局表单
		// 更新所有人工节点中表单data-type=global的表单
		var dataType = $('#' + _self.id).find("input[name='task_guan_lian_biao_dan']").attr("data-type");
		if (dataType == "global" || dataType == undefined || dataType == "") {
			$('#' + _self.id).find('#task_guan_lian_biao_dan').val(globalformid);
			$('#' + _self.id).find('#task_guan_lian_biao_dan').attr("data-type","global");
			$('#' + _self.id).find('#task_formName').val(globalformname);
		}
}

MyTask.prototype.showOrHiddenCuiban = function(isShow,isSdcb){
	var _self = this;
	if(isShow){
		if(isSdcb){
			$("#" + _self.id).find("#task_cuiban_txfs_div").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div1").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div2").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_sxl_div").removeClass("hidden");
		}else{
			$("#" + _self.id).find("#task_cuiban_txfs_div").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div1").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div2").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_sxl_div").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_blqx_div").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_cbcs_div").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_jgsx_div").removeClass("hidden");
			$("#" + _self.id).find("#task_cuiban_cbpl_div").removeClass("hidden");
		}
	}else{
		if(isSdcb){
			$("#" + _self.id).find("#task_cuiban_txfs_div").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div1").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div2").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_sxl_div").addClass("hidden");
		}else{
			$("#" + _self.id).find("#task_cuiban_txfs_div").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div1").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_txfs_div2").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_sxl_div").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_blqx_div").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_cbcs_div").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_jgsx_div").addClass("hidden");
			$("#" + _self.id).find("#task_cuiban_cbpl_div").addClass("hidden");
		}
	}
}

//配置流程待办标题
MyTask.prototype.configTaskTitle = function(){
	var _self = this;
	var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
	var processId = process.id;
	var value = $("#" + _self.id).find("#dai_ban_biao_ti").val();
	value = encodeURIComponent(value);
	layer.open({
		type: 2,
        title: '配置【待办标题】',
        skin: 'index-model',
        area: ['400px', '350px'],
        content: 'bpm/business/expr?value=' + value+'&processId='+processId,
        btn: ['确认', '取消'],
        yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;
			var value = iframeWin.getValue();
			$("#" + _self.id).find("#formName_biaoTi").val(value);
			$("#" + _self.id).find("#dai_ban_biao_ti").val(value);
			layer.close(index);
		}
    });
};


MyTask.prototype.getSubXml = function(node) {
	var _self = this;
	var sub = flowUtils.createElement("sub");

	var hasSubFlow = false;
	$("#"+_self.id+" input[id^='subflowid_']").each(function(){
		var _selfNode = this;
		hasSubFlow = true;
		var id = $(_selfNode).val();
		var name = $("#"+_self.id+" #subflowname_"+id).val();
		var key = $("#"+_self.id+" #subflowkey_"+id).val();
		var formInData = $("#"+_self.id+" #formInData_"+id).val();
		var procmodel = flowUtils.createElement("procmodel");
		procmodel.setAttribute("id", id);
		procmodel.setAttribute("name", name);
		procmodel.setAttribute("key", key);
		sub.appendChild(procmodel);
		if(flowUtils.notNull(formInData)){
			var formInArr = JSON.parse(formInData);
			if(formInArr.length){
				for(i=0;i<formInArr.length;i++){
					var data = formInArr[i];
					var arg = flowUtils.createElement("form-in");
					arg.setAttribute("formTable", data.formTable);
					arg.setAttribute("formCol", data.formCol);
					arg.setAttribute("subFormTable", data.subFormTable);
					arg.setAttribute("subFormCol", data.subFormCol);
					arg.setAttribute("colType", data.colType);
					arg.setAttribute("tableModify", data.tableModify);
					arg.setAttribute("colComments",data.colComments);
					arg.setAttribute("isOrgIdentity",data.isOrgIdentity);
					arg.setAttribute("fromComments",data.fromComments);
					arg.setAttribute("isSubTable",data.isSubTable=="1"?"1":"");
					arg.setAttribute("fromFkColName",data.fromFkColName);
					arg.setAttribute("toFkColName",data.toFkColName);
					procmodel.appendChild(arg);
				}
			}
		}

	});

	if(hasSubFlow){
		node.appendChild(sub);
	}

};


MyTask.prototype.getSubFromDom = function(node) {
	var _self = this;
	var $table =  $("#"+_self.id+" #table_subprocess tbody");
	$table.empty();
	$(node).children("sub").children("procmodel").each(function(){
		var procmodel = this;
		var id = $.trim(procmodel.getAttribute("id"));
		var name = $.trim(procmodel.getAttribute("name"));
		var key = $.trim(procmodel.getAttribute("key"));
		var dataArr = [];
		$(procmodel).children("form-in").each(function(){
			var _selfNode = this;
			var dataObj = {};
			dataObj.formTable = $.trim(_selfNode.getAttribute("formTable"));
			dataObj.formCol = $.trim(_selfNode.getAttribute("formCol"));
			dataObj.subFormTable = $.trim(_selfNode.getAttribute("subFormTable"));
			dataObj.subFormCol = $.trim(_selfNode.getAttribute("subFormCol"));
			dataObj.colType = $.trim(_selfNode.getAttribute("colType"));
			dataObj.tableModify = $.trim(_selfNode.getAttribute("tableModify"));
			dataObj.colComments = $.trim(_selfNode.getAttribute("colComments"));
			dataObj.isOrgIdentity = $.trim(_selfNode.getAttribute("isOrgIdentity"));
			dataObj.fromComments = $.trim(_selfNode.getAttribute("fromComments"));
			dataObj.isSubTable = $.trim(_selfNode.getAttribute("isSubTable"));
			dataObj.fromFkColName = $.trim(_selfNode.getAttribute("fromFkColName"));
			dataObj.toFkColName = $.trim(_selfNode.getAttribute("toFkColName"));
			dataArr.push(dataObj);
		});
		var formInDataStr = JSON.stringify(dataArr);
		var $tr = $("<tr></tr>");
		var $td1 = $("<td></td>");
		$td1.append(name);
		var $hidden1 = $("<input type='hidden' id='subflowid_"+id+"' value='"+id+"'/>");
		var $hidden_name = $("<input type='hidden' id='subflowname_"+id+"' value='"+name+"'/>");
		var $hidden_key = $("<input type='hidden' id='subflowkey_"+id+"' value='"+key+"'/>");
		$td1.append($hidden1);
		$td1.append($hidden_name);
		$td1.append($hidden_key);

		var op = "<td><a href='javascript:void(0)' name='deleteData'><i class='iconfont icon-delete'></i></a>" +
		   "<a href='javascript:void(0)' name='modifyData' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
	   var $td2 = $(op);
	   $td2.find("a[name='deleteData']").off("click").on("click",function() {
		   $(this).parent().parent().siblings("div").remove();
	  	 $(this).parent().parent().remove();
	   });
	   $td2.find("a[name='modifyData']").off("click").on("click",function() {
		   var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
			var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
	        var subProcessKey = key;
	        var subProcessId = id;
	        if(!flowUtils.notNull(subProcessId) && !flowUtils.notNull(subProcessKey)){
	        	layer.msg("您还没选择子流程");
	        	return false;
	        }

	        new FormFieldParameter({id:_self.id,dataDomId1:_self.id+" #formInData_"+id,dataDomId2:_self.id+" #formOutData_"+id,callback:function(data){

	        },process:process,mainProcessFormId:globalformid,
	        subProcessKey:subProcessKey,hiddenVarParameter:'1'});
	   });
		var $hidden2 = $("<input type='hidden' id='formInData_"+id+"' value='"+formInDataStr+"'/>");
		$td2.append($hidden2);

		$tr.append($td1).append($td2);
		$table.append($tr);

	});
};

/**
 * 保存流程数据同步信息到xml
 * @param node
 */
MyTask.prototype.saveDataSynToXml = function(node){
	var _self = this;
	var _tr = $("#"+_self.id+" #table-shujutongbu-value tbody").find("tr");
	if(_tr && _tr.length){
		var dataSyns = flowUtils.createElement('dataSyns');
		_tr.each(function(){
			var dataSyn = flowUtils.createElement('dataSyn');
			var data = $(this).find("td").eq(0).find("input").val();
			dataSyn.appendChild(flowUtils.createTextNode("<![CDATA[" + data.trim() + "]]>"));
			dataSyns.appendChild(dataSyn);
		});
		node.appendChild(dataSyns);
		var endEventListener = flowUtils.createElement('event-listener');
		endEventListener.setAttribute('name', "节点完成后同步流程数据");
		var waSysDataAfterClass = getWaSysDataAfterClass();
		//endEventListener.setAttribute('class', "avicit.platform6.bpm.bpmreform.event.SynDataAfter");
		endEventListener.setAttribute('class', waSysDataAfterClass);
		endEventListener.setAttribute('display', "no");
		var endListenerList = $(node).children("on[event='end']");
		if(endListenerList.length == 0){
			var conditionEndNode =   flowUtils.createElement('on');
			conditionEndNode.setAttribute('event', 'end');
			conditionEndNode.appendChild(endEventListener)
			node.appendChild(conditionEndNode);
		}else{
			endListenerList.append(endEventListener);
		}

		var startEventListener = flowUtils.createElement('event-listener');
		startEventListener.setAttribute('name', "节点创建前同步流程数据");
		var waSynDataBeforeClass = getWaSynDataBeforeClass();
		//startEventListener.setAttribute('class', "avicit.platform6.bpm.bpmreform.event.SynDataBefore");
		startEventListener.setAttribute('class', waSynDataBeforeClass);
		startEventListener.setAttribute('display', "no");
		var startListenerList = $(node).children("on[event='start']");
		if(startListenerList.length == 0){
			var conditionEndNode =   flowUtils.createElement('on');
			conditionEndNode.setAttribute('event', 'start');
			conditionEndNode.appendChild(startEventListener)
			node.appendChild(conditionEndNode);
		}else{
			startListenerList.append(startEventListener);
		}

	}
};

/**
 * 保存流程数据同步信息到xml
 * @param node
 */
MyTask.prototype.getDataSynFromXml = function(node){
	var _self = this;
	var $table = $("#"+_self.id+" #table-shujutongbu-value tbody");
	$table.empty();
	var dataDomId = _self.id+" #shujutongbu";
	var encodeDataDomId = encodeURIComponent(dataDomId);
	var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
	var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
	var dataObject = {};
	dataObject.dataDomId = dataDomId;
	dataObject.formId = globalformid;
	dataObject.process = process;
	$("#"+dataDomId).data("data-object", dataObject);
	$(node).children("dataSyns").children("dataSyn").each(function(){
		var dataSynStr = $(this).text();
		var synObject = JSON.parse(dataSynStr);
		$table.append(_self.getDataSynTableTr(synObject,dataDomId,encodeDataDomId));
	});
};

MyTask.prototype.getDataSynTableTr = function(synObject,dataDomId,encodeDataDomId){
	var _self = this;
	var _tr = $("<tr></tr>");
	var _td1 = $("<td></td>");
	_td1.append(synObject.dbTableName);
	var _hidden = $("<input type='hidden'/>");
	_hidden.val(JSON.stringify(synObject));
	_td1.append(_hidden);
	_tr.append(_td1);
	var _td2 = $("<td></td>");
	var typeName = "";
	if(synObject.type=="0"){
		typeName = "新增";
	}else if(synObject.type=="1"){
		typeName = "修改";
	}else if(synObject.type=="2"){
		typeName = "新增或修改";
	}else if(synObject.type=="3"){
		typeName = "删除";
	}
	_td2.append(typeName);
	_tr.append(_td2);
	var op = "<td><a href='javascript:void(0)' name='deleteData'><i class='iconfont icon-delete'></i></a>" +
		"<a href='javascript:void(0)' name='modifyData' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
	var _td3 = $(op);
	_td3.find("a[name='deleteData']").off("click").on("click",function() {
		$(this).parent().parent().remove();
	});
	_td3.find("a[name='modifyData']").off("click").on("click",function() {
		var $oldTr = $(this).parentsUntil("tr").parent();
		var synObjectStr = $oldTr.find("td:eq(0)").find("input").val();
		var synObject = JSON.parse(synObjectStr);
		$("#"+dataDomId).data("synObject",synObject);
		layer.config({
			extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
		});
		layer.open({
			type:  2,
			area: [ "700px",  "600px"],
			title: "流程数据同步",
			skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
			shade:   0.3,
			maxmin: true, //开启最大化最小化按钮
			content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ProcessDataSynchronization/ProcessDataSynchronization.jsp?dataDomId="
				+encodeDataDomId+"&edit=1",
			btn: ['确定', '关闭'],
			yes: function(index, layero){
				var iframeWin = layero.find('iframe')[0].contentWindow;
				var validateResult = iframeWin.validateForm();
				if(validateResult){
					var synObject = iframeWin.getSynObject();
					$oldTr.replaceWith(_self.getDataSynTableTr(synObject,dataDomId,encodeDataDomId));
					layer.close(index);
				}
			},
			cancel: function(index){
				layer.close(index);
				$('html').addClass('fix-ie-font-face');
				setTimeout(function() {
					$('html').removeClass('fix-ie-font-face');
				}, 10);
			},
			success: function(layero, index){
			}
		});
	});
	_tr.append(_td3);
	return _tr;
};

/**
 * 获取字段关联权限配置
 * @param node
 */
MyTask.prototype.getFieldRelationAuthFromXml = function(fieldsRelationAuthJson){
	var _self = this;
	$("#" + _self.id+" #fieldRelationControlConfigValue").val(fieldsRelationAuthJson);
	var _table =  $("#"+_self.id+" #table-field-relation-control tbody");
	_table.empty();
	if(fieldsRelationAuthJson!=''){
		var fieldsRelationAuth = JSON.parse(fieldsRelationAuthJson);
		if(fieldsRelationAuth && fieldsRelationAuth.length){
			for(var i=0;i<fieldsRelationAuth.length;i++){

				var configObj = fieldsRelationAuth[i];
				var conditonValues = configObj.conditonValues;
				var conditionHtml = "";
				var conditonTitle = "";
				if(conditonValues && conditonValues.length){
					for(var j=0;j<conditonValues.length;j++){
						conditionHtml += conditonValues[j].controlTagName+" "+conditonValues[j].operName+" "+conditonValues[j].compareValueName+"<br>";
						conditonTitle += conditonValues[j].controlTagName+" "+conditonValues[j].operName+" "+conditonValues[j].compareValueName+"\n";
					}
				}
				var _tr = $("<tr></tr>");
				var _td1 = $("<td></td>");
				_td1.append(conditionHtml);
				_td1.attr("title",conditonTitle);
				_tr.append(_td1);
				var _td2 = $("<td></td>");
				var beControledFields = configObj.beControledFields;
				var beControledFieldsHtml = "";
				var beControledFieldsTitle = "";
				if(beControledFields && beControledFields.length){
					for(var m=0;m<beControledFields.length;m++){
						beControledFieldsHtml+=beControledFields[m].tagName;
						if(beControledFields[m].accessibility == "1"){
							beControledFieldsHtml+=" 可显示";
							beControledFieldsTitle+=" 可显示";
						}else{
							beControledFieldsHtml+=" 隐藏";
							beControledFieldsTitle+=" 隐藏";
						}
						if(beControledFields[m].hideRow == "1"){
							beControledFieldsHtml+=" 隐藏行";
							beControledFieldsTitle+=" 隐藏行";
						}else{
							beControledFieldsHtml+=" 不隐藏行";
							beControledFieldsTitle+=" 不隐藏行";
						}
						if(beControledFields[m].operability == "1"){
							beControledFieldsHtml+=" 可编辑";
							beControledFieldsTitle+=" 可编辑";
						}else{
							beControledFieldsHtml+=" 不可编辑";
							beControledFieldsTitle+=" 不可编辑";
						}
						if(beControledFields[m].required == "1"){
							beControledFieldsHtml+=" 必填";
							beControledFieldsTitle+=" 必填";
						}else{
							beControledFieldsHtml+=" 非必填";
							beControledFieldsTitle+=" 非必填";
						}
						beControledFieldsHtml+="<br>";
						beControledFieldsTitle+="\n";
					}
				}
				_td2.append(beControledFieldsHtml);
				_td2.attr("title",beControledFieldsTitle);
				_tr.append(_td1);
				_tr.append(_td2);
				_table.append(_tr);
			}
		}
	}
}
