/**
 * process extends MyBase
 */
function MyProcess(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "process");
	// 修改锁
	this.lock =  {
			varModifyLock : false
	};

	// 观察者模式
	// 主要观察全局变量的变化
	this.observers =  new ObserverList();
}

MyProcess.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyProcess.prototype.init = function() {
	this.initBase();
	// 配置各种监听事件
	this.initEvent();
	// 初始化文档上传对象
	this.bpmDocUploader = new BpmDocUploader({id:this.id,defineId:this.defineId,activityName:"global",uploaderId:"bpm-designer-upload"});
	//配置流程待办标题
	$("#formName_biaoTi").click(function(){
		_self.configProcessTaskTitle();
	});
	//配置实例标题
	$("#shi_li_biao_ti").click(function(){
		_self.configProcessInstanceTitle();
	});
	// 初始化节点事件
	 this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-flow-event");
	var _self = this;
	this.selectPublishBpmEform1 = new SelectPublishEform("guan_lian_biao_dan", "formName", this.id, "Y", "");
	this.selectPublishBpmEform1.init( function(data) {
		var values = _self.designerEditor.myCellMap.values();
 		$.each(values, function(i, n){
 			if(n.tagName == "task"){
 				this.syncTaskForm(data.id, data.name);
 			}
 		});
 	});
	//配置流程待办标题

	this.name = this.designerEditor.processKey;
	this.alias = _bmpsName;
	$("#" + this.id).find("#liu_cheng_ming_cheng").val(this.alias);
	$("#" + this.id).find("#liu_cheng_biao_shi").val(this.name);

	this.observers.add(this);
};

/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyProcess.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	// 配置各种监听事件
	this.initEvent();
	this.name = this.designerEditor.processKey;
	// 初始化文档上传对象
	this.bpmDocUploader = new BpmDocUploader({id:this.id,defineId:this.defineId,activityName:"global",uploaderId:"bpm-designer-upload"});
	// 流程关联表单
	var _self = this;
	this.selectPublishBpmEform1 = new SelectPublishEform("guan_lian_biao_dan", "formName", this.id, "Y", "");
	this.selectPublishBpmEform1.init( function(data) {
		var values = _self.designerEditor.myCellMap.values();
 		$.each(values, function(i, n){
 			if(n.tagName == "task"){
 				this.syncTaskForm(data.id, data.name);
 			}
 		});
 	});

	//配置流程待办标题
	$("#formName_biaoTi").click(function(){
		_self.configProcessTaskTitle();
	});
	//配置实例标题
	$("#shi_li_biao_ti").click(function(){
		_self.configProcessInstanceTitle();
	});
	// 全局属性：
	// 启动权限
	this.initStartAuthTableDom(xmlValue,"table-auth-user","users");
	this.initStartAuthTableDom(xmlValue,"table-auth-dept","depts");
	this.initStartAuthTableDom(xmlValue,"table-auth-role","roles");
	this.initStartAuthTableDom(xmlValue,"table-auth-group","groups");
	this.initStartAuthTableDom(xmlValue,"table-auth-position","positions");
   //	按钮权限
	this.createQXDom(xmlValue, "yi_jian_xiu_gai", "globalIdea");
	this.createQXDom(xmlValue, "liu_cheng_tiao_zhuan", "globalJump");
	this.createQXDom(xmlValue, "liu_cheng_zan_ting", "globalSuspend");
	this.createQXDom(xmlValue, "liu_cheng_hui_fu", "globalResume");
	this.createQXDom(xmlValue, "liu_cheng_jie_shu", "globalEnd");
	this.createQXDom(xmlValue, "guan_zhu_gong_zuo", "focus");
	this.createQXDom(xmlValue, "xiang_guan_liu_cheng", "relationprocess");
	this.createQXDom(xmlValue, "guan_lian_fu_liucheng", "relationparentprocess");

	$("#"+_self.id).find("input[_type='bpm_but_attribute']").each(function (i, n) {
		_self.createQXDom(xmlValue, $(n).attr("name"), $(n).attr("name"));
	});

	// 全局属性：事件
	 this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-flow-event");

	this.alias = $.trim(xmlValue.getAttribute("name"));
	$("#" + this.id).find("#liu_cheng_ming_cheng").val($.trim(this.alias));
	$("#" + this.id).find("#liu_cheng_biao_shi").val(this.name);
	/*其他*/
	var descriptionNode = $(xmlValue).children("description");
	if(descriptionNode.length == 0){
		this.setDomValByAttr("liu_cheng_miao_shu", xmlValue, "description");
	}else {
		$("#" + this.id).find("#liu_cheng_miao_shu").val(descriptionNode.text());
	}

	this.setDomValByAttr("shi_li_biao_ti", xmlValue, "title");
	this.setDomCheckByMeta("shi_li_biao_ti_geng_xin", xmlValue, "titleAutoUpdate");
	this.setDomValByMeta("dai_ban_biao_ti", xmlValue, "todo");
	this.setDomValByMeta("formName_biaoTi", xmlValue, "todo");
	this.setDomValByMeta("liu_cheng_shan_chu", xmlValue, "deleteEvent");

	this.setDomCheckByMeta("process_yi_dong_shen_pi", xmlValue, "processMobileApproval", "yes");

	this.setDomCheckByMeta("wen_zi_gen_zong", xmlValue, "showTrackInForm", "yes");

	this.createConditionDom("zhi_xing_fang_shi", "table-executor", xmlValue);//启动条件

	this.createFlowVariableDom("table-flow-variable", xmlValue); // 流程变量回写

	/*tab5 流程事件回写*/
	 this.nodeEvent.setEventDom(xmlValue);

	//全局表单
	var globalformid = $.trim(xmlValue.getAttribute("globalformid"));
	var globalformname = $.trim(xmlValue.getAttribute("globalformname"));
	$('#' + this.id).find('#guan_lian_biao_dan').val(globalformid);
	$('#' + this.id).find('#formName').val(globalformname);

	// 意见配置
	this.setOpinionDOM("table-process-add-opinion", xmlValue);

	/**kpi设置*/
	this.setDomValByMeta("kpi_process_reasonable_day", xmlValue, "kpiProcessReasonableDay");
	this.setDomValByMeta("kpi_process_reasonable_hour", xmlValue, "kpiProcessReasonableHour");
	this.setDomValByMeta("kpi_process_reasonable_minute", xmlValue, "kpiProcessReasonableMinute");
	this.setDomValByMeta("kpi_process_warning_day", xmlValue, "kpiProcessWarningDay");
	this.setDomValByMeta("kpi_process_warning_hour", xmlValue, "kpiProcessWarningHour");
	this.setDomValByMeta("kpi_process_warning_minute", xmlValue, "kpiProcessWarningMinute");
	this.setDomCheckByMeta("is_participate_KPI", xmlValue, "isParticipateKPI");

	this.setDomValByMeta("flow_owner_deptId", xmlValue, "flowOwnerDeptId");
	this.setDomValByMeta("flow_owner_deptName", xmlValue, "flowOwnerDeptName");
	this.setDomValByMeta("flow_owner_userId", xmlValue, "flowOwnerUserId");
	this.setDomValByMeta("flow_owner_userName", xmlValue, "flowOwnerUserName");

	this.setDomCheckByMeta("event_auto_perform", xmlValue, "event_auto_perform");

	this.observers.add(this);

};

