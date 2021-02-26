/**
 * sub-process extends MyBase
 */
function MySubprocess(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "sub-process");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_subprocess.png;";
};
MySubprocess.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MySubprocess.prototype.init = function() {
	this.initBase();
	this.name = "Subprocess" + this.designerEditor.countUtils.getSubprocess();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-subprocess-node");
    // 界面模型的事件
    this.initEvent();
};
/**
 * 为流程跟踪提供的特殊方法
 * @param xmlValue
 * @param rootXml
 */
MySubprocess.prototype.initTracks = function(xmlValue, rootXml) {
    this.name = xmlValue.getAttribute("name");
    this.alias = $.trim(xmlValue.getAttribute("alias"));
    this.g = xmlValue.getAttribute("g");
    this.deploymentId = this.getAttr(xmlValue,"sub-process-id");
    rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
    this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MySubprocess.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setSubprocess(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/


	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-subprocess-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
	// 界面模型的事件
    this.initEvent();
    $("#"+this.id+" #inputValueSubFlowId").val(this.getAttr(xmlValue,"sub-process-id"));
    $("#"+this.id+" #inputValueSubFlowName").val(this.getAttr(xmlValue,"sub-process-key"));
    $("#"+this.id+" #inputTextSubFlowName").val(this.getAttr(xmlValue,"sub-process-name"));
    var shifoutongbu = this.getMeta(xmlValue, "asynchronous");
    $("#" + this.id).find("input[name='shifoutongbu'][value='"+shifoutongbu+"']").prop("checked","checked");
    var isMustUser = this.getMeta(xmlValue,"isMustUser");
    if(isMustUser == "yes") {
        $("#"+this.id+" #ziliuchengxuanren").trigger("click");
        var metaValue = this.getMeta(xmlValue, "userSelectType");
        $("#" + this.id).find("#yunxuzidongxuanren").prop("checked", metaValue =="auto" ? true :false);
        this.setUserSelectDom({dataField:'candidate-data-field',textField:'candidate-text-field'}, xmlValue);
	}
	this.setDomCheckByMeta("putongliucheng", xmlValue, "putongliucheng", "no");

    $("#"+this.id+" input[name='inputValueOutCome']").val(this.getAttr(xmlValue, "outcome"));
    $("#"+this.id+" input[name='inputTextOutCome']").val(this.getAttr(xmlValue, "outcome"));
    this.parameterIn.getDom(xmlValue);
    this.parameterOut.getOutDom(xmlValue);
    this.getFormInDom(xmlValue);
    this.getFormOutDom(xmlValue);
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MySubprocess.prototype.getOtherAttr = function(node) {
// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
	 this.putAttr("sub-process-id", $("#"+this.id+" #inputValueSubFlowId").val(), node);
    this.putAttr("sub-process-key", $("#"+this.id+" #inputValueSubFlowName").val(), node);
    this.putAttr("sub-process-name", $("#"+this.id+" #inputTextSubFlowName").val(), node);
    this.addMeta("asynchronous",$("#"+this.id+" input[name='shifoutongbu']:checked").val(),node);

    if($("#"+this.id+" input[name='ziliuchengxuanren']").is(":checked")) {
        this.addMeta("isMustUser","yes",node);
        this.addMeta("userSelectType",$("#"+this.id+" input[name='yunxuzidongxuanren']").is(":checked")?"auto":"manual",node);
        this.setUserSelectXml({dataField:'candidate-data-field'}, node);
    } else {
        this.addMeta("isMustUser","no",node);
	}
	this.setXmlMetaByCheck("putongliucheng", node, "putongliucheng");

    this.putAttr("outcome",$("#"+this.id+" input[name='inputValueOutCome']").val(),node);
    this.parameterIn.getXml(node);
    this.parameterOut.getOutXml(node);
    this.getFormInXml(node);
    this.getFormOutXml(node);
};
/**
 * 通过name解析数字，例如end1解析出数字:1
 */
MySubprocess.prototype.resolve = function() {
	return Number(this.name.replace("Subprocess", ""));
};

MySubprocess.prototype.initEvent = function() {
	var _self = this;
    $("#"+_self.id+" button[name='button-sub-flowname']").on("click", function(){
        new SubProcess({dataDomId:_self.id+" #inputValueSubFlowName",showDomId:_self.id+" #inputTextSubFlowName", callback:function(data){
        }, multiple:false, dataDomId2:_self.id+" #inputValueSubFlowId"});
    });

    
    $("#"+_self.id+" #ziliuchengxuanren").on("click", function(){
    	if(this.checked) {
    		if($("#"+_self.id+" div[name='zidongxuanren-area']").hasClass("hidden")) {
                $("#"+_self.id+" div[name='zidongxuanren-area']").removeClass("hidden");
			}
		} else {
            if(!$("#"+_self.id+" div[name='zidongxuanren-area']").hasClass("hidden")) {
                $("#"+_self.id+" div[name='zidongxuanren-area']").addClass("hidden");
            }
		}
	});
    var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
    $("#"+_self.id+" button[name='button-auth-candidate']").on('click',function() {
        var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
    	var option = {processId:process.id,type:'userSelect',dataField:"candidate-data-field",textField:"candidate-text-field",topId:_self.id,processId:process.id};
        new UserSelect(option);
	});


    $("#"+_self.id+" button[name='button-OutCome']").on("click", function(){
        var process = null;
        var values = _self.designerEditor.myCellMap.values();
        $.each(values, function(i, n){
            if(n.tagName == "process"){
                process = n;
            }
        });
        new ProcessVariable({dataDomId:_self.id+" #inputValueOutCome",showDomId:_self.id+" #inputTextOutCome", callback:function(data){
            var d = data[0];
            var txt = "#{"+d.name+"}";
            $("#"+_self.id+" #inputValueOutCome").val(txt);

            $("#"+_self.id+" #inputTextOutCome").val(txt);
        },process:process,
            multiple:false});
    });

    _self.parameterIn = new ParameterInAndOut({id:_self.id, buttonId:"buttonAddParameterIn", tableId:_self.id+" #table-flow-ParameterIn",type:"parameter-in", callback:function(data){
//       console.log(data);
    }});
    _self.parameterOut = new ParameterInAndOut({id:_self.id, buttonId:"buttonAddParameterOut", tableId:_self.id+" #table-flow-ParameterOut",type:"parameter-out", callback:function(data){
//       console.log(data);
    }});
    
    $("#"+_self.id+" button[name='formFieldParameterConfig']").on("click", function(){
    	var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey)
		var globalformid = $.trim($('#' + process.id).find('#guan_lian_biao_dan').val());
        var subProcessKey = $("#"+_self.id+" #inputValueSubFlowName").val();
        var subProcessId = $("#"+_self.id+" #inputValueSubFlowId").val();
        if(!flowUtils.notNull(subProcessId) && !flowUtils.notNull(subProcessKey)){
        	layer.msg("您还没选择子流程");
        	return false;
        }
        
        new FormFieldParameter({id:_self.id,dataDomId1:_self.id+" #fieldArgsMainProcessToSub",dataDomId2:_self.id+" #fieldArgsSubProcessToMain",callback:function(data){
            
        },process:process,mainProcessFormId:globalformid,
        subProcessKey:subProcessKey});
    });

};
MySubprocess.prototype.getFormInXml = function(node) {
	var _self = this;
	var formInVal = $("#"+_self.id+" #fieldArgsMainProcessToSub").val();
	if(flowUtils.notNull(formInVal)){
		var formInArr = JSON.parse(formInVal);
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
				node.appendChild(arg);
			}
		}
	}
};
MySubprocess.prototype.getFormOutXml = function(node) {
	var _self = this;
	var formOutVal = $("#"+_self.id+" #fieldArgsSubProcessToMain").val();
	if(flowUtils.notNull(formOutVal)){
		var formOutArr = JSON.parse(formOutVal);
		if(formOutArr.length){
			for(i=0;i<formOutArr.length;i++){
				var data = formOutArr[i];
				var arg = flowUtils.createElement("form-out");
				arg.setAttribute("formTable", data.formTable);
				arg.setAttribute("formCol", data.formCol);
				arg.setAttribute("subFormTable", data.subFormTable);
				arg.setAttribute("subFormCol", data.subFormCol);
				arg.setAttribute("colType", data.colType);
				arg.setAttribute("tableModify", data.tableModify);
				arg.setAttribute("colComments",data.colComments);
				arg.setAttribute("isOrgIdentity",data.isOrgIdentity);
				arg.setAttribute("fromComments",data.fromComments);
				node.appendChild(arg);
			}
		}
	}
};
MySubprocess.prototype.getFormInDom = function(node) {
	var _self = this;
	var dataArr = [];
	$(node).children("form-in").each(function(){
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
	}) ;
	var formInDataStr = JSON.stringify(dataArr);
	$("#"+_self.id+" #fieldArgsMainProcessToSub").val(formInDataStr);
	
};
MySubprocess.prototype.getFormOutDom = function(node) {
	var _self = this;
	var dataArr = [];
	$(node).children("form-out").each(function(){
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
		dataArr.push(dataObj);
	}) ;
	var formOutDataStr = JSON.stringify(dataArr);
	$("#"+_self.id+" #fieldArgsSubProcessToMain").val(formOutDataStr);
	
};
MySubprocess.prototype.doubleClickCell = function(){
	var subFlowId = $("#"+this.id+" #inputValueSubFlowId").val();
	var subFlowName = $("#"+this.id+" #inputTextSubFlowName").val();
	if(flowUtils.notNull(subFlowId)){
		layer.open({
			type : 2,
			title: subFlowName,
			area : [ "800px", "500px" ],
			content : "platform/bpm/bpmPublishAction/getProcessImageTrack.gif?processInstanceId=" + subFlowId
		});
	}
};