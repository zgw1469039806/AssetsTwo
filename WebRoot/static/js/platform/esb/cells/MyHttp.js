/**
 * MyHttp extends MyBase
 */
function MyHttp(id) {
	MyBase.call(this, id, "http", "HTTP");
};
MyHttp.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyHttp.prototype.init = function() {
	this.initBase();
	this.tagName = "http:inbound-endpoint";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyHttp.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	this.tagName = xmlValue.get(0).tagName;
	if(this.tagName == "http:outbound-endpoint"){
		$("#" + this.id).find("#outbound-endpoint").attr("checked", true);
	}
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomCheckByAttr("one-way", xmlValue, "exchange-pattern", "one-way");
	this.setDomValByAttr("zhu_ji_di_zhi", xmlValue, "host");
	this.setDomValByAttr("duan_kou_hao", xmlValue, "port");
	this.setDomValByAttr("lu_jing", xmlValue, "path");
	this.setDomValByAttr("di_zhi", xmlValue, "address");
	this.setDomValByAttr("xiang_ying_chao_shi_shi_jian", xmlValue, "responseTimeout");
	this.setDomValByAttr("zi_fu_bian_ma", xmlValue, "encoding");
	this.setDomValByAttr("MIME_TYPE", xmlValue, "mimeType");
	this.setDomValByAttr("quan_xian_yong_hu_ming", xmlValue, "user");
	this.setDomValByAttr("quan_xian_mi_ma", xmlValue, "password");
	this.setDomValByAttr("method", xmlValue, "method");
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyHttp.prototype.getOtherAttr = function(node) {
	if(!myAction.xmlns.containsKey("xmlns:http")){
		myAction.xmlns.put("xmlns:http", "http://www.mulesoft.org/schema/mule/http");
		myAction.schemaLocation.put("http", "http://www.mulesoft.org/schema/mule/http http://www.mulesoft.org/schema/mule/http/current/mule-http.xsd");
	}
	//属性信息
	this.setXmlAttrByCheck("exchange-pattern", "exchange-pattern", node);
	this.setXmlAttrByVal("host", "zhu_ji_di_zhi", node);
	this.setXmlAttrByVal("port", "duan_kou_hao", node);
	this.setXmlAttrByVal("path", "lu_jing", node);
	this.setXmlAttrByVal("address", "di_zhi", node);
	this.setXmlAttrByVal("responseTimeout", "xiang_ying_chao_shi_shi_jian", node);
	this.setXmlAttrByVal("encoding", "zi_fu_bian_ma", node);
	this.setXmlAttrByVal("mimeType", "MIME_TYPE", node);
	this.setXmlAttrByVal("user", "quan_xian_yong_hu_ming", node);
	this.setXmlAttrByVal("password", "quan_xian_mi_ma", node);
	this.setXmlAttrByVal("method", "method", node);
};
MyHttp.prototype.endpointChanged = function(value) {
	this.tagName = "http:" + value;
};
MyHttp.prototype.imageChanged = function(value) {
	_editor.graph.setCellStyles(mxConstants.STYLE_IMAGE, "static/js/platform/esb/images/48/http_" + value + ".png", [this.getCell()]);
};
/**
 * 获取属性分项列表
 * 
 * @returns {Array}
 */
MyHttp.prototype.getItem = function() {
	return [ {
		text : "通用"
	}, {
		text : "高级"
	} ];
};