//配置流程实例标题
MyProcess.prototype.configProcessInstanceTitle = function(){
	var _self = this;
	var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
	var processId = process.id;
	var value = $("#shi_li_biao_ti").val();
	value = encodeURIComponent(value);
	layer.open({
		type: 2,
		title: '配置【实例标题】',
		skin: 'index-model',
		area: ['400px', '350px'],
		content: 'bpm/business/expr?value=' + value+'&processId='+processId,
		btn: ['确认', '取消'],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;
			var value = iframeWin.getValue();
			$("#shi_li_biao_ti").val(value);
			layer.close(index);
		}
	});
};

//配置流程待办标题
MyProcess.prototype.configProcessTaskTitle = function(){
	var _self = this;
	var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
	var processId = process.id;
	var value = $("#dai_ban_biao_ti").val();
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
			$("#formName_biaoTi").val(value);
			$("#dai_ban_biao_ti").val(value);
			layer.close(index);
		}
    });
};
/**
 * 重写了组装processXML的方法，自定义所有信息
 *
 * @returns
 */
MyProcess.prototype.getXmlDoc = function() {
	var node = flowUtils.createElement(this.tagName);
	this.putAttr("name", this.alias, node);
	this.putAttr("key", this.name, node);

//	封装意见设置
	this.setOpinionXml("table-process-add-opinion",node);
	/* tab1 封装基本信息*/
	// 属性
	//this.setXmlAttrByVal("", node, "description"); // 流程描述
	var descriptionValue = $("#" + this.id).find("#liu_cheng_miao_shu").val();
	var descriptionNode = flowUtils.createElement("description");
	descriptionNode.appendChild(flowUtils.createTextNode(descriptionValue));
	node.appendChild(descriptionNode);

	// 实例
	this.setXmlAttrByVal("shi_li_biao_ti", node, "title");
	this.setXmlMetaByCheck("shi_li_biao_ti_geng_xin", node, "titleAutoUpdate");
	this.setXmlMetaByVal("dai_ban_biao_ti", node, "todo");
	this.setXmlMetaByVal("liu_cheng_shan_chu", node, "deleteEvent");
	this.setXmlMetaByCheck("process_yi_dong_shen_pi", node, "processMobileApproval");

	this.setXmlMetaByCheck("wen_zi_gen_zong", node, "showTrackInForm");

	/* tab2 封装启动条件 */
	this.setConditionXml("zhi_xing_fang_shi", "table-executor",  node);

	/*tab3 封装流程变量*/
	this.setFlowVariableXml("table-flow-variable", node);

	/*tab4 封装流程权限*/
	//启动权限
	var processAuth = flowUtils.createElement("processAuth");
	this.getStartAuthTableXml(processAuth, "table-auth-user","user");
	this.getStartAuthTableXml(processAuth, "table-auth-dept", "dept");
	this.getStartAuthTableXml(processAuth, "table-auth-role", "role");
	this.getStartAuthTableXml(processAuth, "table-auth-group", "group");
	this.getStartAuthTableXml(processAuth, "table-auth-position", "position");
	if(processAuth.childNodes.length > 0){
		node.appendChild(processAuth);
	}
	//按钮权限
	var magicsNode = flowUtils.createElement("magics");
	this.createQXXml(magicsNode, "yi_jian_xiu_gai", "globalIdea", "意见修改", node);
	this.createQXXml(magicsNode, "liu_cheng_tiao_zhuan", "globalJump", "流程跳转", node);
	this.createQXXml(magicsNode, "liu_cheng_zan_ting", "globalSuspend", "流程暂停", node);
	this.createQXXml(magicsNode, "liu_cheng_hui_fu", "globalResume", "流程恢复", node);
	this.createQXXml(magicsNode, "liu_cheng_jie_shu", "globalEnd", "流程结束", node);
	this.createQXXml(magicsNode, "guan_zhu_gong_zuo", "focus", "关注工作", node);
	this.createQXXml(magicsNode, "xiang_guan_liu_cheng", "relationprocess", "相关流程", node);
	this.createQXXml(magicsNode, "guan_lian_fu_liucheng", "relationparentprocess", "关联父流程", node);

	var _self = this;
	$("#"+_self.id).find("input[_type='bpm_but_attribute']").each(function (i, n) {
		_self.createQXXml(magicsNode, $(n).attr("name"), $(n).attr("name"),  $(n).attr("_name"), node);
	});

	if(magicsNode.childNodes.length > 0){
		node.appendChild(magicsNode);
	}

	/*tab5 封装流程事件*/
	 this.nodeEvent.setEventXml(node, "start");//event

	//全局表单
	this.putAttr("globalformid", $('#' + this.id).find('#guan_lian_biao_dan').val(), node);
	this.putAttr("globalformname", $('#' + this.id).find('#formName').val(), node);

	/** KPI设置*/
	this.setXmlMetaByVal("kpi_process_reasonable_day", node, "kpiProcessReasonableDay");
	this.setXmlMetaByVal("kpi_process_reasonable_hour", node, "kpiProcessReasonableHour");
	this.setXmlMetaByVal("kpi_process_reasonable_minute", node, "kpiProcessReasonableMinute");
	this.setXmlMetaByVal("kpi_process_warning_day", node, "kpiProcessWarningDay");
	this.setXmlMetaByVal("kpi_process_warning_hour", node, "kpiProcessWarningHour");
	this.setXmlMetaByVal("kpi_process_warning_minute", node, "kpiProcessWarningMinute");
	this.setXmlMetaByCheck("is_participate_KPI", node, "isParticipateKPI");

	this.setXmlMetaByVal("flow_owner_deptId", node, "flowOwnerDeptId");
	this.setXmlMetaByVal("flow_owner_deptName", node, "flowOwnerDeptName");
	this.setXmlMetaByVal("flow_owner_userId", node, "flowOwnerUserId");
	this.setXmlMetaByVal("flow_owner_userName", node, "flowOwnerUserName");

	this.setXmlMetaByCheck("event_auto_perform", node, "event_auto_perform");

	if($("#" + this.id).find("input[name='event_auto_perform']").is(":checked")){
		var eventListener = flowUtils.createElement('event-listener');
		eventListener.setAttribute('name', "结束后自动激活父流程");
		eventListener.setAttribute('class', "avicit.platform6.bpm.bpmreform.event.AutoPerformProcess");
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
	}
	return node;
};
/**
 * 重写了name监听事件，不需要其他处理
 *
 * @param value
 */
MyProcess.prototype.labelChanged = function(value) {
	this.alias = value;
};

/**** 	基本信息各种事件开始	 ****/

/**
 * 创建意见dom
 */
