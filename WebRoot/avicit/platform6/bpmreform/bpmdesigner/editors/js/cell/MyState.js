/**
 * state extends MyBase
 */
function MyState(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "state");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_wait.png;";
};
MyState.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyState.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getState();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-state-node");
	
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyState.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setState(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	
	// 配置事件对象
	this.nodeEvent = new NodeEvent(this.designerEditor,this.id, "avic-digital-event-state-node");
	// 回写事件
	this.nodeEvent.setEventDom(xmlValue);
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyState.prototype.getOtherAttr = function(node) {
// 获取事件xml
	this.nodeEvent.setEventXml(node, "");
};
