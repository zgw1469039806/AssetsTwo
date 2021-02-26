/**
 * MyObj2xml extends MyBase
 */
function MyObj2xml(id) {
	MyBase.call(this, id, "obj2xml", "OBJ2XML");
};
MyObj2xml.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyObj2xml.prototype.init = function() {
	this.initBase();
	this.tagName = "mulexml:object-to-xml-transformer";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyObj2xml.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyObj2xml.prototype.getOtherAttr = function(node) {
	if(!myAction.xmlns.containsKey("xmlns:mulexml")){
		myAction.xmlns.put("xmlns:mulexml", "http://www.mulesoft.org/schema/mule/xml");
		myAction.schemaLocation.put("mulexml", "http://www.mulesoft.org/schema/mule/xml http://www.mulesoft.org/schema/mule/xml/current/mule-xml.xsd");
	}
};