MyProcess.prototype.setOpinionDOM = function (tableTbodydomId, tagNodeXml) {
	var _self = this;
	var table =  $("#"+_self.id+" table[name='"+tableTbodydomId+"'] tbody");
	$(tagNodeXml).children("ideas").children("idea").each(function() {
		var opinionName =  $.trim(_self.getXmlElement(this, "opinionName"));
	    var opinionCode = $.trim(_self.getXmlElement(this, "opinionCode"));
	    var opinionOrder = $.trim(_self.getXmlElement(this, "opinionOrder"));
	    var opinionNode = $.trim(_self.getXmlElement(this, "opinionNode"));
	    var opinionNodeText = $.trim(_self.getXmlElement(this, "opinionNodeText"));
	    var positionId = $.trim(_self.getXmlElement(this, "positionId"));
	    var positionText = $.trim(_self.getXmlElement(this, "positionText"));
	    var showPositionId = $.trim(_self.getXmlElement(this, "showPositionId"));
	    var showPositionText = $.trim(_self.getXmlElement(this, "showPositionText"));
	    var eSign = $.trim(_self.getXmlElement(this, "eSign"));
	    var ideaStyle = $.trim(_self.getXmlElement(this, "ideaStyle"));
	    var opinionType = $.trim(_self.getXmlElement(this, "opinionType"));
	    var subprocessDefId = $.trim(_self.getXmlElement(this, "subprocessDefId"));
	    var subopinionCode = $.trim(_self.getXmlElement(this, "subopinionCode"));
	    var subopinionName = $.trim(_self.getXmlElement(this, "subopinionName"));
	    var showIdeaStyle = $.trim(_self.getXmlElement(this, "showIdeaStyle"));
	    table.append(_self.getOpinionTableTr(_self.id ,opinionName,
	   		 opinionCode,opinionOrder,positionId,positionText ,
	   		 showPositionText,showPositionId,eSign,ideaStyle,showIdeaStyle,opinionNode,opinionNodeText, opinionType, subprocessDefId, subopinionCode, subopinionName));
	});
};

MyProcess.prototype.setOpinionXml = function (domId, tagNodeXml) {
	var _self = this;
	var ideas = flowUtils.createElement("ideas");
	$("#"+_self.id).find("table[name='"+domId+"'] tbody tr").each(function(i){
		var jsonData = JSON.parse($(this).find("input").val());
		var idea = flowUtils.createElement("idea");
		_self.addXmlElement("opinionName", jsonData.opinionName, idea);
		_self.addXmlElement("opinionCode", jsonData.opinionCode, idea);
		_self.addXmlElement("opinionOrder", jsonData.opinionOrder, idea);
		_self.addXmlElement("opinionNode", jsonData.opinionNode, idea);
		_self.addXmlElement("opinionNodeText", jsonData.opinionNodeText, idea);
		_self.addXmlElement("positionId", jsonData.positionId, idea);
		_self.addXmlElement("positionText", jsonData.positionText, idea);
		_self.addXmlElement("showPositionId", jsonData.showPositionId, idea);
		_self.addXmlElement("showPositionText", jsonData.showPositionText, idea);
		_self.addXmlElement("eSign", jsonData.eSign, idea);
		_self.addXmlElement("ideaStyle", jsonData.ideaStyle, idea);
		_self.addXmlElement("opinionType", jsonData.opinionType, idea);
		_self.addXmlElement("subprocessDefId", jsonData.subprocessDefId, idea);
		_self.addXmlElement("subopinionCode", jsonData.subopinionCode, idea);
		_self.addXmlElement("subopinionName", jsonData.subopinionName, idea);
		_self.addXmlElement("showIdeaStyle", jsonData.showIdeaStyle, idea);
		ideas.appendChild(idea);
	});
	tagNodeXml.appendChild(ideas);
}

/**
 * 编辑意见的时候，获取意见信息
 */
MyProcess.prototype.getInitOpinion = function (pid, idx) {
	 var tr =  $("#"+pid+" table[name='table-process-add-opinion'] tbody tr").eq(idx);
	 return JSON.parse(tr.find("input").val());
}
/**
 * 获取所有意见的code
 */
MyProcess.prototype.getInitOpinionCodes = function (pid, idx) {
	var codeArr = [];
    $("#"+pid+" table[name='table-process-add-opinion'] tbody tr").each(function(i, n){
    	if(i == idx){
    		return;
		}
        var data = JSON.parse($(n).find("input").val());
        codeArr.push(data.opinionCode);
	});
    return codeArr;
}
/**
 * 保存意见
 * @param pid
 * @param $form
 */
MyProcess.prototype.addOpinion = function (pid, $form) {
	var table =  $("#"+pid+" table[name='table-process-add-opinion'] tbody")
	var opinionName =  $.trim($form.find("#opinionName").val());
    var opinionCode = $.trim($form.find("#opinionCode").val());
    var opinionOrder = $.trim($form.find("#opinionOrder").val());
    var opinionNode = $.trim($form.find("#opinionNode").val());
    var opinionNodeText = $.trim($form.find("#opinionNodeText").val());
    var positionId = $.trim($form.find("#positionId").val().replaceAll(";",","));
    var positionText = $.trim($form.find("#positionText").val().replaceAll(";",","));
    var showPositionId = $.trim($form.find("#showPositionId").val().replaceAll(";",","));
    var showPositionText = $.trim($form.find("#showPositionText").val().replaceAll(";",","));
    var eSign = $.trim($form.find("#eSign").val());
    var ideaStyle = $.trim($form.find("#ideaStyle").val());
    var opinionType = $.trim($form.find("#opinionType").val());
    var subprocessDefId = $.trim($form.find("#subprocessDefId").val());
    var subopinionCode = $.trim($form.find("#subopinionCode").val());
    var subopinionName = $.trim($form.find("#subopinionName").val());
    var showIdeaStyle = $.trim($form.find("#ideaStyle option[value='"+ideaStyle+"']").text());
    table.append(this.getOpinionTableTr(pid,opinionName,
   		 opinionCode,opinionOrder,positionId,positionText ,
   		 showPositionText,showPositionId,eSign,ideaStyle,showIdeaStyle,opinionNode,opinionNodeText, opinionType, subprocessDefId, subopinionCode, subopinionName));
}

