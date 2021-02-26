/**
 * MyJson2obj extends MyBase
 */
function MyJson2obj(id) {
	MyBase.call(this, id, "json2obj", "JSON2OBJ");
};
MyJson2obj.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyJson2obj.prototype.init = function() {
	this.initBase();
	this.tagName = "json:json-to-object-transformer";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyJson2obj.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyJson2obj.prototype.getOtherAttr = function(node) {
	if(!myAction.xmlns.containsKey("xmlns:json")){
		myAction.xmlns.put("xmlns:json", "http://www.mulesoft.org/schema/mule/json");
		myAction.schemaLocation.put("json", "http://www.mulesoft.org/schema/mule/json http://www.mulesoft.org/schema/mule/json/current/mule-json.xsd");
	}
};