/**
 * ws extends MyBase
 */
function MyWs(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "ws");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_webservice.png;";
};
MyWs.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyWs.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getWs();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-ws-node");
    this.initEvent();
};
/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyWs.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setWs(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	this.initEvent();
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-ws-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);

    $("#"+this.id+" #inputValueBackVar").val(this.getAttr(xmlValue,"var"));
    $("#"+this.id+" #inputTextBackVar").val(this.getAttr(xmlValue,"var"));
    $("#"+this.id+" #jgzhl").val(this.getAttr(xmlValue,"resultConvertClass"));
    $("#"+this.id+" #dingzhishixian").val(this.getMeta(xmlValue,"wsClient"));
    var sync = $.trim(this.getMeta(xmlValue,"sync"));
    if(sync == "true") {
    	$("#"+this.id +" #shifoutongbu").trigger("click");
	}
    var serviceId = this.getAttr(xmlValue,"serviceId");
    if(flowUtils.notNull(serviceId)){
    	$("#"+this.id+" #serviceId").val(serviceId);
    	$("#"+this.id+" #serviceName").val(this.getAttr(xmlValue,"serviceName"));
    	$("#"+this.id+" #serviceType").val(this.getAttr(xmlValue,"serviceType"));
    	var serviceType = this.getAttr(xmlValue,"serviceType");
    	if(serviceType=="restful"){
			 $("#"+this.id+" #paramType").val(this.getAttr(xmlValue,"paramType"));
			 var paramType = this.getAttr(xmlValue,"paramType");
			 if(paramType=="text"){
				 $("#"+this.id+" #paramTableDiv").hide();
				 var $table =  $("#"+this.id+" table[name='methodParamsTable'] tbody");
				 $table.empty();
				 $("#"+this.id+" #paramTextDiv").attr("style","display:block;");
				 this.setParamText(xmlValue);
			 }else{
				 $("#"+this.id+" #paramTableDiv").attr("style","display:block;");
				 $("#"+this.id+" #paramTextDiv").hide();
				 this.setParamTable(xmlValue);
			 }
   	    }else{
			  $("#"+this.id+" #paramTableDiv").attr("style","display:block;");
			  $("#"+this.id+" #paramTextDiv").hide();
			  this.setParamTable(xmlValue);
   	    }
    	this.hiddenServiceItems();
    }else{
    	$("#"+this.id+" #fuwudizhi").val(this.getAttr(xmlValue,"url"));
        $("#"+this.id+" #zhixingfangfa").val(this.getAttr(xmlValue, "method"));
        $("#"+this.id+" #yonghuming").val(this.getMeta(xmlValue,"accessUser"));
        $("#"+this.id+" #mima").val(this.getMeta(xmlValue,"accessPwd"))
    }
	this.methodClass.getDom(xmlValue);


};
/**
 * 组装processXML的自定义信息
 *
 * @param node
 */
MyWs.prototype.getOtherAttr = function(node) {
	// 获取事件xml
	this.nodeEvent.setEventXml(node, "");

	this.putAttr("url",$("#"+this.id+" #fuwudizhi").val(), node);
    this.putAttr("method",$("#"+this.id+" #zhixingfangfa").val(), node);
    this.putAttr("var",$("#"+this.id+" #inputValueBackVar").val(), node);
    this.putAttr("serviceId", $("#"+this.id+" #serviceId").val(), node);
    this.putAttr("serviceName", $("#"+this.id+" #serviceName").val(), node);
    this.putAttr("serviceType", $("#"+this.id+" #serviceType").val(), node);
    this.putAttr("paramType", $("#"+this.id+" #paramType").val(), node);
    this.putAttr("paramText", $("#"+this.id+" #paramText").val(), node);
    this.getParamTextValues(node);
    this.putAttr("resultConvertClass", $("#"+this.id+" #jgzhl").val(), node);
    this.addMeta("accessUser",$("#"+this.id+" #yonghuming").val(),node);
    this.addMeta("accessPwd",$("#"+this.id+" #mima").val(),node);
    this.addMeta("wsClient",$("#"+this.id+" #dingzhishixian").val(),node);
    this.addMeta("error","break",node);
    this.addMeta("sync",$("#"+this.id+" #shifoutongbu").is(":checked"),node);
	this.methodClass.getXml(node);
	this.getParamValues(node);

};

