/**
 * MyTcp extends MyBase
 */
function MyTcp(id) {
	MyBase.call(this, id, "tcp", "TCP");
};
MyTcp.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyTcp.prototype.init = function() {
	this.initBase();
	this.tagName = "tcp:inbound-endpoint";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyTcp.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	this.tagName = xmlValue.get(0).tagName;
	if(this.tagName == "tcp:outbound-endpoint"){
		$("#" + this.id).find("#outbound-endpoint").attr("checked", true);
	}
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomValByAttr("zhu_ji", xmlValue, "host");
	this.setDomValByAttr("duan_kou", xmlValue, "port");
	this.setDomCheckByAttr("one-way", xmlValue, "exchange-pattern", "one-way");
	this.setDomValByAttr("tcp_protocol", xmlValue, "connector-ref");
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyTcp.prototype.getOtherAttr = function(node) {
	if(!myAction.xmlns.containsKey("xmlns:tcp")){
		myAction.xmlns.put("xmlns:tcp", "http://www.mulesoft.org/schema/mule/tcp");
		myAction.schemaLocation.put("tcp", "http://www.mulesoft.org/schema/mule/tcp http://www.mulesoft.org/schema/mule/tcp/current/mule-tcp.xsd");
	}
	//属性信息
	this.setXmlAttrByVal("host", "zhu_ji", node);
	this.setXmlAttrByVal("port", "duan_kou", node);
	this.setXmlAttrByCheck("exchange-pattern", "exchange-pattern", node);
	this.setXmlAttrByVal("connector-ref", "tcp_protocol", node);
	
};
MyTcp.prototype.endpointChanged = function(value) {
	this.tagName = "tcp:" + value;
};
MyTcp.prototype.imageChanged = function(value) {
	_editor.graph.setCellStyles(mxConstants.STYLE_IMAGE, "static/js/platform/esb/images/48/tcp_" + value + ".png", [this.getCell()]);
};