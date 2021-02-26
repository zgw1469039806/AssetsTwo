/**
 * MyLogger extends MyBase
 */
function MyLogger(id) {
	MyBase.call(this, id, "logger", "LOGGER");
};
MyLogger.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyLogger.prototype.init = function() {
	this.initBase();
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyLogger.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomValByAttr("shu_chu_nei_rong", xmlValue, "message");
	this.setDomValByAttr("ji_bie", xmlValue, "level");
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyLogger.prototype.getOtherAttr = function(node) {
	//属性信息
	this.setXmlAttrByVal("message", "shu_chu_nei_rong", node);
	this.setXmlAttrByVal("level", "ji_bie", node);
};