MyProcess.prototype.getOpinionTableTr = function (pid,
   		 opinionName,
   		 opinionCode,
   		 opinionOrder,
   		 positionId,
   		 positionText ,
   		 showPositionText,
   		 showPositionId,
   		 eSign,
   		 ideaStyle,
   		 showIdeaStyle,
   		 opinionNode,
   		 opinionNodeText, opinionType, subprocessDefId, subopinionCode, subopinionName) {
	var _self = this;
	var $tr = $("<tr data-toggle='popover' data-container='body' title=''></tr>");
    // 增加一个hover
    var _dataContent = '<table width="180px" border="0" style="font-size:12px;table-layout:fixed;"  align="center">'
			+'<tr><td width="40%" height="25"><lable>名称:</lable></td><td>'+opinionName+'</td></tr>'
				+'<tr ><td width="40%" height="25">代码:</td><td>'+opinionCode+'</td></tr>'
				+'<tr><td width="40%" height="25" >排序:</td><td>'+opinionOrder+'</td></tr>'
/*				+'<tr><td width="40%" height="25" >节点:</td><td >'+opinionNodeText+'</td></tr>'
				+'<tr><td width="40%" height="25">查看岗位:</td><td>'+positionText+'</td></tr>'
				+'<tr><td width="40%" height="25">显示岗位:</td><td>'+showPositionText+'</td></tr>'*/
				+'</table>';
    $tr.attr("data-content",_dataContent);
    $tr.popover({trigger:"hover",placement:"top",html:true});
    var $td1 = $("<td></td>");
    $td1.append(opinionName);
    // 添加隐藏input
    var $input = $("<input type='hidden'/>");
    var opinion ={
   		 opinionName : opinionName,
   		 opinionCode : opinionCode,
   		 opinionOrder : opinionOrder,
   		 positionId : positionId,
   		 positionText : positionText,
   		 showPositionText : showPositionText,
   		 showPositionId : showPositionId,
   		 eSign : eSign,
   		 ideaStyle : ideaStyle,
   		opinionType : opinionType,
   		subprocessDefId : subprocessDefId,
   		subopinionCode : subopinionCode,
   		subopinionName : subopinionName,
   		showIdeaStyle : showIdeaStyle,
   		opinionNode : opinionNode,
   		opinionNodeText : opinionNodeText
    }
    $input.val(JSON.stringify(opinion));
    $td1.append($input);
    var op = "<td><a href='javascript:void(0)' name='deleteOpinion'><i class='iconfont icon-delete'></i></a>" +
 	   "<a href='javascript:void(0)' name='modifyOpinion' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
    var $td2 = $(op);
    $td2.find("a[name='deleteOpinion']").off("click").on("click",function() {
    	var $tr = $(this).parent().parent();
    	var ariaDescribedby =$tr.attr("aria-describedby");
    	$("#"+ariaDescribedby).remove();
        $tr.remove();
    });
    $td2.find("a[name='modifyOpinion']").off("click").on("click",function() {
    	var idx = $(this).parent().parent().index();
   	 layer.open({
     	    type:  2,
     	    area: [ "80%",  "80%"],
     	    title: "意见修改",
     	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
     	    shade:   0.3,
     	    maxmin: false, //开启最大化最小化按钮
     	    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ProcessOpinion/processOpinionEdit.jsp?id="+pid+"&idx="+idx,
     	   btn: ['确定', '关闭'],
     	   yes: function(index, layero){
       	    	var iframeWin = layero.find('iframe')[0].contentWindow;
       	    	var isValidate = iframeWin.$("#form").validate();
    	        if (!isValidate.checkForm()) {
    	            isValidate.showErrors();
    	            return false;
    	        }
    	        _self.saveModifyOpinion(_self.id, idx, iframeWin.$("#form"));
//    	       layer.msg("保存成功");
    	       layer.close(index);
       		 }
     	});
    });

    $tr.append($td1).append($td2);
    return $tr;
}

MyProcess.prototype.saveModifyOpinion = function (pid, idx, $form) {
	var _self = this;
	 var opinionName =  $form.find("#opinionName").val();
	 var opinionCode = $form.find("#opinionCode").val();
	 var opinionOrder = $form.find("#opinionOrder").val();
	 var opinionNode = $.trim($form.find("#opinionNode").val());
	 var opinionNodeText = $.trim($form.find("#opinionNodeText").val());
	 var positionId = $form.find("#positionId").val().replaceAll(";",",");
	 var positionText = $form.find("#positionText").val().replaceAll(";",",");
	 var showPositionId = $form.find("#showPositionId").val().replaceAll(";",",");
	 var showPositionText = $form.find("#showPositionText").val().replaceAll(";",",");
	 var eSign = $.trim($form.find("#eSign").val());
	 var ideaStyle = $.trim($form.find("#ideaStyle").val());
	 var opinionType = $.trim($form.find("#opinionType").val());
	 var subprocessDefId = $.trim($form.find("#subprocessDefId").val());
	 var subopinionCode = $.trim($form.find("#subopinionCode").val());
	 var subopinionName = $.trim($form.find("#subopinionName").val());
	  var showIdeaStyle = $.trim($form.find("#ideaStyle option[value='"+ideaStyle+"']").text());
	 var $tr = $("<tr data-toggle='popover' data-container='body' title=''></tr>");
	 // 增加一个hover
	 var _dataContent = '<table width="180px" border="0" style="font-size:12px;table-layout:fixed;"  align="center">'
		 +'<tr><td width="40%" height="25"><lable>名称:</lable></td><td>'+opinionName+'</td></tr>'
		 +'<tr ><td width="40%" height="25">代码:</td><td>'+opinionCode+'</td></tr>'
		 +'<tr><td width="40%" height="25" >排序:</td><td>'+opinionOrder+'</td></tr>'
/*		 +'<tr><td width="40%" height="25" >节点:</td><td>'+opinionNodeText+'</td></tr>'
		 +'<tr><td width="40%" height="25">查看岗位:</td><td>'+positionText+'</td></tr>'
		 +'<tr><td width="40%" height="25">显示岗位:</td><td>'+showPositionText+'</td></tr>'*/
		 +'</table>';
	 $tr.attr("data-content",_dataContent);
	 $tr.popover({trigger:"hover",placement:"top",html:true});
	 var $td1 = $("<td></td>");
	 $td1.append(opinionName);
	 // 添加隐藏input
	 var $input = $("<input type='hidden'/>");
	 var opinion ={
			 opinionName : opinionName,
			 opinionCode : opinionCode,
			 opinionOrder : opinionOrder,
			 opinionNode : opinionNode,
			 opinionNodeText : opinionNodeText,
			 positionId : positionId,
			 positionText : positionText,
			 showPositionText : showPositionText,
			 showPositionId : showPositionId,
			 eSign : eSign,
			 ideaStyle : ideaStyle,
			 opinionType: opinionType,
			 subprocessDefId: subprocessDefId,
			 subopinionCode: subopinionCode,
			 subopinionName: subopinionName,
			 showIdeaStyle :showIdeaStyle
	 }
	 $input.val(JSON.stringify(opinion));
	 $td1.append($input);
	 var op = "<td><a href='javascript:void(0)' name='deleteOpinion'><i class='iconfont icon-delete'></i></a>" +
	 "<a href='javascript:void(0)' name='modifyOpinion' style='margin-left:5px'><i class='iconfont icon-edit'></i></a> </td>";
	 var $td2 = $(op);
	 $td2.find("a[name='deleteOpinion']").off("click").on("click",function() {
         var $tr = $(this).parent().parent();
         var ariaDescribedby =$tr.attr("aria-describedby");
         $("#"+ariaDescribedby).remove();
         $tr.remove();
	 });
	 $td2.find("a[name='modifyOpinion']").off("click").on("click",function() {
		 var idx = $(this).parent().parent().index();
		 layer.open({
			 type:  2,
			 area: [ "80%",  "80%"],
			 title: "意见修改",
			 skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
			 shade:   0.3,
			 maxmin: false, //开启最大化最小化按钮
			 content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ProcessOpinion/processOpinionEdit.jsp?id="+pid+"&idx="+idx,
			 btn: ['确定', '关闭'],
     	   yes: function(index, layero){
       	    	var iframeWin = layero.find('iframe')[0].contentWindow;
       	    	var isValidate = iframeWin.$("#form").validate();
    	        if (!isValidate.checkForm()) {
    	            isValidate.showErrors();
    	            return false;
    	        }
    	        _self.saveModifyOpinion(_self.id, idx, iframeWin.$("#form"));
//    	       layer.msg("保存成功");
    	       layer.close(index);
       		 }
		 });
	 });
	 $tr.append($td1).append($td2);
	 var oldTr =  $("#"+pid+" table[name='table-process-add-opinion'] tbody tr").eq(idx);
	 $tr.replaceAll(oldTr);
}

