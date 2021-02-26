/**
 * MyCusttrans extends MyBase
 */
function MyCusttrans(id) {
	MyBase.call(this, id, "custtrans", "JAVA TRANSFORMER");
};
MyCusttrans.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyCusttrans.prototype.init = function() {
	this.initBase();
	this.tagName = "custom-transformer";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyCusttrans.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomValByAttr("zhuan_huan_lei", xmlValue, "class");
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyCusttrans.prototype.getOtherAttr = function(node) {
	//属性信息
	this.setXmlAttrByVal("class", "zhuan_huan_lei", node);
};