/**
 * MyDatabase extends MyBase
 */
function MyDatabase(id) {
	MyBase.call(this, id, "database", "DATABASE");
};
MyDatabase.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyDatabase.prototype.init = function() {
	this.initBase();
	this.tagName = "jdbc:inbound-endpoint";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyDatabase.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	this.tagName = xmlValue.get(0).tagName;
	if(this.tagName == "jdbc:outbound-endpoint"){
		$("#" + this.id).find("#outbound-endpoint").attr("checked", true);
	}
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomCheckByAttr("one-way", xmlValue, "exchange-pattern", "one-way");
	this.setDomValByAttr("connector-ref", xmlValue, "connector-ref");
	$("#" + this.id).find("#connector-ref").trigger("change");
	this.setDomValByAttr("queryKey", xmlValue, "queryKey");
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyDatabase.prototype.getOtherAttr = function(node) {
	if(!myAction.xmlns.containsKey("xmlns:jdbc")){
		myAction.xmlns.put("xmlns:jdbc", "http://www.mulesoft.org/schema/mule/jdbc");
		myAction.schemaLocation.put("jdbc", "http://www.mulesoft.org/schema/mule/jdbc http://www.mulesoft.org/schema/mule/jdbc/3.4/mule-jdbc.xsd");
	}
	//属性信息
	this.setXmlAttrByCheck("exchange-pattern", "exchange-pattern", node);
	this.setXmlAttrByVal("connector-ref", "connector-ref", node);
	this.setXmlAttrByVal("queryKey", "queryKey", node);
};
MyDatabase.prototype.endpointChanged = function(value) {
	this.tagName = "jdbc:" + value;
};
MyDatabase.prototype.imageChanged = function(value) {
	_editor.graph.setCellStyles(mxConstants.STYLE_IMAGE, "static/js/platform/esb/images/48/database_" + value + ".png", [this.getCell()]);
};
/**
 * 获取属性分项列表
 * 
 * @returns {Array}
 */
MyDatabase.prototype.getItem = function() {
	return [ {
		text : "通用"
	}, {
		text : "全局数据源"
	} ];
};