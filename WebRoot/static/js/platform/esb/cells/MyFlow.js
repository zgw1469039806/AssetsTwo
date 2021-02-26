/**
 * MyFlow extends MyBase
 */
function MyFlow(id) {
	MyBase.call(this, id, "flow", _title);
};
MyFlow.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyFlow.prototype.init = function() {
	this.initBase();
};
/**
 * 组装esbXML,流程子类改写了该方法
 * 
 * @returns
 */
MyFlow.prototype.getXmlDoc = function() {
	var node = ComUtils.createElement(this.tagName);
	this.putAttr("name", this.alias, node);
	this.putAttr("doc:name", this.alias, node);
	return node;
};
/**
 * 重写了name监听事件，不需要其他处理
 * 
 * @param value
 */
MyFlow.prototype.labelChanged = function(value) {
	this.alias = value;
};