/**** 	基本信息各种事件结束	 ****/

/**** 	启动条件各种事件开始	 ****/

/**
 * 初始化：启动条件
 * @param executorDomId  执行方式domId
 * @param tableExecutorDomId	数据table domId
 * @param tagNodeXml
 */
MyProcess.prototype.createConditionDom = function(executorDomId, tableExecutorDomId, tagNodeXml) {
	var self = this;
	$(tagNodeXml).children("conditions").each(function(){
		var type = $(this).attr("type");
		$('#' + self.id).find('#' + executorDomId).val(type);
		var $tbody = $("#" + self.id).find("#" +  tableExecutorDomId).find("tbody");
		$(this).children("condition").each(function(i){
			var idx = i;
			var c_type = $(this).attr("type");
            var computeRes = $(this).attr("computeRes");
			var value = $(this).text();
			// 该方法中的参数是jquery参数
            if (computeRes != null && computeRes != ''){
                // 该方法中的参数是jquery参数
                EventThatInsertStartConditionContentIntoTableWhenInit($tbody, c_type, $("<input value='"+computeRes +"'longJson='"+value+"'/>"));
            } else {
                // 该方法中的参数是jquery参数
                EventThatInsertStartConditionContentIntoTableWhenInit($tbody, c_type, $("<input value='"+value+"'/>"));
            }
		});
	});
};

MyProcess.prototype.modifyStartCondition = function (obj) {
		var $modifyBtn = $(obj);
		var $targetTr = $modifyBtn.parent().parent();
		var $tabName = $targetTr.find("td:eq(1)");
		var tabIndex =  $tabName.text().toLowerCase()== "expr" ? 0 : 1;
		var $val =  $targetTr.find("td:eq(2)");
		// 切换tab
		$modifyBtn.find("div[name='demoCont'] ul").find("li:eq("+tabIndex+")").click();
		// 先找到顶层的div
		var $top = $modifyBtn.parents("table[name=table-executor]").parent().parent();
		// 进行tab切换
		this.changeStartConditionTab($top.find("ul:eq(0)").find("li").eq(tabIndex));
		// 赋值
		$top.find("ul:eq(1)")
				.find("li")
				.eq(tabIndex)
				.find(tabIndex == 0? "textarea" : "input")
				.val($val.text().trim());

		// 查找添加buttion
		var $oldAddButton = $top.find("ul:eq(1)")
				.find("li")
				.eq(tabIndex).find("button[name='btn-add-start-condition']");
		// 更改为 保存添加按钮
		var $oldBtn = $oldAddButton.clone(true);
		$oldAddButton.off("click").text("保存").on("click", function() {
            var $content = tabIndex == 0 ?  $(this).parent().parent().parent().find("textarea") :
           	 $(this).parent().parent().parent().find("input");
            if ($content && $content.val().length != 0) {
            	$val.text($content.val());
            	$content.val("");
				// 恢复原来的添加按钮
				$(this).replaceWith($oldBtn);
            } else {
                alert("您还没输入内容");
            }
            return false;
		});
 }
MyProcess.prototype.changeStartConditionTab = function (obj) {
		var that = $(obj);
    //切换标签
    that.addClass('active')
        .siblings('li')
        .removeClass('active')
        .parent('.global-attrs-tab')
        .siblings('.tab-cont')
        .find('>li:eq(' + that.index() + ')')
        .addClass('active')
        .siblings('li')
        .removeClass('active');
      // 选中input
     that.find("input").prop("checked",true);
}

/**** 	启动条件各种事件结束	 ****/

MyProcess.prototype.getFlowVariables = function (variableDomId) {
	var _self = this;
	var dataArr = []
	var $tableTbody = $("#"+_self.id).find("table[name='table-flow-variable'] tbody tr");
	if($tableTbody.length > 0) {
		$tableTbody.each(function(index) {
			var $hiddenInput = $(this).find("td:eq(0) > div > input");
			try {
				var dataJSON = JSON.parse($hiddenInput.val());
				dataArr.push(dataJSON);
			} catch(err) {

			}
		});
	}
	return dataArr;
}



 /**	流程变量各种事件开始		**/

MyProcess.prototype.setFlowVariableXml = function(variableDomId, tabNodeXml) {
		// 从隐藏表单中获取数据
		var $obj = $('#' + this.id).find('#' + variableDomId + ' tbody tr');
		if($obj.length > 0) {
			var node = flowUtils.createElement('variables');
			$obj.each(function(index) {
				var $hiddenInput = $(this).find("td:eq(0) > div > input");
				var dataJSON = JSON.parse($hiddenInput.val());
				var varNode = flowUtils.createElement('variable');
				varNode.setAttribute("alias", dataJSON.alias);
				varNode.setAttribute("name", dataJSON.name);
				varNode.setAttribute('required', "N");
				varNode.setAttribute("init-expr", dataJSON.initExpr);
				varNode.setAttribute("type", dataJSON.type);
				varNode.setAttribute("desc", dataJSON.desc);
				node.appendChild(varNode);
			});
			tabNodeXml.appendChild(node);
		}
}

/**
 * 封装流程变量基本信息
 * @param varName
 * @param varibale
 * @param varVal
 * @param varType
 * @param varDesc
 * @returns
 */
