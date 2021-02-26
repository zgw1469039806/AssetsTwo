/**
 * exclusive extends MyBase
 */
function MyExclusive(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "decision");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/gateway_exclusive.png;";
};
MyExclusive.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyExclusive.prototype.init = function() {
	this.initBase();
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-exclusive-node");
	this.name = "exclusive" + this.designerEditor.countUtils.getExclusive();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyExclusive.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setExclusive(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-exclusive-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyExclusive.prototype.getOtherAttr = function(node) {
// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
};
/**
 * 通过name解析数字，例如end1解析出数字:1
 */
MyExclusive.prototype.resolve = function() {
	return Number(this.name.replace("exclusive", ""));
};