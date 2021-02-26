/**
 * MyCust extends MyBase
 */
function MyCust(id) {
	MyBase.call(this, id, "cust", "JAVA");
};
MyCust.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyCust.prototype.init = function() {
	this.initBase();
	this.tagName = "component";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyCust.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomValByAttr("lei_wen_jian", xmlValue, "class");
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyCust.prototype.getOtherAttr = function(node) {
	//属性信息
	this.setXmlAttrByVal("class", "lei_wen_jian", node);
};