MyProcess.prototype.assembleBpmVariableJSONData = function(varName, varibale, varVal, varType, varDesc) {
	var data = {
			alias 			: varName,
			name 			: varibale,
			initExpr 		: varVal,
			type 			: varType,
			desc			: varDesc
	};
	return JSON.stringify(data);
}

 /**
  * 初始化页面的时候，回写流程变量dom
  * @param tableDomId
  * @param tagNodeXml
  */
 MyProcess.prototype.createFlowVariableDom = function(tableDomId, tagNodeXml) {
		var self = this;
		$(tagNodeXml).children("variables").children("variable").each(function(){
			var $tableTbody = $("#"+self.id).find("table[name='table-flow-variable'] tbody");
			var variableName = $(this).attr("alias");
			var variable = $(this).attr("name");
			var variableValue = $(this).attr("init-expr");
			var variableType = $(this).attr("type");
			var variableDesc = $(this).attr("desc");
			self.insertFlowVariableContentIntoTable($tableTbody, variableName, variable, variableValue, variableType, variableDesc)
		});
		self.introVariableListener();
}

 /**
  * 封装基本信息到给定的tbody中
  * @param $tableTbody
  * @param variableName
  * @param variable
  * @param variableValue
  * @param variableType
  * @param variableDesc
  */
 MyProcess.prototype.insertFlowVariableContentIntoTable =  function ($tableTbody, variableName, variable, variableValue, variableType, variableDesc) {
     var _self = this;
	 var btn = '<a href="javascript:void(0)" name="btn-flow-variable-delete"><i class="iconfont icon-delete"></i></a>';
     btn += '<a href="javascript:void(0)" name="btn-flow-variable-modify" style="margin-left:5px"><i class="iconfont icon-edit"></i></a>';

     var varJSONData = _self.assembleBpmVariableJSONData(variableName, variable, variableValue, variableType, variableDesc);

     // 隐藏表单
     var hiddenInput = "<div class='hidden'>";
     	hiddenInput += "<input name='dataValue' value='" + varJSONData + "'/>"
     	hiddenInput += "</div>";
     var content = variable + "(" + variableType + ")" + (variableValue ? "=" + variableValue : "");
     var c = '<tr title="' + content + '" ><td style="display:none;">' + hiddenInput + '</td><td>' + variableName + '</td><td>' + content + '</td> <td> ' + btn + '</td></tr>';
     $tableTbody.append(c);
     _self.reloadVaribaleButtonEvent();

 }

 /**
  * 重新绑定表格中信息的事件
  */
 MyProcess.prototype.reloadVaribaleButtonEvent = function () {
	 var _self = this;
	 $("a[name='btn-flow-variable-delete']").off('click').on('click', function(argument) {
		 if (!_self.lock.varModifyLock) {
			 _self.userClickVariableDelete(this);
			 _self.introVariableListener();
		 } else {
			 layer.msg("请先保存当前操作项");
		 }
	 });;
	 $("a[name='btn-flow-variable-modify']").off('click').on('click', function(argument) {
			 _self.userClickVariableModify(this);
	 });
 }

 /**
  * obj 流程变量中的修改按钮dom
  */
 MyProcess.prototype.userClickVariableModify = function(obj) {
	 var _self = this;
	 if (_self.lock.varModifyLock) {
		 layer.msg("请先保存当前操作项");
		 return false;
	 }
	 // 假装加了一个锁,防止用户点击多次修改.
	 // 此处也可以让用户多次点击修改，以最后一次点击为准
	  _self.lock.varModifyLock = true;
      // 显示保存按钮并在该方法中添加事件
	 _self.toggleSiblingsButton($("button[name='btn-save-flow-variable']"));

     // 后续赋值使用
     var $topTR = $(obj).parent().parent();

     // 获取到该tab的最顶部dom
     var $top = $(obj).parent().parent().parent().parent().parent().parent();

     // 获取变量的 json内容
     var dataValue = $topTR.find("td>div>input[name=dataValue]").val();
     var dataJSON = JSON.parse(dataValue);

     $top.find("input[name='avic-input-variable-name']").val(dataJSON.alias);
     $top.find("input[name='avic-input-variable']").val(dataJSON.name);
     $top.find("select[name='avic-input-variable-type']").val(dataJSON.type);
     $top.find("input[name='avic-input-variable-value']").val(dataJSON.initExpr);
     $top.find("textarea[name='avic-input-variable-desc']").val(dataJSON.desc);

     // 获取显示内容
     var $showVaribaleName = $topTR.find("td:eq(1)");
     var $showVaribaleExpress = $topTR.find("td:eq(2)");


     // 添加保存按钮事件
     $("button[name='btn-save-flow-variable']").off("click").on("click", function() {
         var obj = $(this);
         _self.toggleSiblingsButton(obj);
         // 隐藏表单赋值
         var varName = $top.find("input[name='avic-input-variable-name']").val();
         var varibale = $top.find("input[name='avic-input-variable']").val();
         var varValue = $top.find("input[name='avic-input-variable-value']").val();
         var varType = $top.find("select[name='avic-input-variable-type']").val();
         var varDesc = $top.find("textarea[name='avic-input-variable-desc']").val();
         $topTR.find("td>div>input[name=dataValue]").val(function(){
        	 return _self.assembleBpmVariableJSONData(varName,
        			 varibale,
        			 varValue,
        			 varType,
        			 varDesc)
         });

         var content = varibale + "(" + varType + ")" + (varValue ? "=" + varValue : "");
         // 修改tr的 title
         $topTR.attr("title", content);
         // 显示赋值
         $showVaribaleName.text(varName);

         $showVaribaleExpress.text(content);
         // 清空输入框
         obj.parent().parent().prevAll().find("input,textarea").val("");

         _self.lock.varModifyLock = false;
         _self.introVariableListener();
         return false;
     });
 }

 /**
  * 流程变量内容中的删除操作
  * obj 删除dom
  */
 MyProcess.prototype.userClickVariableDelete = function(obj) {
	 var _self = this;
	 if(!_self.lock.varModifyLock) { // 如果有正在进行的操作,则不允许删除
		 $(obj).parent().parent().remove();
	 } else {
		 layer.msg("请先保存当前项");
	 }
 }

 /**
  * 动态切换流程变量的保存、修改按钮
  * @param $btn
  */
 MyProcess.prototype.toggleSiblingsButton = function($btn) {
     $btn.each(function() {
         if ($(this).hasClass("hidden")) {
             $(this).removeClass("hidden");
             $(this).siblings().addClass("hidden");
         } else {
             $(this).addClass("hidden");
             $(this).siblings().removeClass("hidden");
         }
     });
 }

 MyProcess.prototype.introVariableListener = function() {
	 var _self = this;
	 _self.notify(_self);
 }
 /*MyProcess.prototype.reloadOptions = function(domName, option, type) {
	 var _self = this;
	 var $Select = $("#"+this.id + " select[name='"+domName+"']");
	 $Select.empty();
	 	for (var i = 0; i< option.length; i++) {
	 		var d = option[i];
	 		  var val = d.value;
			  var text = d.text;
			  $Select.append("<option  value='"+val+"'>"+text+"</option>");
	 	}
		$Select.off("change").on('change', function() {
		 		if (this.value != "") {
					$.ajax({
						type : "POST",
						url : "platform/bpm/bpmconsole/eventManageAction/getEventInfoForDesigner",
						data : {
							id : this.value
						},
						dataType : "json",
						success : function(result) {
							 if(!type || type == "流程启动条件") {
								 var bpmClass = result.bpmClass;
									var properties = result.properties;
						            var input = $Select.parent().parent().parent().find("input");
						            input.val(bpmClass.path);
							 } else if (type == "流程事件监听") {
								 var bpmClass = result.bpmClass;
								 var properties = result.properties;
								 $("#"+_self.id + " input[name='input-event-name']").val(bpmClass.name);
								 $("#"+_self.id + " input[name='input-event']").val(bpmClass.path);
								 var $table = 	$("#"+_self.id + " table[name='constants']");
								 for (var i=0 ; i < properties.length; i++) {
									 var property = properties[i];
									 var tr = $table.find(">tbody>tr").eq(i);
									 if(tr.get(0)) {
										 tr.children("td").eq(0).text(property.name);
										 tr.children("td").eq(1).text(property.initExpr||"");
									 } else {
										 $table.find(">tbody").append("<tr><td>"+property.name+"</td><td>"+(property.initExpr||"")+"</td><tr>");
									 }
								 }
							 }

						}
					});
				} else {
					_self.nodeEvent.empty();
				}

	        });

 }*/
 /**	流程变量各种事件结束		**/