MyWs.prototype.initEvent = function() {
    var _self  = this;
    $("#"+_self.id+" button[name='button-BackVar']").on("click", function(){
        var process = null;
        var values = _self.designerEditor.myCellMap.values();
        $.each(values, function(i, n){
            if(n.tagName == "process"){
                process = n;
            }
        });
        new ProcessVariable({dataDomId:_self.id+" #inputValueBackVar",showDomId:_self.id+" #inputTextBackVar", callback:function(data){
            var d = data[0];
            $("#"+_self.id+" #inputValueBackVar").val(d.name);
            $("#"+_self.id+" #inputTextBackVar").val(d.name);
        },process:process,
            multiple:false});
    });

    _self.methodClass = new MethodAndClass({id:_self.id, buttonId:"buttonAddMethodClass", tableId:_self.id+" #table-flow-add-methodClass",type:"arg", callback:function(data){
        var d = data[0];
    }});


    $("#"+this.id+" button[name=serviceSelect]").on("click",function(){
    	var option = {
			 selectContainer :'webservice-container' ,
			 dataField:'serviceId',
			 textField:'serviceName',
			 topId:_self.id,
			 processId:process.id,
		 	callback:function(serviceType,data){
        	 _self.hiddenServiceItems();
        	 $("#"+_self.id+" #serviceType").val(serviceType);
        	 if(serviceType=="restful"){
        		 $("#"+_self.id+" #paramType").val(data.paramType);
        		 if(data.paramType=="text"){
        			 $("#"+_self.id+" #paramTableDiv").hide();
					 var $table =  $("#"+_self.id+" table[name='methodParamsTable'] tbody");
					 $table.empty();
            		 $("#"+_self.id+" #paramTextDiv").attr("style","display:block;");
            		 $("#"+_self.id + " #paramTextValueType").val("text");
					 $("#"+_self.id + " input[name='paramTextValueTypeCheck']").prop("checked",false);
					 var selectHtml = _self.getFieldsSelectHtml();
					 $("#"+_self.id + " #selectFieldDiv").empty();
            		 $("#"+_self.id + " #selectFieldDiv").append(selectHtml);
					 $("#"+_self.id + " #selectFieldDiv").find("select[name='field']").hide();
					 $("#"+_self.id + " #paramTextDiv").find("#paramText").attr("style","display:block;");
					 $("#"+_self.id + " input[name='paramTextValueTypeCheck']").on("change",function(){
						 if($(this).is(':checked')){
							 $("#"+_self.id + " #paramTextValueType").val("select");
							 $(this).parent().find(" select[name='field']").attr("style","display:block;");
							 $(this).parent().find(" #paramText").hide();
						 }else{
							 $("#"+_self.id + " #paramTextValueType").val("text");
							 $(this).parent().find("select[name='field']").hide();
							 $(this).parent().find("#paramText").attr("style","display:block;");
						 }
					 });

        		 }else{
        			 $("#"+_self.id+" #paramTableDiv").attr("style","display:block;");
            		 $("#"+_self.id+" #paramTextDiv").hide();
					 $("#"+_self.id+" #paramText").val();
            		 _self.initParamTable(data,'methodParamsTable');
        		 }
        	 }else{
        		 $("#"+_self.id+" #paramTableDiv").attr("style","display:block;");
        		 $("#"+_self.id+" #paramTextDiv").hide();
        		 _self.initParamTable(data,'methodParamsTable');
        	 }
		 }};
        _self.serviceSelect = new WebService(option);
    });

};

MyWs.prototype.hiddenServiceItems = function(){
	$("#"+this.id+" #fuwudizhi").attr("disabled",true);
    $("#"+this.id+" #zhixingfangfa").attr("disabled",true);

    $("#"+this.id+" #yonghuming").attr("disabled",true);
    $("#"+this.id+" #mima").attr("disabled",true);
};

