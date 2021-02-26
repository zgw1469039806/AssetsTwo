/**
 * MyFtp extends MyBase
 */
function MyFtp(id) {
	MyBase.call(this, id, "ftp", "FTP");
};
MyFtp.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyFtp.prototype.init = function() {
	this.initBase();
	this.tagName = "ftp:inbound-endpoint";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MyFtp.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	this.tagName = xmlValue.get(0).tagName;
	if(this.tagName == "ftp:outbound-endpoint"){
		$("#" + this.id).find("#outbound-endpoint").attr("checked", true);
	}
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomValByAttr("zhu_ji", xmlValue, "host");
	this.setDomValByAttr("duan_kou", xmlValue, "port");
	this.setDomValByAttr("lu_jing", xmlValue, "path");
	this.setDomValByAttr("yong_hu_ming", xmlValue, "user");
	this.setDomValByAttr("mi_ma", xmlValue, "password");
	this.setDomCheckByAttr("binary_false", xmlValue, "binary", "false");
	this.setDomCheckByAttr("passive_true", xmlValue, "passive", "true");
	this.setDomValByAttr("di_zhi", xmlValue, "address");
	this.setDomValByAttr("xiang_ying_chao_shi_shi_jian", xmlValue, "responseTimeout");
	this.setDomValByAttr("zi_fu_bian_ma", xmlValue, "encoding");
	this.setDomValByAttr("MIME_TYPE", xmlValue, "mimeType");
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MyFtp.prototype.getOtherAttr = function(node) {
	if(!myAction.xmlns.containsKey("xmlns:ftp")){
		myAction.xmlns.put("xmlns:ftp", "http://www.mulesoft.org/schema/mule/ftp");
		myAction.schemaLocation.put("ftp", "http://www.mulesoft.org/schema/mule/ftp http://www.mulesoft.org/schema/mule/ftp/current/mule-ftp.xsd");
	}
	//属性信息
	this.setXmlAttrByVal("host", "zhu_ji", node);
	this.setXmlAttrByVal("port", "duan_kou", node);
	this.setXmlAttrByVal("path", "lu_jing", node);
	this.setXmlAttrByVal("user", "yong_hu_ming", node);
	this.setXmlAttrByVal("password", "mi_ma", node);
	this.setXmlAttrByCheck("binary", "binary", node);
	this.setXmlAttrByCheck("passive", "passive", node);
//	if(this.tagName == "ftp:inbound-endpoint"){
//		this.setXmlAttrByCheck("exchange-pattern", "exchange-pattern", node);
//	}else{
//	}
	this.setXmlAttrByVal("address", "di_zhi", node);
	this.setXmlAttrByVal("responseTimeout", "xiang_ying_chao_shi_shi_jian", node);
	this.setXmlAttrByVal("encoding", "zi_fu_bian_ma", node);
	this.setXmlAttrByVal("mimeType", "MIME_TYPE", node);
};
MyFtp.prototype.endpointChanged = function(value) {
	this.tagName = "ftp:" + value;
};
/**
 * 获取属性分项列表
 * 
 * @returns {Array}
 */
MyFtp.prototype.getItem = function() {
	return [ {
		text : "通用"
	}, {
		text : "高级"
	} ];
};