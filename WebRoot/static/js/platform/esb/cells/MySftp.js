/**
 * MySftp extends MyBase
 */
function MySftp(id) {
	MyBase.call(this, id, "sftp", "SFTP");
};
MySftp.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MySftp.prototype.init = function() {
	this.initBase();
	this.tagName = "sftp:inbound-endpoint";
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 */
MySftp.prototype.initLoad = function(xmlValue) {
	this.alias = $.trim(xmlValue.attr("doc:name"));
	this.tagName = xmlValue.get(0).tagName;
	if(this.tagName == "sftp:outbound-endpoint"){
		$("#" + this.id).find("#outbound-endpoint").attr("checked", true);
		$("#" + this.id).find("#outbound-endpoint").next().trigger('click');
	}
	$("#" + this.id).find("#xian_shi_ming_cheng").val(this.alias);
	//属性信息
	this.setDomValByAttr("zhu_ji", xmlValue, "host");
	this.setDomValByAttr("duan_kou", xmlValue, "port");
	this.setDomValByAttr("lu_jing", xmlValue, "path");
	this.setDomValByAttr("yong_hu_ming", xmlValue, "user");
	this.setDomValByAttr("mi_ma", xmlValue, "password");
	if(this.tagName == "sftp:inbound-endpoint"){
		this.setDomValByAttr("deng_dai_chu_li_shi_jian", xmlValue, "fileAge");
		this.setDomValByAttr("shua_xin_pin_lv", xmlValue, "pollingFrequency");
	}else{
		this.setDomCheckByAttr("one-way", xmlValue, "exchange-pattern", "one-way");
		this.setDomValByAttr("shu_chu_mo_shi", xmlValue, "outputPattern");
	}
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
MySftp.prototype.getOtherAttr = function(node) {
	if(!myAction.xmlns.containsKey("xmlns:sftp")){
		myAction.xmlns.put("xmlns:sftp", "http://www.mulesoft.org/schema/mule/sftp");
		myAction.schemaLocation.put("sftp", "http://www.mulesoft.org/schema/mule/sftp http://www.mulesoft.org/schema/mule/sftp/current/mule-sftp.xsd");
	}
	//属性信息
	this.setXmlAttrByVal("host", "zhu_ji", node);
	this.setXmlAttrByVal("port", "duan_kou", node);
	this.setXmlAttrByVal("path", "lu_jing", node);
	this.setXmlAttrByVal("user", "yong_hu_ming", node);
	this.setXmlAttrByVal("password", "mi_ma", node);
	if(this.tagName == "sftp:inbound-endpoint"){
		this.setXmlAttrByVal("fileAge", "deng_dai_chu_li_shi_jian", node);
		this.setXmlAttrByVal("pollingFrequency", "shua_xin_pin_lv", node);
	}else{
		this.setXmlAttrByCheck("exchange-pattern", "exchange-pattern", node);
		this.setXmlAttrByVal("outputPattern", "shu_chu_mo_shi", node);
	}
	this.setXmlAttrByVal("address", "di_zhi", node);
	this.setXmlAttrByVal("responseTimeout", "xiang_ying_chao_shi_shi_jian", node);
	this.setXmlAttrByVal("encoding", "zi_fu_bian_ma", node);
	this.setXmlAttrByVal("mimeType", "MIME_TYPE", node);
};
MySftp.prototype.endpointChanged = function(value) {
	this.tagName = "sftp:" + value;
	if(value == "inbound-endpoint"){
		_editor.graph.setCellStyles(mxConstants.STYLE_IMAGE, "static/js/platform/esb/images/48/sftp.png", [this.getCell()]);
	}else{
		this.imageChanged($("#" + this.id).find("input[name = 'exchange-pattern']:checked").val());
	}
};
MySftp.prototype.imageChanged = function(value) {
	_editor.graph.setCellStyles(mxConstants.STYLE_IMAGE, "static/js/platform/esb/images/48/sftp_" + value + ".png", [this.getCell()]);
};
/**
 * 获取属性分项列表
 * 
 * @returns {Array}
 */
MySftp.prototype.getItem = function() {
	return [ {
		text : "通用"
	}, {
		text : "高级"
	} ];
};