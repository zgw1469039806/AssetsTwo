/**
 * MySmtp extends MyBase
 */
function MySmtp(id) {
	MyBase.call(this, id, "smtp", "SMTP");
};
MySmtp.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MySmtp.prototype.init = function() {
	this.initBase();
	this.tagName = "smtp:outbound-endpoint";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MySmtp.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomValByAttr("zhu_ji", xmlValue, "host");
	this.setDomValByAttr("duan_kou", xmlValue, "port");
	this.setDomValByAttr("yong_hu_ming", xmlValue, "user");
	this.setDomValByAttr("mi_ma", xmlValue, "password");
	this.setDomValByAttr("shou_jian_ren", xmlValue, "to");
	this.setDomValByAttr("fa_jian_ren", xmlValue, "from");
	this.setDomValByAttr("biao_ti", xmlValue, "subject");
	this.setDomValByAttr("chao_song", xmlValue, "cc");
	this.setDomValByAttr("mi_song", xmlValue, "bcc");
	this.setDomValByAttr("di_zhi", xmlValue, "address");
	this.setDomValByAttr("xiang_ying_chao_shi_shi_jian", xmlValue, "responseTimeout");
	this.setDomValByAttr("zi_fu_bian_ma", xmlValue, "encoding");
	this.setDomValByAttr("MIME_TYPE", xmlValue, "mimeType");
	
	this.setDomValByAttr("connector-ref", xmlValue, "connector-ref");
	$("#" + this.id).find("#connector-ref").trigger("change");
};
/**
 * 自定义扩展,子类需要重写，用于组装esbXML时组织非公共部分
 * 
 * @param node
 */
MySmtp.prototype.getOtherAttr = function(node) {
	if(!myAction.xmlns.containsKey("xmlns:smtp")){
		myAction.xmlns.put("xmlns:smtp", "http://www.mulesoft.org/schema/mule/smtp");
		myAction.schemaLocation.put("smtp", "http://www.mulesoft.org/schema/mule/smtp http://www.mulesoft.org/schema/mule/smtp/current/mule-smtp.xsd");
	}
	//属性信息
	this.setXmlAttrByVal("host", "zhu_ji", node);
	this.setXmlAttrByVal("port", "duan_kou", node);
	this.setXmlAttrByVal("user", "yong_hu_ming", node);
	this.setXmlAttrByVal("password", "mi_ma", node);
	this.setXmlAttrByVal("to", "shou_jian_ren", node);
	this.setXmlAttrByVal("from", "fa_jian_ren", node);
	this.setXmlAttrByVal("subject", "biao_ti", node);
	this.setXmlAttrByVal("cc", "chao_song", node);
	this.setXmlAttrByVal("bcc", "mi_song", node);
	this.setXmlAttrByVal("address", "di_zhi", node);
	this.setXmlAttrByVal("responseTimeout", "xiang_ying_chao_shi_shi_jian", node);
	this.setXmlAttrByVal("encoding", "zi_fu_bian_ma", node);
	this.setXmlAttrByVal("mimeType", "MIME_TYPE", node);
	
	this.setXmlAttrByVal("connector-ref", "connector-ref", node);
};
/**
 * 获取属性分项列表
 * 
 * @returns {Array}
 */
MySmtp.prototype.getItem = function() {
	return [ {
		text : "通用"
	}, {
		text : "高级"
	} ];
};