/**
 * custom extends MyBase
 */
function MyCustom(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "custom");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_custom.png;";
};
MyCustom.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyCustom.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getCustom();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-custom-node");
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyCustom.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setCustom(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
		// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-custom-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);

	var custom_class = this.getAttr(xmlValue,"class");
    $("#"+this.id+" #node_class").val(custom_class);
	$("#"+this.id+" input[name='custom_class_check']").each(function (i, n) {
		if($(n).val() == custom_class){
			$(n).click();
		}
	});
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MyCustom.prototype.getOtherAttr = function(node) {
// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
	this.putAttr("class",$("#"+this.id+" #node_class").val(),node);
};