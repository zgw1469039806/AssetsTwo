/**
 * jms extends MyBase
 */
function MyJms(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "jms");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_jms.png;";
};
MyJms.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyJms.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getJms();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-jms-node");
    this.initEvent();
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyJms.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setJms(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
    this.initEvent();
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-jms-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
	this.setDomValByAttr("initial-context-factory",xmlValue,"initial-context-factory");
	this.setDomValByAttr("provider-url",xmlValue,"provider-url");
	this.setDomValByAttr("connection-factory",xmlValue,"connection-factory");
	this.setDomValByAttr("destination",xmlValue,"destination");

    var transacted = this.getAttr(xmlValue, "transacted");
    if(transacted == "true") {
        $("#" + this.id).find("#transacted").trigger("click");
	}
    var acknowledge = this.getAttr(xmlValue, "acknowledge");
    $("#" + this.id).find("input[name='acknowledge'][value='"+acknowledge+"']").prop("checked","checked");
    var message = this.getAttr(xmlValue, "message");
    $("#" + this.id).find("input[name='message'][value='"+message+"']").trigger('click');
    if(message == "text" || message == "object") {
    	var messageValue = "";
			if(message == "text") {
                messageValue = $.trim($(xmlValue).children("text").text());
			} else {
                messageValue = $.trim($(xmlValue).children("object").attr("expr"));
			}
		    $("#" + this.id).find("input[name='returnValue_"+message+"']").val(messageValue);
    } else {
		this.jmsCollection.getDom(xmlValue);
	}

};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MyJms.prototype.getOtherAttr = function(node) {
// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
	this.setXmlAttrByVal("initial-context-factory",node,"initial-context-factory");
	this.setXmlAttrByVal("provider-url",node,"provider-url");
	this.setXmlAttrByVal("connection-factory",node,"connection-factory");
	this.setXmlAttrByVal("destination",node,"destination");
	// this.setXmlAttrByCheck("transacted", node,"transacted");
    this.putAttr("transacted", $("#" + this.id).find("input[name='transacted']").is(":checked"),node);
    this.putAttr("acknowledge", $("#" + this.id).find("input[type='radio'][name='acknowledge']:checked").val(), node)
	var message = $("#" + this.id).find("input[type='radio'][name='message']:checked").val();
    this.putAttr("message", message, node);
	if(message == "text" || message == "object") {
        var messageValue = $("#" + this.id).find("input[name='returnValue_"+message+"']").val();
		var messageNode = flowUtils.createElement(message);
		node.appendChild(messageNode);
		if(message == "text") {
            messageNode.appendChild(flowUtils.createTextNode(messageValue));
		} else {
            messageNode.setAttribute("expr", messageValue);
		}
	} else {
		this.jmsCollection.getXml(node);
	}
};

MyJms.prototype.initEvent = function() {
	var that = this;
    $("#"+that.id+" input[type='radio'][name='message']").on("click", function() {
    	var inputValue =$(this).val();
		$("#"+that.id).find("div[class^='area-input']").each(function(){
			if(!$(this).hasClass("hidden")) {
                $(this).addClass("hidden");
			}
		});
		$("#"+that.id).find("div[class^='area-input-"+inputValue+"']").removeClass("hidden");
    });

    that.jmsCollection = new JMSCollection({id:that.id, buttonId:"buttonAddMethodClass", tableId:that.id+" #table-flow-add-methodClass",type:"entry", callback:function(data){
        var d = data[0];
    }});
}