MyWs.prototype.initParamTable = function(data,tableName){
	var _self = this;
	var paramNames = data.paramName;
	if(paramNames!=null && paramNames != ''){
		var paramArr = paramNames.split(",");
		var $table =  $("#"+_self.id+" table[name='"+tableName+"'] tbody");
		$("#"+_self.id+" table[name='"+tableName+"'] tbody tr").remove();
		var selectHtml = _self.getFieldsSelectHtml();
		for(var i=0;i<paramArr.length;i++){
			var $tr = $("<tr></tr>");
			var $td1 = $("<td width='30%'></td>");
			$td1.append(paramArr[i]);
			$tr.append($td1);
			var $td2 = $("<td></td>");
			var $checkbox = "<input type='checkbox' name='valueTypeCheck' />&nbsp;选择";
			var $hideden = "<input type='hidden' name='valueType' >";
			var $input = "<input type='text' class='form-control' name='"+paramArr[i]+"' value='' title='"+paramArr[i]+"'/>";
			$td2.append($hideden);
			$td2.append($checkbox);
			$td2.append($input);
			$td2.append(selectHtml);
			$td2.find("input[type='checkbox']").on("change",function(){
				if($(this).is(':checked')){
					$(this).parent().find("input[type='hidden']").val("select");
					$(this).parent().find("input[type='text']").hide();
					$(this).parent().find("select[name='field']").attr("style","display:block;");
				}else{
					$(this).parent().find("input[type='hidden']").val("text");
					$(this).parent().find("input[type='text']").attr("style","display:block;");
					$(this).parent().find("select[name='field']").hide();
				}
			});
			$tr.append($td2);
			$table.append($tr);
		}
	}
};

MyWs.prototype.getParamValues = function(node){
	var _self = this;
	$("#"+_self.id+" #methodParamsTable input").each(function(){
		if(this.type=='text'){
			var paramName = this.name;
			var paramVal = this.value;
			var param = flowUtils.createElement("param");
			param.setAttribute("name", paramName);
			param.setAttribute("value", paramVal);
			var valueType = $(this).parent().find("input[name='valueType']");
			if(flowUtils.notNull(valueType)){
				if(valueType.val() == "select"){
					param.setAttribute("valueType", "select");
					var selectedObj = $(this).parent().find("select[name='field']").find("option:selected");
					var fieldType = selectedObj.attr("fieldType");
					param.setAttribute("fieldType", fieldType);
					var fieldId = selectedObj.attr("fieldId");
					param.setAttribute("fieldId", fieldId);
					var fieldName = selectedObj.attr("fieldName");
					param.setAttribute("fieldName", fieldName);
					var colType = selectedObj.attr("colType");
					param.setAttribute("colType", colType);
					var formId = selectedObj.attr("formId");
					param.setAttribute("formId", formId);
					var tableName = selectedObj.attr("tableName");
					param.setAttribute("tableName", tableName);
				}else{
					param.setAttribute("valueType", "text");
				}
			}else{
				param.setAttribute("valueType", "text");
			}
			node.appendChild(param);
		}
	});
};

MyWs.prototype.getParamTextValues = function(node){
	var _self = this;
	var paramType = $("#"+_self.id+" #paramType").val();
	if(paramType == "text"){
		var paramTextValueType = $("#"+_self.id+" #paramTextValueType").val();
		if(paramTextValueType == "select"){
			this.putAttr("paramTextValueType", "select", node);
			var param = flowUtils.createElement("paramText");
			var $select = $("#"+_self.id + " #selectFieldDiv select[name='field']").find("option:selected");
			var fieldType = $select.attr("fieldType");
			param.setAttribute("fieldType", fieldType);
			var fieldId = $select.attr("fieldId");
			param.setAttribute("fieldId", fieldId);
			var fieldName = $select.attr("fieldName");
			param.setAttribute("fieldName", fieldName);
			var colType = $select.attr("colType");
			param.setAttribute("colType", colType);
			var formId = $select.attr("formId");
			param.setAttribute("formId", formId);
			var tableName = $select.attr("tableName");
			param.setAttribute("tableName", tableName);
			node.appendChild(param);
		}else{
			this.putAttr("paramTextValueType", "text", node);
		}
	}
};