/* 启动权限开始  */

 MyProcess.prototype.initStartAuthTableDom = function (tagNodeXml, tableName, nodeType) {
	 var _self = this;
	 $(tagNodeXml).children("processAuth").children(nodeType).children().each(function(){
		 // 取id
		 var id = _self.getAttr(this, "id");
		 var name = $.trim($(this).find("name").text());
		 var type = $.trim($(this).find("type").text());
		 _self.addStartAuthTableContent (tableName, id, name, type);
	 });
 }

 MyProcess.prototype.getStartAuthTableXml = function (processAuth, tableName, xmlValuetype) {
	 var _self = this;
	 // 传入的xmlValueType分别为 user dept role group position
	 // 对应的xml节点分别为 users depts roles groups positions
	 var target = flowUtils.createElement(xmlValuetype+"s");
	 var $inputs =  $("#"+_self.id+" table[name='"+tableName+"'] tbody input");
	 $inputs.each(function() {
		 // 获取隐藏表单内容
		 var value = JSON.parse($(this).val());
		 // 创建对应的节点
		 // 创建节点属性，节点属性值为id
		var valueNode = flowUtils.createElement(xmlValuetype);
		valueNode.setAttribute("id", value.id);
		// 配置名称
		var nameNode = flowUtils.createElement("name");
		nameNode.appendChild(flowUtils.createTextNode(value.name))
		valueNode.appendChild(nameNode);
		// 配置类型
		var typeNode = flowUtils.createElement("type");
		typeNode.appendChild(flowUtils.createTextNode(value.type))
		valueNode.appendChild(typeNode);
		target.appendChild(valueNode);
	 });
	 processAuth.appendChild(target);
 }


 MyProcess.prototype.addStartAuthTableContent = function (tableName, id, name, type) {
	 if(flowUtils.notNull(id)){
		 var idArr = [];
		 var nameArr = [];
		 /*if(type == "user" || type == "dept"){
			 idArr = id.split(";");
			 nameArr = name.split(";");
		 }else{
			 idArr = id.split(",");
			 nameArr = name.split(",");
		 }*/
		 idArr = id.split(";");
		 nameArr = name.split(";");
		 if(idArr.length != 0 && idArr.length == nameArr.length){
			 var _self = this;
			 var table =  $("#"+this.id+" table[name='"+tableName+"'] tbody")
			 $.each(idArr, function(i, n){
				 if($("#" + _self.id + "_" + n).length == 0){
					 table.append(_self.getStartAuthTableTr(n, nameArr[i], type));
				 }
			 });
		 }
	 }
 }

 MyProcess.prototype.getStartAuthTableTr = function (id, name, type) {
	 var $tr = $("<tr data-toggle='popover' data-container='body' title=''></tr>");
	    // 增加一个hover
	    var _dataContent = '<table width="180px" border="0" style="font-size:12px;"  align="center">'
				+'<tr><td width="40%" height="25"><lable>名称:</lable></td><td>'+name+'</td></tr>'
					+'<tr ><td width="40%" height="25">编号:</td><td>'+id+'</td></tr>'
					+'</table>';
	    $tr.attr("data-content",_dataContent);
	    $tr.popover({trigger:"hover",placement:"top",html:true});
	    var $td1 = $("<td></td>");
	    $td1.append(id);
	    // 添加隐藏input
	    var $input = $("<input type='hidden'/>");
	    var auth ={
	    		id : id,
	    		name : name,
	    		type : type
	    }
	    $input.val(JSON.stringify(auth));
	    $td1.append($input);
	    var $td2 = $("<td></td>");
	    $td2.append(name);
	    var op = "<td><a href='javascript:void(0)' name='deleteStartAuth'><i class='iconfont icon-delete'></i></a> </td>";
	    var $td3 = $(op);
	    $td3.find("a[name='deleteStartAuth']").off("click").on("click",function() {
	    	$(this).parent().parent().popover('destroy');
	    	$(this).parent().parent().siblings("div").remove();
	    	$(this).parent().parent().remove();
	    });
	    $tr.append($td1).append($td2).append($td3);
	    $tr.attr("id", this.id + "_" + id);
	    return $tr;
 }
 /* 启动权限结束  */

 /* 同步人工节点表单开始*/
