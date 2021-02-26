/**
 * MyFlowref extends MyBase
 */
function MyFlowref(id) {
	MyBase.call(this, id, "flowref", "FLOW REFERENCE");
};
MyFlowref.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyFlowref.prototype.init = function() {
	this.initBase();
	this.tagName = "flow-ref";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyFlowref.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomValByAttr("liu_cheng_ming_cheng", xmlValue, "name");
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyFlowref.prototype.getOtherAttr = function(node) {
	//属性信息
	this.setXmlAttrByVal("name", "liu_cheng_ming_cheng", node);
};