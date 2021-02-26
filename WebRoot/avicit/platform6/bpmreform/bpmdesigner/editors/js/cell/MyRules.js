/**
 * rules extends MyBase
 */
function MyRules(designerEditor, id) {
	MyBase.call(this, designerEditor, id, "rules");
	this.style = "symbol;image=avicit/platform6/bpmreform/bpmdesigner/editors/images/48/task_rule.png;";
};
MyRules.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyRules.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + this.designerEditor.countUtils.getRules();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyRules.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	this.designerEditor.countUtils.setRules(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(xmlValue));// 创建mxCell
	this.designerEditor.myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
	this.setDomValByMeta("rulesPath", xmlValue, "rulesPath");
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MyRules.prototype.getOtherAttr = function(node) {
	this.setXmlMetaByVal("rulesPath", node, "rulesPath");
};