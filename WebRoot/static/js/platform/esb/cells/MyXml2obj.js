/**
 * MyXml2obj extends MyBase
 */
function MyXml2obj(id) {
	MyBase.call(this, id, "xml2obj", "XML2OBJ");
};
MyXml2obj.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyXml2obj.prototype.init = function() {
	this.initBase();
	this.tagName = "mulexml:xml-to-object-transformer";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyXml2obj.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyXml2obj.prototype.getOtherAttr = function(node) {
	if(!myAction.xmlns.containsKey("xmlns:mulexml")){
		myAction.xmlns.put("xmlns:mulexml", "http://www.mulesoft.org/schema/mule/xml");
		myAction.schemaLocation.put("mulexml", "http://www.mulesoft.org/schema/mule/xml http://www.mulesoft.org/schema/mule/xml/current/mule-xml.xsd");
	}
};