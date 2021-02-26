/**
 * end extends MyBase
 */
function MyEnd(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "end");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/end_event_terminate.png;";
};
MyEnd.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyEnd.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getEnd();
	this.labelChanged("结束");
	this.initJBXX();// 初始化基本信息
	// 节点事件
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-end-node");
	// 初始化各种事件
	this.initEvent();
};
/**
 * 加载时初始化元素信息
 *
 * @param xmlValue
 * @param rootXml
 */
MyEnd.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-end-node");
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setEnd(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	// 初始化各种事件
	this.initEvent();
		// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
	// 回写权限
	var _self = this;
	$(xmlValue).children("docRights").children("docRight").each(function(){
			var docThis = this;
			var domId = $(docThis).attr("type");
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
						flowUtils.error("你碰到了一个错误");
				}
				});
		});
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MyEnd.prototype.getOtherAttr = function(node) {
	
	//文档权限
	var docRights = flowUtils.createElement("docRights");
	this.createFormSaveXml("wordRead","查看正文", docRights);
	this.createFormSaveXml("wordPrint","打印正文", docRights,node);
	if(docRights.childNodes.length > 0){
		node.appendChild(docRights);
	}

	// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
	
};

MyEnd.prototype.createFormSaveXml = function (type, name, docRights, rootNode) {
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

MyEnd.prototype.initEvent = function() {
	var _self =  this;
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
	 
	// 各种打印级别选人
	 $("#"+_self.id).find("button[name^='btnTaskFormwordSecret']").off("click").on("click",function() {
		 var containerDiv = "";
         var process = _self.designerEditor.myCellMap.get(_self.designerEditor.processKey);
		 var dataField = $(this).parent().siblings("div").find("input[name^='taskFormValuewordSecret']").attr("name");
		 var textField = $(this).parent().siblings("div").find("input[name^='taskFormTextwordSecret']").attr("name");
		 var option = {processId:process.id,type:'userSelect', userSelectContainer :containerDiv ,dataField:dataField,textField:textField,topId:_self.id};
		 new UserSelect(option);
	 });
}