MyWs.prototype.setParamText = function(node){
	var _self = this;
	var paramTextValueType = _self.getAttr(node,"paramTextValueType");
	var selectHtml = _self.getFieldsSelectHtml();
	$("#"+_self.id + " #selectFieldDiv").append(selectHtml);
	if(paramTextValueType == "select"){
		$("#"+_self.id + "#paramTextValueType").val("select");
		$("#" + _self.id +" #paramText").hide();
		$("#" + _self.id + " select[name='field']").attr("style","display:block;");
		$("#"+_self.id + " input[name='paramTextValueTypeCheck']").prop("checked",true);
		if($(node).children("paramText") && $(node).children("paramText").length){
			$(node).children("paramText").each(function(){
				var _selfNode = this;
				var fieldId = $.trim(_selfNode.getAttribute("fieldId"));
				$("#" + _self.id + " select[name='field']").find("option:contains('"+fieldId+"')").attr("selected",true);
			});
		}
	}else{
		$("#"+_self.id + "#paramTextValueType").val("text");
		$("#"+_self.id+" #paramText").val(_self.getAttr(node,"paramText"));
		$("#" + _self.id + " select[name='field']").hide();
		$("#" + _self.id +" #paramText").attr("style","display:block;");
		$("#"+_self.id + " input[name='paramTextValueTypeCheck']").prop("checked",false);
	}
	$("#"+_self.id + " input[name='paramTextValueTypeCheck']").on("change",function(){
		if($(this).is(':checked')){
			$("#"+_self.id + " #paramTextValueType").val("select");
			$(this).parent().find(" select[name='field']").attr("style","display:block;");
			$(this).parent().find(" #paramText").hide();
		}else{
			$("#"+_self.id + " #paramTextValueType").val("text");
			$(this).parent().find("select[name='field']").hide();
			$(this).parent().find("#paramText").attr("style","display:block;");
		}
	});
};

MyWs.prototype.setParamTable = function(node){
	var _self = this;
	var $table =  $("#"+_self.id+" table[name='methodParamsTable'] tbody");
	if($(node).children("param") && $(node).children("param").length){
		var selectHtml = _self.getFieldsSelectHtml();
		$(node).children("param").each(function(){
			var _selfNode = this;
			var varName = $.trim(_selfNode.getAttribute("name"));
			var varValue = $.trim(_selfNode.getAttribute("value"));
			var valueType = _selfNode.getAttribute("valueType");
			var fieldType = _selfNode.getAttribute("fieldType");
			var fieldId = _selfNode.getAttribute("fieldId");
			var fieldName = _selfNode.getAttribute("fieldName");
			var colType = _selfNode.getAttribute("colType");
			var formId = _selfNode.getAttribute("formId");
			var tableName = _selfNode.getAttribute("tableName");


			var $tr = $("<tr></tr>");
			var $td1 = $("<td width='30%'></td>");
			$td1.append(varName);
			$tr.append($td1);
			var $td2 = $("<td></td>");
			var $checked = "";
			if(valueType == "select"){
				$checked = "checked";
			}
			var $checkbox = "<input type='checkbox' name='valueTypeCheck' "+$checked+"/>&nbsp;选择&nbsp;";
			var $hideden = "<input type='hidden' name='valueType' value='"+valueType+"'>";
			var $input = "<input type='text' class='form-control' name='"+varName+"' value='"+varValue+"' title='"+varName+"'/>";
			$td2.append($hideden);
			$td2.append($checkbox);
			$td2.append($input);
			$td2.append(selectHtml);
			if(valueType == "select"){
				$td2.find("input[type='text']").hide();
				$td2.find("select[name='field']").attr("style","display:block;");
				$td2.find("select[name='field']").find("option:contains('"+fieldId+"')").attr("selected",true);
			}else{
				$td2.find("input[type='text']").attr("style","display:block;");
				$td2.find("select[name='field']").hide();
			}
			$td2.find("input[type='checkbox']").on("change",function(){
				if($(this).is(':checked')){
					$(this).parent().find("input[type='hidden']").val("select");
					$(this).parent().find("input[type='text']").hide();
					$(this).parent().find("select[name='field']").attr("style","display:block;");
				}else{
					$(this).parent().find("input[type='hidden']").val("text");
					$(this).parent().find("input[type='text']").attr("style","display:block;");
					$(this).parent().find("select[name='field']").hide();
				}
			});
			$tr.append($td2);
			$table.append($tr);
			//$table.find("input[type='text']").attr("style","");
		});


	}

};

