/**
 * MySetpayload extends MyBase
 */
function MySetpayload(id) {
	MyBase.call(this, id, "setpayload", "SET PAYLOAD");
};
MySetpayload.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MySetpayload.prototype.init = function() {
	this.initBase();
	this.tagName = "set-payload";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MySetpayload.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomValByAttr("she_zhi_nei_rong", xmlValue, "value");
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MySetpayload.prototype.getOtherAttr = function(node) {
	//属性信息
	this.setXmlAttrByVal("value", "she_zhi_nei_rong", node);
};