// MyBase.prototype.syncTaskForm = function(data) {
// 	 var values = this.designerEditor.myCellMap.values();
// 		$.each(values, function(i, n){
// 			if(n.tagName == "task"){
// 				this.syncTaskForm(data.id, data.name);
// 			}
// 		});
// }
 /* 同步人工节点表单结束*/

 MyProcess.prototype.updateGlobalVariable = function(data, context) {
		var _self = this;
		var $yinru = $("#"+_self.id+" select[name='yin_ru_bian_liang']");
		$yinru.empty();
		$yinru.append("<option selected value='0'>引入变量</option>");
		 var varContent = data;
		 if(varContent.length > 0) {
			 // 添加下拉框
			for(var i = 0; i < varContent.length ; i++) {
				var option = "<option>#{"+varContent[i].name+"}"+"</option>";
                // var option = "<option>"+varContent[i].name+"("+varContent[i].type+" "+varContent[i].initExpr+")"+"</option>"
				$yinru.append(option);
			}
		 }
	}

 MyProcess.prototype.initEvent = function() {
		var _self = this;

		// 流程意见配置
		 $("#"+_self.id+" button[name='btn-process-add-opinion']").off('click').on('click', function(e) {
			 layer.open({
         	    type:  2,
         	    area: [ "80%",  "80%"],
         	    title: "意见新增",
         	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
         	    shade:   0.3,
                maxmin: false, //开启最大化最小化按钮
         	    content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/ProcessOpinion/processOpinionAdd.jsp?id="+_self.id,
         	   btn: ['确定', '关闭'],
         	   yes: function(index, layero){
	       	    	var iframeWin = layero.find('iframe')[0].contentWindow;
	       	    	var isValidate = iframeWin.$("#form").validate();
	    	        if (!isValidate.checkForm()) {
	    	            isValidate.showErrors();
	    	            return false;
	    	        }
	    	        _self.addOpinion(_self.id, iframeWin.$("#form"));
//	    	       layer.msg("保存成功");
	    	       layer.close(index);
	       		 }
         	});
			 return false;
		 });

		 $("#"+_self.id+" select[name='yin_ru_bian_liang']").off('click').on('change', function() {
			 	if(this.value == 0) {
			 		return;
			 	}
	            var that = $(this);
	            var target = that.parent().parent().siblings("div").find("textarea")
	            var c = target.val().length == 0 ? that.val() : target.val() + "," + that.val();
	            target.val(c);
	       });

		 // 添加全局的流程变量，添加变量后会通知观察者
		  $("#"+_self.id+" button[name='btn-add-flow-variable']").off('click').on('click', function(argument) {
	            var $parent = $(this).parent().parent().parent();
	            var $variableName = $parent.find("input[name='avic-input-variable-name']");
	            var $variable = $parent.find("input[name='avic-input-variable']");
	            var $variableValue = $parent.find("input[name='avic-input-variable-value']");
	            var $variableType = $parent.find("select[name='avic-input-variable-type']");
	            var $variableDesc = $parent.find("textarea[name='avic-input-variable-desc']");
	            if (!$variableName || $variableName.val().length == 0) {
	                $variableName.focus();
	                layer.msg("还没填写变量名称");
	                return false;
	            }
	            if (!$variable || $variable.val().length == 0) {
	                $variable.focus();
	                layer.msg("还没填写变量");
	                return false;
	            }
	            // if (!$variableValue || $variableValue.val().length == 0) {
	            //     $variableValue.focus();
	            //     layer.msg("还没填写变量值");
	            //     return false;
	            // }

	            var $tableTbody = $parent.find("table[name='table-flow-variable'] tbody");
	            _self.insertFlowVariableContentIntoTable($tableTbody, $variableName.val(), $variable.val(), $variableValue.val(),
	                $variableType.val(), $variableDesc.val());
	            $variableName.val("");
	            $variable.val("");
	            $variableValue.val("");
	            $variableDesc.val("");
	            _self.introVariableListener();
	            return false;
	        });

		  $("#"+_self.id +" div[class^='div-auth-checkbox'] input[type='checkbox']").off('click').on("click",function() {
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
					 })

				 }
				 if($divAuth.find("input[name='candidate-data-field']").get(0)) {
					 // 增加按钮事件
					 $divAuth.find("button[name='button-auth-candidate']").off("click").on("click",function() {
                         var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
					 	var option = {processId:process.id,type:'userSelect', userSelectContainer :divAuthClassName ,dataField:'candidate-data-field',textField:'candidate-text-field',topId:_self.id};
						 new UserSelect(option);
					 })
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
					 })
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
					 })
				 }

			  } else {
				  var $divAuthBox = $(selfCheckbox).parentsUntil(".form-group").parent().siblings("div[class^='div-auth-box']");
				  $divAuthBox.addClass("hidden").find("input").val("");
			  }
		  });

		// 权限配置
		 $("#"+_self.id+" button[name='btn-tab-add-auth']").off('click').on('click', function(e) {
			 e.preventDefault();
			var dataRole =  $(this).attr("data-role");

			if(dataRole == "user") {
				var u1 = {
						type : 'userSelect',
						idFiled : _self.id+' #inputSelectUser',
						textFiled : _self.id+' #inputSelectUserText',
						selectModel : "multi",
						callBack: function(data) {
							_self.addStartAuthTableContent("table-auth-"+dataRole,data.userids,data.usernames,dataRole);
						},
						viewScope : 'currentOrg'
					};
				new H5CommonSelect(u1);
			}
			if(dataRole == "dept") {
				var u1 = {
						type : 'deptSelect',
						idFiled : _self.id+' #inputSelectDept',
						textFiled : _self.id+' #inputSelectDeptText',
						selectModel : "multi",
						callBack: function(data) {
							_self.addStartAuthTableContent("table-auth-"+dataRole,data.deptids,data.deptnames,dataRole);
						},
						viewScope : 'currentOrg'
				};
				new H5CommonSelect(u1);
			}
			if(dataRole == "role") {
				var u1 = {
						type : 'roleSelect',
						idFiled : _self.id+' #inputSelectRole',
						textFiled : _self.id+' #inputSelectRoleText',
						selectModel : "multi",
						callBack: function(data) {
							_self.addStartAuthTableContent("table-auth-"+dataRole,data.roleids,data.roleNames,dataRole);
						},
						viewScope : 'currentOrg'
				};
				new H5CommonSelect(u1);
			}
			if(dataRole == "group") {
				var u1 = {
						type : 'groupSelect',
						idFiled : _self.id+' #inputSelectGroup',
						textFiled : _self.id+' #inputSelectGroupText',
						selectModel : "multi",
						callBack: function(data) {
							_self.addStartAuthTableContent("table-auth-"+dataRole,data.groupids,data.groupNames,dataRole);
						},
						viewScope : 'currentOrg'
				};
				new H5CommonSelect(u1);
			}
			if(dataRole == "position") {
				var u1 = {
						type : 'positionSelect',
						idFiled : _self.id+' #inputSelectPosition',
						textFiled : _self.id+' #inputSelectPositionText',
						selectModel : "multi",
						callBack: function(data) {
							_self.addStartAuthTableContent("table-auth-"+dataRole,data.positionids,data.positionNames,dataRole);
						},
						viewScope : 'currentOrg'
				};
				new H5CommonSelect(u1);
			}
		 });

		 //expr配置
		 $("#"+_self.id+" button[name='btn-expr-config']").off('click').on("click", function(){
				var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
				var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
		        new ExprConfig({id:_self.id,domId:_self.id+" #expr-config-value-new",globalformid:globalformid,
                    processFlag:true,
		        	callback:function(data){

		        }});
		    });
		 $("#"+_self.id+" #flow_owner_deptName").off('click').on("click", function(){
			 var u1 = {
						type : 'deptSelect',
						idFiled : _self.id+' #flow_owner_deptId',
						textFiled : _self.id+' #flow_owner_deptName',
						selectModel : "single",
						callBack: function(data) {
							$("#"+ _self.id+' #flow_owner_userId').val("");
							$("#"+ _self.id+' #flow_owner_userName').val("");
						},
						viewScope : 'currentOrg'
				};
				new H5CommonSelect(u1);
		 });
		 $("#"+_self.id+" #flow_owner_userName").off('click').on("click", function(){
			 var u1 = {
						type : 'userSelect',
						idFiled : _self.id+' #flow_owner_userId',
						textFiled : _self.id+' #flow_owner_userName',
						deptidFiled:_self.id+' #flow_owner_deptId',
						deptNameFiled:_self.id+' #flow_owner_deptName',
						selectModel : "single",
						viewScope : 'currentOrg'
					};
				new H5CommonSelect(u1);
		 });
};


MyProcess.prototype.addObserver = function( observer ){
	  this.observers.add( observer );
};

MyProcess.prototype.notify = function( context ){
	  var observerCount = this.observers.count();
	  var jsonData = this.getFlowVariables();
	  for(var i=0; i < observerCount; i++){
	    this.observers.get(i).updateGlobalVariable(jsonData, context );
	  }
};

function ObserverList() {
	this.observerList = [];
}

ObserverList.prototype.add = function(obj) {
	this.observerList.push(obj);
};

ObserverList.prototype.removeAt = function( index ){
	  this.observerList.splice( index, 1 );
};

ObserverList.prototype.remove = function( obj ){
	var index = this.indexOf(obj,0);
	this.observerList.splice( index, 1 );
};

ObserverList.prototype.indexOf = function( obj, startIndex ){
	  var i = startIndex;
	  while( i < this.observerList.length ){
	    if( this.observerList[i] === obj ){
	      return i;
	    }
	    i++;
	  }
	  return -1;
};

ObserverList.prototype.count = function(){
	  return this.observerList.length;
};

ObserverList.prototype.get = function( index ){
	  if( index > -1 && index < this.observerList.length ){
	    return this.observerList[ index ];
	  }
};