MyWs.prototype.getFieldsSelectHtml = function(){
	var _self = this;
	var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
	var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
	var selectHtml = '';
	selectHtml+='<select class="form-control input-sm"  name="field"  title=""  style="display: none;">';
	selectHtml+= '<option value="">&nbsp;&nbsp;&nbsp;请选择</option>';
	selectHtml+="<optgroup label='" + "流程常量" + "'></optgroup>";
	selectHtml+="<option value='currPerfomer' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='currPerfomer'"
		+ " fieldName='" + "当前节点处理人" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;当前节点处理人</option>";
	selectHtml+="<option value='currPerfomerCurrDept' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='currPerfomerCurrDept'"
		+ " fieldName='" + "当前节点处理人" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;节点处理人当前部门</option>";
	selectHtml+="<option value='starter' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='starter'"
		+ " fieldName='" + "拟稿人" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;拟稿人</option>";
	selectHtml+="<option value='starterCurrDept' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='starterCurrDept'"
		+ " fieldName='" + "拟稿人部门" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;拟稿人部门</option>";
	selectHtml+="<option value='processInstanceId' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='processInstanceId'"
		+ " fieldName='" + "流程实例ID" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;流程实例ID</option>";
	selectHtml+="<option value='formId' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='formId'"
		+ " fieldName='" + "表单ID" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;表单ID</option>";
	selectHtml+="<option value='processDefId' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='processDefId'"
		+ " fieldName='" + "流程定义ID" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;流程定义ID</option>";
	selectHtml+="<option value='activityName' "
		+ " formId='" + globalformid + "'"
		+ " fieldType='4'"
		+ " fieldId='activityName'"
		+ " fieldName='" + "当前节点名称" + "'"
		+ " colType='string'"
		+ ">&nbsp;&nbsp;&nbsp;当前节点名称</option>";

	avicAjax.ajax({
		url: "platform/bpm/designer/getProcessFormFieldsForVar",
		data: "globalformid=" + globalformid,
		type: "post",
		async: false,
		dataType: "json",
		success: function (backData) {
		    var formFields = null;
		    if(flowUtils.notNull(backData.fields)){
                formFields = JSON.parse(backData.fields);
            }
			if(flowUtils.notNull(formFields)){
				selectHtml+="<optgroup label='" + "主表字段" + "'></optgroup>";
				for(var i=0;i<formFields.length;i++){
					var tableName = backData.tableName;
					//外部表字段表名加@区分
					if(formFields[i].domdataId){
						tableName = "@"+formFields[i].tableName;
					}
					selectHtml+="<option value='" + formFields[i].colName + "' "
						+ " colType='" + formFields[i].colType + "'"
						+ " fieldType='2'"
						+ " fieldId='" + formFields[i].colName + "'"
						+ " fieldName='" + formFields[i].colLabel + "'"
						+ " formId='" + globalformid + "'"
						+ " tableName='" + tableName + "'>&nbsp;&nbsp;&nbsp;" + formFields[i].colLabel + "(" + formFields[i].colName + ")" + "</option>";
				}
			}
			//处理关联子表的字段
			var subMap = backData.subFieldsMap;
			var key = null;//子表名称
			var value = null;//子表字段内容
			if(flowUtils.notNull(subMap)){
				for (var entry in subMap) {
					//key = entry;
					key = "子表字段" + "(" + entry + ")";
					value = subMap[entry];
					if (value != null && value != '') {
						var subFormFields = JSON.parse(value);
						if (subFormFields.length > 0) {
							selectHtml+="<optgroup label='" + key + "'></optgroup>";
						}
						for (var j = 0; j < subFormFields.length; j++) {
							selectHtml+="<option value='" + subFormFields[j].colName + "' "
								+ " subFlag='true'"
								+ " colType='" + subFormFields[j].colType + "'"
								+ " fieldType='3'"
								+ " fieldId='" + subFormFields[j].colName + "'"
								+ " fieldName='" + subFormFields[j].colLabel + "'"
								+ " tableName='" + entry + "'"
								+ " formId='" + globalformid + "'"
								+ " mainTableName='" + backData.tableName + "'"
								+ " fieldShowType='" + subFormFields[j].elementType + "'>&nbsp;&nbsp;&nbsp;" + subFormFields[j].colLabel + "(" + subFormFields[j].colName + ")" + "</option>";
						}
					}

				}
			}

		}
	});
	selectHtml+= '</select>';
	return selectHtml;
};
