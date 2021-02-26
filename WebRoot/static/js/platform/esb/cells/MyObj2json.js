/**
 * MyObj2json extends MyBase
 */
function MyObj2json(id) {
	MyBase.call(this, id, "obj2json", "OBJ2JSON");
};
MyObj2json.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyObj2json.prototype.init = function() {
	this.initBase();
	this.tagName = "json:object-to-json-transformer";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyObj2json.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyObj2json.prototype.getOtherAttr = function(node) {
	if(!myAction.xmlns.containsKey("xmlns:json")){
		myAction.xmlns.put("xmlns:json", "http://www.mulesoft.org/schema/mule/json");
		myAction.schemaLocation.put("json", "http://www.mulesoft.org/schema/mule/json http://www.mulesoft.org/schema/mule/json/current/mule-json.xsd");
	}
};